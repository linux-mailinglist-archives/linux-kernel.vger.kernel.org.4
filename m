Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EABB6EB752
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 06:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDVESm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 00:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDVESk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 00:18:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2350173F;
        Fri, 21 Apr 2023 21:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682137118; x=1713673118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dY2qs8+rlp/rs99HoANqnowhLvLoxWNYndLxlIHsgLU=;
  b=c2K5r4oXEaUvU/juNYmrOZGwXfbTZ6r/vWs2dzz5NaqsOj9AGPj4JqXh
   Zr8qpfsP3EvuFN1lFvDRakmGiVdsEwMV/osbFhYwST7Uz9kFyHOed6M8y
   JIvY8gxqxkEISZ0nGRnInA5PBaCtQV+Eob+noh3WTaHpa0rpjOFi5c4D7
   H0XxcCLT7iwmDvujXcZfUNyTpWRwSBT5EXgAFwYFnpQM7t4jI2HrNZSNc
   IR5TiZNz4G8Ds7U8XyF4BlmEPOjSOFPMk4OZH2h5LGli0q64LvCLjQshg
   nNAB/11cHTEdZ/5iWEmqpv7Ot655R/KbBGkq5GcpXJQ0X+n92fsl94Q63
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="374063243"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="374063243"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 21:18:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="757102408"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="757102408"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2023 21:18:35 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pq4hm-000h3s-0Y;
        Sat, 22 Apr 2023 04:18:34 +0000
Date:   Sat, 22 Apr 2023 12:18:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 6/7] ASoC: codecs: Add support for the Lantiq PEF2256
 codec
Message-ID: <202304221213.LXOnsKtj-lkp@intel.com>
References: <20230417171601.74656-7-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417171601.74656-7-herve.codina@bootlin.com>
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

Hi Herve,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on linusw-pinctrl/devel linusw-pinctrl/for-next broonie-sound/for-next linus/master v6.3-rc7 next-20230421]
[cannot apply to lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Herve-Codina/dt-bindings-mfd-Add-the-Lantiq-PEF2256-E1-T1-J1-framer/20230418-011757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20230417171601.74656-7-herve.codina%40bootlin.com
patch subject: [PATCH v6 6/7] ASoC: codecs: Add support for the Lantiq PEF2256 codec
config: loongarch-randconfig-s051-20230421 (https://download.01.org/0day-ci/archive/20230422/202304221213.LXOnsKtj-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/1b22af56c892af6c0b5f6f18eff40f1fbefcb699
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Herve-Codina/dt-bindings-mfd-Add-the-Lantiq-PEF2256-E1-T1-J1-framer/20230418-011757
        git checkout 1b22af56c892af6c0b5f6f18eff40f1fbefcb699
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304221213.LXOnsKtj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/soc/codecs/pef2256-codec.c:137:26: sparse: sparse: restricted snd_pcm_format_t degrades to integer
>> sound/soc/codecs/pef2256-codec.c:139:59: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted snd_pcm_format_t [usertype] format @@     got unsigned int [assigned] i @@
   sound/soc/codecs/pef2256-codec.c:139:59: sparse:     expected restricted snd_pcm_format_t [usertype] format
   sound/soc/codecs/pef2256-codec.c:139:59: sparse:     got unsigned int [assigned] i
   sound/soc/codecs/pef2256-codec.c:177:26: sparse: sparse: restricted snd_pcm_format_t degrades to integer
>> sound/soc/codecs/pef2256-codec.c:179:62: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted snd_pcm_format_t [usertype] format @@     got int [assigned] i @@
   sound/soc/codecs/pef2256-codec.c:179:62: sparse:     expected restricted snd_pcm_format_t [usertype] format
   sound/soc/codecs/pef2256-codec.c:179:62: sparse:     got int [assigned] i

vim +137 sound/soc/codecs/pef2256-codec.c

   118	
   119	static int pef2256_dai_hw_rule_format_by_channels(struct snd_soc_dai *dai,
   120							  struct snd_pcm_hw_params *params,
   121							  unsigned int nb_ts)
   122	{
   123		struct snd_mask *f_old = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
   124		unsigned int channels = params_channels(params);
   125		unsigned int slot_width;
   126		struct snd_mask f_new;
   127		unsigned int i;
   128	
   129		if (!channels || channels > nb_ts) {
   130			dev_err(dai->dev, "channels %u not supported\n", nb_ts);
   131			return -EINVAL;
   132		}
   133	
   134		slot_width = (nb_ts / channels) * 8;
   135	
   136		snd_mask_none(&f_new);
 > 137		for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
   138			if (snd_mask_test(f_old, i)) {
 > 139				if (snd_pcm_format_physical_width(i) <= slot_width)
   140					snd_mask_set(&f_new, i);
   141			}
   142		}
   143	
   144		return snd_mask_refine(f_old, &f_new);
   145	}
   146	
   147	static int pef2256_dai_hw_rule_playback_format_by_channels(struct snd_pcm_hw_params *params,
   148								   struct snd_pcm_hw_rule *rule)
   149	{
   150		struct snd_soc_dai *dai = rule->private;
   151		struct pef2256_codec *pef2256 = snd_soc_component_get_drvdata(dai->component);
   152	
   153		return pef2256_dai_hw_rule_format_by_channels(dai, params, pef2256->max_chan_playback);
   154	}
   155	
   156	static int pef2256_dai_hw_rule_capture_format_by_channels(struct snd_pcm_hw_params *params,
   157								  struct snd_pcm_hw_rule *rule)
   158	{
   159		struct snd_soc_dai *dai = rule->private;
   160		struct pef2256_codec *pef2256 = snd_soc_component_get_drvdata(dai->component);
   161	
   162		return pef2256_dai_hw_rule_format_by_channels(dai, params, pef2256->max_chan_capture);
   163	}
   164	
   165	static u64 pef2256_formats(u8 nb_ts)
   166	{
   167		u64 formats;
   168		unsigned int chan_width;
   169		unsigned int format_width;
   170		int i;
   171	
   172		if (!nb_ts)
   173			return 0;
   174	
   175		formats = 0;
   176		chan_width = nb_ts * 8;
   177		for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
   178			/* Support physical width multiple of 8bit */
 > 179			format_width = snd_pcm_format_physical_width(i);
   180			if (format_width == 0 || format_width % 8)
   181				continue;
   182	
   183			/*
   184			 * And support physical width that can fit N times in the
   185			 * channel
   186			 */
   187			if (format_width > chan_width || chan_width % format_width)
   188				continue;
   189	
   190			formats |= (1ULL << i);
   191		}
   192		return formats;
   193	}
   194	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
