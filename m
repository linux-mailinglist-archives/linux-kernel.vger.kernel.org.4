Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF41735EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjFSUrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFSUrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:47:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621701A3;
        Mon, 19 Jun 2023 13:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687207628; x=1718743628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ycKjZzBsCwN//CAhRyctU2g6YIaDxzvCXqjhNY5zko8=;
  b=bOKlz9WZ2C5zDPx+Haav0WkJDTpeT4KXwwzIV8eNqpDrJ834u5HSA57g
   J0EQIPTluFTSqtrMNBcaZfEsiLekBSCxQBdh7+wZC8EGry2ESjma29bCv
   ZL1lRoef/9hnDVD7oKyNbjY1siu1epsAjhWHThGIsDvBcZntoxxQVhWHa
   tnV4Yo5dRr+rzaXAssCVgPvWp4hKzH93Cptvofee3j8A3kALE6W5sQNto
   27mxmRRsYcFsSiTE6T9aqXXGwO/6vSlFQNRAiPA0OaXf/lf/Z9tbS8qik
   rFr36PnbHuMQ1Wl13N1AdtkRwH//fZ1N//ObULG0w3VibF547KnyCPSFU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="349437114"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="349437114"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 13:47:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="691194551"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="691194551"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Jun 2023 13:47:04 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBLmB-00057c-2J;
        Mon, 19 Jun 2023 20:47:03 +0000
Date:   Tue, 20 Jun 2023 04:47:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v5 8/8] soc: mediatek: pm-domains: Add support for MT8365
Message-ID: <202306200439.julbXDpI-lkp@intel.com>
References: <20230619085344.2885311-9-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619085344.2885311-9-msp@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on krzk-dt/for-next linus/master v6.4-rc7 next-20230619]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Schneider-Pargmann/dt-bindings-power-Add-MT8365-power-domains/20230619-165759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230619085344.2885311-9-msp%40baylibre.com
patch subject: [PATCH v5 8/8] soc: mediatek: pm-domains: Add support for MT8365
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230620/202306200439.julbXDpI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230620/202306200439.julbXDpI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306200439.julbXDpI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/bits.h:6,
                    from include/linux/bitops.h:6,
                    from include/linux/kernel.h:22,
                    from include/linux/clk.h:13,
                    from drivers/soc/mediatek/mtk-pm-domains.c:5:
>> include/vdso/bits.h:7:33: warning: conversion from 'long unsigned int' to 'unsigned char' changes value from '384' to '128' [-Woverflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                 ^
   drivers/soc/mediatek/mtk-pm-domains.h:15:41: note: in expansion of macro 'BIT'
      15 | #define MTK_SCPD_STRICT_BUS_PROTECTION  BIT(8)
         |                                         ^~~
   drivers/soc/mediatek/mt8365-pm-domains.h:69:25: note: in expansion of macro 'MTK_SCPD_STRICT_BUS_PROTECTION'
      69 |                 .caps = MTK_SCPD_STRICT_BUS_PROTECTION | MTK_SCPD_HAS_INFRA_NAO,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +7 include/vdso/bits.h

3945ff37d2f48d Vincenzo Frascino 2020-03-20  6  
3945ff37d2f48d Vincenzo Frascino 2020-03-20 @7  #define BIT(nr)			(UL(1) << (nr))
cbdb1f163af2bb Andy Shevchenko   2022-11-28  8  #define BIT_ULL(nr)		(ULL(1) << (nr))
3945ff37d2f48d Vincenzo Frascino 2020-03-20  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
