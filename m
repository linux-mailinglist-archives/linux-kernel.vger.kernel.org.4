Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7533F74B1D5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjGGNfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGGNfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:35:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CBA1997;
        Fri,  7 Jul 2023 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688736902; x=1720272902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zJMl5SY47pBGwDkNPoefM/yltDD51XulbBFX8TC/LJw=;
  b=eBKWUR8M7QtCPfaV6QDgLWHBV0LHoCg60a/iH8/dD9No0pgAC7IRdCgN
   j0+rURr7Nhg7iVB1jTQUAxpNrppN9VlFRZE/KzDRJ9wbPwj906UnmFTqO
   TJg7czj3KAX18MBam2/kqSu1LV5Pr+LHf9tRsw3IyJA810tsHqsSlYFSI
   75HJZb6yxHb34qBJ8ahFownJDUUQsEmpQHkeECVX+rPmIhfCxxvf5WO5/
   yktIl7r26VQaOd1qOn7poKiMjzHzr1p6g5bgVbIrxWWZZEcIBcCHHPzA8
   0WQrZoCSgQYodJq6uuf4G2C8jDwxiCUtgG6UBbEc0lR77JnCS9IxVZowG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="366471756"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="366471756"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 06:33:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="966656794"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="966656794"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jul 2023 06:33:00 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHlZz-000212-2G;
        Fri, 07 Jul 2023 13:32:59 +0000
Date:   Fri, 7 Jul 2023 21:32:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
        peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@gmail.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] clk: imx: imx8: add audio clock mux driver
Message-ID: <202307072131.S4pYlrxM-lkp@intel.com>
References: <1688449175-1677-4-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688449175-1677-4-git-send-email-shengjiu.wang@nxp.com>
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

Hi Shengjiu,

kernel test robot noticed the following build errors:

[auto build test ERROR on abelvesa/clk/imx]
[also build test ERROR on linus/master v6.4 next-20230707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shengjiu-Wang/dt-bindings-clock-imx8-acm-Add-audio-clock-mux-support/20230704-141425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
patch link:    https://lore.kernel.org/r/1688449175-1677-4-git-send-email-shengjiu.wang%40nxp.com
patch subject: [PATCH 3/3] clk: imx: imx8: add audio clock mux driver
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20230707/202307072131.S4pYlrxM-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230707/202307072131.S4pYlrxM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307072131.S4pYlrxM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: init_module
   >>> defined at clk-imx8qxp.c
   >>>            drivers/clk/imx/clk-imx8qxp.o:(init_module)
   >>> defined at clk-imx8-acm.c
   >>>            drivers/clk/imx/clk-imx8-acm.o:(.init.text+0x4)
--
>> ld.lld: error: duplicate symbol: cleanup_module
   >>> defined at clk-imx8qxp.c
   >>>            drivers/clk/imx/clk-imx8qxp.o:(cleanup_module)
   >>> defined at clk-imx8-acm.c
   >>>            drivers/clk/imx/clk-imx8-acm.o:(.exit.text+0x4)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
