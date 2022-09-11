Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A035B4C2F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 07:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiIKFgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 01:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiIKFgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 01:36:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7BF3ECF2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 22:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662874600; x=1694410600;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3fOEPaTAAh18tUunwzCItwg3gaaPJo4Q4hfDFIVpjJQ=;
  b=U0exElHC/L1VmszBXr3zFKi5G+dNUWU8GN9uf7+yPlMA3gwCGTPJvCl7
   341hoeI5E/sPJjaATRJdgYUw96fumj8zpyYy+nDh1dpjH4KomLdALFhyW
   znMmovuVn0KfdANhBMPQRPc6eCXtaacwxJeHpSHvxh31sSQXpkMhkJwDN
   Sks1AkRNZ3T0rpKXiUNu+Wt0LsauLSSvJoEtnmcH79nmlBhnL+JVIsA3c
   JanjbvY7AhcD3VUZMcDKeVuDPhuQV9PrCnD0hmQ99Hf+YumOMxtm46yHJ
   WzGdonhOmNKwXPNz+3i2RXITV92g1+SJsHgL702VTBrMBjXM0xvUj61Ck
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="296432097"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="296432097"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 22:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="704825148"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Sep 2022 22:36:38 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXFe1-00010V-25;
        Sun, 11 Sep 2022 05:36:37 +0000
Date:   Sun, 11 Sep 2022 13:35:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: s390x-linux-ld: reboot.c:undefined reference to `__tsan_memset'
Message-ID: <202209111311.pJj7LWEF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b96fbd602d35739b5cdb49baa02048f2c41fdab1
commit: 587b9bfe0668bc997e51af9526a0c7c084d4660f kernel/reboot: Use static handler for register_platform_power_off()
date:   3 months ago
config: s390-randconfig-r044-20220909 (https://download.01.org/0day-ci/archive/20220911/202209111311.pJj7LWEF-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=587b9bfe0668bc997e51af9526a0c7c084d4660f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 587b9bfe0668bc997e51af9526a0c7c084d4660f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390x-linux-ld: sys.c:(.text+0x3d0e): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: sys.c:(.text+0x3d24): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/sys.o: in function `__se_sys_gethostname':
   sys.c:(.text+0x3d8e): undefined reference to `__tsan_memset'
   s390x-linux-ld: sys.c:(.text+0x3e0c): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: kernel/sys.o: in function `__se_sys_setdomainname':
   sys.c:(.text+0x3f5c): undefined reference to `__tsan_memset'
   s390x-linux-ld: sys.c:(.text+0x40a8): undefined reference to `__tsan_memset'
   s390x-linux-ld: sys.c:(.text+0x40fe): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: sys.c:(.text+0x4114): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/sys.o: in function `__se_sys_getrlimit':
   sys.c:(.text+0x41e2): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: kernel/sys.o: in function `__se_sys_old_getrlimit':
   sys.c:(.text+0x437a): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: kernel/sys.o: in function `__se_sys_prlimit64':
   sys.c:(.text+0x44fa): undefined reference to `__tsan_memset'
   s390x-linux-ld: sys.c:(.text+0x450c): undefined reference to `__tsan_memset'
   s390x-linux-ld: sys.c:(.text+0x451e): undefined reference to `__tsan_memset'
   s390x-linux-ld: sys.c:(.text+0x453e): undefined reference to `__tsan_memset'
   s390x-linux-ld: sys.c:(.text+0x4636): undefined reference to `__tsan_memset'
   s390x-linux-ld: sys.c:(.text+0x49dc): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: sys.c:(.text+0x49fa): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: kernel/sys.o: in function `__se_sys_setrlimit':
   sys.c:(.text+0x4be0): undefined reference to `__tsan_memset'
   s390x-linux-ld: sys.c:(.text+0x4cce): undefined reference to `__tsan_memset'
   s390x-linux-ld: sys.c:(.text+0x4dec): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: kernel/sys.o: in function `getrusage':
   sys.c:(.text+0x4ec0): undefined reference to `__tsan_memset'
   s390x-linux-ld: sys.c:(.text+0x5632): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: sys.c:(.text+0x5662): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: kernel/sys.o: in function `__se_sys_getrusage':
   sys.c:(.text+0x575a): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/sys.o: in function `__se_sys_prctl':
   sys.c:(.text+0x595a): undefined reference to `__tsan_memset'
   s390x-linux-ld: sys.c:(.text+0x6208): undefined reference to `__tsan_memset'
   s390x-linux-ld: sys.c:(.text+0x6304): undefined reference to `__tsan_memset'
   s390x-linux-ld: sys.c:(.text+0x656c): undefined reference to `__tsan_memset'
   s390x-linux-ld: sys.c:(.text+0x659c): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: kernel/sys.o: in function `__se_sys_sysinfo':
   sys.c:(.text+0x6a5c): undefined reference to `__tsan_memset'
   s390x-linux-ld: DWARF error: could not find abbrev number 97
   kernel/umh.o: in function `__usermodehelper_disable':
   umh.c:(.text+0x380): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/umh.o: in function `call_usermodehelper_exec':
   umh.c:(.text+0x780): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/umh.o: in function `call_usermodehelper':
   umh.c:(.text+0xa9a): undefined reference to `__tsan_memset'
   s390x-linux-ld: umh.c:(.text+0xaac): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/umh.o: in function `proc_cap_handler':
   umh.c:(.text+0xdc6): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: DWARF error: could not find abbrev number 44
   kernel/workqueue.o: in function `trace_event_raw_event_workqueue_queue_work':
   workqueue.c:(.text+0x282): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/workqueue.o: in function `trace_event_raw_event_workqueue_activate_work':
   workqueue.c:(.text+0x43a): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/workqueue.o: in function `trace_event_raw_event_workqueue_execute_start':
   workqueue.c:(.text+0x51a): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/workqueue.o: in function `trace_event_raw_event_workqueue_execute_end':
   workqueue.c:(.text+0x61e): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/workqueue.o: in function `flush_workqueue':
   workqueue.c:(.text+0x254c): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/workqueue.o:workqueue.c:(.text+0x3640): more undefined references to `__tsan_memset' follow
   s390x-linux-ld: kernel/workqueue.o: in function `process_one_work':
   workqueue.c:(.text+0xd5ce): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: workqueue.c:(.text+0xd5e4): undefined reference to `__tsan_memset'
   s390x-linux-ld: workqueue.c:(.text+0xe144): undefined reference to `__tsan_memset'
   s390x-linux-ld: workqueue.c:(.text+0xe158): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/workqueue.o: in function `workqueue_init_early':
   workqueue.c:(.init.text+0x2c2): undefined reference to `__tsan_memset'
   s390x-linux-ld: workqueue.c:(.init.text+0x372): undefined reference to `__tsan_memset'
   s390x-linux-ld: DWARF error: could not find abbrev number 100
   kernel/pid.o:pid.c:(.text+0x65e): more undefined references to `__tsan_memset' follow
   s390x-linux-ld: DWARF error: could not find abbrev number 2880
   kernel/params.o: in function `param_array_get':
   params.c:(.text+0x1d50): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: kernel/params.o: in function `add_sysfs_param':
   params.c:(.text+0x2506): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/params.o: in function `param_sysfs_builtin':
   params.c:(.init.text+0x166): undefined reference to `__tsan_memset'
   s390x-linux-ld: DWARF error: could not find abbrev number 76
   kernel/kthread.o: in function `kthread_create_on_node':
   kthread.c:(.text+0x9b8): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/kthread.o: in function `__kthread_create_on_node':
   kthread.c:(.text+0xa3c): undefined reference to `__tsan_memset'
   s390x-linux-ld: kthread.c:(.text+0xc3a): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/kthread.o:kthread.c:(.text+0xc4c): more undefined references to `__tsan_memset' follow
   s390x-linux-ld: DWARF error: could not find abbrev number 16057
   kernel/ksysfs.o: in function `uevent_helper_store':
   ksysfs.c:(.text+0x126): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: kernel/ksysfs.o: in function `notes_read':
   ksysfs.c:(.text+0x59a): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: DWARF error: could not find abbrev number 33
   kernel/cred.o: in function `prepare_creds':
   cred.c:(.text+0x71e): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: kernel/cred.o: in function `prepare_kernel_cred':
   cred.c:(.text+0x17d0): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: cred.c:(.text+0x1896): undefined reference to `__tsan_memset'
   s390x-linux-ld: DWARF error: could not find abbrev number 14
   kernel/reboot.o: in function `register_sys_off_handler':
   reboot.c:(.text+0x91e): undefined reference to `__tsan_memset'
>> s390x-linux-ld: reboot.c:(.text+0x942): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/reboot.o: in function `unregister_sys_off_handler':
   reboot.c:(.text+0xa7e): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/reboot.o: in function `devm_register_sys_off_handler':
   reboot.c:(.text+0xcca): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/reboot.o:reboot.c:(.text+0xdb0): more undefined references to `__tsan_memset' follow
   s390x-linux-ld: DWARF error: could not find abbrev number 34
   kernel/range.o: in function `add_range_with_merge':
   range.c:(.text+0x144): undefined reference to `__tsan_memmove'
   s390x-linux-ld: range.c:(.text+0x168): undefined reference to `__tsan_memset'
   s390x-linux-ld: range.c:(.text+0x200): undefined reference to `__tsan_memmove'
   s390x-linux-ld: range.c:(.text+0x220): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/range.o: in function `subtract_range':
   range.c:(.text+0x2ee): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/range.o: in function `clean_sort_range':
   range.c:(.text+0x654): undefined reference to `__tsan_memset'
   s390x-linux-ld: DWARF error: could not find abbrev number 35
   kernel/ucount.o: in function `get_ucounts':
   ucount.c:(.text+0xe4): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/ucount.o: in function `put_ucounts':
   ucount.c:(.text+0x1cc): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/ucount.o:ucount.c:(.text+0x5a2): more undefined references to `__tsan_memset' follow
   s390x-linux-ld: DWARF error: could not find abbrev number 62
   kernel/printk/printk.o: in function `trace_event_raw_event_console':
   printk.c:(.text+0x1a4): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: kernel/printk/printk.o: in function `devkmsg_read':
   printk.c:(.text+0x5ae): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x854): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/printk/printk.o: in function `devkmsg_poll':
   printk.c:(.text+0xbe0): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/printk/printk.o: in function `devkmsg_open':
   printk.c:(.text+0xdaa): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/printk/printk.o: in function `do_syslog':
   printk.c:(.text+0x13f8): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/printk/printk.o:printk.c:(.text+0x1592): more undefined references to `__tsan_memset' follow
   s390x-linux-ld: kernel/printk/printk.o: in function `do_syslog':
   printk.c:(.text+0x18fc): undefined reference to `__tsan_memmove'
   s390x-linux-ld: printk.c:(.text+0x190e): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: printk.c:(.text+0x1e14): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/printk/printk.o: in function `syslog_print':
   printk.c:(.text+0x20c4): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x21f6): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x23c0): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x2494): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x2580): undefined reference to `__tsan_memmove'
   s390x-linux-ld: printk.c:(.text+0x2592): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: kernel/printk/printk.o: in function `vprintk_store':
   printk.c:(.text+0x2b2c): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x2b3e): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x2b56): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x2ee4): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x2fe4): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/printk/printk.o:printk.c:(.text+0x3074): more undefined references to `__tsan_memset' follow
   s390x-linux-ld: kernel/printk/printk.o: in function `vprintk_store':
   printk.c:(.text+0x33e6): undefined reference to `__tsan_memmove'
   s390x-linux-ld: printk.c:(.text+0x3536): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: printk.c:(.text+0x35c6): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: printk.c:(.text+0x3612): undefined reference to `__tsan_memmove'
   s390x-linux-ld: kernel/printk/printk.o: in function `early_printk':
   printk.c:(.text+0x44bc): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x44ce): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/printk/printk.o: in function `register_console':
   printk.c:(.text+0x7398): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/printk/printk.o: in function `kmsg_dump_get_line':
   printk.c:(.text+0x8714): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x8806): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/printk/printk.o:printk.c:(.text+0x88e2): more undefined references to `__tsan_memset' follow
   s390x-linux-ld: kernel/printk/printk.o: in function `kmsg_dump_get_line':
   printk.c:(.text+0x89c4): undefined reference to `__tsan_memmove'
   s390x-linux-ld: printk.c:(.text+0x89d6): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: printk.c:(.text+0x8af0): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/printk/printk.o: in function `kmsg_dump_get_buffer':
   printk.c:(.text+0x8caa): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x8f36): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x9012): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x90f2): undefined reference to `__tsan_memmove'
   s390x-linux-ld: printk.c:(.text+0x9104): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: kernel/printk/printk.o: in function `find_first_fitting_seq':
   printk.c:(.text+0x91f0): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x9316): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x94d6): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/printk/printk.o: in function `__console_emit_next_record':
   printk.c:(.text+0x9cea): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.text+0x9f2c): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/printk/printk.o:printk.c:(.text+0xa0c8): more undefined references to `__tsan_memset' follow
   s390x-linux-ld: kernel/printk/printk.o: in function `__console_emit_next_record':
   printk.c:(.text+0xa274): undefined reference to `__tsan_memmove'
   s390x-linux-ld: printk.c:(.text+0xa286): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: kernel/printk/printk.o: in function `printk_kthread_func':
   printk.c:(.text+0xad3e): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/printk/printk.o: in function `setup_log_buf':
   printk.c:(.init.text+0x292): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/printk/printk.o: in function `add_to_rb':
   printk.c:(.init.text+0x8b8): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.init.text+0x900): undefined reference to `__tsan_memset'
   s390x-linux-ld: printk.c:(.init.text+0x962): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: printk.c:(.init.text+0xac0): undefined reference to `__tsan_memcpy'
   s390x-linux-ld: kernel/printk/printk.o: in function `console_setup':
   printk.c:(.init.text+0xbda): undefined reference to `__tsan_memset'
   s390x-linux-ld: kernel/printk/printk.o: in function `_printk':
   printk.c:(.text.unlikely.+0x2c): undefined reference to `__tsan_memset'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
