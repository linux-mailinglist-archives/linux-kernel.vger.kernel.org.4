Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB906AA853
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 07:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCDGbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 01:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDGbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 01:31:44 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5C012861
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 22:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677911501; x=1709447501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2xjW8UXfYVZizYZ3X6AhoGj6AODJ5vMeZKBBdiY/UX4=;
  b=WPZgIG/7LchMoDNEP8Ku1/PwiXMzAE7vac+ZpDZAHCxdkoXieNx91jvv
   PF8Y41c3h2LK3m+QkeQBv9J7pIbT4JquN0qluJGn+uFblRQjacFFXGwSL
   QcSaE/CQJRx9R6l5o5Rqk/dioDs87RdtQcwE/aLu/RxFL4NfYzKkgepf1
   yUfU92GBVWtUGRMGm7bU3a0g6o0F9oaSB1uDAejX6VHIJ7N8aAM7VgG9Z
   nVQdxxWejFnGKVYRDNup8aNVNrz73T7pQoidFNpF6WEWk4YQNVSEwVy7L
   C1NFPoaiAOJtvlewL105xa1y4+mi2FcArTPMXLSNGMXjhGIpOsQ1n7LlO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="335256047"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="335256047"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 22:31:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="764663560"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="764663560"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2023 22:31:38 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYLQf-0001vV-21;
        Sat, 04 Mar 2023 06:31:37 +0000
Date:   Sat, 4 Mar 2023 14:30:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Schspa Shi <schspa@gmail.com>, tglx@linutronix.de,
        longman@redhat.com, swboyd@chromium.org, linux@roeck-us.net,
        wuchi.zero@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Schspa Shi <schspa@gmail.com>
Subject: Re: [PATCH v2 2/2] debugobject: add unit test for static debug object
Message-ID: <202303041412.ikI5GiS6-lkp@intel.com>
References: <20230303183147.934793-2-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303183147.934793-2-schspa@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Schspa,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.2 next-20230303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Schspa-Shi/debugobject-add-unit-test-for-static-debug-object/20230304-024247
patch link:    https://lore.kernel.org/r/20230303183147.934793-2-schspa%40gmail.com
patch subject: [PATCH v2 2/2] debugobject: add unit test for static debug object
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230304/202303041412.ikI5GiS6-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/54cf5a36c1c89cb79463e38bdbd636a016a80c66
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Schspa-Shi/debugobject-add-unit-test-for-static-debug-object/20230304-024247
        git checkout 54cf5a36c1c89cb79463e38bdbd636a016a80c66
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303041412.ikI5GiS6-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kgdb.h:19,
                    from include/drm/drm_util.h:36,
                    from include/drm/drm_connector.h:32,
                    from include/drm/drm_modes.h:33,
                    from include/drm/drm_crtc.h:32,
                    from include/drm/drm_atomic_helper.h:31,
                    from drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c:8:
>> include/linux/kprobes.h:70:9: error: unknown type name 'kprobe_opcode_t'
      70 |         kprobe_opcode_t *addr;
         |         ^~~~~~~~~~~~~~~
   include/linux/kprobes.h:85:9: error: unknown type name 'kprobe_opcode_t'
      85 |         kprobe_opcode_t opcode;
         |         ^~~~~~~~~~~~~~~
>> include/linux/kprobes.h:88:35: error: field 'ainsn' has incomplete type
      88 |         struct arch_specific_insn ainsn;
         |                                   ^~~~~
   include/linux/kprobes.h:174:9: error: unknown type name 'kprobe_opcode_t'
     174 |         kprobe_opcode_t *ret_addr;
         |         ^~~~~~~~~~~~~~~
   include/linux/kprobes.h:298:33: error: unknown type name 'kprobe_opcode_t'
     298 | extern int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset);
         |                                 ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/percpu.h:7,
                    from arch/alpha/include/asm/percpu.h:17,
                    from include/linux/irqflags.h:17,
                    from include/linux/spinlock.h:59,
                    from include/drm/drm_crtc.h:28:
   include/linux/kprobes.h: In function 'get_kprobe_ctlblk':
>> include/linux/percpu-defs.h:219:59: error: invalid use of undefined type 'struct kprobe_ctlblk'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                           ^
   include/linux/percpu-defs.h:241:9: note: in expansion of macro '__verify_pcpu_ptr'
     241 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/kprobes.h:414:16: note: in expansion of macro 'this_cpu_ptr'
     414 |         return this_cpu_ptr(&kprobe_ctlblk);
         |                ^~~~~~~~~~~~
   include/linux/kprobes.h: At top level:
   include/linux/kprobes.h:417:1: error: unknown type name 'kprobe_opcode_t'
     417 | kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
         | ^~~~~~~~~~~~~~~
   include/linux/kprobes.h:418:1: error: unknown type name 'kprobe_opcode_t'
     418 | kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset, bool *on_func_entry);
         | ^~~~~~~~~~~~~~~
   include/linux/kprobes.h: In function 'kprobe_page_fault':
>> include/linux/kprobes.h:599:16: error: implicit declaration of function 'kprobe_fault_handler' [-Werror=implicit-function-declaration]
     599 |         return kprobe_fault_handler(regs, trap);
         |                ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/kgdb.h:19,
                    from include/linux/fb.h:6,
                    from include/linux/vga_switcheroo.h:34,
                    from sound/pci/hda/hda_intel.c:52:
>> include/linux/kprobes.h:70:9: error: unknown type name 'kprobe_opcode_t'
      70 |         kprobe_opcode_t *addr;
         |         ^~~~~~~~~~~~~~~
   include/linux/kprobes.h:85:9: error: unknown type name 'kprobe_opcode_t'
      85 |         kprobe_opcode_t opcode;
         |         ^~~~~~~~~~~~~~~
>> include/linux/kprobes.h:88:35: error: field 'ainsn' has incomplete type
      88 |         struct arch_specific_insn ainsn;
         |                                   ^~~~~
   include/linux/kprobes.h:174:9: error: unknown type name 'kprobe_opcode_t'
     174 |         kprobe_opcode_t *ret_addr;
         |         ^~~~~~~~~~~~~~~
   include/linux/kprobes.h:298:33: error: unknown type name 'kprobe_opcode_t'
     298 | extern int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset);
         |                                 ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/percpu.h:7,
                    from arch/alpha/include/asm/percpu.h:17,
                    from include/linux/irqflags.h:17,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/delay.h:23,
                    from sound/pci/hda/hda_intel.c:23:
   include/linux/kprobes.h: In function 'get_kprobe_ctlblk':
>> include/linux/percpu-defs.h:219:59: error: invalid use of undefined type 'struct kprobe_ctlblk'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                           ^
   include/linux/percpu-defs.h:241:9: note: in expansion of macro '__verify_pcpu_ptr'
     241 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/kprobes.h:414:16: note: in expansion of macro 'this_cpu_ptr'
     414 |         return this_cpu_ptr(&kprobe_ctlblk);
         |                ^~~~~~~~~~~~
   include/linux/kprobes.h: At top level:
   include/linux/kprobes.h:417:1: error: unknown type name 'kprobe_opcode_t'
     417 | kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
         | ^~~~~~~~~~~~~~~
   include/linux/kprobes.h:418:1: error: unknown type name 'kprobe_opcode_t'
     418 | kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset, bool *on_func_entry);
         | ^~~~~~~~~~~~~~~
   include/linux/kprobes.h: In function 'kprobe_page_fault':
>> include/linux/kprobes.h:599:16: error: implicit declaration of function 'kprobe_fault_handler' [-Werror=implicit-function-declaration]
     599 |         return kprobe_fault_handler(regs, trap);
         |                ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/init.h:5,
                    from include/linux/printk.h:6,
                    from include/asm-generic/bug.h:22,
                    from arch/alpha/include/asm/bug.h:23,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/alpha/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12:
   sound/pci/hda/hda_intel.c: At top level:
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:232:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     232 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:55:59: note: in expansion of macro '__must_be_array'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   include/linux/moduleparam.h:517:20: note: in expansion of macro 'ARRAY_SIZE'
     517 |         = { .max = ARRAY_SIZE(array), .num = nump,                      \
         |                    ^~~~~~~~~~
   include/linux/moduleparam.h:501:9: note: in expansion of macro 'module_param_array_named'
     501 |         module_param_array_named(name, name, type, nump, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   sound/pci/hda/hda_intel.c:125:1: note: in expansion of macro 'module_param_array'
     125 | module_param_array(index, int, NULL, 0444);
         | ^~~~~~~~~~~~~~~~~~
   sound/pci/hda/hda_intel.c:104:12: warning: 'index' defined but not used [-Wunused-variable]
     104 | static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
         |            ^~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/kgdb.h:19,
                    from include/drm/drm_util.h:36,
                    from include/drm/drm_connector.h:32,
                    from include/drm/drm_modes.h:33,
                    from include/drm/drm_crtc.h:32,
                    from include/drm/drm_atomic.h:31,
                    from drivers/gpu/drm/arm/malidp_planes.c:12:
>> include/linux/kprobes.h:70:9: error: unknown type name 'kprobe_opcode_t'
      70 |         kprobe_opcode_t *addr;
         |         ^~~~~~~~~~~~~~~
   include/linux/kprobes.h:85:9: error: unknown type name 'kprobe_opcode_t'
      85 |         kprobe_opcode_t opcode;
         |         ^~~~~~~~~~~~~~~
>> include/linux/kprobes.h:88:35: error: field 'ainsn' has incomplete type
      88 |         struct arch_specific_insn ainsn;
         |                                   ^~~~~
   include/linux/kprobes.h:174:9: error: unknown type name 'kprobe_opcode_t'
     174 |         kprobe_opcode_t *ret_addr;
         |         ^~~~~~~~~~~~~~~
   include/linux/kprobes.h:298:33: error: unknown type name 'kprobe_opcode_t'
     298 | extern int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset);
         |                                 ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/percpu.h:7,
                    from arch/alpha/include/asm/percpu.h:17,
                    from include/linux/irqflags.h:17,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from include/linux/scatterlist.h:8,
                    from include/linux/iommu.h:10,
                    from drivers/gpu/drm/arm/malidp_planes.c:9:
   include/linux/kprobes.h: In function 'get_kprobe_ctlblk':
>> include/linux/percpu-defs.h:219:59: error: invalid use of undefined type 'struct kprobe_ctlblk'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                           ^
   include/linux/percpu-defs.h:241:9: note: in expansion of macro '__verify_pcpu_ptr'
     241 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/kprobes.h:414:16: note: in expansion of macro 'this_cpu_ptr'
     414 |         return this_cpu_ptr(&kprobe_ctlblk);
         |                ^~~~~~~~~~~~
   include/linux/kprobes.h: At top level:
   include/linux/kprobes.h:417:1: error: unknown type name 'kprobe_opcode_t'
     417 | kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
         | ^~~~~~~~~~~~~~~
   include/linux/kprobes.h:418:1: error: unknown type name 'kprobe_opcode_t'
     418 | kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset, bool *on_func_entry);
         | ^~~~~~~~~~~~~~~
   include/linux/kprobes.h: In function 'kprobe_page_fault':
   include/linux/kprobes.h:599:16: error: implicit declaration of function 'kprobe_fault_handler'; did you mean 'iommu_set_fault_handler'? [-Werror=implicit-function-declaration]
     599 |         return kprobe_fault_handler(regs, trap);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                iommu_set_fault_handler
   cc1: some warnings being treated as errors
--
   In file included from include/linux/kgdb.h:19,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:64,
                    from drivers/gpu/drm/amd/amdgpu/si_dma.c:25:
>> include/linux/kprobes.h:70:9: error: unknown type name 'kprobe_opcode_t'
      70 |         kprobe_opcode_t *addr;
         |         ^~~~~~~~~~~~~~~
   include/linux/kprobes.h:85:9: error: unknown type name 'kprobe_opcode_t'
      85 |         kprobe_opcode_t opcode;
         |         ^~~~~~~~~~~~~~~
>> include/linux/kprobes.h:88:35: error: field 'ainsn' has incomplete type
      88 |         struct arch_specific_insn ainsn;
         |                                   ^~~~~
   include/linux/kprobes.h:174:9: error: unknown type name 'kprobe_opcode_t'
     174 |         kprobe_opcode_t *ret_addr;
         |         ^~~~~~~~~~~~~~~
   include/linux/kprobes.h:298:33: error: unknown type name 'kprobe_opcode_t'
     298 | extern int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset);
         |                                 ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/percpu.h:7,
                    from arch/alpha/include/asm/percpu.h:17,
                    from include/linux/irqflags.h:17,
                    from include/linux/spinlock.h:59,
                    from include/linux/wait.h:9,
                    from include/linux/dma-fence.h:17,
                    from include/drm/gpu_scheduler.h:28,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h:28,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h:29,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:43:
   include/linux/kprobes.h: In function 'get_kprobe_ctlblk':
>> include/linux/percpu-defs.h:219:59: error: invalid use of undefined type 'struct kprobe_ctlblk'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                           ^
   include/linux/percpu-defs.h:241:9: note: in expansion of macro '__verify_pcpu_ptr'
     241 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/kprobes.h:414:16: note: in expansion of macro 'this_cpu_ptr'
     414 |         return this_cpu_ptr(&kprobe_ctlblk);
         |                ^~~~~~~~~~~~
   include/linux/kprobes.h: At top level:
   include/linux/kprobes.h:417:1: error: unknown type name 'kprobe_opcode_t'
     417 | kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
         | ^~~~~~~~~~~~~~~
   include/linux/kprobes.h:418:1: error: unknown type name 'kprobe_opcode_t'
     418 | kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset, bool *on_func_entry);
         | ^~~~~~~~~~~~~~~
   include/linux/kprobes.h: In function 'kprobe_page_fault':
>> include/linux/kprobes.h:599:16: error: implicit declaration of function 'kprobe_fault_handler' [-Werror=implicit-function-declaration]
     599 |         return kprobe_fault_handler(regs, trap);
         |                ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:37,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30:
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_hdmi_types.h: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_hdmi_types.h:53:22: warning: 'dp_hdmi_dongle_signature_str' defined but not used [-Wunused-const-variable=]
      53 | static const uint8_t dp_hdmi_dongle_signature_str[] = "DP-HDMI ADAPTOR";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/kgdb.h:19,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:26:
>> include/linux/kprobes.h:70:9: error: unknown type name 'kprobe_opcode_t'
      70 |         kprobe_opcode_t *addr;
         |         ^~~~~~~~~~~~~~~
   include/linux/kprobes.h:85:9: error: unknown type name 'kprobe_opcode_t'
      85 |         kprobe_opcode_t opcode;
         |         ^~~~~~~~~~~~~~~
>> include/linux/kprobes.h:88:35: error: field 'ainsn' has incomplete type
      88 |         struct arch_specific_insn ainsn;
         |                                   ^~~~~
   include/linux/kprobes.h:174:9: error: unknown type name 'kprobe_opcode_t'
     174 |         kprobe_opcode_t *ret_addr;
         |         ^~~~~~~~~~~~~~~
   include/linux/kprobes.h:298:33: error: unknown type name 'kprobe_opcode_t'
     298 | extern int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset);
         |                                 ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/percpu.h:7,
                    from arch/alpha/include/asm/percpu.h:17,
                    from include/linux/irqflags.h:17,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:15,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:30:
   include/linux/kprobes.h: In function 'get_kprobe_ctlblk':
>> include/linux/percpu-defs.h:219:59: error: invalid use of undefined type 'struct kprobe_ctlblk'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                           ^
   include/linux/percpu-defs.h:241:9: note: in expansion of macro '__verify_pcpu_ptr'
     241 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/kprobes.h:414:16: note: in expansion of macro 'this_cpu_ptr'
     414 |         return this_cpu_ptr(&kprobe_ctlblk);
         |                ^~~~~~~~~~~~
   include/linux/kprobes.h: At top level:
   include/linux/kprobes.h:417:1: error: unknown type name 'kprobe_opcode_t'
     417 | kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
         | ^~~~~~~~~~~~~~~
   include/linux/kprobes.h:418:1: error: unknown type name 'kprobe_opcode_t'
     418 | kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset, bool *on_func_entry);
         | ^~~~~~~~~~~~~~~
   include/linux/kprobes.h: In function 'kprobe_page_fault':
>> include/linux/kprobes.h:599:16: error: implicit declaration of function 'kprobe_fault_handler' [-Werror=implicit-function-declaration]
     599 |         return kprobe_fault_handler(regs, trap);
         |                ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:29:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:143:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     143 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:140:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_3' defined but not used [-Wunused-const-variable=]
     140 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:138:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_2' defined but not used [-Wunused-const-variable=]
     138 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:135:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     135 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:133:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     133 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:37,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30:
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_hdmi_types.h:53:22: warning: 'dp_hdmi_dongle_signature_str' defined but not used [-Wunused-const-variable=]
      53 | static const uint8_t dp_hdmi_dongle_signature_str[] = "DP-HDMI ADAPTOR";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
..

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for KPROBES
   Depends on [n]: MODULES [=y] && HAVE_KPROBES [=n]
   Selected by [y]:
   - TEST_STATIC_DEBUGOBJECT [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +/kprobe_opcode_t +70 include/linux/kprobes.h

d0aaff9796c331 Prasanna S Panchamukhi     2005-09-06  49  
^1da177e4c3f41 Linus Torvalds             2005-04-16  50  struct kprobe;
^1da177e4c3f41 Linus Torvalds             2005-04-16  51  struct pt_regs;
b94cce926b2b90 Hien Nguyen                2005-06-23  52  struct kretprobe;
b94cce926b2b90 Hien Nguyen                2005-06-23  53  struct kretprobe_instance;
^1da177e4c3f41 Linus Torvalds             2005-04-16  54  typedef int (*kprobe_pre_handler_t) (struct kprobe *, struct pt_regs *);
^1da177e4c3f41 Linus Torvalds             2005-04-16  55  typedef void (*kprobe_post_handler_t) (struct kprobe *, struct pt_regs *,
^1da177e4c3f41 Linus Torvalds             2005-04-16  56  				       unsigned long flags);
b94cce926b2b90 Hien Nguyen                2005-06-23  57  typedef int (*kretprobe_handler_t) (struct kretprobe_instance *,
b94cce926b2b90 Hien Nguyen                2005-06-23  58  				    struct pt_regs *);
b94cce926b2b90 Hien Nguyen                2005-06-23  59  
^1da177e4c3f41 Linus Torvalds             2005-04-16  60  struct kprobe {
^1da177e4c3f41 Linus Torvalds             2005-04-16  61  	struct hlist_node hlist;
^1da177e4c3f41 Linus Torvalds             2005-04-16  62  
64f562c6df3cfc Ananth N Mavinakayanahalli 2005-05-05  63  	/* list of kprobes for multi-handler support */
64f562c6df3cfc Ananth N Mavinakayanahalli 2005-05-05  64  	struct list_head list;
64f562c6df3cfc Ananth N Mavinakayanahalli 2005-05-05  65  
ea32c65cc2d229 Prasanna S Panchamukhi     2005-06-23  66  	/*count the number of times this probe was temporarily disarmed */
ea32c65cc2d229 Prasanna S Panchamukhi     2005-06-23  67  	unsigned long nmissed;
ea32c65cc2d229 Prasanna S Panchamukhi     2005-06-23  68  
^1da177e4c3f41 Linus Torvalds             2005-04-16  69  	/* location of the probe point */
^1da177e4c3f41 Linus Torvalds             2005-04-16 @70  	kprobe_opcode_t *addr;
^1da177e4c3f41 Linus Torvalds             2005-04-16  71  
3a872d89baae82 Ananth N Mavinakayanahalli 2006-10-02  72  	/* Allow user to indicate symbol name of the probe point */
9b3af29bf33bfe Ananth N Mavinakayanahalli 2007-05-08  73  	const char *symbol_name;
3a872d89baae82 Ananth N Mavinakayanahalli 2006-10-02  74  
3a872d89baae82 Ananth N Mavinakayanahalli 2006-10-02  75  	/* Offset into the symbol */
3a872d89baae82 Ananth N Mavinakayanahalli 2006-10-02  76  	unsigned int offset;
3a872d89baae82 Ananth N Mavinakayanahalli 2006-10-02  77  
^1da177e4c3f41 Linus Torvalds             2005-04-16  78  	/* Called before addr is executed. */
^1da177e4c3f41 Linus Torvalds             2005-04-16  79  	kprobe_pre_handler_t pre_handler;
^1da177e4c3f41 Linus Torvalds             2005-04-16  80  
^1da177e4c3f41 Linus Torvalds             2005-04-16  81  	/* Called after addr is executed, unless... */
^1da177e4c3f41 Linus Torvalds             2005-04-16  82  	kprobe_post_handler_t post_handler;
^1da177e4c3f41 Linus Torvalds             2005-04-16  83  
^1da177e4c3f41 Linus Torvalds             2005-04-16  84  	/* Saved opcode (which has been replaced with breakpoint) */
^1da177e4c3f41 Linus Torvalds             2005-04-16  85  	kprobe_opcode_t opcode;
^1da177e4c3f41 Linus Torvalds             2005-04-16  86  
^1da177e4c3f41 Linus Torvalds             2005-04-16  87  	/* copy of the original instruction */
^1da177e4c3f41 Linus Torvalds             2005-04-16 @88  	struct arch_specific_insn ainsn;
e8386a0cb22f4a Masami Hiramatsu           2009-01-06  89  
de5bd88d5a5cce Masami Hiramatsu           2009-04-06  90  	/*
de5bd88d5a5cce Masami Hiramatsu           2009-04-06  91  	 * Indicates various status flags.
de5bd88d5a5cce Masami Hiramatsu           2009-04-06  92  	 * Protected by kprobe_mutex after this kprobe is registered.
de5bd88d5a5cce Masami Hiramatsu           2009-04-06  93  	 */
e8386a0cb22f4a Masami Hiramatsu           2009-01-06  94  	u32 flags;
^1da177e4c3f41 Linus Torvalds             2005-04-16  95  };
^1da177e4c3f41 Linus Torvalds             2005-04-16  96  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
