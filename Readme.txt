
cmd's ...
    cd C:\IBM\WCDE_ENT70\workspace\XUtill
    
    git add .
    git commit -m "commit msg ..."
    git remote add origin https://github.com/xjjo/XUtil.git
    git push -u origin master
    
----------------------------------------------------------------------------
----------------------------------------------------------------------------
be carefull with simbolic Links and theirs path's

Example
---------
mklink /D (folder) simbolik realFolder
mklink /D "E:\Path\Symlink_Books" "F:\Books"
--\\vmware-host\Shared Folders\XJO\git.repositories\XUtill is the real path and it referes to a net path, but in the host is in c:\XJO\git.repositories\XUtill 
--C:\IBM\WCDE_ENT70\workspace2\XUtill is the simbolic link inside the vm machine

mklink /D "C:\IBM\WCDE_ENT70\workspace2\XUtill" "\\vmware-host\Shared Folders\XJO\git.repositories\XUtill"