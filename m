Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2366E6CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjDRTNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjDRTNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:13:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BAF9001
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681845185; x=1713381185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s5alUOoExPKk4DlbBZLsLa0FYjGJlJ79KIT2EQ4Y4CM=;
  b=AqDj4APm5iBJW6l9q8+ywg4nCZxVbBY+BpwJfqRUybdMXwltB3tdoBcf
   8pI0bD3uwBi6xlKWPp3MZbBO4TgKTtB/rjUjO9Jxs6+I+YgEZKBVoYTdK
   ani8uwcZB/klQGVcg4gtdSLn/4qtKxmBnXIc0CYkk5m+MRaVDi8tdf08q
   VKqiWSlnJJCrmTGhfof9/vrYCwOQ7Gvbu6JtpGhiM3O1vPqHC4TG4dw5S
   +zv8t9KCORiNr8EUq/j3L4Q+o3iFVQq2zJmqXqx1HOXbYkewriO29xFVp
   hlpcKaJy2UyQEyBhFJbUi0lEoOntdZiDeRkfGtek3vQjx7LQmFbcSvK3t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431547345"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="431547345"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 12:13:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="760445257"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="760445257"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Apr 2023 12:13:04 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poqlD-000dwJ-1k;
        Tue, 18 Apr 2023 19:13:03 +0000
Date:   Wed, 19 Apr 2023 03:12:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lin Chun Yeh <r09921093@g.ntu.edu.tw>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Lin Chun Yeh <r09921093@g.ntu.edu.tw>
Subject: Re: [PATCH] include/linux/rbtree.h: move the declaration of c in
 rb_find_add()
Message-ID: <202304190219.FPDNRf8x-lkp@intel.com>
References: <20230418145712.20620-1-r09921093@g.ntu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418145712.20620-1-r09921093@g.ntu.edu.tw>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc7 next-20230417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lin-Chun-Yeh/include-linux-rbtree-h-move-the-declaration-of-c-in-rb_find_add/20230418-230031
patch link:    https://lore.kernel.org/r/20230418145712.20620-1-r09921093%40g.ntu.edu.tw
patch subject: [PATCH] include/linux/rbtree.h: move the declaration of c in rb_find_add()
config: s390-randconfig-r044-20230417 (https://download.01.org/0day-ci/archive/20230419/202304190219.FPDNRf8x-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/9348e5c71c46a8d88c805acf5dd56c1785bc04e8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lin-Chun-Yeh/include-linux-rbtree-h-move-the-declaration-of-c-in-rb_find_add/20230418-230031
        git checkout 9348e5c71c46a8d88c805acf5dd56c1785bc04e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304190219.FPDNRf8x-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: unsafe memchr() usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-memchr.c
--
>> warning: unsafe memchr_inv() usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-memchr_inv.c
--
>> warning: unsafe memcmp() usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-memcmp.c
--
>> warning: unsafe memscan() usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-memscan.c
--
>> warning: unsafe memcmp() usage lacked '__read_overflow2' warning in lib/test_fortify/read_overflow2-memcmp.c
--
>> warning: unsafe memcpy() usage lacked '__read_overflow2' warning in lib/test_fortify/read_overflow2-memcpy.c
--
>> warning: unsafe memmove() usage lacked '__read_overflow2' warning in lib/test_fortify/read_overflow2-memmove.c
--
>> warning: unsafe memcpy() usage lacked '__read_overflow2_field' warning in lib/test_fortify/read_overflow2_field-memcpy.c
--
>> warning: unsafe memmove() usage lacked '__read_overflow2_field' warning in lib/test_fortify/read_overflow2_field-memmove.c
--
>> warning: unsafe memcpy() usage lacked '__write_overflow' warning in lib/test_fortify/write_overflow-memcpy.c
--
>> warning: unsafe memmove() usage lacked '__write_overflow' warning in lib/test_fortify/write_overflow-memmove.c
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
