Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8101E6A2A8D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 16:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBYPlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 10:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBYPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 10:41:39 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336B683C0;
        Sat, 25 Feb 2023 07:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677339698; x=1708875698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7TlSJBAv1JWgP8CG84HHh60dSmh6Utj+V6WWc5f2D80=;
  b=eFuLfSuKFnD2v5vaIcSmUubPUHmXQAeCEdRCbcmzGeUEXNwrXwtw/LsL
   W+xrDmWx0Ka0ehvnl/efN/xsO1n+hFSMT1im7/hNlENk2NUyozYUIssIr
   gf38KRQtaq0hND7Hc99iK6Ca1j+oaOdygsI3y5SDiib91/yV8DG5AG0Km
   lZmYePVL6iNRdZC+WKd6XRyGwLBrW1R9ZxcNTtRFMF2x3PhIZWWKEUZla
   CBjHJpOUk3wnJCkkSN+eniORrMxNedkFZ3WevGrOnsEIOsZaVJToVSzyl
   ZWsPdfLc02jhvKVuA7OQTGVxpMnUDsYhQCZtO56oIb3k3lKpDcZWq5bAm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="396182615"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="396182615"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 07:41:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="782728869"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="782728869"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 25 Feb 2023 07:41:34 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVwg1-0003Hb-2Q;
        Sat, 25 Feb 2023 15:41:33 +0000
Date:   Sat, 25 Feb 2023 23:40:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM64: dts: debix model-a: enable hdmi
Message-ID: <202302252343.4lnZcpLX-lkp@intel.com>
References: <MA0PR01MB7145D1E9382C7F91197B259FFFA99@MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0PR01MB7145D1E9382C7F91197B259FFFA99@MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hardevsinh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on linus/master next-20230225]
[cannot apply to v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hardevsinh-Palaniya/ARM64-dts-debix-model-a-enable-hdmi/20230225-222532
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/MA0PR01MB7145D1E9382C7F91197B259FFFA99%40MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM
patch subject: [PATCH] ARM64: dts: debix model-a: enable hdmi
config: arm64-randconfig-r014-20230222 (https://download.01.org/0day-ci/archive/20230225/202302252343.4lnZcpLX-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/169f8a9904944622235b3485702d64ac942af621
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hardevsinh-Palaniya/ARM64-dts-debix-model-a-enable-hdmi/20230225-222532
        git checkout 169f8a9904944622235b3485702d64ac942af621
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302252343.4lnZcpLX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts:49.1-15 Label or path irqsteer_hdmi not found
>> Error: arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts:53.1-15 Label or path hdmi_blk_ctrl not found
>> Error: arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts:57.1-11 Label or path hdmi_pavi not found
>> Error: arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts:61.1-6 Label or path hdmi not found
>> Error: arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts:65.1-9 Label or path hdmiphy not found
>> Error: arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts:69.1-8 Label or path lcdif1 not found
>> Error: arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts:77.1-8 Label or path lcdif3 not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
