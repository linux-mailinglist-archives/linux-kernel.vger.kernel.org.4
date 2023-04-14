Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B40A6E215F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjDNK5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDNK5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:57:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D749E3;
        Fri, 14 Apr 2023 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681469854; x=1713005854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8581aDVLXia4BD7N5gh7+6X7T7ZkX9w7ZpnUdBdBB74=;
  b=aDTn6CJLv1it5WRMuC6fBuYtUzgupeXmuPm/LuGhhaUmwi609Ko/JpyL
   4HFYDCN0P6V+Na6eXUyE/GpaF8+C2yhdkZ3oyJYbiTEocyigCO2zA9VAA
   auMqFEr+RRtrXNJwhfQIFJmwq2gBhv/F4lXINfEK+joyEEAs8NOwqL1jQ
   zebLeVp74iEyRxte5HR8c+q4OPJ7+pxBzPPXr8g54d/1QUt9wIWkFMOMz
   azXpjj0jWf7piqf1AXm51HFJe2bg2GZUB6XDOyJQgTHzMba25pS00Emt/
   H0oWD9mAvEyrcK+xcZOL+u/av4NL0yrltr1XMajR6ga3wGAC+MCxXGzmQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="324065601"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="324065601"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:57:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="779155520"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="779155520"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Apr 2023 03:57:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnH7N-000ZST-2c;
        Fri, 14 Apr 2023 10:57:25 +0000
Date:   Fri, 14 Apr 2023 18:57:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: Re: [PATCH v7 1/2] dt-bindings: spi: add loongson spi
Message-ID: <202304141851.mUss7Eyn-lkp@intel.com>
References: <20230412045152.4694-2-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412045152.4694-2-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yinbo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on robh/for-next krzk-dt/for-next linus/master v6.3-rc6 next-20230413]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yinbo-Zhu/dt-bindings-spi-add-loongson-spi/20230412-125222
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20230412045152.4694-2-zhuyinbo%40loongson.cn
patch subject: [PATCH v7 1/2] dt-bindings: spi: add loongson spi
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/e230989729f1d1e10c49d1903a5c76a5b8b81f95
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yinbo-Zhu/dt-bindings-spi-add-loongson-spi/20230412-125222
        git checkout e230989729f1d1e10c49d1903a5c76a5b8b81f95
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304141851.mUss7Eyn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
