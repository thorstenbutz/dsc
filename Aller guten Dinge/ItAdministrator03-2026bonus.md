# Aller guten Dinge (BONUS)

## Desired State Configuration (DSC) v3

Aus Platzgründen haben es einige Beispiele nicht in die Druckausgabe geschafft. Diese Inhalte stellen wir Ihnen in diesem Addendum zur Verfügung.

### DSC v3 auf dem Windows Server

Im Listing 7 finden Sie eine YAML-Datei zur, die Bereitstellung der Windows Server-Komponente verdeutlicht.

**Listing 7: DNS-Server-Installation.yaml**

```powershell
# yaml-language-server: $schema=https://aka.ms/configuration-dsc-schema/0.3
$schema: https://raw.githubusercontent.com/PowerShell/DSC/main/schemas/2024/04/config/document.json

metadata:
  description: 'Install DNS Server role and management tools on Windows Server'
  created_by: 'DSC v3 Configuration'
  creation_date: '2024'

resources:
  - name: Use Windows PowerShell resources
    type: Microsoft.Windows/WindowsPowerShell
    properties:
      resources:
        - name: DNS Server install
          type: PSDesiredStateConfiguration/WindowsFeature
          properties:
            Name: DNS
            Ensure: Present
            IncludeAllSubFeature: false
        
        - name: DNS Server management tools install
          type: PSDesiredStateConfiguration/WindowsFeature
          properties:
            Name: RSAT-DNS-Server
            Ensure: Present
            IncludeAllSubFeature: false
```

## Configuration Managment: Ansible und Co

"Infrastructure as Code" (IaC) ist kein Microsoft-Konzept. Etablierte Lösungen wie Ansible, Chef oder  Puppet, die man etwas  einfacher unter dem Begriff "Configuration Mangement" (CM) zusammen fassen kann, verfolgen im Kern den gleichen Ansatz. Diese Tools definieren den gewünschten Zustand von Endgeräten (in Hinblick auf installierte Softwarepakete, Dienste, Dateien, Benutzer) und wenden diesen Zustand dann automatisch auf viele Knoten an, verifizieren den aktuellen Zustand und erzwingen gegebenenfalls eine erneute Anpassung. 

Werfen wir einen etwas genaueren Blick auf den Marktführer Ansible, der seit einigen Jahren unter dem Dach von Redhat weiterentwicklet wird. Ansible verfolgt einen agentenlosen Ansatz; der Admin erstellt zur Konfiguration der verwalteten Maschinen sogenannte "Playbooks" im YAML-Format. Diese Konfigurationsscripts greifen zurück auf eine Vielzahl von Ansible-Erweiterungen. Eine solche Erweiterung, ist das "ansible.windows.win_dsc module".  Dieses Modul nutzt die nunmehr veraltete PSDSC und erfordert somit die Windows PowerShell (v5). 

**Listing 8: Ansible playbooks (win_dsc)** 

```yaml
- name: Install Telnet Client using PSDSC
  hosts: windows_workstations
  tasks:
    - name: Enable Telnet Client
      ansible.windows.win_dsc:
        resource_name: WindowsOptionalFeature
        Ensure: Enable
        Name: TelnetClient
```

Daneben existiert ein natives Ansiblemodul "win_optional_feature", letztlich ein PowerShell-Script, das die erforderlichen Änderungen vornimmt. Bei näherer Betrachtung, ergibt die Verwendung des "win_dsc"-Moduls kaum einen Vorteil, es erhöht aber erheblich die Komplexität. So empfiehlt die Ansible-Dokumentation nur dann "win_dsc", wenn kein natives Modul für die gewünschte Anpassung vorliegt oder der Admin schlicht sehr viel DSC-Erfahrung mitbringt und gegebenenfalls über eine große DSC-Codebasis verfügt. 

**Listing 9: Ansible playbooks (native)** 

```yaml
- name: Install Telnet Client using Native Module
  hosts: windows_workstations
  tasks:
    - name: Enable Telnet Client
      ansible.windows.win_optional_feature:
        name: TelnetClient
        state: present
```

Quelle: https://docs.ansible.com/projects/ansible/latest/os_guide/windows_dsc.html

DSC ist in der Version 3 von Grund auf als plattformübergreifendes Kommandozeilenprogramm entwickelt worden.  Somit eignet es sich prinzipiell in idealer Weise als Brücke zwischen Ansible und Co zu den verwalteten Clients, sein dies nun Windows, MacOS oder Linux-PCs. Ein eigenständiges CM-Werkzeug ist die DSC nicht, es fehlen Push/Pull und Monitoring-Optionen.

Die Ansible-Entwickler können die DSC v3 in die eigene Software  integrieren, um ein einheitliches Management der Ressourcen zu ermöglichen, ein solches DSC v3-Ansible-Modul ist aktuell nicht verfügbar. 

## Nachgedanken 

Es bleibt abzuwarten, ob sich Softwarefirmen und Distributoren finden, die DSC unter Windows, Linux oder macOS integrieren. Mit Ansible, Puppet oder Chef stünden eine Reihe von Lösungen bereit, die der Technologie einen Schub verschaffen könnten. Leider zeigt sich Microsoft selbst recht ambitionslos. Denn weder DSC v3 noch PowerShell 7.x sind Bestandteil der Windows-Betriebssysteme und auch das "Azure Machine Configuration“-Team zeigt sich wenig beeindruckt von den Neuerungen aus dem eigenen Haus. 

Betrachtet man ein Ansible-Playbook im YAML-Format, fällt einem die große Ähnlichkeit zu den DSC-v3-Konfigurationsdokumenten unmittelbar auf. Die neue DSC-Version imitiert – so könnte man meinen – geradezu das Playbook-Format von Ansible.  Somit stellt sich die Frage, warum die Ansible-Entwickler/Redhat DSC v3 den nativen Modulen vorziehen sollte.

Der Schwachpunkt der "Desired State Configuration" bleibt ein altbekannter: Die DSC-Ressourcen sind letztlich der entscheidende Dreh- und Angelpunkt. Und gerade da ändert sich gegenwärtig so gut wie nichts. Ein Riesenvorteil ist, dass sich diese Ressourcen nun in beliebigen Sprachen entwickeln lassen. Für Python- und Linux-affine Ansible-Entwickler bringt das jedoch keinen Mehrwert, da sie Ansible-Erweiterungen bereits heute in verschiedenen Sprachen entwickeln können.  Relevant ist einzig, dass die Ansible-Knoten mittels JSON-Strings kommunizieren, was auch das DSC v3 Utility unterstützt.

So sehr ich es bedauere, das sagen zu müssen: Aus Sicht eines Ansible-Entwicklers wirkt DSC v3 so, als hätte das PowerShell-Team das Rad neu erfunden. DSC v3 wird nur dann eine Zukunft haben, wenn die Qualität des Programmcodes und die Qualität des DSC-Ökosystems so überzeugend sind, dass Ansible und Co. der DSC den Vorzug gegenüber nativen Implementierungen geben. Es wäre schön, wenn Microsoft den Faden in den eigenen Produktgruppen aufnehmen und – zum Beispiel – in einem ersten Schritt ausgereifte DSC-Ressourcen für die eigenen Produkte bereitstellen würde. 

