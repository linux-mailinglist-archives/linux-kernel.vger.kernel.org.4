Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267336BBF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjCOWIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCOWIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:08:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBBE9B2CC;
        Wed, 15 Mar 2023 15:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678918094; x=1710454094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L9wWQnLQK8EccBPcz1LMij8+7p7qKU/Q/6HijEp6Sb4=;
  b=c6+X16vIg4hvrUX8a986OslDI76pRDyG6qgGwc4zs79+Xlh45Q2kX1JH
   xwc4MVdL9RsoxBONIlVlYmjjbWD+nPlUms8pL+ki8KBXGUcjkhDkTp2rQ
   901dJg5fvfWZTGS1m7UBJ5Tfy+izK9IN0pYvx93b0lhrFmTDa6KxtzqSn
   oLGHdAfrBL7cwd9aXNrz/zhjmwvGX26PI3OlZuTpbPHe6IiwO4v/1FZwZ
   /jjVoH+/hNwdenFlKbgkcrMbRAJKMXgTdMRwa8d4Pz53+Q5n9csUlbweV
   RAdoeBcZqJzlLXitengLpZI7rxGBrUeOLnT1KFiSFwqNFegXRKdfyu//N
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340192773"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340192773"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 15:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="679650937"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="679650937"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Mar 2023 15:08:09 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcZI1-000843-0O;
        Wed, 15 Mar 2023 22:08:09 +0000
Date:   Thu, 16 Mar 2023 06:07:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH 12/15] clk: nuvoton: Add clock driver for ma35d1 clock
 controller
Message-ID: <202303160558.ECjzXS4Z-lkp@intel.com>
References: <20230315072902.9298-13-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315072902.9298-13-ychuang570808@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacky,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on clk/clk-next tty/tty-testing tty/tty-next tty/tty-linus linus/master v6.3-rc2 next-20230315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Huang/arm64-Kconfig-platforms-Add-config-for-Nuvoton-MA35-platform/20230315-153355
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230315072902.9298-13-ychuang570808%40gmail.com
patch subject: [PATCH 12/15] clk: nuvoton: Add clock driver for ma35d1 clock controller
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230316/202303160558.ECjzXS4Z-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/696d8d2916e32766dba52bc51453176af883ae96
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jacky-Huang/arm64-Kconfig-platforms-Add-config-for-Nuvoton-MA35-platform/20230315-153355
        git checkout 696d8d2916e32766dba52bc51453176af883ae96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/clk/nuvoton/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303160558.ECjzXS4Z-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/nuvoton/clk-ma35d1-pll.c:79:15: warning: no previous prototype for 'CLK_GetPLLFreq_SMICPLL' [-Wmissing-prototypes]
      79 | unsigned long CLK_GetPLLFreq_SMICPLL(struct ma35d1_clk_pll *pll,
         |               ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/clk/nuvoton/clk-ma35d1-pll.c:104:15: warning: no previous prototype for 'CLK_CalPLLFreq_Mode0' [-Wmissing-prototypes]
     104 | unsigned long CLK_CalPLLFreq_Mode0(unsigned long PllSrcClk,
         |               ^~~~~~~~~~~~~~~~~~~~
>> drivers/clk/nuvoton/clk-ma35d1-pll.c:185:15: warning: no previous prototype for 'CLK_CalPLLFreq_Mode1' [-Wmissing-prototypes]
     185 | unsigned long CLK_CalPLLFreq_Mode1(unsigned long PllSrcClk,
         |               ^~~~~~~~~~~~~~~~~~~~
>> drivers/clk/nuvoton/clk-ma35d1-pll.c:231:15: warning: no previous prototype for 'CLK_CalPLLFreq_Mode2' [-Wmissing-prototypes]
     231 | unsigned long CLK_CalPLLFreq_Mode2(unsigned long PllSrcClk,
         |               ^~~~~~~~~~~~~~~~~~~~
>> drivers/clk/nuvoton/clk-ma35d1-pll.c:305:15: warning: no previous prototype for 'CLK_SetPLLFreq' [-Wmissing-prototypes]
     305 | unsigned long CLK_SetPLLFreq(struct ma35d1_clk_pll *pll,
         |               ^~~~~~~~~~~~~~
>> drivers/clk/nuvoton/clk-ma35d1-pll.c:347:15: warning: no previous prototype for 'CLK_GetPLLFreq_VSIPLL' [-Wmissing-prototypes]
     347 | unsigned long CLK_GetPLLFreq_VSIPLL(struct ma35d1_clk_pll *pll,
         |               ^~~~~~~~~~~~~~~~~~~~~
   drivers/clk/nuvoton/clk-ma35d1-pll.c: In function 'CLK_GetPLLFreq_VSIPLL':
>> drivers/clk/nuvoton/clk-ma35d1-pll.c:350:44: warning: variable 'u32FMOD' set but not used [-Wunused-but-set-variable]
     350 |         u32 u32M, u32N, u32P, u32X, u32SR, u32FMOD;
         |                                            ^~~~~~~
>> drivers/clk/nuvoton/clk-ma35d1-pll.c:350:37: warning: variable 'u32SR' set but not used [-Wunused-but-set-variable]
     350 |         u32 u32M, u32N, u32P, u32X, u32SR, u32FMOD;
         |                                     ^~~~~


vim +/CLK_GetPLLFreq_SMICPLL +79 drivers/clk/nuvoton/clk-ma35d1-pll.c

    77	
    78	/* SMIC PLL for CAPLL */
  > 79	unsigned long CLK_GetPLLFreq_SMICPLL(struct ma35d1_clk_pll *pll,
    80					     unsigned long PllSrcClk)
    81	{
    82		u32 u32M, u32N, u32P, u32OutDiv;
    83		u32 val;
    84		unsigned long u64PllClk;
    85		u32 clk_div_table[] = { 1, 2, 4, 8};
    86	
    87		val = __raw_readl(pll->ctl0_base);
    88	
    89		u32N = FIELD_GET(PLL0CTL0_FBDIV_MSK, val);
    90		u32M = FIELD_GET(PLL0CTL0_INDIV_MSK, val);
    91		u32P = FIELD_GET(PLL0CTL0_OUTDIV_MSK, val);
    92		u32OutDiv = clk_div_table[u32P];
    93	
    94		if (val & PLL0CTL0_BP_MSK) {
    95			u64PllClk = PllSrcClk;
    96		} else {
    97			u64PllClk = PllSrcClk * u32N;
    98			do_div(u64PllClk, u32M * u32OutDiv);
    99		}
   100		return u64PllClk;
   101	}
   102	
   103	/* VSI-PLL: INTEGER_MODE */
 > 104	unsigned long CLK_CalPLLFreq_Mode0(unsigned long PllSrcClk,
   105					   unsigned long u64PllFreq, u32 *u32Reg)
   106	{
   107		u32 u32TmpM, u32TmpN, u32TmpP;
   108		u32 u32RngMinN, u32RngMinM, u32RngMinP;
   109		u32 u32RngMaxN, u32RngMaxM, u32RngMaxP;
   110		u32 u32Tmp, u32Min, u32MinN, u32MinM, u32MinP;
   111		unsigned long u64PllClk;
   112		unsigned long u64Con1, u64Con2, u64Con3;
   113	
   114		u64PllClk = 0;
   115		u32Min = (u32) -1;
   116	
   117		if (!((u64PllFreq >= VSIPLL_FCLKO_MIN_FREQ) &&
   118		    (u64PllFreq <= VSIPLL_FCLKO_MAX_FREQ))) {
   119			u32Reg[0] = ma35d1pll_freq[0].ctl0_reg;
   120			u32Reg[1] = ma35d1pll_freq[0].ctl1_reg;
   121			u64PllClk = ma35d1pll_freq[0].freq;
   122			return u64PllClk;
   123		}
   124	
   125		u32RngMinM = 1UL;
   126		u32RngMaxM = 63UL;
   127		u32RngMinM = ((PllSrcClk / VSIPLL_FREFDIVM_MAX_FREQ) > 1) ?
   128			     (PllSrcClk / VSIPLL_FREFDIVM_MAX_FREQ) : 1;
   129		u32RngMaxM = ((PllSrcClk / VSIPLL_FREFDIVM_MIN_FREQ0) < u32RngMaxM) ?
   130			     (PllSrcClk / VSIPLL_FREFDIVM_MIN_FREQ0) : u32RngMaxM;
   131	
   132		for (u32TmpM = u32RngMinM; u32TmpM < (u32RngMaxM + 1); u32TmpM++) {
   133			u64Con1 = PllSrcClk / u32TmpM;
   134			u32RngMinN = 16UL;
   135			u32RngMaxN = 2047UL;
   136			u32RngMinN = ((VSIPLL_FCLK_MIN_FREQ / u64Con1) > u32RngMinN) ?
   137				     (VSIPLL_FCLK_MIN_FREQ / u64Con1) : u32RngMinN;
   138			u32RngMaxN = ((VSIPLL_FCLK_MAX_FREQ / u64Con1) < u32RngMaxN) ?
   139				     (VSIPLL_FCLK_MAX_FREQ / u64Con1) : u32RngMaxN;
   140	
   141			for (u32TmpN = u32RngMinN; u32TmpN < (u32RngMaxN + 1);
   142			     u32TmpN++) {
   143				u64Con2 = u64Con1 * u32TmpN;
   144				u32RngMinP = 1UL;
   145				u32RngMaxP = 7UL;
   146				u32RngMinP = ((u64Con2 / VSIPLL_FCLKO_MAX_FREQ) > 1) ?
   147					      (u64Con2 / VSIPLL_FCLKO_MAX_FREQ) : 1;
   148				u32RngMaxP = ((u64Con2 / VSIPLL_FCLKO_MIN_FREQ) <
   149					      u32RngMaxP) ?
   150					      (u64Con2 / VSIPLL_FCLKO_MIN_FREQ) :
   151					      u32RngMaxP;
   152				for (u32TmpP = u32RngMinP; u32TmpP < (u32RngMaxP + 1);
   153				     u32TmpP++) {
   154					u64Con3 = u64Con2 / u32TmpP;
   155					if (u64Con3 > u64PllFreq)
   156						u32Tmp = u64Con3 - u64PllFreq;
   157					else
   158						u32Tmp = u64PllFreq - u64Con3;
   159	
   160					if (u32Tmp < u32Min) {
   161						u32Min = u32Tmp;
   162						u32MinM = u32TmpM;
   163						u32MinN = u32TmpN;
   164						u32MinP = u32TmpP;
   165	
   166						if (u32Min == 0UL) {
   167							u32Reg[0] = (u32MinM << 12) |
   168								    (u32MinN);
   169							u32Reg[1] = (u32MinP << 4);
   170							return ((PllSrcClk * u32MinN) /
   171								(u32MinP * u32MinM));
   172						}
   173					}
   174				}
   175			}
   176		}
   177	
   178		u32Reg[0] = (u32MinM << 12) | (u32MinN);
   179		u32Reg[1] = (u32MinP << 4);
   180		u64PllClk = (PllSrcClk * u32MinN) / (u32MinP * u32MinM);
   181		return u64PllClk;
   182	}
   183	
   184	/* VSI-PLL: FRACTIONAL_MODE */
 > 185	unsigned long CLK_CalPLLFreq_Mode1(unsigned long PllSrcClk,
   186					   unsigned long u64PllFreq, u32 *u32Reg)
   187	{
   188		unsigned long u64X, u64N, u64M, u64P, u64tmp;
   189		unsigned long u64PllClk, u64FCLKO;
   190		u32 u32FRAC;
   191	
   192		if (u64PllFreq > VSIPLL_FCLKO_MAX_FREQ) {
   193			u32Reg[0] = ma35d1pll_freq[1].ctl0_reg;
   194			u32Reg[1] = ma35d1pll_freq[1].ctl1_reg;
   195			u64PllClk = ma35d1pll_freq[1].freq;
   196			return u64PllClk;
   197		}
   198	
   199		if (u64PllFreq > (VSIPLL_FCLKO_MIN_FREQ/(100-1))) {
   200			u64FCLKO = u64PllFreq * ((VSIPLL_FCLKO_MIN_FREQ / u64PllFreq) +
   201				   ((VSIPLL_FCLKO_MIN_FREQ % u64PllFreq) ? 1 : 0));
   202		} else {
   203			pr_err("Failed to set rate %ld\n", u64PllFreq);
   204			return 0;
   205		}
   206	
   207		u64P = (u64FCLKO >= VSIPLL_FCLK_MIN_FREQ) ? 1 :
   208		       ((VSIPLL_FCLK_MIN_FREQ / u64FCLKO) +
   209			((VSIPLL_FCLK_MIN_FREQ % u64FCLKO) ? 1 : 0));
   210	
   211		if ((PllSrcClk > (VSIPLL_FREFDIVM_MAX_FREQ * (64-1))) ||
   212		    (PllSrcClk < VSIPLL_FREFDIVM_MIN_FREQ1))
   213			return 0;
   214	
   215		u64M = (PllSrcClk <= VSIPLL_FREFDIVM_MAX_FREQ) ? 1 :
   216		       ((PllSrcClk / VSIPLL_FREFDIVM_MAX_FREQ) +
   217		       ((PllSrcClk % VSIPLL_FREFDIVM_MAX_FREQ) ? 1 : 0));
   218	
   219		u64tmp = (u64FCLKO * u64P * u64M * 1000) / PllSrcClk;
   220		u64N = u64tmp / 1000;
   221		u64X = u64tmp % 1000;
   222		u32FRAC = ((u64X << 24) + 500) / 1000;
   223		u64PllClk = (PllSrcClk * u64tmp) / u64P / u64M / 1000;
   224	
   225		u32Reg[0] = (u64M << 12) | (u64N);
   226		u32Reg[1] = (u64P << 4) | (u32FRAC << 8);
   227		return u64PllClk;
   228	}
   229	
   230	/* VSI-PLL: SS_MODE */
 > 231	unsigned long CLK_CalPLLFreq_Mode2(unsigned long PllSrcClk,
   232					   unsigned long u64PllFreq,
   233					   u32 u32SR, u32 u32Fmod, u32 *u32Reg)
   234	{
   235		unsigned long u64X, u64N, u64M, u64P, u64tmp, u64tmpP, u64tmpM;
   236		unsigned long u64SSRATE, u64SLOPE, u64PllClk, u64FCLKO;
   237		u32 u32FRAC, i;
   238	
   239		if (u64PllFreq >= VSIPLL_FCLKO_MAX_FREQ) {
   240			u32Reg[0] = ma35d1pll_freq[2].ctl0_reg;
   241			u32Reg[1] = ma35d1pll_freq[2].ctl1_reg;
   242			u32Reg[2] = ma35d1pll_freq[2].ctl2_reg;
   243			u64PllClk = ma35d1pll_freq[2].freq;
   244			return u64PllClk;
   245		}
   246	
   247		if (u64PllFreq < VSIPLL_FCLKO_MIN_FREQ) {
   248			u64FCLKO = 0;
   249			for (i = 2; i < 8; i++) {
   250				u64tmp = (i * u64PllFreq);
   251				if (u64tmp > VSIPLL_FCLKO_MIN_FREQ)
   252					u64FCLKO = u64tmp;
   253			}
   254			if (u64FCLKO == 0) {
   255				pr_err("Failed to set rate %ld\n", u64PllFreq);
   256				return 0;
   257			}
   258	
   259		} else
   260			u64FCLKO = u64PllFreq;
   261	
   262		u64P = 0;
   263		for (i = 1; i < 8; i++) {
   264			u64tmpP = i * u64FCLKO;
   265			if ((u64tmpP <= VSIPLL_FCLK_MAX_FREQ) &&
   266			    (u64tmpP >= VSIPLL_FCLK_MIN_FREQ)) {
   267				u64P = i;
   268				break;
   269			}
   270		}
   271	
   272		if (u64P == 0)
   273			return 0;
   274	
   275		u64M = 0;
   276		for (i = 1; i < 64; i++) {
   277			u64tmpM = PllSrcClk / i;
   278			if ((u64tmpM <= VSIPLL_FREFDIVM_MAX_FREQ) &&
   279			    (u64tmpM >= VSIPLL_FREFDIVM_MIN_FREQ1)) {
   280				u64M = i;
   281				break;
   282			}
   283		}
   284	
   285		if (u64M == 0)
   286			return 0;
   287	
   288		u64tmp = (u64FCLKO * u64P * u64M * 1000) / PllSrcClk;
   289		u64N = u64tmp / 1000;
   290		u64X = u64tmp % 1000;
   291		u32FRAC = ((u64X << 24) + 500) / 1000;
   292	
   293		u64SSRATE = ((PllSrcClk >> 1) / (u32Fmod * 2)) - 1;
   294		u64SLOPE = ((u64tmp * u32SR / u64SSRATE) << 24) / 100 / 1000;
   295	
   296		u64PllClk = (PllSrcClk * u64tmp) / u64P / u64M / 1000;
   297	
   298		u32Reg[0] = (u64SSRATE << VSIPLLCTL0_SSRATE_POS) | (u64M <<
   299			     VSIPLLCTL0_INDIV_POS) | (u64N);
   300		u32Reg[1] = (u64P << VSIPLLCTL1_OUTDIV_POS) | (u32FRAC << VSIPLLCTL1_FRAC_POS);
   301		u32Reg[2] = u64SLOPE;
   302		return u64PllClk;
   303	}
   304	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
