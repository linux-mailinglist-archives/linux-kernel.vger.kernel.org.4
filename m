Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204AF5B5B21
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiILN1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiILN1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:27:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4852EF05
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662989234; x=1694525234;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SRGI0pjjOGRAsEoNIfL/7Zywsnc5wk2tS3lZ0Xsx84U=;
  b=Xqzv+xW+dpjS8F5FVKv8WUOplUFJMIap4kR9xWWgUn7HF5rYfdl7NqSh
   vadnt1BdwxcV+Ciom3/nK7FeqVeVLwSteMdbrDujsnhazFhpLGXYe/TB+
   qcng+r63BN6kh3hhUf+6rGiJUpEx0fNavHhQON3bq6Vlyxb0jItIXpCCs
   m8Wl8VIx+OD9fPkuvX1O5kJynCYAll0RkK/QCMoxeFOB1JMWL0csXclxQ
   4fPVCbs/kUDv/AwRItUT0TjJI0qGaO6suqKDmZECSJua2ApLCamPeKaw5
   /4YYDdIMX1foNp+RvKKfcUGDMmrpG6qfvraoPO16ylNgKbPalVmsxcEjW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="277596842"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="277596842"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 06:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="944634932"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2022 06:26:49 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXjSa-0002Xj-1r;
        Mon, 12 Sep 2022 13:26:48 +0000
Date:   Mon, 12 Sep 2022 21:26:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/s390/kernel/machine_kexec.c:215: undefined reference to
 `__tsan_memcpy'
Message-ID: <202209122136.ZvcEoCA1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   80e78fcce86de0288793a0ef0f6acf37656ee4cf
commit: ebbc9570169147740aa39aee1d61b4cc5a631644 s390/crash: support multi-segment iterators
date:   8 weeks ago
config: s390-buildonly-randconfig-r003-20220912 (https://download.01.org/0day-ci/archive/20220912/202209122136.ZvcEoCA1-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ebbc9570169147740aa39aee1d61b4cc5a631644
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ebbc9570169147740aa39aee1d61b4cc5a631644
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/s390/kernel/debug.c:1151: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/debug.o:arch/s390/kernel/debug.c:931: more undefined references to `__tsan_memset' follow
   s390x-linux-ld: arch/s390/kernel/debug.o: in function `debug_prolog_level_fn':
   arch/s390/kernel/debug.c:1361: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/debug.o: in function `debug_input_level_fn':
   include/linux/uaccess.h:122: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/debug.o: in function `debug_input_flush_fn':
   arch/s390/kernel/debug.c:1422: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/debug.c:1426: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/debug.c:1426: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/debug.c:1426: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/debug.o:arch/s390/kernel/debug.c:1426: more undefined references to `__tsan_memset' follow
   s390x-linux-ld: arch/s390/kernel/debug.o: in function `debug_input_pages_fn':
   arch/s390/kernel/debug.c:912: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/debug.o: in function `debug_info_copy':
   arch/s390/kernel/debug.c:353: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/debug.c:353: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/debug.c:353: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/debug.c:353: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/irq.o: in function `init_ext_interrupts':
   arch/s390/kernel/irq.c:365: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_ccw_loadparm_store':
   arch/s390/kernel/ipl.c:747: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_ccw_vmparm_show':
   arch/s390/kernel/ipl.c:577: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_ccw_vmparm_store':
   arch/s390/kernel/ipl.c:602: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/ipl.c:602: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/ipl.c:606: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_fcp_loadparm_store':
   arch/s390/kernel/ipl.c:747: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_fcp_scpdata_write':
   arch/s390/kernel/ipl.c:673: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl.c:676: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_nvme_loadparm_store':
   arch/s390/kernel/ipl.c:747: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_nvme_scpdata_write':
   arch/s390/kernel/ipl.c:826: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl.c:829: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_nss_name_store':
   arch/s390/kernel/ipl.c:1023: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_nss_loadparm_store':
   arch/s390/kernel/ipl.c:747: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_nss_vmparm_show':
   arch/s390/kernel/ipl.c:577: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_nss_vmparm_store':
   arch/s390/kernel/ipl.c:602: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/ipl.c:602: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/ipl.c:606: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `ipl_ccw_loadparm_show':
   arch/s390/kernel/ipl.c:426: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `ipl_vm_parm_show':
   arch/s390/kernel/ipl.c:319: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_ccw_init':
   arch/s390/kernel/ipl.c:1184: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_fcp_init':
   arch/s390/kernel/ipl.c:1264: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_nvme_init':
   arch/s390/kernel/ipl.c:1320: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_type_init':
   arch/s390/kernel/ipl.c:1362: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl.c:1359: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl.o:arch/s390/kernel/ipl.c:1365: more undefined references to `__tsan_memcpy' follow
   s390x-linux-ld: arch/s390/kernel/dis.o: in function `show_code':
   arch/s390/kernel/dis.c:503: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/dis.c:504: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/dis.o: in function `show_code':
   include/linux/uaccess.h:122: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/dis.o: in function `show_code':
   arch/s390/kernel/dis.c:561: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/dis.o: in function `show_code':
   include/linux/uaccess.h:122: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/dis.o: in function `print_fn_code':
   arch/s390/kernel/dis.c:569: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/diag.o: in function `diag210':
   arch/s390/kernel/diag.c:185: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/diag.c:190: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/sysinfo.o: in function `s390_adjust_jiffies':
   arch/s390/kernel/sysinfo.c:421: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/sysinfo.o: in function `calibrate_delay':
   arch/s390/kernel/sysinfo.c:421: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/lgr.o: in function `lgr_info_log':
   arch/s390/kernel/lgr.c:145: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/lgr.o: in function `lgr_info_get':
   arch/s390/kernel/lgr.c:120: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/lgr.o: in function `lgr_info_get':
   arch/s390/include/asm/facility.h:104: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/lgr.o: in function `lgr_info_get':
   arch/s390/kernel/lgr.c:60: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/lgr.c:60: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/lgr.c:60: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/lgr.c:60: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/lgr.o: in function `lgr_timer_fn':
   arch/s390/kernel/lgr.c:145: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/os_info.o: in function `os_info_old_entry':
   arch/s390/include/asm/os_info.h:48: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/include/asm/os_info.h:48: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/include/asm/os_info.h:48: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/include/asm/os_info.h:48: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/machine_kexec.o: in function `machine_kexec_prepare':
>> arch/s390/kernel/machine_kexec.c:215: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/machine_kexec.o: in function `__do_machine_kdump':
   arch/s390/kernel/machine_kexec.c:59: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/runtime_instr.o: in function `__se_sys_s390_runtime_instr':
   arch/s390/kernel/runtime_instr.c:91: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/dumpstack.o: in function `show_stack':
   arch/s390/kernel/dumpstack.c:142: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/dumpstack.o: in function `show_regs':
   arch/s390/kernel/dumpstack.c:142: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/dumpstack.o: in function `die':
   arch/s390/kernel/dumpstack.c:142: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/guarded_storage.o: in function `__se_sys_s390_guarded_storage':
   include/linux/uaccess.h:122: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/sthyi.o:arch/s390/kernel/sthyi.c:446: more undefined references to `__tsan_memset' follow
   s390x-linux-ld: arch/s390/kernel/sthyi.o: in function `sthyi_fill':
   arch/s390/kernel/sthyi.c:194: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/sthyi.c:196: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/sthyi.c:312: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/sthyi.c:482: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl_vmparm.o: in function `ipl_block_get_ascii_vmparm':
   arch/s390/kernel/ipl_vmparm.c:20: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/ipl_vmparm.c:20: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/unwind_bc.o: in function `__unwind_start':
   arch/s390/kernel/unwind_bc.c:128: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/smp.o: in function `smp_emergency_stop':
   include/linux/bitmap.h:254: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/smp.o: in function `smp_emergency_stop':
   arch/s390/include/asm/timex.h:182: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/include/asm/timex.h:182: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/include/asm/timex.h:182: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/include/asm/timex.h:182: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/smp.o: in function `smp_ctl_set_clear_bit':
   arch/s390/kernel/smp.c:583: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/smp.o:arch/s390/kernel/smp.c:572: more undefined references to `__tsan_memset' follow
   s390x-linux-ld: arch/s390/kernel/smp.o: in function `__cpu_up':
   arch/s390/kernel/smp.c:202: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/smp.c:203: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/smp.c:262: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/smp.o: in function `smp_start_secondary':
   arch/s390/include/asm/timex.h:182: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/smp.o: in function `__cpu_disable':
   arch/s390/kernel/smp.c:943: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/smp.o: in function `smp_save_cpu_regs':
   arch/s390/include/asm/os_info.h:48: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/stacktrace.o:arch/s390/kernel/stacktrace.c:16: more undefined references to `__tsan_memset' follow
   s390x-linux-ld: arch/s390/kernel/nospec-sysfs.o: in function `cpu_show_spectre_v1':
   arch/s390/kernel/nospec-sysfs.c:10: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/nospec-sysfs.o: in function `cpu_show_spectre_v2':
   arch/s390/kernel/nospec-sysfs.c:22: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/nospec-sysfs.c:17: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/nospec-sysfs.c:21: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `elfcorehdr_alloc':
   arch/s390/kernel/crash_dump.c:463: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:369: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:271: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:274: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:313: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:314: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:315: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:316: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:321: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:271: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:274: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:274: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:274: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:274: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:274: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:271: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:274: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:271: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:271: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:271: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.o:arch/s390/kernel/crash_dump.c:271: more undefined references to `__tsan_memcpy' follow
   s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `elfcorehdr_alloc':
   arch/s390/kernel/crash_dump.c:544: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `elfcorehdr_read':
   arch/s390/kernel/crash_dump.c:645: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `elfcorehdr_read_notes':
   arch/s390/kernel/crash_dump.c:657: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `get_vmcoreinfo_old':
   arch/s390/kernel/crash_dump.c:380: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:382: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `get_vmcoreinfo_old':
   arch/s390/include/asm/os_info.h:48: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `get_vmcoreinfo_old':
   arch/s390/kernel/crash_dump.c:386: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `get_vmcoreinfo_old':
   arch/s390/include/asm/os_info.h:48: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/crash_dump.o:arch/s390/include/asm/os_info.h:48: more undefined references to `__tsan_memset' follow
   s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `save_area_add_regs':
   arch/s390/kernel/crash_dump.c:93: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:94: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:95: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:96: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.c:97: undefined reference to `__tsan_memcpy'
   s390x-linux-ld: arch/s390/kernel/crash_dump.o:arch/s390/kernel/crash_dump.c:116: more undefined references to `__tsan_memcpy' follow
   s390x-linux-ld: arch/s390/kernel/trace.o: in function `trace_event_raw_event_s390_diagnose':
   arch/s390/include/asm/trace/diag.h:23: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/uv.o: in function `uv_destroy_owned_page':
   arch/s390/kernel/uv.c:106: undefined reference to `__tsan_memset'
   s390x-linux-ld: arch/s390/kernel/uv.o: in function `uv_convert_from_secure':


vim +215 arch/s390/kernel/machine_kexec.c

60a0c68df2632f Michael Holzheu 2011-10-30  199  
c6b5b847a7cf11 Heiko Carstens  2006-12-04  200  int machine_kexec_prepare(struct kimage *image)
cf13f0eaffa31b Heiko Carstens  2005-06-25  201  {
c6b5b847a7cf11 Heiko Carstens  2006-12-04  202  	void *reboot_code_buffer;
cf13f0eaffa31b Heiko Carstens  2005-06-25  203  
60a0c68df2632f Michael Holzheu 2011-10-30  204  	if (image->type == KEXEC_TYPE_CRASH)
60a0c68df2632f Michael Holzheu 2011-10-30  205  		return machine_kexec_prepare_kdump();
60a0c68df2632f Michael Holzheu 2011-10-30  206  
cf13f0eaffa31b Heiko Carstens  2005-06-25  207  	/* We don't support anything but the default image type for now. */
cf13f0eaffa31b Heiko Carstens  2005-06-25  208  	if (image->type != KEXEC_TYPE_DEFAULT)
cf13f0eaffa31b Heiko Carstens  2005-06-25  209  		return -EINVAL;
cf13f0eaffa31b Heiko Carstens  2005-06-25  210  
cf13f0eaffa31b Heiko Carstens  2005-06-25  211  	/* Get the destination where the assembler code should be copied to.*/
c6b5b847a7cf11 Heiko Carstens  2006-12-04  212  	reboot_code_buffer = (void *) page_to_phys(image->control_code_page);
cf13f0eaffa31b Heiko Carstens  2005-06-25  213  
cf13f0eaffa31b Heiko Carstens  2005-06-25  214  	/* Then copy it */
c6b5b847a7cf11 Heiko Carstens  2006-12-04 @215  	memcpy(reboot_code_buffer, relocate_kernel, relocate_kernel_len);
cf13f0eaffa31b Heiko Carstens  2005-06-25  216  	return 0;
cf13f0eaffa31b Heiko Carstens  2005-06-25  217  }
cf13f0eaffa31b Heiko Carstens  2005-06-25  218  

:::::: The code at line 215 was first introduced by commit
:::::: c6b5b847a7cf11f131c43fe0041443ec11697fc7 [S390] cpu shutdown rework

:::::: TO: Heiko Carstens <heiko.carstens@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
