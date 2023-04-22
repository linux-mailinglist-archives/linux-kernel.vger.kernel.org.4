Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF36EB9CF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 16:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjDVOz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 10:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDVOzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 10:55:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33181981;
        Sat, 22 Apr 2023 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682175350; x=1713711350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bp0lZbgB9qXMzSvQZwpIeAsM6SvqExlhhg1XVVT7xEk=;
  b=nje+aFtnE2tUzsXWpCyMt8E07c1o91AiQQchv6lz5tXPaO6reQu3eqG+
   BOPB6OOKFNxkKKPe7CcmDivuLgqb1ApsoZXexdCJflZNWwRq7AY7TeNET
   0OmHH0+YK4f9Bj3qkIxpIhAiw/Shp7ZsB1FjsOTFpduWK+PRVJ+M9XFgi
   9qCGg7oR6Dn1CWsFzJBcpND2CUc0iJ+CeM26y7U/BASG/rHJqq9v/XlQF
   Fk+Bq5+BSUYiZKEPQrGo0ogKQI9QmZkFee3NRKy4AIDEMZE5Xgn3XXweo
   jgxAfCwEkBxIuOik86X+eRA7c0HgaPoIJiBVAcQ9q9sElQnreZZrFUCqe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="348959628"
X-IronPort-AV: E=Sophos;i="5.99,218,1677571200"; 
   d="scan'208";a="348959628"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 07:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="670007526"
X-IronPort-AV: E=Sophos;i="5.99,218,1677571200"; 
   d="scan'208";a="670007526"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2023 07:55:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqEeQ-000hLS-0T;
        Sat, 22 Apr 2023 14:55:46 +0000
Date:   Sat, 22 Apr 2023 22:55:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v9 09/11] AppArmor: Add selfattr hooks
Message-ID: <202304222257.AqAHzkgi-lkp@intel.com>
References: <20230421174259.2458-10-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-10-casey@schaufler-ca.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/perf/core]
[also build test WARNING on acme/perf/core shuah-kselftest/next shuah-kselftest/fixes linus/master v6.3-rc7]
[cannot apply to next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230422-024331
base:   tip/perf/core
patch link:    https://lore.kernel.org/r/20230421174259.2458-10-casey%40schaufler-ca.com
patch subject: [PATCH v9 09/11] AppArmor: Add selfattr hooks
config: mips-randconfig-s051-20230421 (https://download.01.org/0day-ci/archive/20230422/202304222257.AqAHzkgi-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/2628bfcd3ff1b12fbae522a5449a7344ffe6ecbd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230422-024331
        git checkout 2628bfcd3ff1b12fbae522a5449a7344ffe6ecbd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash security/apparmor/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304222257.AqAHzkgi-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> security/apparmor/lsm.c:1339:9: sparse: sparse: incorrect type in initializer (incompatible argument 3 (different address spaces)) @@     expected int ( *setselfattr )( ... ) @@     got int ( * )( ... ) @@
   security/apparmor/lsm.c:1339:9: sparse:     expected int ( *setselfattr )( ... )
   security/apparmor/lsm.c:1339:9: sparse:     got int ( * )( ... )
>> security/apparmor/lsm.c:643:13: sparse: sparse: dereference of noderef expression
   security/apparmor/lsm.c:645:18: sparse: sparse: dereference of noderef expression
   security/apparmor/lsm.c:647:18: sparse: sparse: dereference of noderef expression
   security/apparmor/lsm.c:785:13: sparse: sparse: dereference of noderef expression
   security/apparmor/lsm.c:785:41: sparse: sparse: dereference of noderef expression
   security/apparmor/lsm.c:788:27: sparse: sparse: dereference of noderef expression
   security/apparmor/lsm.c:788:27: sparse: sparse: dereference of noderef expression
   security/apparmor/lsm.c:793:42: sparse: sparse: dereference of noderef expression
   security/apparmor/lsm.c:793:42: sparse: sparse: dereference of noderef expression
   security/apparmor/lsm.c:795:34: sparse: sparse: dereference of noderef expression
   security/apparmor/lsm.c:798:33: sparse: sparse: dereference of noderef expression

vim +1339 security/apparmor/lsm.c

  1305	
  1306	static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
  1307		LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
  1308		LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
  1309		LSM_HOOK_INIT(capget, apparmor_capget),
  1310		LSM_HOOK_INIT(capable, apparmor_capable),
  1311	
  1312		LSM_HOOK_INIT(sb_mount, apparmor_sb_mount),
  1313		LSM_HOOK_INIT(sb_umount, apparmor_sb_umount),
  1314		LSM_HOOK_INIT(sb_pivotroot, apparmor_sb_pivotroot),
  1315	
  1316		LSM_HOOK_INIT(path_link, apparmor_path_link),
  1317		LSM_HOOK_INIT(path_unlink, apparmor_path_unlink),
  1318		LSM_HOOK_INIT(path_symlink, apparmor_path_symlink),
  1319		LSM_HOOK_INIT(path_mkdir, apparmor_path_mkdir),
  1320		LSM_HOOK_INIT(path_rmdir, apparmor_path_rmdir),
  1321		LSM_HOOK_INIT(path_mknod, apparmor_path_mknod),
  1322		LSM_HOOK_INIT(path_rename, apparmor_path_rename),
  1323		LSM_HOOK_INIT(path_chmod, apparmor_path_chmod),
  1324		LSM_HOOK_INIT(path_chown, apparmor_path_chown),
  1325		LSM_HOOK_INIT(path_truncate, apparmor_path_truncate),
  1326		LSM_HOOK_INIT(inode_getattr, apparmor_inode_getattr),
  1327	
  1328		LSM_HOOK_INIT(file_open, apparmor_file_open),
  1329		LSM_HOOK_INIT(file_receive, apparmor_file_receive),
  1330		LSM_HOOK_INIT(file_permission, apparmor_file_permission),
  1331		LSM_HOOK_INIT(file_alloc_security, apparmor_file_alloc_security),
  1332		LSM_HOOK_INIT(file_free_security, apparmor_file_free_security),
  1333		LSM_HOOK_INIT(mmap_file, apparmor_mmap_file),
  1334		LSM_HOOK_INIT(file_mprotect, apparmor_file_mprotect),
  1335		LSM_HOOK_INIT(file_lock, apparmor_file_lock),
  1336		LSM_HOOK_INIT(file_truncate, apparmor_file_truncate),
  1337	
  1338		LSM_HOOK_INIT(getselfattr, apparmor_getselfattr),
> 1339		LSM_HOOK_INIT(setselfattr, apparmor_setselfattr),
  1340		LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
  1341		LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
  1342	
  1343		LSM_HOOK_INIT(sk_alloc_security, apparmor_sk_alloc_security),
  1344		LSM_HOOK_INIT(sk_free_security, apparmor_sk_free_security),
  1345		LSM_HOOK_INIT(sk_clone_security, apparmor_sk_clone_security),
  1346	
  1347		LSM_HOOK_INIT(socket_create, apparmor_socket_create),
  1348		LSM_HOOK_INIT(socket_post_create, apparmor_socket_post_create),
  1349		LSM_HOOK_INIT(socket_bind, apparmor_socket_bind),
  1350		LSM_HOOK_INIT(socket_connect, apparmor_socket_connect),
  1351		LSM_HOOK_INIT(socket_listen, apparmor_socket_listen),
  1352		LSM_HOOK_INIT(socket_accept, apparmor_socket_accept),
  1353		LSM_HOOK_INIT(socket_sendmsg, apparmor_socket_sendmsg),
  1354		LSM_HOOK_INIT(socket_recvmsg, apparmor_socket_recvmsg),
  1355		LSM_HOOK_INIT(socket_getsockname, apparmor_socket_getsockname),
  1356		LSM_HOOK_INIT(socket_getpeername, apparmor_socket_getpeername),
  1357		LSM_HOOK_INIT(socket_getsockopt, apparmor_socket_getsockopt),
  1358		LSM_HOOK_INIT(socket_setsockopt, apparmor_socket_setsockopt),
  1359		LSM_HOOK_INIT(socket_shutdown, apparmor_socket_shutdown),
  1360	#ifdef CONFIG_NETWORK_SECMARK
  1361		LSM_HOOK_INIT(socket_sock_rcv_skb, apparmor_socket_sock_rcv_skb),
  1362	#endif
  1363		LSM_HOOK_INIT(socket_getpeersec_stream,
  1364			      apparmor_socket_getpeersec_stream),
  1365		LSM_HOOK_INIT(socket_getpeersec_dgram,
  1366			      apparmor_socket_getpeersec_dgram),
  1367		LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
  1368	#ifdef CONFIG_NETWORK_SECMARK
  1369		LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
  1370	#endif
  1371	
  1372		LSM_HOOK_INIT(cred_alloc_blank, apparmor_cred_alloc_blank),
  1373		LSM_HOOK_INIT(cred_free, apparmor_cred_free),
  1374		LSM_HOOK_INIT(cred_prepare, apparmor_cred_prepare),
  1375		LSM_HOOK_INIT(cred_transfer, apparmor_cred_transfer),
  1376	
  1377		LSM_HOOK_INIT(bprm_creds_for_exec, apparmor_bprm_creds_for_exec),
  1378		LSM_HOOK_INIT(bprm_committing_creds, apparmor_bprm_committing_creds),
  1379		LSM_HOOK_INIT(bprm_committed_creds, apparmor_bprm_committed_creds),
  1380	
  1381		LSM_HOOK_INIT(task_free, apparmor_task_free),
  1382		LSM_HOOK_INIT(task_alloc, apparmor_task_alloc),
  1383		LSM_HOOK_INIT(current_getsecid_subj, apparmor_current_getsecid_subj),
  1384		LSM_HOOK_INIT(task_getsecid_obj, apparmor_task_getsecid_obj),
  1385		LSM_HOOK_INIT(task_setrlimit, apparmor_task_setrlimit),
  1386		LSM_HOOK_INIT(task_kill, apparmor_task_kill),
  1387	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
