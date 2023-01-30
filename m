Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEF3681661
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbjA3Q3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbjA3Q3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:29:17 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A8B5FDB;
        Mon, 30 Jan 2023 08:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675096156; x=1706632156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F1ULbSw1MBsHWcGX+HC4GSetpggTnGdsHsr0Ru7tKp4=;
  b=BAkYIP56U9LPtkvy9ucLDypaLXX++Km8LfFEDRgRJPGpsgEB5Q7HVNbG
   AoSf8S0TjBbkrY3bc4iAwyTDg/zIcLyW/nDS+mLekvXVfvPsVFuGK+blZ
   EICMbmGQELePuohuJFwFWNxriBbX8NnxvIAHrYdoB2XyWseD3YK0abRhV
   tW0NoPVxO1uCN4ykr7ov9038abTOKczj1K4iLOJMvSg/3IkY+yZ13lEmw
   cqck4iG+HOZ0PbqFxfDHA/1twz9Uj3nXSZgChDqguZ6q9LVr+z8Oxs2LF
   FJ1y0katU3HZ6qFtlUL9YMwk01NEGAxI1qYWAly2bDEtvqqUbFRA3z3lC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="329715492"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="329715492"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:29:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="772570775"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="772570775"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jan 2023 08:29:08 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMX1o-0003kE-0N;
        Mon, 30 Jan 2023 16:29:08 +0000
Date:   Tue, 31 Jan 2023 00:28:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
Subject: Re: [RESEND PATCH v5 07/10] dt-bindings: mtd: Split ECC engine with
 rawnand controller
Message-ID: <202301310056.ZF1Yst4B-lkp@intel.com>
References: <20230130030656.12127-8-xiangsheng.hou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130030656.12127-8-xiangsheng.hou@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiangsheng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on robh/for-next mtd/mtd/next mtd/mtd/fixes linus/master v6.2-rc6 next-20230130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiangsheng-Hou/spi-mtk-snfi-Change-default-page-format-to-setup-default-setting/20230130-111021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20230130030656.12127-8-xiangsheng.hou%40mediatek.com
patch subject: [RESEND PATCH v5 07/10] dt-bindings: mtd: Split ECC engine with rawnand controller
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/f3a5f8d573b8be1d7a10224f0e10a699d9a0ea09
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xiangsheng-Hou/spi-mtk-snfi-Change-default-page-format-to-setup-default-setting/20230130-111021
        git checkout f3a5f8d573b8be1d7a10224f0e10a699d9a0ea09
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/mtd/mtk-nand.txt

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
