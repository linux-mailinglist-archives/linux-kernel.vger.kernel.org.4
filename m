Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58D75B87BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiINMAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiINMAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:00:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058443A147
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663156804; x=1694692804;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=odGCZOqqPhtUt/3w//H/HcoVPFDADR0NjoKREpHE5x8=;
  b=B2cGa45KaS/N8EKGcl/jYfSa0flryd3Wg7lF45YveVpLnPaP+9hLJCjG
   W8BsSosZy08nRQuGpjzhjCOdbcD/fao2etxd/u94jkf7JCId3IrjkWd/5
   /7TgDlt1wWdjdWPYfyD1qvmnt8jvCXB3Ut0vjGTrtGH8xyvW/ZCL3Iyxo
   MveemUZXa+UQ6VDsyFfbrlcxhsfnFIHN7W0kMjCuhdwY+EeRoc/r27b7e
   MW+vzD4fVnDzntZDlerT6R+PhmwNJHfFsIuzhXjzfDQ4Gi9kgII0ria8B
   HesDxSx7syQ6FiASpDJkxhlPUrRTb9PQGSoknEZBzA7aF2oALrvB4WYr+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="297139189"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="297139189"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 05:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="594354447"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Sep 2022 05:00:01 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYR3h-0000AS-02;
        Wed, 14 Sep 2022 12:00:01 +0000
Date:   Wed, 14 Sep 2022 19:59:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [djbw-nvdimm:libnvdimm-pending 16/22]
 arch/powerpc/include/asm/pgalloc.h:9:1: error: expected '=', ',', ';', 'asm'
 or '__attribute__' before '{' token
Message-ID: <202209141938.l6Ot2o1K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git libnvdimm-pending
head:   e27a0356de15f16934325784c6b1d89cf0f13458
commit: 155ac6b670cf6385f6dd14910560d569560af889 [16/22] devdax: Move address_space helpers to the DAX core
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220914/202209141938.l6Ot2o1K-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/commit/?id=155ac6b670cf6385f6dd14910560d569560af889
        git remote add djbw-nvdimm https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git
        git fetch --no-tags djbw-nvdimm libnvdimm-pending
        git checkout 155ac6b670cf6385f6dd14910560d569560af889
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   include/trace/events/vmscan.h:328:2: error: expected declaration specifiers before ';' token
     328 | );
         |  ^
   include/trace/events/vmscan.h:351:2: error: expected declaration specifiers before ';' token
     351 | );
         |  ^
   include/trace/events/vmscan.h:402:2: error: expected declaration specifiers before ';' token
     402 | );
         |  ^
   include/trace/events/vmscan.h:438:2: error: expected declaration specifiers before ';' token
     438 | );
         |  ^
   include/trace/events/vmscan.h:462:2: error: expected declaration specifiers before ';' token
     462 | );
         |  ^
   include/trace/events/vmscan.h:469:2: error: expected declaration specifiers before ';' token
     469 | );
         |  ^
   include/trace/events/vmscan.h:496:2: error: expected declaration specifiers before ';' token
     496 | );
         |  ^
   mm/vmscan.c:66:1: warning: empty declaration
      66 | struct scan_control {
         | ^~~~~~
   mm/vmscan.c:181:1: error: parameter 'vm_swappiness' is initialized
     181 | int vm_swappiness = 60;
         | ^~~
   mm/vmscan.c:185:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     185 | {
         | ^
   In file included from include/linux/preempt.h:11,
                    from include/linux/spinlock.h:55:
   include/linux/list.h:26:16: error: parameter 'shrinker_list' is initialized
      26 |         struct list_head name = LIST_HEAD_INIT(name)
         |                ^~~~~~~~~
   mm/vmscan.c:195:1: note: in expansion of macro 'LIST_HEAD'
     195 | LIST_HEAD(shrinker_list);
         | ^~~~~~~~~
   In file included from include/linux/mm_types.h:12,
                    from include/linux/mmzone.h:21:
   include/linux/rwsem.h:101:16: error: parameter 'shrinker_rwsem' is initialized
     101 |         struct rw_semaphore name = __RWSEM_INITIALIZER(name)
         |                ^~~~~~~~~~~~
   mm/vmscan.c:196:1: note: in expansion of macro 'DECLARE_RWSEM'
     196 | DECLARE_RWSEM(shrinker_rwsem);
         | ^~~~~~~~~~~~~
   mm/vmscan.c:465:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     465 | {
         | ^
   mm/vmscan.c:470:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     470 | {
         | ^
   mm/vmscan.c:475:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     475 | {
         | ^
   mm/vmscan.c:481:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     481 | {
         | ^
   mm/vmscan.c:486:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     486 | {
         | ^
   mm/vmscan.c:491:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     491 | {
         | ^
   mm/vmscan.c:498:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     498 | {
         | ^
   mm/vmscan.c:515:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     515 | {
         | ^
   mm/vmscan.c:530:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     530 | {
         | ^
   mm/vmscan.c:544:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     544 | {
         | ^
   mm/vmscan.c:572:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     572 | {
         | ^
   mm/vmscan.c:592:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     592 | {
         | ^
   mm/vmscan.c:614:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     614 | {
         | ^
   mm/vmscan.c:659:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     659 | {
         | ^
   mm/vmscan.c:665:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     665 | {
         | ^
   mm/vmscan.c:682:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     682 | {
         | ^
   mm/vmscan.c:691:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     691 | {
         | ^
   mm/vmscan.c:721:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     721 | {
         | ^
>> mm/vmscan.c:725:33: error: expected declaration specifiers before ';' token
     725 | EXPORT_SYMBOL(register_shrinker);
         |                                 ^
   mm/vmscan.c:731:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     731 | {
         | ^
   mm/vmscan.c:746:35: error: expected declaration specifiers before ';' token
     746 | EXPORT_SYMBOL(unregister_shrinker);
         |                                   ^
   mm/vmscan.c:757:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     757 | {
         | ^
   mm/vmscan.c:761:37: error: expected declaration specifiers before ';' token
     761 | EXPORT_SYMBOL(synchronize_shrinkers);
         |                                     ^
   mm/vmscan.c:767:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     767 | {
         | ^
   mm/vmscan.c:939:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     939 | {
         | ^
   mm/vmscan.c:967:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     967 | {
         | ^
   mm/vmscan.c:1013:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1013 | {
         | ^
   mm/vmscan.c:1032:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1032 | {
         | ^
   mm/vmscan.c:1040:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1040 | {
         | ^
   mm/vmscan.c:1064:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1064 | {
         | ^
   mm/vmscan.c:1072:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1072 | {
         | ^
   mm/vmscan.c:1105:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1105 | {
         | ^
   mm/vmscan.c:1180:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1180 | {
         | ^
   mm/vmscan.c:1209:3: error: storage class specified for parameter 'pageout_t'
    1209 | } pageout_t;
         |   ^~~~~~~~~
   mm/vmscan.c:1215:18: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'pageout'
    1215 | static pageout_t pageout(struct folio *folio, struct address_space *mapping,
         |                  ^~~~~~~
   mm/vmscan.c:1291:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1291 | {
         | ^
   mm/vmscan.c:1398:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1398 | {
         | ^
   mm/vmscan.c:1421:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1421 | {
         | ^
   mm/vmscan.c:1426:1: warning: empty declaration
    1426 | enum page_references {
         | ^~~~
   mm/vmscan.c:1435:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1435 | {
         | ^
   mm/vmscan.c:1493:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1493 | {
         | ^
   mm/vmscan.c:1524:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1524 | {
         | ^
   mm/vmscan.c:1547:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1547 | {
         | ^
   mm/vmscan.c:1571:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1571 | {
         | ^
   mm/vmscan.c:1594:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1594 | {
         | ^
   mm/vmscan.c:2052:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    2052 | {
         | ^
   mm/vmscan.c:2105:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    2105 | {
         | ^
   mm/vmscan.c:2142:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    2142 | {
         | ^
   mm/vmscan.c:2255:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    2255 | {
         | ^
   mm/vmscan.c:2282:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    2282 | {
         | ^
   mm/vmscan.c:2325:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    2325 | {
         | ^
   mm/vmscan.c:2393:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    2393 | {
--
         | ^
   mm/vmscan.c:2941:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    2941 | {
         | ^
   mm/vmscan.c:2951:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    2951 | {
         | ^
   mm/vmscan.c:3067:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    3067 | {
         | ^
   mm/vmscan.c:3086:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    3086 | {
         | ^
   mm/vmscan.c:3137:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    3137 | {
         | ^
   mm/vmscan.c:3195:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    3195 | {
         | ^
   mm/vmscan.c:3399:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    3399 | {
         | ^
   mm/vmscan.c:3426:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    3426 | {
         | ^
   mm/vmscan.c:3464:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    3464 | {
         | ^
   mm/vmscan.c:3556:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    3556 | {
         | ^
   mm/vmscan.c:3585:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    3585 | {
         | ^
   mm/vmscan.c:3673:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    3673 | {
         | ^
   mm/vmscan.c:3723:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    3723 | {
         | ^
   mm/vmscan.c:3803:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    3803 | {
         | ^
   mm/vmscan.c:3928:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    3928 | {
         | ^
   mm/vmscan.c:3949:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    3949 | {
         | ^
   mm/vmscan.c:3977:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    3977 | {
         | ^
   mm/vmscan.c:4013:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4013 | {
         | ^
   mm/vmscan.c:4029:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4029 | {
         | ^
   mm/vmscan.c:4068:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4068 | {
         | ^
   mm/vmscan.c:4104:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4104 | {
         | ^
   mm/vmscan.c:4123:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4123 | {
         | ^
   mm/vmscan.c:4129:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4129 | {
         | ^
   mm/vmscan.c:4147:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4147 | {
         | ^
   mm/vmscan.c:4366:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4366 | {
         | ^
   mm/vmscan.c:4374:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4374 | {
         | ^
   mm/vmscan.c:4470:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4470 | {
         | ^
   mm/vmscan.c:4557:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4557 | {
         | ^
   mm/vmscan.c:4643:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4643 | {
         | ^
   mm/vmscan.c:4663:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4663 | {
         | ^
   mm/vmscan.c:4673:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4673 | {
         | ^
   In file included from include/linux/printk.h:6,
                    from include/asm-generic/bug.h:22,
                    from arch/powerpc/include/asm/bug.h:158,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6:
>> include/linux/init.h:198:17: error: storage class specified for parameter '__initcall__kmod_vmscan__315_4682_kswapd_init6'
     198 |         __PASTE(__,                                             \
         |                 ^~
   include/linux/init.h:249:27: note: in definition of macro '____define_initcall'
     249 |         static initcall_t __name __used                         \
         |                           ^~~~~~
   include/linux/compiler_types.h:70:22: note: in expansion of macro '___PASTE'
      70 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:198:9: note: in expansion of macro '__PASTE'
     198 |         __PASTE(__,                                             \
         |         ^~~~~~~
   include/linux/init.h:256:17: note: in expansion of macro '__initcall_name'
     256 |                 __initcall_name(initcall, __iid, id),           \
         |                 ^~~~~~~~~~~~~~~
   include/linux/init.h:260:9: note: in expansion of macro '__unique_initcall'
     260 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:262:35: note: in expansion of macro '___define_initcall'
     262 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:291:41: note: in expansion of macro '__define_initcall'
     291 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:296:24: note: in expansion of macro 'device_initcall'
     296 | #define __initcall(fn) device_initcall(fn)
         |                        ^~~~~~~~~~~~~~~
   include/linux/module.h:88:25: note: in expansion of macro '__initcall'
      88 | #define module_init(x)  __initcall(x);
         |                         ^~~~~~~~~~
   mm/vmscan.c:4682:1: note: in expansion of macro 'module_init'
    4682 | module_init(kswapd_init)
         | ^~~~~~~~~~~
>> mm/vmscan.c:4682:1: error: parameter '__initcall__kmod_vmscan__315_4682_kswapd_init6' is initialized
   mm/vmscan.c:4682:1: warning: 'used' attribute ignored [-Wattributes]
>> include/linux/init.h:198:17: error: section attribute not allowed for '__initcall__kmod_vmscan__315_4682_kswapd_init6'
     198 |         __PASTE(__,                                             \
         |                 ^~
   include/linux/init.h:249:27: note: in definition of macro '____define_initcall'
     249 |         static initcall_t __name __used                         \
         |                           ^~~~~~
   include/linux/compiler_types.h:70:22: note: in expansion of macro '___PASTE'
      70 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:198:9: note: in expansion of macro '__PASTE'
     198 |         __PASTE(__,                                             \
         |         ^~~~~~~
   include/linux/init.h:256:17: note: in expansion of macro '__initcall_name'
     256 |                 __initcall_name(initcall, __iid, id),           \
         |                 ^~~~~~~~~~~~~~~
   include/linux/init.h:260:9: note: in expansion of macro '__unique_initcall'
     260 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:262:35: note: in expansion of macro '___define_initcall'
     262 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:291:41: note: in expansion of macro '__define_initcall'
     291 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:296:24: note: in expansion of macro 'device_initcall'
     296 | #define __initcall(fn) device_initcall(fn)
         |                        ^~~~~~~~~~~~~~~
   include/linux/module.h:88:25: note: in expansion of macro '__initcall'
      88 | #define module_init(x)  __initcall(x);
         |                         ^~~~~~~~~~
   mm/vmscan.c:4682:1: note: in expansion of macro 'module_init'
    4682 | module_init(kswapd_init)
         | ^~~~~~~~~~~
   mm/vmscan.c:4682:13: error: 'kswapd_init' undeclared (first use in this function); did you mean 'trap_init'?
    4682 | module_init(kswapd_init)
         |             ^~~~~~~~~~~
   include/linux/init.h:250:55: note: in definition of macro '____define_initcall'
     250 |                 __attribute__((__section__(__sec))) = fn;
         |                                                       ^~
   include/linux/init.h:260:9: note: in expansion of macro '__unique_initcall'
     260 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:262:35: note: in expansion of macro '___define_initcall'
     262 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:291:41: note: in expansion of macro '__define_initcall'
     291 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:296:24: note: in expansion of macro 'device_initcall'
     296 | #define __initcall(fn) device_initcall(fn)
         |                        ^~~~~~~~~~~~~~~
   include/linux/module.h:88:25: note: in expansion of macro '__initcall'
      88 | #define module_init(x)  __initcall(x);
         |                         ^~~~~~~~~~
   mm/vmscan.c:4682:1: note: in expansion of macro 'module_init'
    4682 | module_init(kswapd_init)
         | ^~~~~~~~~~~
   mm/vmscan.c:4682:13: note: each undeclared identifier is reported only once for each function it appears in
    4682 | module_init(kswapd_init)
         |             ^~~~~~~~~~~
   include/linux/init.h:250:55: note: in definition of macro '____define_initcall'
     250 |                 __attribute__((__section__(__sec))) = fn;
         |                                                       ^~
   include/linux/init.h:260:9: note: in expansion of macro '__unique_initcall'
     260 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:262:35: note: in expansion of macro '___define_initcall'
     262 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:291:41: note: in expansion of macro '__define_initcall'
     291 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:296:24: note: in expansion of macro 'device_initcall'
     296 | #define __initcall(fn) device_initcall(fn)
         |                        ^~~~~~~~~~~~~~~
   include/linux/module.h:88:25: note: in expansion of macro '__initcall'
      88 | #define module_init(x)  __initcall(x);
         |                         ^~~~~~~~~~
   mm/vmscan.c:4682:1: note: in expansion of macro 'module_init'
    4682 | module_init(kswapd_init)
         | ^~~~~~~~~~~
   In file included from mm/vmscan.c:17:
   include/linux/module.h:88:38: error: expected declaration specifiers before ';' token
      88 | #define module_init(x)  __initcall(x);
         |                                      ^
   mm/vmscan.c:4682:1: note: in expansion of macro 'module_init'
    4682 | module_init(kswapd_init)
         | ^~~~~~~~~~~
   mm/vmscan.c:4856:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4856 | {
         | ^
   mm/vmscan.c:4870:48: error: expected declaration specifiers before ';' token
    4870 | EXPORT_SYMBOL_GPL(check_move_unevictable_pages);
         |                                                ^
   mm/vmscan.c:4882:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    4882 | {
         | ^
   mm/vmscan.c:4916:49: error: expected declaration specifiers before ';' token
    4916 | EXPORT_SYMBOL_GPL(check_move_unevictable_folios);
         |                                                 ^
   include/linux/dax.h:193:28: error: old-style parameter declarations in prototyped function definition
..


vim +9 arch/powerpc/include/asm/pgalloc.h

0186f47e703fb7 Kumar Gala                     2008-11-19   6  
de3b87611dd1f3 Balbir Singh                   2017-05-02   7  #ifndef MODULE
de3b87611dd1f3 Balbir Singh                   2017-05-02   8  static inline gfp_t pgtable_gfp_flags(struct mm_struct *mm, gfp_t gfp)
de3b87611dd1f3 Balbir Singh                   2017-05-02  @9  {
de3b87611dd1f3 Balbir Singh                   2017-05-02  10  	if (unlikely(mm == &init_mm))
de3b87611dd1f3 Balbir Singh                   2017-05-02  11  		return gfp;
de3b87611dd1f3 Balbir Singh                   2017-05-02  12  	return gfp | __GFP_ACCOUNT;
de3b87611dd1f3 Balbir Singh                   2017-05-02  13  }
de3b87611dd1f3 Balbir Singh                   2017-05-02  14  #else /* !MODULE */
de3b87611dd1f3 Balbir Singh                   2017-05-02  15  static inline gfp_t pgtable_gfp_flags(struct mm_struct *mm, gfp_t gfp)
de3b87611dd1f3 Balbir Singh                   2017-05-02  16  {
de3b87611dd1f3 Balbir Singh                   2017-05-02  17  	return gfp | __GFP_ACCOUNT;
de3b87611dd1f3 Balbir Singh                   2017-05-02  18  }
de3b87611dd1f3 Balbir Singh                   2017-05-02  19  #endif /* MODULE */
de3b87611dd1f3 Balbir Singh                   2017-05-02  20  
75f296d93bcebc Levin, Alexander (Sasha Levin  2017-11-15  21) #define PGALLOC_GFP (GFP_KERNEL | __GFP_ZERO)
5b6c133e080100 Michael Ellerman               2017-08-15  22  
dc096864ba784c Christophe Leroy               2019-04-26  23  pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel);
dc096864ba784c Christophe Leroy               2019-04-26  24  
dc096864ba784c Christophe Leroy               2019-04-26  25  static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
dc096864ba784c Christophe Leroy               2019-04-26  26  {
dc096864ba784c Christophe Leroy               2019-04-26  27  	return (pte_t *)pte_fragment_alloc(mm, 1);
dc096864ba784c Christophe Leroy               2019-04-26  28  }
dc096864ba784c Christophe Leroy               2019-04-26  29  
dc096864ba784c Christophe Leroy               2019-04-26  30  static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
dc096864ba784c Christophe Leroy               2019-04-26  31  {
dc096864ba784c Christophe Leroy               2019-04-26  32  	return (pgtable_t)pte_fragment_alloc(mm, 0);
dc096864ba784c Christophe Leroy               2019-04-26  33  }
dc096864ba784c Christophe Leroy               2019-04-26  34  
dc096864ba784c Christophe Leroy               2019-04-26  35  void pte_frag_destroy(void *pte_frag);
dc096864ba784c Christophe Leroy               2019-04-26  36  void pte_fragment_free(unsigned long *table, int kernel);
dc096864ba784c Christophe Leroy               2019-04-26  37  
dc096864ba784c Christophe Leroy               2019-04-26  38  static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
dc096864ba784c Christophe Leroy               2019-04-26  39  {
dc096864ba784c Christophe Leroy               2019-04-26  40  	pte_fragment_free((unsigned long *)pte, 1);
dc096864ba784c Christophe Leroy               2019-04-26  41  }
dc096864ba784c Christophe Leroy               2019-04-26  42  
dc096864ba784c Christophe Leroy               2019-04-26  43  static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
dc096864ba784c Christophe Leroy               2019-04-26  44  {
dc096864ba784c Christophe Leroy               2019-04-26  45  	pte_fragment_free((unsigned long *)ptepage, 0);
dc096864ba784c Christophe Leroy               2019-04-26  46  }
dc096864ba784c Christophe Leroy               2019-04-26  47  
e80789a3c13f9f Christophe Leroy               2019-04-26  48  /*
e80789a3c13f9f Christophe Leroy               2019-04-26  49   * Functions that deal with pagetables that could be at any level of
e80789a3c13f9f Christophe Leroy               2019-04-26  50   * the table need to be passed an "index_size" so they know how to
e80789a3c13f9f Christophe Leroy               2019-04-26  51   * handle allocation.  For PTE pages, the allocation size will be
e80789a3c13f9f Christophe Leroy               2019-04-26  52   * (2^index_size * sizeof(pointer)) and allocations are drawn from
e80789a3c13f9f Christophe Leroy               2019-04-26  53   * the kmem_cache in PGT_CACHE(index_size).
e80789a3c13f9f Christophe Leroy               2019-04-26  54   *
e80789a3c13f9f Christophe Leroy               2019-04-26  55   * The maximum index size needs to be big enough to allow any
e80789a3c13f9f Christophe Leroy               2019-04-26  56   * pagetable sizes we need, but small enough to fit in the low bits of
e80789a3c13f9f Christophe Leroy               2019-04-26  57   * any page table pointer.  In other words all pagetables, even tiny
e80789a3c13f9f Christophe Leroy               2019-04-26  58   * ones, must be aligned to allow at least enough low 0 bits to
e80789a3c13f9f Christophe Leroy               2019-04-26  59   * contain this value.  This value is also used as a mask, so it must
e80789a3c13f9f Christophe Leroy               2019-04-26  60   * be one less than a power of two.
e80789a3c13f9f Christophe Leroy               2019-04-26  61   */
e80789a3c13f9f Christophe Leroy               2019-04-26  62  #define MAX_PGTABLE_INDEX_SIZE	0xf
e80789a3c13f9f Christophe Leroy               2019-04-26  63  
e80789a3c13f9f Christophe Leroy               2019-04-26 @64  extern struct kmem_cache *pgtable_cache[];
e80789a3c13f9f Christophe Leroy               2019-04-26  65  #define PGT_CACHE(shift) pgtable_cache[shift]
e80789a3c13f9f Christophe Leroy               2019-04-26  66  

:::::: The code at line 9 was first introduced by commit
:::::: de3b87611dd1f3c00f4e42fe298457260ea781e0 powerpc/mm/book(e)(3s)/64: Add page table accounting

:::::: TO: Balbir Singh <bsingharora@gmail.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
