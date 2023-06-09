Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2FB72952E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241592AbjFIJax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241541AbjFIJai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:30:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918A76EAF;
        Fri,  9 Jun 2023 02:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686302712; x=1717838712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Pdlge8HOdOgXrhYJQZzSWtRLLf66oRiREo2GTdCF98=;
  b=FbtQSp7AMbroTPOj4xv9yyhtp49Oiaj/5gF1wa/gsfV8gApNWGDMpmPt
   JXSRto7VBvwD7zluSrBDs+KwZpsDu8PHLMLS42SEUIQ74XUx9dCj/A8Pd
   6Gir/Vv28A7Fz1ODJiA6GdHUyALfjm3Nx6TjRahYxM7FvX4iTXb0jsgrd
   bGs8eBDSf190Witu8/9X4YgbyB9JadT/KsgAuO1kiAUmVb4rWyQbOByUn
   XV4+dH1nZLmsdSZCFNPxQG9RNGK615WtGx26LmeeRLeF4EBK7TLBISBB/
   eK+nPSKWjYHQUhayOCrBTvwXt3dyHo/T8a2Wznbu3qX1IUXFH82SibORg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="421151097"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="421151097"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="660706496"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="660706496"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2023 02:25:02 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7YMf-0008tU-0p;
        Fri, 09 Jun 2023 09:25:01 +0000
Date:   Fri, 9 Jun 2023 17:24:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com, Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH] watchdog/mm: Allow dumping memory info in pretimeout
Message-ID: <202306091730.papweTh9-lkp@intel.com>
References: <20230608-pretimeout-oom-v1-1-542cc91062d7@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608-pretimeout-oom-v1-1-542cc91062d7@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9561de3a55bed6bdd44a12820ba81ec416e705a7]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Whitchurch/watchdog-mm-Allow-dumping-memory-info-in-pretimeout/20230609-144807
base:   9561de3a55bed6bdd44a12820ba81ec416e705a7
patch link:    https://lore.kernel.org/r/20230608-pretimeout-oom-v1-1-542cc91062d7%40axis.com
patch subject: [PATCH] watchdog/mm: Allow dumping memory info in pretimeout
config: i386-randconfig-i051-20230608 (https://download.01.org/0day-ci/archive/20230609/202306091730.papweTh9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        git checkout 9561de3a55bed6bdd44a12820ba81ec416e705a7
        b4 shazam https://lore.kernel.org/r/20230608-pretimeout-oom-v1-1-542cc91062d7@axis.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306091730.papweTh9-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__show_mem" [drivers/watchdog/pretimeout_panic.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
