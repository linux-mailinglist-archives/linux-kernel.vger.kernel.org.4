Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E876C6A9A0E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCCPAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCCPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:00:22 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDF462333;
        Fri,  3 Mar 2023 07:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677855619; x=1709391619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TMNP08vwbk1/xlZyyZJWhOWKVuIm24PIkc1+069668g=;
  b=k7UXAo8ANQzf/qRfG6hRzQAUlzcDhzGyiEGMk6TgFehp8NeGweN0YZbK
   DBKWeK+UJg9FpEUvVWEcvyCoOcDYjV5DP9D7kjeG6T6gKARpLeuUcPKhl
   gmBAT6yIpK9W1UQshoTILqFQmpNvjWjcvzwe0ULHBRy9UPEK5qhOfXsfj
   +0U7Sy6vRRN1zVoXa8bCy8Td6LA2nv03iRRqrTfy9SZxjgBe+sGDi+h3u
   w5MP47MzmIvI5rA2nhUOwIEQp4CvA/vet1QkQi+7N5ccE2FwI9xZClc+G
   3Ye/gqgBupmv9n5V29j3C281vcQJuRTREaaJEEVDUXaB9og5FwzxQq9DZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="332539990"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="332539990"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 07:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="921142115"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="921142115"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Mar 2023 07:00:16 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pY6tL-0001U8-2R;
        Fri, 03 Mar 2023 15:00:15 +0000
Date:   Fri, 3 Mar 2023 22:59:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Taniya Das <quic_tdas@quicinc.com>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>
Subject: Re: [PATCH 2/2] clk: qcom: lpass: Initialize start_index
Message-ID: <202303032224.tuvDnbbB-lkp@intel.com>
References: <20230303092859.22094-3-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303092859.22094-3-quic_tdas@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Taniya-Das/clk-qcom-common-Handle-invalid-index-error/20230303-173158
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20230303092859.22094-3-quic_tdas%40quicinc.com
patch subject: [PATCH 2/2] clk: qcom: lpass: Initialize start_index
config: hexagon-randconfig-r021-20230302 (https://download.01.org/0day-ci/archive/20230303/202303032224.tuvDnbbB-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d26ce274e7b0af8a6c6985630d1da8e257c9031d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Taniya-Das/clk-qcom-common-Handle-invalid-index-error/20230303-173158
        git checkout d26ce274e7b0af8a6c6985630d1da8e257c9031d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/clk/qcom/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303032224.tuvDnbbB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/clk/qcom/lpassaudiocc-sc7280.c:13:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/clk/qcom/lpassaudiocc-sc7280.c:13:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/clk/qcom/lpassaudiocc-sc7280.c:13:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/clk/qcom/lpassaudiocc-sc7280.c:705:56: error: unexpected ';' before '}'
           .start_index = LPASS_AUDIO_CC_CDIV_RX_MCLK_DIV_CLK_SRC;
                                                                 ^
   6 warnings and 1 error generated.


vim +705 drivers/clk/qcom/lpassaudiocc-sc7280.c

   700	
   701	static const struct qcom_cc_desc lpass_audio_cc_sc7280_desc = {
   702		.config = &lpass_audio_cc_sc7280_regmap_config,
   703		.clks = lpass_audio_cc_sc7280_clocks,
   704		.num_clks = ARRAY_SIZE(lpass_audio_cc_sc7280_clocks),
 > 705		.start_index = LPASS_AUDIO_CC_CDIV_RX_MCLK_DIV_CLK_SRC;
   706	};
   707	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
