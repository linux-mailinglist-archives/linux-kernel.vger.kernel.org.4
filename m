Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0FC67FA4D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 19:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjA1S6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 13:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjA1S56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 13:57:58 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2337E12040;
        Sat, 28 Jan 2023 10:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674932277; x=1706468277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C/Fj/U8MY72zX0xzMfuMhE7ROEG03cf3gcA25/GnMq4=;
  b=ZxFri32kxuhz7r/YRQp3NR3rOLbvO4EsGUMqrivjqoDNS/vRr1GN51JO
   6F7ewltH8MnE1dJ1H2KMZeN1DVEZlceEOBZplh5xc72noosQ7vJyFjtJy
   zx0tUw9X6JMPXQ+/rzeILG8UPN/aH1WQpBInb82iozhRpaWee0FbCWtaI
   Z9vmDm/GNzXvJFF8vit2aEC6MOYdTCfiAxKYlywXWjZZtF78vmguSQAY2
   dvQOzZYivKGTZgEngl90w9byyS55ZvwVN8xLLB79+gdjzr1LUKOOu/3ez
   7VyByN3j3uUS3Oqa4HXVIn1sRtO55U968lMUWIbvRGwF6nNln1mACB96a
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="325015347"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="325015347"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 10:57:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="771960911"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="771960911"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2023 10:57:47 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLqOY-000109-2z;
        Sat, 28 Jan 2023 18:57:46 +0000
Date:   Sun, 29 Jan 2023 02:57:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jitao shi <jitao.shi@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, CK Hu <ck.hu@mediatek.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mac.shen@mediatek.com, linux-phy@lists.infradead.org,
        Guillaume Ranquet <granquet@baylibre.com>,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, stuart.lee@mediatek.com
Subject: Re: [PATCH v5 3/3] phy: mediatek: add support for phy-mtk-hdmi-mt8195
Message-ID: <202301290245.KWRXz5OS-lkp@intel.com>
References: <20220919-v5-3-cfb0e5ad29b2@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919-v5-3-cfb0e5ad29b2@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on e2f86c02fdc96ca29ced53221a3cbf50aa6f8b49]

url:    https://github.com/intel-lab-lkp/linux/commits/Guillaume-Ranquet/dt-bindings-phy-mediatek-hdmi-phy-Add-mt8195-compatible/20230128-160522
base:   e2f86c02fdc96ca29ced53221a3cbf50aa6f8b49
patch link:    https://lore.kernel.org/r/20220919-v5-3-cfb0e5ad29b2%40baylibre.com
patch subject: [PATCH v5 3/3] phy: mediatek: add support for phy-mtk-hdmi-mt8195
config: arm-buildonly-randconfig-r005-20230129 (https://download.01.org/0day-ci/archive/20230129/202301290245.KWRXz5OS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2cc45518a7fd551117426c770070d93acb31166e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Guillaume-Ranquet/dt-bindings-phy-mediatek-hdmi-phy-Add-mt8195-compatible/20230128-160522
        git checkout 2cc45518a7fd551117426c770070d93acb31166e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__aeabi_uldivmod" [drivers/phy/mediatek/phy-mtk-hdmi-drv.ko] undefined!
>> ERROR: modpost: "__aeabi_ldivmod" [drivers/phy/mediatek/phy-mtk-hdmi-drv.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
