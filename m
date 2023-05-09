Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F1D6FBD81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjEIDKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbjEIDJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:09:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B259749FD
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 20:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683601792; x=1715137792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ApfAyEhUhHfjNFBHlVJnMnylpSR+C5SjLICGhV+eHbM=;
  b=NPJ4SvzEodWMLln4lYoZvxUrp48YQWtyMCTaBzWYqnw4m2pNV8INBFpk
   b7Q9aQtCtwzQcfAqtBj/SOBwi8QgpTgCdeKcMshHYgQzmsQHypWPYO6KE
   fFEFJB2bGv8a0ZhyQDlxSZA1fqpgTLwmiIniNGyB8hz5kuUtSum0Tm4ma
   fCMVbMY4bESdF5i4D4O62zDaSNRIQkpLWSRccLAdcxFknvyLq0Bjp2bCA
   Divph1XEvJlDX86dVxjW/pV7i50/dFs4qzdMqaqbhwtYlg9DboYP3gkFc
   ZGNkPAlVVfRSMt6ecpMIFdG47wMRgbGpHlictfDM10cPnwnONMt0u2Yur
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="334250140"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="334250140"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 20:09:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="842939432"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="842939432"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 May 2023 20:09:50 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwDjZ-0001cC-2h;
        Tue, 09 May 2023 03:09:49 +0000
Date:   Tue, 9 May 2023 11:09:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     liuwf <liuwf@mailbox.org>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: library: btree_blue - a simple btree with rapid linear traversal
Message-ID: <202305091033.ffi2G2ZL-lkp@intel.com>
References: <37586fd4e76b597aea4dad3f06bb7eb648425fa0.camel@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37586fd4e76b597aea4dad3f06bb7eb648425fa0.camel@mailbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi liuwf,

kernel test robot noticed the following build errors:

[auto build test ERROR on fbe1871b562af6e9cffcf622247e821d1dd16c64]

url:    https://github.com/intel-lab-lkp/linux/commits/liuwf/library-btree_blue-a-simple-btree-with-rapid-linear-traversal/20230509-095127
base:   fbe1871b562af6e9cffcf622247e821d1dd16c64
patch link:    https://lore.kernel.org/r/37586fd4e76b597aea4dad3f06bb7eb648425fa0.camel%40mailbox.org
patch subject: library: btree_blue - a simple btree with rapid linear traversal
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20230509/202305091033.ffi2G2ZL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/fba954cf20fd4764f0e6090d1164251873b7569c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review liuwf/library-btree_blue-a-simple-btree-with-rapid-linear-traversal/20230509-095127
        git checkout fba954cf20fd4764f0e6090d1164251873b7569c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305091033.ffi2G2ZL-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: lib/btree_blue_test.o: in function `btree_blue_test_init':
>> btree_blue_test.c:(.text+0xb7): undefined reference to `btree_init'
>> ld: btree_blue_test.c:(.text+0x133): undefined reference to `btree_geo64'
>> ld: btree_blue_test.c:(.text+0x13d): undefined reference to `btree_insert'
   ld: btree_blue_test.c:(.text+0x25b): undefined reference to `btree_geo64'
>> ld: btree_blue_test.c:(.text+0x269): undefined reference to `btree_lookup'
   ld: btree_blue_test.c:(.text+0x379): undefined reference to `btree_geo64'
   ld: btree_blue_test.c:(.text+0x38f): undefined reference to `btree_insert'
   ld: btree_blue_test.c:(.text+0x3aa): undefined reference to `btree_geo64'
>> ld: btree_blue_test.c:(.text+0x3b8): undefined reference to `btree_remove'
   ld: btree_blue_test.c:(.text+0x57f): undefined reference to `btree_geo64'
>> ld: btree_blue_test.c:(.text+0x58d): undefined reference to `btree_last'
   ld: btree_blue_test.c:(.text+0x5a4): undefined reference to `btree_geo64'
>> ld: btree_blue_test.c:(.text+0x5ae): undefined reference to `btree_get_prev'
   ld: btree_blue_test.c:(.text+0x5fb): undefined reference to `btree_geo64'
   ld: btree_blue_test.c:(.text+0x609): undefined reference to `btree_last'
   ld: btree_blue_test.c:(.text+0x62e): undefined reference to `btree_geo64'
   ld: btree_blue_test.c:(.text+0x638): undefined reference to `btree_get_prev'
   ld: btree_blue_test.c:(.text+0x6ef): undefined reference to `btree_geo64'
   ld: btree_blue_test.c:(.text+0x6f9): undefined reference to `btree_remove'
>> ld: btree_blue_test.c:(.text+0x7cd): undefined reference to `btree_destroy'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
