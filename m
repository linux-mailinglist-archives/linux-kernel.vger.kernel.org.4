Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E8774E76D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjGKGg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGKGgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:36:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E2293
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689057412; x=1720593412;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4+1OPTUKS90sS9jGvC6Wn9idI+xTKRc38R1oLorStVs=;
  b=APKt1m5q1dvPsiXTKy/9UflSlq1jYzYNp6DU1UyfjL5630OE4NW3ioXG
   uNb6nW5CDWoV6pg23Z2kzoDWRUzMaKpTR/ZiucOOyTKNuBmtZ/HtceC4y
   Ge1Xb57YQ/I+k4LmXTGBuz0V7wv5tiXEL9hkvFwLsaBbAeqhKtcnZJbb7
   RV/0ThFJpTQ23+bKRgIJMxbgl3pdcf1mc0nMsTvZ/RUgDBixXCBqp9gIK
   1GSAHZa/Dx2AFyl5SYnNFPG4QNL/eufENUJxXb8S7B/dJUeDeoEqGQBts
   WXwRzkRrcj3QB0AJIUP8/mvdp1NNU1oBSBVPjOK50vgWEdCn63FzseEdT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="362001206"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="362001206"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 23:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="698328881"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="698328881"
Received: from baparham-mobl.ger.corp.intel.com (HELO [10.252.44.75]) ([10.252.44.75])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 23:36:45 -0700
Message-ID: <f12360ff-cd8a-64b6-6cdd-beec2651787c@linux.intel.com>
Date:   Mon, 10 Jul 2023 09:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2] ASoC: Intel: sof_rt5682: add jsl_rt5650 board config
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
        Uday M Bhat <uday.m.bhat@intel.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Terry Cheong <htcheong@chromium.org>,
        "Dharageswari . R" <dharageswari.r@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org
References: <20230710141610.227988-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230710141610.227988-1-brent.lu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/23 16:16, Brent Lu wrote:
> This configuration supports JSL boards which implement ALC5650 dual
> I2S interface codec. Two DAI links are added: AIF1 (on codec side) for
> headphone and AIF2 for speakers.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>  sound/soc/intel/boards/Kconfig                |  5 +-
>  sound/soc/intel/boards/sof_rt5682.c           | 81 ++++++++++++++++++-
>  .../intel/common/soc-acpi-intel-jsl-match.c   | 12 +++
>  3 files changed, 93 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index f472f603ab75..1fe830af2b84 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -475,7 +475,7 @@ endif ## SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC || SND_SOC_SOF_HDA_AUDIO_CODEC
>  
>  if SND_SOC_SOF_HDA_LINK || SND_SOC_SOF_BAYTRAIL
>  config SND_SOC_INTEL_SOF_RT5682_MACH
> -	tristate "SOF with rt5682 codec in I2S Mode"
> +	tristate "SOF with rt5650/rt5682 codec in I2S Mode"
>  	depends on I2C && ACPI
>  	depends on ((SND_HDA_CODEC_HDMI && SND_SOC_SOF_HDA_AUDIO_CODEC) &&\
>  		    (MFD_INTEL_LPSS || COMPILE_TEST)) ||\
> @@ -485,6 +485,7 @@ config SND_SOC_INTEL_SOF_RT5682_MACH
>  	select SND_SOC_RT1011
>  	select SND_SOC_RT1015
>  	select SND_SOC_RT1015P
> +	select SND_SOC_RT5645
>  	select SND_SOC_RT5682_I2C
>  	select SND_SOC_RT5682S
>  	select SND_SOC_DMIC
> @@ -494,7 +495,7 @@ config SND_SOC_INTEL_SOF_RT5682_MACH
>  	select SND_SOC_INTEL_SOF_REALTEK_COMMON
>  	help
>  	   This adds support for ASoC machine driver for SOF platforms
> -	   with rt5682 codec.
> +	   with rt5650 or rt5682 codec.
>  	   Say Y if you have such a device.
>  	   If unsure select "N".
>  
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index 7c034d671cf3..53451c1b67f8 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -22,6 +22,7 @@
>  #include <sound/soc-acpi.h>
>  #include "../../codecs/rt5682.h"
>  #include "../../codecs/rt5682s.h"
> +#include "../../codecs/rt5645.h"
>  #include "../../codecs/hdac_hdmi.h"
>  #include "../common/soc-intel-quirks.h"
>  #include "hda_dsp_common.h"
> @@ -60,6 +61,7 @@
>  #define SOF_MAX98390_SPEAKER_AMP_PRESENT	BIT(24)
>  #define SOF_MAX98390_TWEETER_SPEAKER_PRESENT	BIT(25)
>  #define SOF_RT1019_SPEAKER_AMP_PRESENT	BIT(26)
> +#define SOF_RT5650_HEADPHONE_CODEC_PRESENT	BIT(27)
>  
>  
>  /* Default: MCLK on, MCLK 19.2M, SSP0  */
> @@ -305,7 +307,7 @@ static int sof_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
>  	struct sof_card_private *ctx = snd_soc_card_get_drvdata(rtd->card);
>  	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
>  	struct snd_soc_jack *jack;
> -	int ret;
> +	int ret, extra;

two lines, and rename to e.g. extra_jack_data


> +	if (sof_rt5682_quirk & SOF_RT5650_HEADPHONE_CODEC_PRESENT) {
> +		extra = SND_JACK_MICROPHONE | SND_JACK_BTN_0;
> +		ret = snd_soc_component_set_jack(component, jack, &extra);

I am a bit confused on why this wasn't set for rt5682?

> +	} else
> +		ret = snd_soc_component_set_jack(component, jack, NULL);

> +static const struct snd_soc_dapm_route rt5650_spk_dapm_routes[] = {
> +	/* speaker */
> +	{ "Left Spk", NULL, "SPOL" },
> +	{ "Right Spk", NULL, "SPOR" },
> +};
> +
>  static const struct snd_soc_dapm_route dmic_map[] = {
>  	/* digital mics */
>  	{"DMic", NULL, "SoC DMIC"},
>  };
>  
> +static int rt5650_spk_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_card *card = rtd->card;
> +	int ret;
> +
> +	ret = snd_soc_dapm_add_routes(&card->dapm, rt5650_spk_dapm_routes,
> +				      ARRAY_SIZE(rt5650_spk_dapm_routes));
> +	if (ret)
> +		dev_err(rtd->dev, "fail to add dapm routes, ret=%d\n", ret);
> +
> +	return ret;
> +}
> +
>  static int dmic_init(struct snd_soc_pcm_runtime *rtd)
>  {
>  	struct snd_soc_card *card = rtd->card;
> @@ -614,6 +656,17 @@ static struct snd_soc_dai_link_component rt5682s_component[] = {
>  	}
>  };
>  
> +static struct snd_soc_dai_link_component rt5650_components[] = {
> +	{
> +		.name = "i2c-10EC5650:00",
> +		.dai_name = "rt5645-aif1",
> +	},
> +	{
> +		.name = "i2c-10EC5650:00",
> +		.dai_name = "rt5645-aif2",
> +	}
> +};

can we move these definitions to realtek_common.c, chances are other
boards will also use this codec. Thanks!
