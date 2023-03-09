Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992066B1F37
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCIJDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjCIJDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:03:10 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B95C38E9E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:01:29 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l1so1081635wry.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678352488;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UGQZkHP1qVG01CaVXO04kp919ezN3KHl1VDzCs0HD0I=;
        b=nkhextoC71CnpZHbd5HOt33fXk4UAivrVodz5RmU1siplPa2VeNRigVx9NE3cP9DuO
         lDCl/rSQecgd/X7U4kkNMgzKym+gSDK/6KbqH96Iyht6RhZ/oInjELooArd83S8ya2i2
         XflDN1G4baXDgjbqi1o19Cse8Sr1hWxlF6XHXlGaRng6azEwKfAGUkRx2yE4bOJcfv2S
         rXnAX5/zjiU8/srwF2nR5f0No6yBRytkEaOOxDGYUeEIWcinb5/ECqNwZKxmAjOs+m2g
         Gy+e8JcV0MazDzZiOe6d9EHv9ulSfEcMMODb0FaYpmkKNs24Q9Reh09aBtdp6WqfqEX6
         FUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678352488;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGQZkHP1qVG01CaVXO04kp919ezN3KHl1VDzCs0HD0I=;
        b=SUw5Znh6CI19RJ4NPl0TOwjRovPGsDl/0a4T/jteZ5UnWJZjjRY9BgeTVtMslhdJfk
         PwPtSK5njBJglAvhS/7PT30jfB0mrZIIo5GtOnHFQazPK5UzOP6Ov/cqkU7+Drchz3TY
         MBvaB2jlmevUNzXtnsJuziTke3ONUs4GzErWifd14XSHyyiSL9e7Mhocw9+PIX26Bels
         AFtbfZoWi2NXTvzBrMzepGgP8GE/W19LiHxfTTNEIVyVqGxNJ6ZZVswyym7s3rvqNCSy
         lDBKAYCoSExvWyJ4+nzkyLHKS9Mznk8Cn3Bf5/XExm5TYcx7JfWtOBAStPlTkKwn+2gc
         t0uQ==
X-Gm-Message-State: AO0yUKVyG0T9jp9yXarR9SuqZ+oW0jbuvkmlEaMqiEkCvPV3NlNDlzkr
        0VysUtNb7U3m+DIAqgp2Wcr/t/uY3JraoehcThg=
X-Google-Smtp-Source: AK7set/9B/JjLq8gEDuCihyGvt4qC+LZIBxqjpN4LLp6McUmPqH1VLliCB+nM7bH2+xMvH76jiDrng==
X-Received: by 2002:a5d:4b08:0:b0:2c3:e7d8:245c with SMTP id v8-20020a5d4b08000000b002c3e7d8245cmr13840229wrq.13.1678352487765;
        Thu, 09 Mar 2023 01:01:27 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id n5-20020a5d4c45000000b002c55306f6edsm16760180wrt.54.2023.03.09.01.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:01:27 -0800 (PST)
Message-ID: <95945d3f-40e6-cea8-42b4-c2e34b1d6671@linaro.org>
Date:   Thu, 9 Mar 2023 09:01:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 06/28] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-7-quic_wcheng@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230308235751.495-7-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/03/2023 23:57, Wesley Cheng wrote:
> The QC ADSP is able to support USB playback endpoints, so that the main
> application processor can be placed into lower CPU power modes.  This adds
> the required AFE port configurations and port start command to start an
> audio session.
> 
> Specifically, the QC ADSP can support all potential endpoints that are
> exposed by the audio data interface.  This includes, feedback endpoints
> (both implicit and explicit) as well as the isochronous (data) endpoints.
> The size of audio samples sent per USB frame (microframe) will be adjusted
> based on information received on the feedback endpoint.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>

thanks for the work,


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/qdsp6/q6afe-dai.c         |  50 ++++++
>   sound/soc/qcom/qdsp6/q6afe.c             | 185 ++++++++++++++++++++++-
>   sound/soc/qcom/qdsp6/q6afe.h             |  46 +++++-
>   sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c |  23 +++
>   sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h |   1 +
>   sound/soc/qcom/qdsp6/q6routing.c         |   9 ++
>   6 files changed, 312 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
> index 8bb7452b8f18..bda79d77c8d8 100644
> --- a/sound/soc/qcom/qdsp6/q6afe-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
> @@ -111,6 +111,40 @@ static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
>   	return 0;
>   }
>   
> +static int q6usb_hw_params(struct snd_pcm_substream *substream,
> +			   struct snd_pcm_hw_params *params,
> +			   struct snd_soc_dai *dai)
> +{
> +	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
> +	int channels = params_channels(params);
> +	int rate = params_rate(params);
> +	struct q6afe_usb_cfg *usb = &dai_data->port_config[dai->id].usb_audio;
> +
> +	usb->sample_rate = rate;
> +	usb->num_channels = channels;
> +
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_U16_LE:
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +	case SNDRV_PCM_FORMAT_SPECIAL:
> +		usb->bit_width = 16;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +	case SNDRV_PCM_FORMAT_S24_3LE:
> +		usb->bit_width = 24;
> +		break;
> +	case SNDRV_PCM_FORMAT_S32_LE:
> +		usb->bit_width = 32;
> +		break;
> +	default:
> +		dev_err(dai->dev, "%s: invalid format %d\n",
> +			__func__, params_format(params));
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   static int q6i2s_hw_params(struct snd_pcm_substream *substream,
>   			   struct snd_pcm_hw_params *params,
>   			   struct snd_soc_dai *dai)
> @@ -411,6 +445,10 @@ static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
>   		q6afe_cdc_dma_port_prepare(dai_data->port[dai->id],
>   					   &dai_data->port_config[dai->id].dma_cfg);
>   		break;
> +	case USB_RX:
> +		q6afe_usb_port_prepare(dai_data->port[dai->id],
> +				       &dai_data->port_config[dai->id].usb_audio);
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -637,6 +675,15 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
>   	{"TX_CODEC_DMA_TX_5", NULL, "TX_CODEC_DMA_TX_5 Capture"},
>   	{"RX_CODEC_DMA_RX_6 Playback", NULL, "RX_CODEC_DMA_RX_6"},
>   	{"RX_CODEC_DMA_RX_7 Playback", NULL, "RX_CODEC_DMA_RX_7"},
> +
> +	/* USB playback AFE port receives data for playback, hence use the RX port */
> +	{"USB Playback", NULL, "USB_RX"},
> +};
> +
> +static const struct snd_soc_dai_ops q6usb_ops = {
> +	.prepare	= q6afe_dai_prepare,
> +	.hw_params	= q6usb_hw_params,
> +	.shutdown	= q6afe_dai_shutdown,
>   };
>   
>   static const struct snd_soc_dai_ops q6hdmi_ops = {
> @@ -952,6 +999,8 @@ static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
>   		0, SND_SOC_NOPM, 0, 0),
>   	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_7", "NULL",
>   		0, SND_SOC_NOPM, 0, 0),
> +
> +	SND_SOC_DAPM_AIF_IN("USB_RX", NULL, 0, SND_SOC_NOPM, 0, 0),
>   };
>   
>   static const struct snd_soc_component_driver q6afe_dai_component = {
> @@ -1068,6 +1117,7 @@ static int q6afe_dai_dev_probe(struct platform_device *pdev)
>   	cfg.q6i2s_ops = &q6i2s_ops;
>   	cfg.q6tdm_ops = &q6tdm_ops;
>   	cfg.q6dma_ops = &q6dma_ops;
> +	cfg.q6usb_ops = &q6usb_ops;
>   	dais = q6dsp_audio_ports_set_config(dev, &cfg, &num_dais);
>   
>   	return devm_snd_soc_register_component(dev, &q6afe_dai_component, dais, num_dais);
> diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
> index 919e326b9462..43baf93f9c89 100644
> --- a/sound/soc/qcom/qdsp6/q6afe.c
> +++ b/sound/soc/qcom/qdsp6/q6afe.c
> @@ -34,6 +34,8 @@
>   #define AFE_MODULE_TDM			0x0001028A
>   
>   #define AFE_PARAM_ID_CDC_SLIMBUS_SLAVE_CFG 0x00010235
> +#define AFE_PARAM_ID_USB_AUDIO_DEV_PARAMS    0x000102A5
> +#define AFE_PARAM_ID_USB_AUDIO_DEV_LPCM_FMT 0x000102AA
>   
>   #define AFE_PARAM_ID_LPAIF_CLK_CONFIG	0x00010238
>   #define AFE_PARAM_ID_INT_DIGITAL_CDC_CLK_CONFIG	0x00010239
> @@ -43,6 +45,7 @@
>   #define AFE_PARAM_ID_TDM_CONFIG	0x0001029D
>   #define AFE_PARAM_ID_PORT_SLOT_MAPPING_CONFIG	0x00010297
>   #define AFE_PARAM_ID_CODEC_DMA_CONFIG	0x000102B8
> +#define AFE_PARAM_ID_USB_AUDIO_CONFIG    0x000102A4
>   #define AFE_CMD_REMOTE_LPASS_CORE_HW_VOTE_REQUEST	0x000100f4
>   #define AFE_CMD_RSP_REMOTE_LPASS_CORE_HW_VOTE_REQUEST   0x000100f5
>   #define AFE_CMD_REMOTE_LPASS_CORE_HW_DEVOTE_REQUEST	0x000100f6
> @@ -71,12 +74,16 @@
>   #define AFE_PORT_CONFIG_I2S_WS_SRC_INTERNAL	0x1
>   #define AFE_LINEAR_PCM_DATA				0x0
>   
> +#define AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG 0x1
>   
>   /* Port IDs */
>   #define AFE_API_VERSION_HDMI_CONFIG	0x1
>   #define AFE_PORT_ID_MULTICHAN_HDMI_RX	0x100E
>   #define AFE_PORT_ID_HDMI_OVER_DP_RX	0x6020
>   
> +/* USB AFE port */
> +#define AFE_PORT_ID_USB_RX                       0x7000
> +
>   #define AFE_API_VERSION_SLIMBUS_CONFIG 0x1
>   /* Clock set API version */
>   #define AFE_API_VERSION_CLOCK_SET 1
> @@ -512,12 +519,109 @@ struct afe_param_id_cdc_dma_cfg {
>   	u16	active_channels_mask;
>   } __packed;
>   
> +struct afe_param_id_usb_cfg {
> +/* Minor version used for tracking USB audio device configuration.
> + * Supported values: AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
> + */
> +	u32                  cfg_minor_version;
> +/* Sampling rate of the port.
> + * Supported values:
> + * - AFE_PORT_SAMPLE_RATE_8K
> + * - AFE_PORT_SAMPLE_RATE_11025
> + * - AFE_PORT_SAMPLE_RATE_12K
> + * - AFE_PORT_SAMPLE_RATE_16K
> + * - AFE_PORT_SAMPLE_RATE_22050
> + * - AFE_PORT_SAMPLE_RATE_24K
> + * - AFE_PORT_SAMPLE_RATE_32K
> + * - AFE_PORT_SAMPLE_RATE_44P1K
> + * - AFE_PORT_SAMPLE_RATE_48K
> + * - AFE_PORT_SAMPLE_RATE_96K
> + * - AFE_PORT_SAMPLE_RATE_192K
> + */
> +	u32                  sample_rate;
> +/* Bit width of the sample.
> + * Supported values: 16, 24
> + */
> +	u16                  bit_width;
> +/* Number of channels.
> + * Supported values: 1 and 2
> + */
> +	u16                  num_channels;
> +/* Data format supported by the USB. The supported value is
> + * 0 (#AFE_USB_AUDIO_DATA_FORMAT_LINEAR_PCM).
> + */
> +	u16                  data_format;
> +/* this field must be 0 */
> +	u16                  reserved;
> +/* device token of actual end USB aduio device */
> +	u32                  dev_token;
> +/* endianness of this interface */
> +	u32                   endian;
> +/* service interval */
> +	u32                  service_interval;
> +} __packed;
> +
> +/**
> + * struct afe_param_id_usb_audio_dev_params
> + * @cfg_minor_version: Minor version used for tracking USB audio device
> + * configuration.
> + * Supported values:
> + *     AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
> + * @dev_token: device token of actual end USB aduio device
> + **/
> +struct afe_param_id_usb_audio_dev_params {
> +	u32	cfg_minor_version;
> +	u32	dev_token;
> +} __packed;
> +
> +/**
> + * struct afe_param_id_usb_audio_dev_lpcm_fmt
> + * @cfg_minor_version: Minor version used for tracking USB audio device
> + * configuration.
> + * Supported values:
> + *     AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
> + * @endian: endianness of this interface
> + **/
> +struct afe_param_id_usb_audio_dev_lpcm_fmt {
> +	u32	cfg_minor_version;
> +	u32	endian;
> +} __packed;
> +
> +/**
> + * struct afe_param_id_usb_audio_dev_latency_mode
> + * @cfg_minor_version: Minor version used for tracking USB audio device
> + * configuration.
> + * Supported values:
> + *     AFE_API_MINOR_VERSION_USB_AUDIO_LATENCY_MODE
> + * @mode: latency mode for the USB audio device
> + **/
> +struct afe_param_id_usb_audio_dev_latency_mode {
> +	u32	minor_version;
> +	u32	mode;
> +} __packed;
> +
> +#define AFE_PARAM_ID_USB_AUDIO_SVC_INTERVAL     0x000102B7
> +
> +/**
> + * struct afe_param_id_usb_audio_svc_interval
> + * @cfg_minor_version: Minor version used for tracking USB audio device
> + * configuration.
> + * Supported values:
> + *     AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
> + * @svc_interval: service interval
> + **/
> +struct afe_param_id_usb_audio_svc_interval {
> +	u32	cfg_minor_version;
> +	u32	svc_interval;
> +} __packed;
> +
>   union afe_port_config {
>   	struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
>   	struct afe_param_id_slimbus_cfg           slim_cfg;
>   	struct afe_param_id_i2s_cfg	i2s_cfg;
>   	struct afe_param_id_tdm_cfg	tdm_cfg;
>   	struct afe_param_id_cdc_dma_cfg	dma_cfg;
> +	struct afe_param_id_usb_cfg usb_cfg;
>   } __packed;
>   
>   
> @@ -832,6 +936,7 @@ static struct afe_port_map port_maps[AFE_PORT_MAX] = {
>   				RX_CODEC_DMA_RX_6, 1, 1},
>   	[RX_CODEC_DMA_RX_7] = { AFE_PORT_ID_RX_CODEC_DMA_RX_7,
>   				RX_CODEC_DMA_RX_7, 1, 1},
> +	[USB_RX] = { AFE_PORT_ID_USB_RX, USB_RX, 1, 1},
>   };
>   
>   static void q6afe_port_free(struct kref *ref)
> @@ -1289,6 +1394,81 @@ void q6afe_tdm_port_prepare(struct q6afe_port *port,
>   }
>   EXPORT_SYMBOL_GPL(q6afe_tdm_port_prepare);
>   
> +static int afe_port_send_usb_dev_param(struct q6afe_port *port, struct q6afe_usb_cfg *cfg)
> +{
> +	union afe_port_config *pcfg = &port->port_cfg;
> +	struct afe_param_id_usb_audio_dev_params usb_dev;
> +	struct afe_param_id_usb_audio_dev_lpcm_fmt lpcm_fmt;
> +	struct afe_param_id_usb_audio_svc_interval svc_int;
> +	int ret = 0;
> +
> +	if (!pcfg) {
> +		dev_err(port->afe->dev, "%s: Error, no configuration data\n", __func__);
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	memset(&usb_dev, 0, sizeof(usb_dev));
> +	memset(&lpcm_fmt, 0, sizeof(lpcm_fmt));
> +	memset(&svc_int, 0, sizeof(svc_int));
> +
> +	usb_dev.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
> +	q6afe_port_set_param_v2(port, &usb_dev,
> +				AFE_PARAM_ID_USB_AUDIO_DEV_PARAMS,
> +				AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(usb_dev));
> +	if (ret) {
> +		dev_err(port->afe->dev, "%s: AFE device param cmd failed %d\n",
> +			__func__, ret);
> +		goto exit;
> +	}
> +
> +	lpcm_fmt.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
> +	lpcm_fmt.endian = pcfg->usb_cfg.endian;
> +	ret = q6afe_port_set_param_v2(port, &lpcm_fmt,
> +				      AFE_PARAM_ID_USB_AUDIO_DEV_LPCM_FMT,
> +				      AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(lpcm_fmt));
> +	if (ret) {
> +		dev_err(port->afe->dev, "%s: AFE device param cmd LPCM_FMT failed %d\n",
> +			__func__, ret);
> +		goto exit;
> +	}
> +
> +	svc_int.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
> +	svc_int.svc_interval = pcfg->usb_cfg.service_interval;
> +	ret = q6afe_port_set_param_v2(port, &svc_int,
> +				      AFE_PARAM_ID_USB_AUDIO_SVC_INTERVAL,
> +				      AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(svc_int));
> +	if (ret) {
> +		dev_err(port->afe->dev, "%s: AFE device param cmd svc_interval failed %d\n",
> +			__func__, ret);
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +exit:
> +	return ret;
> +}
> +
> +/**
> + * q6afe_usb_port_prepare() - Prepare usb afe port.
> + *
> + * @port: Instance of afe port
> + * @cfg: USB configuration for the afe port
> + *
> + */
> +void q6afe_usb_port_prepare(struct q6afe_port *port,
> +			     struct q6afe_usb_cfg *cfg)
> +{
> +	union afe_port_config *pcfg = &port->port_cfg;
> +
> +	pcfg->usb_cfg.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
> +	pcfg->usb_cfg.sample_rate = cfg->sample_rate;
> +	pcfg->usb_cfg.num_channels = cfg->num_channels;
> +	pcfg->usb_cfg.bit_width = cfg->bit_width;
> +
> +	afe_port_send_usb_dev_param(port, cfg);
> +}
> +EXPORT_SYMBOL_GPL(q6afe_usb_port_prepare);
> +
>   /**
>    * q6afe_hdmi_port_prepare() - Prepare hdmi afe port.
>    *
> @@ -1611,7 +1791,10 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
>   		break;
>   	case AFE_PORT_ID_WSA_CODEC_DMA_RX_0 ... AFE_PORT_ID_RX_CODEC_DMA_RX_7:
>   		cfg_type = AFE_PARAM_ID_CODEC_DMA_CONFIG;
> -	break;
> +		break;
> +	case AFE_PORT_ID_USB_RX:
> +		cfg_type = AFE_PARAM_ID_USB_AUDIO_CONFIG;
> +		break;
>   	default:
>   		dev_err(dev, "Invalid port id 0x%x\n", port_id);
>   		return ERR_PTR(-EINVAL);
> diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
> index 30fd77e2f458..e098a3e15135 100644
> --- a/sound/soc/qcom/qdsp6/q6afe.h
> +++ b/sound/soc/qcom/qdsp6/q6afe.h
> @@ -5,7 +5,7 @@
>   
>   #include <dt-bindings/sound/qcom,q6afe.h>
>   
> -#define AFE_PORT_MAX		129
> +#define AFE_PORT_MAX		130
>   
>   #define MSM_AFE_PORT_TYPE_RX 0
>   #define MSM_AFE_PORT_TYPE_TX 1
> @@ -205,6 +205,47 @@ struct q6afe_cdc_dma_cfg {
>   	u16	active_channels_mask;
>   };
>   
> +/**
> + * struct q6afe_usb_cfg
> + * @cfg_minor_version: Minor version used for tracking USB audio device
> + * configuration.
> + * Supported values:
> + *     AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
> + * @sample_rate: Sampling rate of the port
> + *    Supported values:
> + *      AFE_PORT_SAMPLE_RATE_8K
> + *      AFE_PORT_SAMPLE_RATE_11025
> + *      AFE_PORT_SAMPLE_RATE_12K
> + *      AFE_PORT_SAMPLE_RATE_16K
> + *      AFE_PORT_SAMPLE_RATE_22050
> + *      AFE_PORT_SAMPLE_RATE_24K
> + *      AFE_PORT_SAMPLE_RATE_32K
> + *      AFE_PORT_SAMPLE_RATE_44P1K
> + *      AFE_PORT_SAMPLE_RATE_48K
> + *      AFE_PORT_SAMPLE_RATE_96K
> + *      AFE_PORT_SAMPLE_RATE_192K
> + * @bit_width: Bit width of the sample.
> + *    Supported values: 16, 24
> + * @num_channels: Number of channels
> + *    Supported values: 1, 2
> + * @data_format: Data format supported by the USB
> + *    Supported values: 0
> + * @reserved: this field must be 0
> + * @dev_token: device token of actual end USB audio device
> + * @endian: endianness of this interface
> + * @service_interval: service interval
> + **/
> +struct q6afe_usb_cfg {
> +	u32	cfg_minor_version;
> +	u32     sample_rate;
> +	u16	bit_width;
> +	u16	num_channels;
> +	u16	data_format;
> +	u16	reserved;
> +	u32	dev_token;
> +	u32	endian;
> +	u32	service_interval;
> +};
>   
>   struct q6afe_port_config {
>   	struct q6afe_hdmi_cfg hdmi;
> @@ -212,6 +253,7 @@ struct q6afe_port_config {
>   	struct q6afe_i2s_cfg i2s_cfg;
>   	struct q6afe_tdm_cfg tdm;
>   	struct q6afe_cdc_dma_cfg dma_cfg;
> +	struct q6afe_usb_cfg usb_audio;
>   };
>   
>   struct q6afe_port;
> @@ -221,6 +263,8 @@ int q6afe_port_start(struct q6afe_port *port);
>   int q6afe_port_stop(struct q6afe_port *port);
>   void q6afe_port_put(struct q6afe_port *port);
>   int q6afe_get_port_id(int index);
> +void q6afe_usb_port_prepare(struct q6afe_port *port,
> +			     struct q6afe_usb_cfg *cfg);
>   void q6afe_hdmi_port_prepare(struct q6afe_port *port,
>   			    struct q6afe_hdmi_cfg *cfg);
>   void q6afe_slim_port_prepare(struct q6afe_port *port,
> diff --git a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
> index f67c16fd90b9..39719c3f1767 100644
> --- a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
> +++ b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
> @@ -81,6 +81,26 @@
>   
>   
>   static struct snd_soc_dai_driver q6dsp_audio_fe_dais[] = {
> +	{
> +		.playback = {
> +			.stream_name = "USB Playback",
> +			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
> +					SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |
> +					SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
> +					SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
> +					SNDRV_PCM_RATE_192000,
> +			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
> +					SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |
> +					SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |
> +					SNDRV_PCM_FMTBIT_U24_LE | SNDRV_PCM_FMTBIT_U24_BE,
> +			.channels_min = 1,
> +			.channels_max = 2,
> +			.rate_min =	8000,
> +			.rate_max = 192000,
> +		},
> +		.id = USB_RX,
> +		.name = "USB_RX",
> +	},
>   	{
>   		.playback = {
>   			.stream_name = "HDMI Playback",
> @@ -616,6 +636,9 @@ struct snd_soc_dai_driver *q6dsp_audio_ports_set_config(struct device *dev,
>   		case WSA_CODEC_DMA_RX_0 ... RX_CODEC_DMA_RX_7:
>   			q6dsp_audio_fe_dais[i].ops = cfg->q6dma_ops;
>   			break;
> +		case USB_RX:
> +			q6dsp_audio_fe_dais[i].ops = cfg->q6usb_ops;
> +			break;
>   		default:
>   			break;
>   		}
> diff --git a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h
> index 7f052c8a1257..d8dde6dd0aca 100644
> --- a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h
> +++ b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h
> @@ -11,6 +11,7 @@ struct q6dsp_audio_port_dai_driver_config {
>   	const struct snd_soc_dai_ops *q6i2s_ops;
>   	const struct snd_soc_dai_ops *q6tdm_ops;
>   	const struct snd_soc_dai_ops *q6dma_ops;
> +	const struct snd_soc_dai_ops *q6usb_ops;
>   };
>   
>   struct snd_soc_dai_driver *q6dsp_audio_ports_set_config(struct device *dev,
> diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
> index 928fd23e2c27..dc2357b4b2c7 100644
> --- a/sound/soc/qcom/qdsp6/q6routing.c
> +++ b/sound/soc/qcom/qdsp6/q6routing.c
> @@ -514,6 +514,9 @@ static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
>   	return 1;
>   }
>   
> +static const struct snd_kcontrol_new usb_mixer_controls[] = {
> +	Q6ROUTING_RX_MIXERS(USB_RX) };
> +
>   static const struct snd_kcontrol_new hdmi_mixer_controls[] = {
>   	Q6ROUTING_RX_MIXERS(HDMI_RX) };
>   
> @@ -949,6 +952,10 @@ static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
>   	SND_SOC_DAPM_MIXER("MultiMedia8 Mixer", SND_SOC_NOPM, 0, 0,
>   		mmul8_mixer_controls, ARRAY_SIZE(mmul8_mixer_controls)),
>   
> +	SND_SOC_DAPM_MIXER("USB Mixer", SND_SOC_NOPM, 0, 0,
> +			   usb_mixer_controls,
> +			   ARRAY_SIZE(usb_mixer_controls)),
> +
>   };
>   
>   static const struct snd_soc_dapm_route intercon[] = {
> @@ -1042,6 +1049,8 @@ static const struct snd_soc_dapm_route intercon[] = {
>   	{"MM_UL6", NULL, "MultiMedia6 Mixer"},
>   	{"MM_UL7", NULL, "MultiMedia7 Mixer"},
>   	{"MM_UL8", NULL, "MultiMedia8 Mixer"},
> +
> +	Q6ROUTING_RX_DAPM_ROUTE("USB Mixer", "USB_RX"),
>   };
>   
>   static int routing_hw_params(struct snd_soc_component *component,
