Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B3B6A346B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBZWKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBZWKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:10:15 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376A1EC5F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677449413; x=1708985413;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wbKrLmy+9YjdePBTNgg8YJEFe4zDewloqR82IM5gcno=;
  b=fHKAH/bj8W5jatIH10lnrU5GXi54igclRnb6Cw0HbpbrZPuIhvXIzkeM
   8lzb8y8xbElsA2JzQE5VB3eF9uHBvpoanLdmk335rdyNjOim/+3DXUNXZ
   ackePwfwKBjvYGX6Hx+OEoMx20vBLtZ3c6+Rn1RBRZgCvnV46SS6+0di0
   KB8ae/JpJYt49+EkYfTTNnuyZNI1APLbhOfelsBzwbsd5HPpn6s/bHv0j
   bicgdhYDpoBQmjMbuEKBCHOg+tuemv9y/6mfw/G+gqqpfWfjPfeUXxpRw
   tGzjk5+WXbS2pniKezGmHwZqrrnqiUgXJV2jYuBQOtQETMfxdqqWi0s7v
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="333786517"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="333786517"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 14:10:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="816398683"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="816398683"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2023 14:10:08 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWPDb-0003uz-2k;
        Sun, 26 Feb 2023 22:10:07 +0000
Date:   Mon, 27 Feb 2023 06:09:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: drivers/block/drbd/drbd_bitmap.c:451:7: warning: expression result
 unused
Message-ID: <202302270609.xV5AJnWY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f3a2439f20d918930cc4ae8f76fe1c1afd26958f
commit: aa034695971124f673d4ccdd39cd7f269904ea86 drbd: introduce dynamic debug
date:   3 months ago
config: i386-randconfig-a005-20230227 (https://download.01.org/0day-ci/archive/20230227/202302270609.xV5AJnWY-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aa034695971124f673d4ccdd39cd7f269904ea86
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout aa034695971124f673d4ccdd39cd7f269904ea86
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/block/drbd/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302270609.xV5AJnWY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/block/drbd/drbd_bitmap.c:451:7: warning: expression result unused [-Wunused-value]
           if (!expect(device->bitmap))
           ~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   drivers/block/drbd/drbd_polymorph_printk.h:55:47: note: expanded from macro '__drbd_printk_if_same_type'
           __drbd_printk_choose_cond(obj, struct_name), \
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
>> drivers/block/drbd/drbd_bitmap.c:451:7: warning: expression result unused [-Wunused-value]
           if (!expect(device->bitmap))
           ~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                       ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
   drivers/block/drbd/drbd_bitmap.c:460:7: warning: expression result unused [-Wunused-value]
           if (!expect(device->bitmap))
           ~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   drivers/block/drbd/drbd_polymorph_printk.h:55:47: note: expanded from macro '__drbd_printk_if_same_type'
           __drbd_printk_choose_cond(obj, struct_name), \
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   drivers/block/drbd/drbd_bitmap.c:460:7: warning: expression result unused [-Wunused-value]
           if (!expect(device->bitmap))
           ~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                       ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
   drivers/block/drbd/drbd_bitmap.c:639:7: warning: expression result unused [-Wunused-value]
           if (!expect(b))
           ~~~~~^~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   drivers/block/drbd/drbd_polymorph_printk.h:55:47: note: expanded from macro '__drbd_printk_if_same_type'
           __drbd_printk_choose_cond(obj, struct_name), \
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   drivers/block/drbd/drbd_bitmap.c:639:7: warning: expression result unused [-Wunused-value]
           if (!expect(b))
           ~~~~~^~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
--
>> drivers/block/drbd/drbd_receiver.c:416:7: warning: expression result unused [-Wunused-value]
           if (!expect(!(peer_req->flags & EE_CALL_AL_COMPLETE_IO))) {
           ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   drivers/block/drbd/drbd_polymorph_printk.h:55:47: note: expanded from macro '__drbd_printk_if_same_type'
           __drbd_printk_choose_cond(obj, struct_name), \
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
>> drivers/block/drbd/drbd_receiver.c:416:7: warning: expression result unused [-Wunused-value]
           if (!expect(!(peer_req->flags & EE_CALL_AL_COMPLETE_IO))) {
           ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                       ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
   drivers/block/drbd/drbd_receiver.c:1876:8: warning: expression result unused [-Wunused-value]
                   if (!expect(data_size == 0))
                   ~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   drivers/block/drbd/drbd_polymorph_printk.h:55:47: note: expanded from macro '__drbd_printk_if_same_type'
           __drbd_printk_choose_cond(obj, struct_name), \
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   drivers/block/drbd/drbd_receiver.c:1876:8: warning: expression result unused [-Wunused-value]
                   if (!expect(data_size == 0))
                   ~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                       ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
   drivers/block/drbd/drbd_receiver.c:1880:8: warning: expression result unused [-Wunused-value]
                   if (!expect(data_size == 0))
                   ~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   drivers/block/drbd/drbd_polymorph_printk.h:55:47: note: expanded from macro '__drbd_printk_if_same_type'
           __drbd_printk_choose_cond(obj, struct_name), \
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   drivers/block/drbd/drbd_receiver.c:1880:8: warning: expression result unused [-Wunused-value]
                   if (!expect(data_size == 0))
                   ~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
--
>> drivers/block/drbd/drbd_actlog.c:871:7: warning: expression result unused [-Wunused-value]
           if (!expect(sector < nr_sectors))
           ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   drivers/block/drbd/drbd_polymorph_printk.h:55:47: note: expanded from macro '__drbd_printk_if_same_type'
           __drbd_printk_choose_cond(obj, struct_name), \
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
>> drivers/block/drbd/drbd_actlog.c:871:7: warning: expression result unused [-Wunused-value]
           if (!expect(sector < nr_sectors))
           ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                       ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
   drivers/block/drbd/drbd_actlog.c:873:7: warning: expression result unused [-Wunused-value]
           if (!expect(esector < nr_sectors))
           ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   drivers/block/drbd/drbd_polymorph_printk.h:55:47: note: expanded from macro '__drbd_printk_if_same_type'
           __drbd_printk_choose_cond(obj, struct_name), \
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   drivers/block/drbd/drbd_actlog.c:873:7: warning: expression result unused [-Wunused-value]
           if (!expect(esector < nr_sectors))
           ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_polymorph_printk.h:128:4: note: expanded from macro 'expect'
                           drbd_err(device, "ASSERTION %s FAILED in %s\n",         \
                           ^
   drivers/block/drbd/drbd_polymorph_printk.h:104:2: note: expanded from macro 'drbd_err'
           drbd_printk(KERN_ERR, device, fmt, ## args)
           ^
   drivers/block/drbd/drbd_polymorph_printk.h:65:4: note: expanded from macro 'drbd_printk'
             __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
             ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                       ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
   4 warnings generated.
..


vim +451 drivers/block/drbd/drbd_bitmap.c

b411b3637fa71f Philipp Reisner     2009-09-25  448  
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  449  sector_t drbd_bm_capacity(struct drbd_device *device)
b411b3637fa71f Philipp Reisner     2009-09-25  450  {
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03 @451  	if (!expect(device->bitmap))
841ce241fa3550 Andreas Gruenbacher 2010-12-15  452  		return 0;
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  453  	return device->bitmap->bm_dev_capacity;
b411b3637fa71f Philipp Reisner     2009-09-25  454  }
b411b3637fa71f Philipp Reisner     2009-09-25  455  

:::::: The code at line 451 was first introduced by commit
:::::: b30ab7913b0a7b1d3b1091c8cb3abb1a9f1e0824 drbd: Rename "mdev" to "device"

:::::: TO: Andreas Gruenbacher <agruen@linbit.com>
:::::: CC: Philipp Reisner <philipp.reisner@linbit.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
