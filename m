Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763046660A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239256AbjAKQgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjAKQgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:36:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57077116C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673454957; x=1704990957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6fg178pyC3sYYKy6n9PRcFhahGLP5hWIRuLMizCzi1g=;
  b=QwDkjEoQrdhG16VOlPFQy2F5FGCg/GMR3JyML8zehLLlyAiGiQyK40E3
   RV4iORuMl38IZU6SsT+HMxqS4TIgt/7yRHuxIu0hS7nhgImhuL2WMVzAY
   zJP2isXhVim4NywcTukV04SHUGouWU+h40U0K40dO+eC4QJtrRwgC7HWC
   JI5Fg6jzMCoizX25ZyTuvGdDLNdDJRgiuMnqpLKOSMHWYNVLw5NheSwmg
   uSQngej9/1mklD7VOWtvmO+65uYmjvbbkeHTQFLEV5+1fLeMNqDuLE1h1
   l66vqn8Q2hgKXmxHSsCnrBF9819HKdykAbZcHJXtyPOqaUnlDflNNEAqJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324704029"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324704029"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607408347"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607408347"
Received: from flobatol-mobl1.amr.corp.intel.com (HELO [10.212.110.208]) ([10.212.110.208])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:13 -0800
Message-ID: <ad052efb-286e-4716-7608-d284782011cd@linux.intel.com>
Date:   Wed, 11 Jan 2023 08:58:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 03/19] soundwire: amd: register sdw controller dai ops
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-4-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230111090222.2016499-4-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/23 03:02, Vijendar Mukunda wrote:
> Register dai ops for two controller instances.

manager instances

> diff --git a/drivers/soundwire/amd_master.c b/drivers/soundwire/amd_master.c
> index 7e1f618254ac..93bffe6ff9e2 100644
> --- a/drivers/soundwire/amd_master.c
> +++ b/drivers/soundwire/amd_master.c
> @@ -952,6 +952,186 @@ static const struct sdw_master_ops amd_sdwc_ops = {
>  	.read_ping_status = amd_sdwc_read_ping_status,
>  };
>  
> +static int amd_sdwc_hw_params(struct snd_pcm_substream *substream,
> +			      struct snd_pcm_hw_params *params,
> +			      struct snd_soc_dai *dai)
> +{
> +	struct amd_sdwc_ctrl *ctrl = snd_soc_dai_get_drvdata(dai);
> +	struct sdw_amd_dma_data *dma;
> +	struct sdw_stream_config sconfig;
> +	struct sdw_port_config *pconfig;
> +	int ch, dir;
> +	int ret;
> +
> +	dma = snd_soc_dai_get_dma_data(dai, substream);
> +	if (!dma)
> +		return -EIO;
> +
> +	ch = params_channels(params);
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +		dir = SDW_DATA_DIR_RX;
> +	else
> +		dir = SDW_DATA_DIR_TX;
> +	dev_dbg(ctrl->dev, "%s: dir:%d dai->id:0x%x\n", __func__, dir, dai->id);
> +	dma->hw_params = params;
> +
> +	sconfig.direction = dir;
> +	sconfig.ch_count = ch;
> +	sconfig.frame_rate = params_rate(params);
> +	sconfig.type = dma->stream_type;
> +
> +	sconfig.bps = snd_pcm_format_width(params_format(params));
> +
> +	/* Port configuration */
> +	pconfig = kzalloc(sizeof(*pconfig), GFP_KERNEL);
> +	if (!pconfig) {
> +		ret =  -ENOMEM;
> +		goto error;
> +	}
> +
> +	pconfig->num = dai->id;
> +	pconfig->ch_mask = (1 << ch) - 1;
> +	ret = sdw_stream_add_master(&ctrl->bus, &sconfig,
> +				    pconfig, 1, dma->stream);
> +	if (ret)
> +		dev_err(ctrl->dev, "add master to stream failed:%d\n", ret);
> +
> +	kfree(pconfig);
> +error:
> +	return ret;
> +}

This looks inspired from intel.c, but you are not programming ANY
registers here. is this intentional?

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

you want to avoid using dma_data and use your own runtime. We made that
change recently for cadence_runtime.c

> +
> +	if (stream) {
> +		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
> +			dma = dai->playback_dma_data;
> +		else
> +			dma = dai->capture_dma_data;
> +
> +		if (dma) {
> +			dev_err(dai->dev,
> +				"dma_data already allocated for dai %s\n",
> +				dai->name);
> +			return -EINVAL;
> +		}
> +
> +		/* allocate and set dma info */
> +		dma = kzalloc(sizeof(*dma), GFP_KERNEL);
> +		if (!dma)
> +			return -ENOMEM;
> +		dma->stream_type = SDW_STREAM_PCM;
> +		dma->bus = &ctrl->bus;
> +		dma->link_id = ctrl->instance;
> +		dma->stream = stream;
> +
> +		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
> +			dai->playback_dma_data = dma;
> +		else
> +			dai->capture_dma_data = dma;
> +	} else {
> +		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
> +			kfree(dai->playback_dma_data);
> +			dai->playback_dma_data = NULL;
> +		} else {
> +			kfree(dai->capture_dma_data);
> +			dai->capture_dma_data = NULL;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int amd_pcm_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
> +{
> +	return amd_set_sdw_stream(dai, stream, direction);
> +}
> +
> +static void *amd_get_sdw_stream(struct snd_soc_dai *dai, int direction)
> +{
> +	struct sdw_amd_dma_data *dma;
> +
> +	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
> +		dma = dai->playback_dma_data;
> +	else
> +		dma = dai->capture_dma_data;
> +
> +	if (!dma)
> +		return ERR_PTR(-EINVAL);
> +
> +	return dma->stream;
> +}
> +
> +static const struct snd_soc_dai_ops amd_sdwc_dai_ops = {
> +	.hw_params = amd_sdwc_hw_params,
> +	.hw_free = amd_sdwc_hw_free,
> +	.set_stream = amd_pcm_set_sdw_stream,

In the first patch there was support for PDM exposed, but here it's PDM
only?

> +	.get_stream = amd_get_sdw_stream,
> +};
> +
> +static const struct snd_soc_component_driver amd_sdwc_dai_component = {
> +	.name = "soundwire",
> +};
> +
> +static int amd_sdwc_register_dais(struct amd_sdwc_ctrl *ctrl)
> +{
> +	struct snd_soc_dai_driver *dais;
> +	struct snd_soc_pcm_stream *stream;
> +	struct device *dev;
> +	int i, num_dais;
> +
> +	dev = ctrl->dev;
> +	num_dais = ctrl->num_dout_ports + ctrl->num_din_ports;
> +	dais = devm_kcalloc(dev, num_dais, sizeof(*dais), GFP_KERNEL);
> +	if (!dais)
> +		return -ENOMEM;
> +	for (i = 0; i < num_dais; i++) {
> +		dais[i].name = devm_kasprintf(dev, GFP_KERNEL, "SDW%d Pin%d", ctrl->instance, i);
> +		if (!dais[i].name) {
> +			dev_err(ctrl->dev, "-ENOMEM dai name allocation failed\n");

remove, we don't add error logs on memory allocation issues.

> +			return -ENOMEM;
> +		}
> +
> +		if (i < ctrl->num_dout_ports)
> +			stream = &dais[i].playback;
> +		else
> +			stream = &dais[i].capture;
> +
> +		stream->channels_min = 2;
> +		stream->channels_max = 2;

Is this a port limitation or just a software definition?

> +		stream->rates = SNDRV_PCM_RATE_48000;
> +		stream->formats = SNDRV_PCM_FMTBIT_S16_LE;

Wondering if this is needed. I don't even recall why it's in the Intel
code, we tested with 32 bit data and 192kHz, that looks unnecessary to
me unless the hardware is really limited to those values.

> +
> +		dais[i].ops = &amd_sdwc_dai_ops;
> +		dais[i].id = i;
> +	}
> +
> +	return devm_snd_soc_register_component(ctrl->dev, &amd_sdwc_dai_component,
> +					       dais, num_dais);
> +}
> +
>  static void amd_sdwc_probe_work(struct work_struct *work)
>  {
>  	struct amd_sdwc_ctrl *ctrl  = container_of(work, struct amd_sdwc_ctrl, probe_work);
> @@ -1043,6 +1223,12 @@ static int amd_sdwc_probe(struct platform_device *pdev)
>  			ret);
>  		return ret;
>  	}
> +	ret = amd_sdwc_register_dais(ctrl);
> +	if (ret) {
> +		dev_err(dev, "CPU DAI registration failed\n");
> +		sdw_bus_master_delete(&ctrl->bus);
> +		return ret;
> +	}
>  	INIT_WORK(&ctrl->probe_work, amd_sdwc_probe_work);
>  	schedule_work(&ctrl->probe_work);
>  	return 0;
> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
> index 5ec39f8c2f2e..7a99d782969f 100644
> --- a/include/linux/soundwire/sdw_amd.h
> +++ b/include/linux/soundwire/sdw_amd.h
> @@ -13,6 +13,7 @@
>  #define ACP_SDW0	0
>  #define ACP_SDW1	1
>  #define ACP_SDW0_MAX_DAI	6
> +#define AMD_SDW_MAX_DAIS	8

How does this work? 6 dais for the first master and 2 for the second?

>  
>  struct acp_sdw_pdata {
>  	u16 instance;
> @@ -25,6 +26,7 @@ struct amd_sdwc_ctrl {
>  	void __iomem *mmio;
>  	struct work_struct probe_work;
>  	struct mutex *sdw_lock;
> +	struct sdw_stream_runtime *sruntime[AMD_SDW_MAX_DAIS];

well no, a stream runtime needs to be allocated per stream and usually
there's a 1:1 mapping between dailink and stream. A stream may use
multiple DAIs, possibly on different masters - just like a dailink can
rely on multiple cpu- and codec-dais.

You are conflating/confusing concepts I am afraid here.

>  	int num_din_ports;
>  	int num_dout_ports;
>  	int cols_index;
> @@ -36,4 +38,23 @@ struct amd_sdwc_ctrl {
>  	bool startup_done;
>  	u32 power_mode_mask;
>  };
> +
> +/**
> + * struct sdw_amd_dma_data: AMD DMA data
> + *
> + * @name: SoundWire stream name
> + * @stream: stream runtime
> + * @bus: Bus handle
> + * @stream_type: Stream type
> + * @link_id: Master link id
> + * @hw_params: hw_params to be applied in .prepare step
> + */
> +struct sdw_amd_dma_data {
> +	char *name;
> +	struct sdw_stream_runtime *stream;
> +	struct sdw_bus *bus;
> +	enum sdw_stream_type stream_type;
> +	int link_id;
> +	struct snd_pcm_hw_params *hw_params;
> +};
>  #endif
