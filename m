Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC68712DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjEZT6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEZT6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:58:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15829E
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685131125; x=1716667125;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M1BzhZ/UHvP1tH65pvSNNevwxU0JTiJJtGUsx9A/6R8=;
  b=ghB7xf7UhEIgCN5Z+1KjhO6yQlcOaN+TJhBQN5GXJaJXPJlt4P+H9Y99
   U/94WSVmIrInq74yaj91YesCKXKeqtVd3vguHpXvIBhOiKmbmmEJoBGOC
   b7HU+7kiyVf9xQkLvrNJ3B377zTyW8RwjLW3q+C+twhZ364l6BNg5GRkf
   91rCmi6hkmMmi0GW9vLuTzuMOljabzf4fXcvk2n/IsIZRBAKudwGFHvvN
   /ZqAbhkiuDR1t2KlcXTX1EDDalmxVJOwaRUs6GepV1Kux8S7aF13ebzTD
   4jmq246t7ZNyzStovTHDKpAE8PaBpvalfXxhcNzWOdU/G4glU5mrTzLFq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="417773743"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="417773743"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 12:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="682829053"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="682829053"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 May 2023 12:58:43 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2daE-000JZO-1V;
        Fri, 26 May 2023 19:58:42 +0000
Date:   Sat, 27 May 2023 03:58:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: drivers/block/drbd/drbd_bitmap.c:451:7: warning: expression result
 unused
Message-ID: <202305270319.WZP0J28B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0d85b27b0cc6b5cf54567c5ad913a247a71583ce
commit: aa034695971124f673d4ccdd39cd7f269904ea86 drbd: introduce dynamic debug
date:   6 months ago
config: i386-randconfig-i011-20230526 (https://download.01.org/0day-ci/archive/20230527/202305270319.WZP0J28B-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aa034695971124f673d4ccdd39cd7f269904ea86
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout aa034695971124f673d4ccdd39cd7f269904ea86
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/block/drbd/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305270319.WZP0J28B-lkp@intel.com/

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

b411b3637fa71fc Philipp Reisner     2009-09-25  448  
b30ab7913b0a7b1 Andreas Gruenbacher 2011-07-03  449  sector_t drbd_bm_capacity(struct drbd_device *device)
b411b3637fa71fc Philipp Reisner     2009-09-25  450  {
b30ab7913b0a7b1 Andreas Gruenbacher 2011-07-03 @451  	if (!expect(device->bitmap))
841ce241fa35504 Andreas Gruenbacher 2010-12-15  452  		return 0;
b30ab7913b0a7b1 Andreas Gruenbacher 2011-07-03  453  	return device->bitmap->bm_dev_capacity;
b411b3637fa71fc Philipp Reisner     2009-09-25  454  }
b411b3637fa71fc Philipp Reisner     2009-09-25  455  

:::::: The code at line 451 was first introduced by commit
:::::: b30ab7913b0a7b1d3b1091c8cb3abb1a9f1e0824 drbd: Rename "mdev" to "device"

:::::: TO: Andreas Gruenbacher <agruen@linbit.com>
:::::: CC: Philipp Reisner <philipp.reisner@linbit.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
