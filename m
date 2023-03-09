Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00896B1F3E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCIJDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjCIJDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:03:13 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A3939B8D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:01:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id g3so1107734wri.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678352495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vELRAq25+56OqYFu5QrkRzq4t5TUmrcmfHa015da/Us=;
        b=Dn0xsTfG9Q4JVbrcYXHM4cUu1A/1UbZ/eGbHcIZNqhgMaTKndCcZagEKfAeAFhmZhp
         4D8UFW3eMIyqhQj7Oz7Sbz742aRsdhs688FEu7OgVJBzOKl3CIfIvd0qNgSIVL+z9BC1
         30KHJnHTBIn27yv3CzeVQ/M8EPsGAsFt5Zxnt5CKwoZkTkXlVCzBAduk95dT2rV+WgSH
         WmI1et+uHch7sc+pB2DpZ0lrQIqaAjtg1iU2rzJUhcj1hyehIa3sy5IMbBx6xTeN+v6h
         4gJDETEq6Y4LOFRtgLqgu6xGYQYZO4igfHn16OYhxU55F3rRMmpsL/IOdvDDJyCge29y
         EcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678352495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vELRAq25+56OqYFu5QrkRzq4t5TUmrcmfHa015da/Us=;
        b=6/gDzAD+ljyQyx4IX9T/JO/gm8JrM86oUcEVqo+SfDmiXDUequL3XribHmHqYhzJLH
         zMBJ5l4m7mPN10tQ9tBvKT6ZzYFpWK5qu033BQG6sozyFCST8Odopg/xbxmO3DpmtSf+
         y6oyG8xMNE5+Ke/xWMRrq9UeQlxpdCRfIqdRad4rRaVmR+swQBG+IjQAHuiMfRMHBiFI
         mITwMR6iloDpIg3jygkw4uRaGlBmnuGzeDXo2w8YtkeEiQVvQlyMKDBgBrG05yktnCp6
         Uac3vVmUlcU4mbBaB7yJ2KwrW59hIyEiypIp6r46aOGxvdkWw+PlW9Gf9oNOHIEBTV8A
         L/8Q==
X-Gm-Message-State: AO0yUKWgYindHOZ/4vtXFpDDBt/tgYTIJOV/VQ7/R6n24DC452KQqGpt
        Dkonssa1BljtR2OFEzTYjsA2HA==
X-Google-Smtp-Source: AK7set9s4BKpxnIOJWRrdkdcmFetHBNdDiWumTZkNpMQ06RigfLiB4bFP2+2WD7On8Z0xP4Vr3M9KQ==
X-Received: by 2002:a05:6000:1ce:b0:2c7:e909:5fcf with SMTP id t14-20020a05600001ce00b002c7e9095fcfmr13887278wrx.3.1678352494892;
        Thu, 09 Mar 2023 01:01:34 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id f2-20020a5d58e2000000b002c56af32e8csm17409633wrd.35.2023.03.09.01.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:01:34 -0800 (PST)
Message-ID: <ad7dd26d-0ee6-675f-72a5-a93bb0240121@linaro.org>
Date:   Thu, 9 Mar 2023 09:01:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 08/28] ASoC: qcom: Add USB backend ASoC driver for Q6
Content-Language: en-US
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
 <20230308235751.495-9-quic_wcheng@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230308235751.495-9-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/03/2023 23:57, Wesley Cheng wrote:
> Create a USB BE component that will register a new USB port to the ASoC USB
> framework.  This will handle determination on if the requested audio
> profile is supported by the USB device currently selected.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>

Thanks Wesley for the patch, I have few minor comments.

> ---
>   include/sound/q6usboffload.h  |  20 ++++
>   sound/soc/qcom/Kconfig        |   4 +
>   sound/soc/qcom/qdsp6/Makefile |   1 +
>   sound/soc/qcom/qdsp6/q6usb.c  | 208 ++++++++++++++++++++++++++++++++++
>   4 files changed, 233 insertions(+)
>   create mode 100644 include/sound/q6usboffload.h
>   create mode 100644 sound/soc/qcom/qdsp6/q6usb.c
> 
> diff --git a/include/sound/q6usboffload.h b/include/sound/q6usboffload.h
> new file mode 100644
> index 000000000000..4fb1912d9f55
> --- /dev/null
> +++ b/include/sound/q6usboffload.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * linux/sound/q6usboffload.h -- QDSP6 USB offload
> + *
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/**
> + * struct q6usb_offload
> + * @dev - dev handle to usb be
> + * @sid - streamID for iommu
> + * @intr_num - usb interrupter number
> + * @domain - allocated iommu domain
> + **/
> +struct q6usb_offload {
> +	struct device *dev;
> +	long long sid;
> +	u32 intr_num;
> +	struct iommu_domain *domain;
Why do we need to store this domain, You can remove this along with the 
one line that gets domain in probe function.

> +};
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index e7b00d1d9e99..bb285af6bb04 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -114,6 +114,9 @@ config SND_SOC_QDSP6_APM
>   config SND_SOC_QDSP6_PRM_LPASS_CLOCKS
>   	tristate
>   
> +config SND_SOC_QDSP6_USB
> +	tristate
> +
>   config SND_SOC_QDSP6_PRM
>   	tristate
>   	select SND_SOC_QDSP6_PRM_LPASS_CLOCKS
> @@ -134,6 +137,7 @@ config SND_SOC_QDSP6
>   	select SND_SOC_TOPOLOGY
>   	select SND_SOC_QDSP6_APM
>   	select SND_SOC_QDSP6_PRM
> +	select SND_SOC_QDSP6_USB
>   	help
>   	 To add support for MSM QDSP6 Soc Audio.
>   	 This will enable sound soc platform specific
> diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
> index 3963bf234664..c9457ee898d0 100644
> --- a/sound/soc/qcom/qdsp6/Makefile
> +++ b/sound/soc/qcom/qdsp6/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_SND_SOC_QDSP6_APM_DAI) += q6apm-dai.o
>   obj-$(CONFIG_SND_SOC_QDSP6_APM_LPASS_DAI) += q6apm-lpass-dais.o
>   obj-$(CONFIG_SND_SOC_QDSP6_PRM) += q6prm.o
>   obj-$(CONFIG_SND_SOC_QDSP6_PRM_LPASS_CLOCKS) += q6prm-clocks.o
> +obj-$(CONFIG_SND_SOC_QDSP6_USB) += q6usb.o
> diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
> new file mode 100644
> index 000000000000..3d480550b3f3
> --- /dev/null
> +++ b/sound/soc/qcom/qdsp6/q6usb.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/iommu.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma-map-ops.h>

you would not need these 3 includes aswell.

> +
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/soc-usb.h>
> +#include <sound/pcm_params.h>
> +#include <sound/asound.h>
> +#include <sound/q6usboffload.h>
> +
> +#include "q6dsp-lpass-ports.h"
> +#include "q6afe.h"
> +
> +#define SID_MASK	0xF
> +
> +struct q6usb_port_data {
> +	struct q6afe_usb_cfg usb_cfg;
> +	struct snd_soc_usb *usb;
> +	struct q6usb_offload priv;
> +	int active_idx;
> +};
> +
> +static const struct snd_soc_dapm_widget q6usb_dai_widgets[] = {
> +	SND_SOC_DAPM_HP("USB_RX_BE", NULL),
> +};
> +
> +static const struct snd_soc_dapm_route q6usb_dapm_routes[] = {
> +	{"USB Playback", NULL, "USB_RX_BE"},
> +};
> +
> +static int q6usb_hw_params(struct snd_pcm_substream *substream,
> +			   struct snd_pcm_hw_params *params,
> +			   struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}
> +static const struct snd_soc_dai_ops q6usb_ops = {
> +	.hw_params = q6usb_hw_params,
> +};
> +
> +static struct snd_soc_dai_driver q6usb_be_dais[] = {
> +	{
> +		.playback = {
> +			.stream_name = "USB BE RX",
> +			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
> +				SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |
> +				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
> +				SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
> +				SNDRV_PCM_RATE_192000,
> +			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
> +				SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |
> +				SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |
> +				SNDRV_PCM_FMTBIT_U24_LE | SNDRV_PCM_FMTBIT_U24_BE,
> +			.channels_min = 1,
> +			.channels_max = 2,
> +			.rate_max =     192000,
> +			.rate_min =	8000,
> +		},
> +		.id = USB_RX,
> +		.name = "USB_RX_BE",
> +		.ops = &q6usb_ops,
> +	},
> +};
> +
> +static int q6usb_audio_ports_of_xlate_dai_name(struct snd_soc_component *component,
> +					const struct of_phandle_args *args,
> +					const char **dai_name)
> +{
> +	int id = args->args[0];
> +	int ret = -EINVAL;
> +	int i;
> +
> +	for (i = 0; i  < ARRAY_SIZE(q6usb_be_dais); i++) {
> +		if (q6usb_be_dais[i].id == id) {
> +			*dai_name = q6usb_be_dais[i].name;
> +			ret = 0;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
> +			int connected)
> +{
> +	struct snd_soc_dapm_context *dapm;
> +	struct q6usb_port_data *data;
> +
> +	dapm = snd_soc_component_get_dapm(usb->component);
> +	data = dev_get_drvdata(usb->component->dev);
> +
> +	if (connected) {
> +		snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
> +		/* We only track the latest USB headset plugged in */
> +		data->active_idx = card_idx;
> +	} else {
> +		snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
> +	}
> +	snd_soc_dapm_sync(dapm);
> +
> +	return 0;
> +}
> +
> +static int q6usb_component_probe(struct snd_soc_component *component)
> +{
> +	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
> +	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
> +
> +	snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
> +	snd_soc_dapm_sync(dapm);
> +
> +	data->usb = snd_soc_usb_add_port(component->dev, &data->priv, q6usb_alsa_connection_cb);
> +	if (IS_ERR(data->usb)) {
> +		dev_err(component->dev, "failed to add usb port\n");
> +		return -ENODEV;
> +	}
> +
> +	data->usb->component = component;
> +
> +	return 0;
> +}
> +


snd_soc_usb_remove_port should be part of component remove rather than 
platform device remove.

static void q6usb_component_remove(struct snd_soc_component *component)
{
	snd_soc_usb_remove_port(component->dev);
}

and delete q6usb_dai_dev_remove()

> +static const struct snd_soc_component_driver q6usb_dai_component = {
> +	.probe = q6usb_component_probe,
> +	.name = "q6usb-dai-component",
> +	.dapm_widgets = q6usb_dai_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(q6usb_dai_widgets),
> +	.dapm_routes = q6usb_dapm_routes,
> +	.num_dapm_routes = ARRAY_SIZE(q6usb_dapm_routes),
> +	.of_xlate_dai_name = q6usb_audio_ports_of_xlate_dai_name,
> +};
> +
> +static int q6usb_dai_dev_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct q6usb_port_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct of_phandle_args args;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u32(node, "qcom,usb-audio-intr-num",
> +				&data->priv.intr_num);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to read intr num.\n");
> +		return ret;
> +	}
> +
> +	ret = of_parse_phandle_with_fixed_args(node, "iommus", 1, 0, &args);
> +	if (ret < 0)
> +		data->priv.sid = -1;
> +	else
> +		data->priv.sid = args.args[0] & SID_MASK;
> +
> +	data->priv.domain = iommu_get_domain_for_dev(&pdev->dev);
> +
> +	data->priv.dev = dev;
> +	dev_set_drvdata(dev, data);
> +
> +	ret = devm_snd_soc_register_component(dev, &q6usb_dai_component,
> +					q6usb_be_dais, ARRAY_SIZE(q6usb_be_dais));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int q6usb_dai_dev_remove(struct platform_device *pdev)
> +{
> +	snd_soc_usb_remove_port(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id q6usb_dai_device_id[] = {
> +	{ .compatible = "qcom,q6usb-dais" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, q6usb_dai_device_id);
> +
> +static struct platform_driver q6usb_dai_platform_driver = {
> +	.driver = {
> +		.name = "q6usb-dai",
> +		.of_match_table = of_match_ptr(q6usb_dai_device_id),
> +	},
> +	.probe = q6usb_dai_dev_probe,
> +	.remove = q6usb_dai_dev_remove,
> +};
> +module_platform_driver(q6usb_dai_platform_driver);
> +
> +MODULE_DESCRIPTION("Q6 USB backend dai driver");
> +MODULE_LICENSE("GPL");
