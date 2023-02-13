Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B315694F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBMSYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMSYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:24:51 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384B4F1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676312690; x=1707848690;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6oemDddA4f4z+hGLzwuZfSDc2rXF+EIzNg4C7rCteyU=;
  b=jMVXuUiACLP7IE+kyct86FBkRHWgt9fxXbfMVgJpaY5BmdXvOmvZ2NPR
   5lh+VKmHQTdvwpcSh65EHdVQduoma1+HYjvZLZ8rmWwnKhJt5/H3rQmml
   Rn3Rdrsre440NK8t0ChPhFIFWCIus5H9qUKDnl7HtqJzLDXxWXS8XnymP
   kr/elzc3a3IRz/Y/hoeTynuCfU+oBwtT2fYecVJrSIcSEvaex1OH7rmCt
   YqWvWo5ELpjZakXlef4AgvFRiayRdVDRwAGumLcFZdZ5foHNh2ehkjDWN
   RZPxO44okzz6cy38QKQC/S3FX/DlV72EIz3NeiffgO3yvXFa4S1qvp8RY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="328664066"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="328664066"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 10:24:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="701369303"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="701369303"
Received: from eatoledo-mobl.amr.corp.intel.com (HELO [10.212.18.132]) ([10.212.18.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 10:24:36 -0800
Message-ID: <0522e771-2e88-462b-ebb1-50126cac0026@linux.intel.com>
Date:   Mon, 13 Feb 2023 12:09:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V2 3/8] soundwire: amd: register soundwire manager dai ops
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, vkoul@kernel.org
Cc:     amadeuszx.slawinski@linux.intel.com, Mario.Limonciello@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
 <20230213094031.2231058-4-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230213094031.2231058-4-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/23 03:40, Vijendar Mukunda wrote:
> Register dai ops for soundwire manager instances.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  drivers/soundwire/amd_manager.c   | 182 ++++++++++++++++++++++++++++++
>  drivers/soundwire/amd_manager.h   |  18 +++
>  include/linux/soundwire/sdw_amd.h |  18 +++
>  3 files changed, 218 insertions(+)
> 
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index cd1e5a3d5995..14c88b80ab6d 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -641,6 +641,182 @@ static const struct sdw_master_ops amd_sdw_ops = {
>  	.read_ping_status = amd_sdw_read_ping_status,
>  };
>  
> +static int amd_sdw_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
> +	struct sdw_amd_dai_runtime *dai_runtime;
> +	struct sdw_stream_config sconfig;
> +	struct sdw_port_config *pconfig;
> +	int ch, dir;
> +	int ret;
> +
> +	dai_runtime = amd_manager->dai_runtime_array[dai->id];
> +	if (!dai_runtime)
> +		return -EIO;
> +
> +	ch = params_channels(params);
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +		dir = SDW_DATA_DIR_RX;
> +	else
> +		dir = SDW_DATA_DIR_TX;
> +	dev_dbg(amd_manager->dev, "%s: dir:%d dai->id:0x%x\n", __func__, dir, dai->id);
> +
> +	sconfig.direction = dir;
> +	sconfig.ch_count = ch;
> +	sconfig.frame_rate = params_rate(params);
> +	sconfig.type = dai_runtime->stream_type;
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
> +	ret = sdw_stream_add_master(&amd_manager->bus, &sconfig,
> +				    pconfig, 1, dai_runtime->stream);
> +	if (ret)
> +		dev_err(amd_manager->dev, "add manager to stream failed:%d\n", ret);
> +
> +	kfree(pconfig);
> +error:
> +	return ret;
> +}
> +
> +static int amd_sdw_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
> +{
> +	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
> +	struct sdw_amd_dai_runtime *dai_runtime;
> +	int ret;
> +
> +	dai_runtime = amd_manager->dai_runtime_array[dai->id];
> +	if (!dai_runtime)
> +		return -EIO;
> +
> +	ret = sdw_stream_remove_master(&amd_manager->bus, dai_runtime->stream);
> +	if (ret < 0)
> +		dev_err(dai->dev, "remove manager from stream %s failed: %d\n",
> +			dai_runtime->stream->name, ret);
> +	return ret;
> +}
> +
> +static int amd_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
> +{
> +	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
> +	struct sdw_amd_dai_runtime *dai_runtime;
> +
> +	dai_runtime = amd_manager->dai_runtime_array[dai->id];
> +	if (stream) {
> +		/* first paranoia check */
> +		if (dai_runtime) {
> +			dev_err(dai->dev,
> +				"dai_runtime already allocated for dai %s\n",
> +				dai->name);
> +			return -EINVAL;
> +		}
> +
> +		/* allocate and set dai_runtime info */
> +		dai_runtime = kzalloc(sizeof(*dai_runtime), GFP_KERNEL);
> +		if (!dai_runtime)
> +			return -ENOMEM;
> +
> +		dai_runtime->stream_type = SDW_STREAM_PCM;
> +		dai_runtime->bus = &amd_manager->bus;
> +		dai_runtime->stream = stream;
> +		amd_manager->dai_runtime_array[dai->id] = dai_runtime;
> +	} else {
> +		/* second paranoia check */
> +		if (!dai_runtime) {
> +			dev_err(dai->dev,
> +				"dai_runtime not allocated for dai %s\n",
> +				dai->name);
> +			return -EINVAL;
> +		}
> +
> +		/* for NULL stream we release allocated dai_runtime */
> +		kfree(dai_runtime);
> +		amd_manager->dai_runtime_array[dai->id] = NULL;
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
> +	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
> +	struct sdw_amd_dai_runtime *dai_runtime;
> +
> +	dai_runtime = amd_manager->dai_runtime_array[dai->id];
> +	if (!dai_runtime)
> +		return ERR_PTR(-EINVAL);
> +
> +	return dai_runtime->stream;
> +}
> +
> +static const struct snd_soc_dai_ops amd_sdw_dai_ops = {
> +	.hw_params = amd_sdw_hw_params,
> +	.hw_free = amd_sdw_hw_free,
> +	.set_stream = amd_pcm_set_sdw_stream,
> +	.get_stream = amd_get_sdw_stream,
> +};
> +
> +static const struct snd_soc_component_driver amd_sdw_dai_component = {
> +	.name = "soundwire",
> +};
> +
> +static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
> +{
> +	struct sdw_amd_dai_runtime **dai_runtime_array;
> +	struct snd_soc_dai_driver *dais;
> +	struct snd_soc_pcm_stream *stream;
> +	struct device *dev;
> +	int i, num_dais;
> +
> +	dev = amd_manager->dev;
> +	num_dais = amd_manager->num_dout_ports + amd_manager->num_din_ports;
> +	dais = devm_kcalloc(dev, num_dais, sizeof(*dais), GFP_KERNEL);
> +	if (!dais)
> +		return -ENOMEM;
> +
> +	dai_runtime_array = devm_kcalloc(dev, num_dais,
> +					 sizeof(struct sdw_amd_dai_runtime *),
> +					 GFP_KERNEL);
> +	if (!dai_runtime_array)
> +		return -ENOMEM;
> +	amd_manager->dai_runtime_array = dai_runtime_array;
> +	for (i = 0; i < num_dais; i++) {
> +		dais[i].name = devm_kasprintf(dev, GFP_KERNEL, "SDW%d Pin%d", amd_manager->instance,
> +					      i);
> +		if (!dais[i].name)
> +			return -ENOMEM;
> +		if (i < amd_manager->num_dout_ports)
> +			stream = &dais[i].playback;
> +		else
> +			stream = &dais[i].capture;
> +
> +		stream->channels_min = 2;
> +		stream->channels_max = 2;
> +		stream->rates = SNDRV_PCM_RATE_48000;
> +		stream->formats = SNDRV_PCM_FMTBIT_S16_LE;

do you have a restriction on formats here? IIRC we've removed this from
the Intel code.

> +
> +		dais[i].ops = &amd_sdw_dai_ops;
> +		dais[i].id = i;
> +	}
> +
> +	return devm_snd_soc_register_component(dev, &amd_sdw_dai_component,
> +					       dais, num_dais);
> +}
> +
>  static void amd_sdw_probe_work(struct work_struct *work)
>  {
>  	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
> @@ -726,6 +902,12 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
>  		dev_err(dev, "Failed to register Soundwire manager(%d)\n", ret);
>  		return ret;
>  	}
> +	ret = amd_sdw_register_dais(amd_manager);
> +	if (ret) {
> +		dev_err(dev, "CPU DAI registration failed\n");
> +		sdw_bus_master_delete(&amd_manager->bus);
> +		return ret;
> +	}
>  	dev_set_drvdata(dev, amd_manager);
>  	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
>  	schedule_work(&amd_manager->probe_work);
> diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
> index 811ed9ee3d86..3e1bded1e769 100644
> --- a/drivers/soundwire/amd_manager.h
> +++ b/drivers/soundwire/amd_manager.h
> @@ -205,6 +205,24 @@ struct sdw_manager_dp_reg {
>  	u32 lane_ctrl_ch_en_reg;
>  };
>  
> +/*
> + * SDW0 Manager instance registers  6 CPU DAI (3 TX & 3 RX Ports)
> + * whereas SDW1  Manager Instance registers 2 CPU DAI (one TX & one RX port)
> + * Below is the CPU DAI <->Manager port number mapping
> + * i.e SDW0 Pin0 -> port number 0 -> AUDIO0 TX
> + *     SDW0 Pin1 -> Port number 1 -> AUDIO1 TX
> + *     SDW0 Pin2 -> Port number 2 -> AUDIO2 TX
> + *     SDW0 Pin3 -> port number 3 -> AUDIO0 RX
> + *     SDW0 Pin4 -> Port number 4 -> AUDIO1 RX
> + *     SDW0 Pin5 -> Port number 5 -> AUDIO2 RX
> + *  Whereas for SDW1 instance
> + *  SDW1 Pin0 -> port number 0 -> AUDIO1 TX
> + *  SDW1 Pin1 -> Port number 1 -> AUDIO1 RX
> + *  Same mapping should be used for programming DMA controller registers in Soundwire DMA driver.
> + * i.e if AUDIO0 TX channel is selected then we need to use AUDIO0 TX registers for DMA programming
> + * in Soundwire DMA driver.
> + */
> +
>  static struct sdw_manager_dp_reg sdw0_manager_dp_reg[AMD_SDW0_MAX_DAI] =  {
>  	{ACP_SW_AUDIO0_TX_FRAME_FORMAT, ACP_SW_AUDIO0_TX_SAMPLEINTERVAL, ACP_SW_AUDIO0_TX_HCTRL_DP0,
>  	 ACP_SW_AUDIO0_TX_OFFSET_DP0, ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP0},
> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
> index 922d30a540fd..c978cfbc0207 100644
> --- a/include/linux/soundwire/sdw_amd.h
> +++ b/include/linux/soundwire/sdw_amd.h
> @@ -23,6 +23,21 @@ struct sdw_manager_reg_mask {
>  	u32 acp_sdw_intr_mask;
>  };
>  
> +/**
> + * struct sdw_amd_dai_runtime: AMD sdw dai runtime  data
> + *
> + * @name: SoundWire stream name
> + * @stream: stream runtime
> + * @bus: Bus handle
> + * @stream_type: Stream type
> + */
> +struct sdw_amd_dai_runtime {
> +	char *name;
> +	struct sdw_stream_runtime *stream;
> +	struct sdw_bus *bus;
> +	enum sdw_stream_type stream_type;
> +};

This seems pretty generic non-AMD code, and all the dai registration is
also 'inspired' from the Intel code, seems like there's room for code
sharing/reuse.

> +
>  /**
>   * struct amd_sdw_manager - amd manager driver context
>   * @bus: bus handle
> @@ -40,6 +55,7 @@ struct sdw_manager_reg_mask {
>   * @quirks: soundwire manager quirks
>   * @wake_en_mask: wake enable mask per soundwire manager
>   * @power_mode_mask: flag interprets amd soundwire manager power mode
> + * @dai_runtime_array: dai runtime array
>   */
>  struct amd_sdw_manager {
>  	struct sdw_bus bus;
> @@ -63,5 +79,7 @@ struct amd_sdw_manager {
>  	u32 quirks;
>  	u32 wake_en_mask;
>  	u32 power_mode_mask;
> +
> +	struct sdw_amd_dai_runtime **dai_runtime_array;
>  };
>  #endif
