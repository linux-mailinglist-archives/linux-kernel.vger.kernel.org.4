Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1395064EE82
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiLPQG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiLPQGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:06:12 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF88062D9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671206586; x=1702742586;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lF4vw7e9EdXWDJLOD83gO5PEMesX68FvheF+irKVV2g=;
  b=Trr81rJ5nzMPMshoemErIiuV2IdEgWV9syPe5c1l3Nbj3c8XLYPv72WM
   u8BJ2jQphzIpppbYf56MEZcpT4kgBf04Kc17fl2748T4rKrEnz59EMW45
   WTxAn3f4i73Vbf+nW6sLKVm+aC9kkQwANPyzYxc4sCSxyQ6HKax5Zs6SY
   +x8tS4hxzE7HBjIYkMH2q9u65H25p4OiAHvktWSW09CqlD9AxB6cHyfSX
   izPjh+8ddkvmZva1Az32RSf/nvZVD/1ipSVG8DjCdT6Gfppj5WMH30KQM
   7h2VyOYpW7HmxjAEqdcyIV2PhBVPBDJx7zwWt0qqAmMASwMyZ4PsxyJSq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="383327925"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="383327925"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 08:03:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="824148061"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="824148061"
Received: from krojasle-mobl.amr.corp.intel.com (HELO [10.209.187.31]) ([10.209.187.31])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 08:03:04 -0800
Message-ID: <b0612bbd-2eba-36cf-9c29-7542cf32adfd@linux.intel.com>
Date:   Fri, 16 Dec 2022 10:03:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2] ASoC: Intel: sof_nau8825: add variant with nau8318
 amplifier.
Content-Language: en-US
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Yong Zhi <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, Brent Lu <brent.lu@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        alsa-devel@alsa-project.org
References: <20221216154938.9426-1-ajye_huang@compal.corp-partner.google.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221216154938.9426-1-ajye_huang@compal.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/22 09:49, Ajye Huang wrote:
> This patch adds the driver data for two nau8318 speaker amplifiers on
> SSP1 and nau8825 on SSP0 for ADL platform.

So here you are making reference to two amplifiers...

> +static struct snd_soc_dai_link_component nau8318_components[] = {
> +	{
> +		.name = "NVTN2012:00",
> +		.dai_name = "nau8315-hifi",
> +	}
> +};

but here there's only one? I was expecting something like what we've
used for Maxim amplifiers with a codec configuration and dailink
components that list the two amplifiers.

static struct snd_soc_codec_conf max_98373_codec_conf[] = {
	{
		.dlc = COMP_CODEC_CONF(MAX_98373_DEV0_NAME),
		.name_prefix = "Right",
	},
	{
		.dlc = COMP_CODEC_CONF(MAX_98373_DEV1_NAME),
		.name_prefix = "Left",
	},
};

struct snd_soc_dai_link_component max_98373_components[] = {
	{  /* For Right */
		.name = MAX_98373_DEV0_NAME,
		.dai_name = MAX_98373_CODEC_DAI,
	},
	{  /* For Left */
		.name = MAX_98373_DEV1_NAME,
		.dai_name = MAX_98373_CODEC_DAI,
	},
};

Or is this a commit message problem and there's really only one amplifier?

> +
>  static struct snd_soc_dai_link_component dummy_component[] = {
>  	{
>  		.name = "snd-soc-dummy",
> @@ -486,6 +494,11 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  			max_98360a_dai_link(&links[id]);
>  		} else if (sof_nau8825_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT) {
>  			sof_rt1015p_dai_link(&links[id]);
> +		} else if (sof_nau8825_quirk &
> +				SOF_NAU8318_SPEAKER_AMP_PRESENT) {
> +			links[id].codecs = nau8318_components;
> +			links[id].num_codecs = ARRAY_SIZE(nau8318_components);
> +			links[id].init = speaker_codec_init;

The rest looks fine, I only have this one/two amplifier question.
