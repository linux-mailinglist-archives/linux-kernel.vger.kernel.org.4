Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793115B6930
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiIMIHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiIMIHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:07:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2AA5A89C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663056464; x=1694592464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cvZ2TM6hCRLiJ4827CHcLJrAhi/wZiqFHNLaQ1jHwQU=;
  b=PIgfW6Qj+s2ZTjbevgoKx12dLHqMVkeilEV8uYAO6vKoqi51oj9NLMtT
   ojvugYakdVf3AkUxaSPoMotpLuZMVfgzY8Qoo0dO94pe5AKhQcqrkpECu
   ObVMetrTld7rp5qekQcyFnRUpIG/5ylFaVU+XtHucFLUWATEPFZdy0omz
   Td0sCEyIgQcUuENHgmrxtjdk15MJwmYEdfD7NWZCmO1r42XEESLqUyhiC
   nwnc4xBwbBl6gD7/x9Gg3blYi0s1vVKryzRuLPUe+V2xrAweXzK4KFb6Z
   nHwDCcc/cHJJUIxA1+eEIBOwrAmc8qJobC4SPj6e8WkU1a8tDxyMNml8S
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="362025750"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="362025750"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 01:07:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="618836636"
Received: from tleistix-mobl2.ger.corp.intel.com (HELO [10.251.208.174]) ([10.251.208.174])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 01:07:38 -0700
Message-ID: <2577e4db-8593-cf37-135b-aa51b6268cd7@linux.intel.com>
Date:   Tue, 13 Sep 2022 10:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: remove
 SOF_RT1015_SPEAKER_AMP_100FS flag
Content-Language: en-US
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Ajye Huang <ajye.huang@gmail.com>,
        Mac Chiang <mac.chiang@intel.com>, linux-kernel@vger.kernel.org
References: <20220913074906.926774-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220913074906.926774-1-brent.lu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> -static int rt1015_hw_params_pll_and_tdm(struct snd_pcm_substream *substream,
> -					 struct snd_pcm_hw_params *params)
> -{
> -	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> -	struct snd_soc_dai *codec_dai;
> -	int i, fs = 100, ret;
> -
>  	for_each_rtd_codec_dais(rtd, i, codec_dai) {
>  		ret = snd_soc_dai_set_pll(codec_dai, 0, RT1015_PLL_S_BCLK,
> -					  params_rate(params) * fs,
> +					  clk_freq,
>  					  params_rate(params) * 256);
> -		if (ret)
> +		if (ret) {
> +			dev_err(codec_dai->dev, "fail to set pll, ret %d\n",
> +				ret);
>  			return ret;
> +		}
>  
>  		ret = snd_soc_dai_set_sysclk(codec_dai, RT1015_SCLK_S_PLL,
>  					     params_rate(params) * 256,
>  					     SND_SOC_CLOCK_IN);
> -		if (ret)
> +		if (ret) {
> +			dev_err(codec_dai->dev, "fail to set sysclk, ret %d\n",
> +				ret);
>  			return ret;
> -	}
> -	/* rx slot 1 for RT1015_DEV0_NAME */
> -	ret = snd_soc_dai_set_tdm_slot(asoc_rtd_to_codec(rtd, 0),
> -				       0x0, 0x1, 4, 24);
> -	if (ret)
> -		return ret;
> +		}
>  
> -	/* rx slot 2 for RT1015_DEV1_NAME */
> -	ret = snd_soc_dai_set_tdm_slot(asoc_rtd_to_codec(rtd, 1),
> -				       0x0, 0x2, 4, 24);
> -	if (ret)
> -		return ret;
> +		switch (dai_link->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +		case SND_SOC_DAIFMT_DSP_A:
> +		case SND_SOC_DAIFMT_DSP_B:
> +			/* 4-slot TDM */
> +			ret = snd_soc_dai_set_tdm_slot(codec_dai,
> +						       rt1015_tdm_mask[i].tx,
> +						       rt1015_tdm_mask[i].rx,
> +						       4,
> +						       params_width(params));

The changes look ok, just wondering if we can avoid hard-coding those 4
values. Can we not get the number of TDM slots from topology and/or
dailink configuration?


> +			if (ret < 0) {
> +				dev_err(codec_dai->dev, "fail to set tdm slot, ret %d\n",
> +					ret);
> +				return ret;
> +			}
> +			break;
> +		default:
> +			dev_dbg(codec_dai->dev, "codec is in I2S mode\n");
> +			break;
> +		}
> +	}
>  
> -	return 0;
> +	return ret;
