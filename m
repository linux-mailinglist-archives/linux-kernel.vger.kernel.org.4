Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EA174252E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjF2Lwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjF2Lwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:52:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5B1BC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 04:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688039547; x=1719575547;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2V8tGpkrTYJKtRA09DARMLWIH/BSQZ3ch/7CRL+ST3s=;
  b=aJOXhgTBgOSOKVuwGVcRS1Lu5P31Wgs0IPe21M+RLUDCj3O9jju1/XyD
   Oi5aqJZUULjLhdfS6MnZg9i4edCCkTwpDqZnWq6ZvuI61g/c5mERVVCh1
   Cvc2XM4AVQDVL/v0PF/Mg1O1Sce5guVU9ZLwES+Lo5g/YmMygP9Ro/ovs
   CXXLIm3S8TpaBhisxB6bnoaTi8cBGQX7/xMFXTHKGsyCJy6xpyUQ2wZQl
   eQpOTmGmMmfsYHthoAQbXqQ9pooD1DocMydhIRqy/SLToImaMXLlpCO3W
   53MuuNcJeFryYRLfLNRsCaJq1qUagzwTKodCNlvA3C9N6dcexwsoVq1vD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="342425936"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="342425936"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 04:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="963967301"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="963967301"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2023 04:52:24 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEqCG-000E6p-0d;
        Thu, 29 Jun 2023 11:52:24 +0000
Date:   Thu, 29 Jun 2023 19:52:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: drivers/block/drbd/drbd_bitmap.c:451:7: warning: expression result
 unused
Message-ID: <202306291938.pFaPlXRt-lkp@intel.com>
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

Hi Christoph,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a8a670eeeaa40d87bd38a587438952741980c18
commit: aa034695971124f673d4ccdd39cd7f269904ea86 drbd: introduce dynamic debug
date:   7 months ago
config: i386-randconfig-r024-20230629 (https://download.01.org/0day-ci/archive/20230629/202306291938.pFaPlXRt-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230629/202306291938.pFaPlXRt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306291938.pFaPlXRt-lkp@intel.com/

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
--
   In file included from drivers/block/drbd/drbd_nl.c:78:
   include/linux/genl_magic_func.h:212:13: warning: no previous prototype for function 'drbd_genl_cmd_to_str' [-Wmissing-prototypes]
   const char *CONCAT_(GENL_MAGIC_FAMILY, _genl_cmd_to_str)(__u8 cmd)
               ^
   include/linux/genl_magic_struct.h:21:22: note: expanded from macro 'CONCAT_'
   #define CONCAT_(a,b)    CONCAT__(a,b)
                           ^
   include/linux/genl_magic_struct.h:20:23: note: expanded from macro 'CONCAT__'
   #define CONCAT__(a,b)   a ## b
                           ^
   <scratch space>:97:1: note: expanded from here
   drbd_genl_cmd_to_str
   ^
   include/linux/genl_magic_func.h:212:7: note: declare 'static' if the function is not intended to be used outside of this translation unit
   const char *CONCAT_(GENL_MAGIC_FAMILY, _genl_cmd_to_str)(__u8 cmd)
         ^
         static 
>> drivers/block/drbd/drbd_nl.c:1546:7: warning: expression result unused [-Wunused-value]
           if (!expect(new_disk_conf->resync_rate >= 1))
           ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>> drivers/block/drbd/drbd_nl.c:1546:7: warning: expression result unused [-Wunused-value]
           if (!expect(new_disk_conf->resync_rate >= 1))
           ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   3 warnings generated.
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
https://github.com/intel/lkp-tests/wiki
