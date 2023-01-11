Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A041665E93
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjAKO7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbjAKO70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:59:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999EDD4A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673449165; x=1704985165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6uBzO+A42kjsB9M6kqGtA0XHS7zpg3L5miYdlRwNzaY=;
  b=OjKNZkqjNAmaAQ1ngRUTRxQyiHBZYANf6r5l+7esV/nnbW6YOruAiAdP
   /bhLSxaxeVVFXuhrAQds8zcmbr3dz35AxsHmCzYo7LTyxYCiY2aIvK7I8
   NYdl8zS+U6x4zqh4mrMKy7vcULpawxje7uwo17W7uQQs+cwOdFBUo4OxG
   qgNmWKoouTyxd2usjfSpuBr1Mn0ChUgvj8cyUcNRhcFKiLjmIEuVK/htX
   Vvv1MevWrdqht4fLijW/F0ZhXsA8evMGMnE450Pl7ac7R2BC7cHz12Ja1
   lns8iDJQO+G8VW9c1w4FsSMwYv98+nbtCo/cGxeL+X3OWAD0qEE/x1407
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="322129507"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="322129507"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:59:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="765176022"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="765176022"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:59:22 -0800
Message-ID: <67ed911d-0a01-7f71-9258-495e2e143664@linux.intel.com>
Date:   Wed, 11 Jan 2023 15:59:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 03/19] soundwire: amd: register sdw controller dai ops
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
        Basavaraj.Hiregoudar@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Mario.Limonciello@amd.com, arungopal.kondaveeti@amd.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-4-Vijendar.Mukunda@amd.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230111090222.2016499-4-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/2023 10:02 AM, Vijendar Mukunda wrote:
> Register dai ops for two controller instances.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---

> +static int amd_sdwc_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
> +{
> +	struct amd_sdwc_ctrl *ctrl = snd_soc_dai_get_drvdata(dai);
> +	struct sdw_amd_dma_data *dma;
> +	int ret;
> +
> +	dma = snd_soc_dai_get_dma_data(dai, substream);
> +	if (!dma)
> +		return -EIO;
> +
> +	ret = sdw_stream_remove_master(&ctrl->bus, dma->stream);
> +	if (ret < 0) {
> +		dev_err(dai->dev, "remove master from stream %s failed: %d\n",
> +			dma->stream->name, ret);
> +		return ret;
> +	}
> +	dma->hw_params = NULL;
> +	return 0;
> +}
> +
> +static int amd_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
> +{
> +	struct amd_sdwc_ctrl *ctrl = snd_soc_dai_get_drvdata(dai);
> +	struct sdw_amd_dma_data *dma;
> +
> +	if (stream) {
> +		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
> +			dma = dai->playback_dma_data;
> +		else
> +			dma = dai->capture_dma_data;
> +

The patch itself looks ok, but I have generic ASoC API question. Could 
we perhaps change snd_soc_dai_get_dma_data() definition, so that instead 
of it being:
static inline void *snd_soc_dai_get_dma_data(const struct snd_soc_dai 
*dai, const struct snd_pcm_substream *ss)
it would be something like:
static inline void *snd_soc_dai_get_dma_data(const struct snd_soc_dai 
*dai, int direction)

it would require converting current calls from something like
dma = snd_soc_dai_get_dma_data(dai, substream);
to
dma = snd_soc_dai_get_dma_data(dai, substream->stream);
but would also allow for use in code like above?
It would become just:
dma = snd_soc_dai_get_dma_data(dai, direction);

The more I'm looking at the soc-dai.h header the more I like this idea, 
as other functions in the area seem to pass stream/direction explicitly 
instead of substream.

Mark, what do you think?
