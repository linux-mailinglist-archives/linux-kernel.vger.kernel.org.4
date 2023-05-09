Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D556FBE1A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjEIEId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEIEIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:08:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D550511605
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 21:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683604991; x=1715140991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uELiJQiQpG6JjFPvIWbDiclDc4cgM4APgw80t2Rvo3w=;
  b=AmEPk07hRVvMLMSfb8uFBCQYVNdf8+idWSEm9bFDw3iLRnySFWCxB7LH
   fca6NJUl/yK4RF+QATz95clvTZmm89jfHkXzsMsr1fpVB1rFvWf975fsT
   4cVhgyLC7YgghzB1OCixCuhNIndNDODPuRxgfWbnDcixGOXJWLGuLxYdm
   CWzN0TWE6XdArIA1Kyu3THvoODlm4SE5UUh9UPZOmEU8rP4vzJbFBxtKT
   +m3hdSF+YVOV6ChrgUaRBGCB1piOfWaIvkwYhMsXqiNgEtPG3/24pdIND
   zG0FV3gIwofCx9+CCahIlpL15pyoAenovocCbmzqiLbFz71GmchxXq/+A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="339030877"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="339030877"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 21:01:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="842953248"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="842953248"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 May 2023 21:01:52 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwEXv-0001f4-2d;
        Tue, 09 May 2023 04:01:51 +0000
Date:   Tue, 9 May 2023 12:01:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     liuwf <liuwf@mailbox.org>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: library: btree_blue - a simple btree with rapid linear traversal
Message-ID: <202305091154.Pq60ESIw-lkp@intel.com>
References: <37586fd4e76b597aea4dad3f06bb7eb648425fa0.camel@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37586fd4e76b597aea4dad3f06bb7eb648425fa0.camel@mailbox.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20230509/202305091154.Pq60ESIw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/fba954cf20fd4764f0e6090d1164251873b7569c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review liuwf/library-btree_blue-a-simple-btree-with-rapid-linear-traversal/20230509-095127
        git checkout fba954cf20fd4764f0e6090d1164251873b7569c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305091154.Pq60ESIw-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "btree_init" [lib/btree_blue_test.ko] undefined!
>> ERROR: modpost: "btree_geo64" [lib/btree_blue_test.ko] undefined!
>> ERROR: modpost: "btree_insert" [lib/btree_blue_test.ko] undefined!
>> ERROR: modpost: "btree_lookup" [lib/btree_blue_test.ko] undefined!
>> ERROR: modpost: "btree_remove" [lib/btree_blue_test.ko] undefined!
>> ERROR: modpost: "btree_last" [lib/btree_blue_test.ko] undefined!
>> ERROR: modpost: "btree_get_prev" [lib/btree_blue_test.ko] undefined!
>> ERROR: modpost: "btree_destroy" [lib/btree_blue_test.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
