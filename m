Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857AA65C38D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbjACQHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbjACQH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:07:29 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3781412A8C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672762043; x=1704298043;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=10rPs+q/6GprahqHx1aTzXOGUTqi4tY+HjtFhoTQcd8=;
  b=O8ju2l8AadI4iy74/FQ8PnDxRbGBlP3pVEEBoZp8LDkevDcvGFHGHdss
   7uBFsgusWZwrgKKIKD0rmWxOE+H1V7dRa53w+qboxIcg3Q6+GGSbzMSfA
   1dVaJGCIco6FEvbhBCJyQPVelXalBzc+4aaXlJ4tMiAJr3rP4wfY8ocnv
   6cESGVtrhNorcar/6eTrT1ES5CjNl1s3h0PaCpzZpNluhfse1+Vlu+CeX
   rEZVuTWa30nDWvU0Fan/4OHRkGYEKwO8+PvwmEev++rNQixBT8ExNf1gq
   i8kuOY2CrnDKtWtBjW051E5NEKnxotIS/Fgj0YnJuLvNMYtQyd+wTjuq1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="305196335"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="305196335"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:07:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="743546034"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="743546034"
Received: from nkpuppal-mobl2.amr.corp.intel.com (HELO [10.209.178.199]) ([10.209.178.199])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:07:21 -0800
Message-ID: <393a6418-0963-4859-3212-2f959be4f14f@linux.intel.com>
Date:   Tue, 3 Jan 2023 09:13:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] ASoC: Intel: sof_ssp_amp: remove unused variable
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
        Takashi Iwai <tiwai@suse.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-kernel@vger.kernel.org
References: <20230103073704.722027-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230103073704.722027-1-brent.lu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/23 01:37, Brent Lu wrote:
> The variable becomes useless since we moved the snd_soc_jack
> structure from a static array to sof_hdmi_pcm structure.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/intel/boards/sof_ssp_amp.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_ssp_amp.c b/sound/soc/intel/boards/sof_ssp_amp.c
> index 94d25aeb6e7c..f75800d9d6de 100644
> --- a/sound/soc/intel/boards/sof_ssp_amp.c
> +++ b/sound/soc/intel/boards/sof_ssp_amp.c
> @@ -105,7 +105,6 @@ static int sof_card_late_probe(struct snd_soc_card *card)
>  	char jack_name[NAME_SIZE];
>  	struct sof_hdmi_pcm *pcm;
>  	int err;
> -	int i;
>  
>  	if (!(sof_ssp_amp_quirk & SOF_HDMI_PLAYBACK_PRESENT))
>  		return 0;
> @@ -124,7 +123,6 @@ static int sof_card_late_probe(struct snd_soc_card *card)
>  		return hda_dsp_hdmi_build_controls(card, component);
>  	}
>  
> -	i = 0;
>  	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
>  		component = pcm->codec_dai->component;
>  		snprintf(jack_name, sizeof(jack_name),
> @@ -139,8 +137,6 @@ static int sof_card_late_probe(struct snd_soc_card *card)
>  					  &pcm->sof_hdmi);
>  		if (err < 0)
>  			return err;
> -
> -		i++;
>  	}
>  
>  	return hdac_hdmi_jack_port_init(component, &card->dapm);
