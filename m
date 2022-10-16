Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640BD60008B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJPPSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJPPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:18:13 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D26C32B9A
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:18:11 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f8so5362620qkg.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E53ndnV51QAjoubS4iT9rmGIvXA5Wu6s6C5IJhMbkLk=;
        b=eJ2Ta5+dG6VgY1DKFb4f7axNtN/BPGU9nfqIfcjFCDUcVdx2CtBcGCaTpLVctTrt0F
         X3ZrHcoEdHSKHHDHphbo+haR2GCs+RPkdOGZ1H/CbdTHkfCSW+vLlActaSpaa7Pjn0f5
         FiN6AWLATymRtZM9rWRDcsSsyWWYP83UmP0qN8kx7zkA5UPiUw9e5h/KKERb7hdsAfvD
         lxbZ7QB5H1Ww9Z0SH+V+5L2HF48MI97JhhfTgx42mygmkYGl1lUAfdR9eL2tOwFRK2qv
         XQNwuustWWOKtkQA0zCQrHi1Zoo6gy2N2qMocrxIP0M/RBwPGXbZJ/+cH6fnKJ+q53Sx
         7Vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E53ndnV51QAjoubS4iT9rmGIvXA5Wu6s6C5IJhMbkLk=;
        b=zmYrOFQvi5MvvzH/cGxLSh/PqfWVaf7mjf0vfijbT80bNyLojm5Er4W6UwUle4pHwa
         HYBWnPPdIK7DLU4hoT/IJfYtHbsYHL+irT9iF0FVhKp1v7JgTxJ4fYMD1Ch0th7lU22t
         fuktLmGYaOCSzkwXYjg8dbfAIpdV24H/nsL4KnUbnVgLZlt6eezpjnkhma/tZUWImSXE
         OM35XUumOGojbVCur3eJQ+FElotiCGP2d1QcGADep1J05Zreab9sMhoTyuXAdoAD5m2v
         Isn0o5mH9eBsDlCvIlcxwoN2yxo5SbhW3WA1rjRyI8SEGIGbzMm/2ZcdyLb53Y3JF1fZ
         ZWJQ==
X-Gm-Message-State: ACrzQf2NOX9vt3Fdzg6UNL8aV8byzxF13oPn0KKMOu2rKVLE/YWxVJgE
        1s80QeKDPHY2K9x9Ifsj8ygAdA==
X-Google-Smtp-Source: AMsMyM4PI+AlyxPZvkBHoKuW0L3zjM+eT6Mru5rikldE09zyd+2kjVdFHSqLUhfY5ObF+C9nwCxSew==
X-Received: by 2002:a05:620a:e:b0:6ee:86e5:66f8 with SMTP id j14-20020a05620a000e00b006ee86e566f8mr4852266qki.163.1665933490686;
        Sun, 16 Oct 2022 08:18:10 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9b13:d679:7b5b:6921? ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id l5-20020ac80785000000b003996aa171b9sm5767987qth.97.2022.10.16.08.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 08:18:09 -0700 (PDT)
Message-ID: <60620ca9-80cd-9b13-800b-130a3f75442a@linaro.org>
Date:   Sun, 16 Oct 2022 11:18:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 4/6] ASoC: samsung: fsd: Add FSD soundcard driver
Content-Language: en-US
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
 <CGME20221014104904epcas5p4f458182cc9ac9c223d9a25566f3dd300@epcas5p4.samsung.com>
 <20221014102151.108539-5-p.rajanbabu@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014102151.108539-5-p.rajanbabu@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 06:21, Padmanabhan Rajanbabu wrote:
> Add a soundcard driver for FSD audio interface to bridge the
> CPU DAI of samsung I2S with the codec and platform driver.
> 

Thank you for your patch. There is something to discuss/improve.

> +
> +#define FSD_PREFIX		"tesla,"
> +#define FSD_DAI_SRC_PCLK	3
> +#define FSD_DAI_RFS_192		192
> +#define FSD_DAI_BFS_48		48
> +#define FSD_DAI_BFS_96		96
> +#define FSD_DAI_BFS_192		192
> +
> +struct fsd_card_priv {
> +	struct snd_soc_card card;
> +	struct snd_soc_dai_link *dai_link;
> +	u32 tdm_slots;
> +	u32 tdm_slot_width;
> +};
> +
> +static unsigned int fsd_card_get_rfs(unsigned int rate)
> +{
> +	return FSD_DAI_RFS_192;

This wrapper is a bit silly...

> +}
> +
> +static unsigned int fsd_card_get_bfs(unsigned int channels)
> +{
> +	switch (channels) {
> +	case 1:
> +	case 2:
> +		return FSD_DAI_BFS_48;
> +	case 3:
> +	case 4:
> +		return FSD_DAI_BFS_96;
> +	case 5:
> +	case 6:
> +	case 7:
> +	case 8:
> +		return FSD_DAI_BFS_192;
> +	default:
> +		return FSD_DAI_BFS_48;
> +	}
> +}
> +
> +static unsigned int fsd_card_get_psr(unsigned int rate)
> +{
> +	switch (rate) {
> +	case 8000:	return 43;
> +	case 11025:	return 31;
> +	case 16000:	return 21;
> +	case 22050:	return 16;
> +	case 32000:	return 11;
> +	case 44100:	return 8;
> +	case 48000:	return 7;
> +	case 64000:	return 5;
> +	case 88200:	return 4;
> +	case 96000:	return 4;
> +	case 192000:	return 2;
> +	default:	return 1;
> +	}
> +}
> +
> +static int fsd_card_hw_params(struct snd_pcm_substream *substream,
> +					struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd	= substream->private_data;
> +	struct snd_soc_card *card	= rtd->card;
> +	struct snd_soc_dai *cpu_dai	= asoc_rtd_to_cpu(rtd, 0);
> +	struct snd_soc_dai_link *link	= rtd->dai_link;
> +	struct fsd_card_priv *priv	= snd_soc_card_get_drvdata(card);
> +	unsigned int rfs, bfs, psr;
> +	int ret = 0, cdclk_dir;
> +
> +	rfs = fsd_card_get_rfs(params_rate(params));
> +	bfs = fsd_card_get_bfs(params_channels(params));
> +	psr = fsd_card_get_psr(params_rate(params));
> +
> +	/* Configure the Root Clock Source */
> +	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_OPCLK,
> +					false, FSD_DAI_SRC_PCLK);
> +	if (ret < 0) {
> +		dev_err(card->dev, "Failed to set OPCLK: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_RCLKSRC_0,
> +					false, false);
> +	if (ret < 0) {
> +		dev_err(card->dev, "Failed to set RCLKSRC: %d\n", ret);

Don't you need to cleanup on error paths?

> +		goto err;
> +	}
> +
> +	/* Set CPU DAI configuration */
> +	ret = snd_soc_dai_set_fmt(cpu_dai, link->dai_fmt);
> +	if (ret < 0) {
> +		dev_err(card->dev, "Failed to set DAIFMT: %d\n", ret);
> +		goto err;
> +	}
> +
> +	if (link->dai_fmt & SND_SOC_DAIFMT_CBC_CFC) {
> +		cdclk_dir = SND_SOC_CLOCK_OUT;
> +	} else if (link->dai_fmt & SND_SOC_DAIFMT_CBP_CFP) {
> +		cdclk_dir = SND_SOC_CLOCK_IN;
> +	} else {
> +		dev_err(card->dev, "Missing Clock Master information\n");
> +		goto err;
> +	}
> +
> +	/* Set Clock Source for CDCLK */
> +	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_CDCLK,
> +					rfs, cdclk_dir);
> +	if (ret < 0) {
> +		dev_err(card->dev, "Failed to set CDCLK: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, SAMSUNG_I2S_DIV_RCLK, psr);
> +	if (ret < 0) {
> +		dev_err(card->dev, "Failed to set PSR: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, SAMSUNG_I2S_DIV_BCLK, bfs);
> +	if (ret < 0) {
> +		dev_err(card->dev, "Failed to set BCLK: %d\n", ret);
> +		goto err;
> +	}
> +
> +	if (priv->tdm_slots) {
> +		ret = snd_soc_dai_set_tdm_slot(cpu_dai, false, false,
> +				priv->tdm_slots, priv->tdm_slot_width);
> +		if (ret < 0) {
> +			dev_err(card->dev,
> +				"Failed to configure in TDM mode:%d\n", ret);
> +			goto err;
> +		}
> +	}
> +
> +err:
> +	return ret;
> +}
> +
> +static const struct snd_soc_ops fsd_card_ops = {
> +	.hw_params	= fsd_card_hw_params,
> +};
> +
> +static struct fsd_card_priv *fsd_card_parse_of(struct snd_soc_card *card)
> +{
> +	struct fsd_card_priv *priv;
> +	struct snd_soc_dai_link *link;
> +	struct device *dev = card->dev;
> +	struct device_node *node = dev->of_node;
> +	struct device_node *np, *cpu_node, *codec_node;
> +	struct snd_soc_dai_link_component *dlc;
> +	int ret, id = 0, num_links;
> +
> +	ret = snd_soc_of_parse_card_name(card, "model");
> +	if (ret) {
> +		dev_err(dev, "Error parsing card name: %d\n", ret);
> +		return ERR_PTR(ret);

return dev_err_probe

> +	}
> +
> +	if (of_property_read_bool(dev->of_node, "widgets")) {
> +		ret = snd_soc_of_parse_audio_simple_widgets(card, "widgets");
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	/* Add DAPM routes to the card */
> +	if (of_property_read_bool(node, "audio-routing")) {
> +		ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	num_links = of_get_child_count(node);
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return ERR_PTR(-ENOMEM);
> +
> +	priv->dai_link = devm_kzalloc(dev, num_links * sizeof(*priv->dai_link),
> +								GFP_KERNEL);
> +	if (!priv->dai_link)
> +		return ERR_PTR(-ENOMEM);
> +
> +	priv->tdm_slots = 0;
> +	priv->tdm_slot_width = 0;
> +
> +	snd_soc_of_parse_tdm_slot(node, NULL, NULL, &priv->tdm_slots,
> +			&priv->tdm_slot_width);
> +
> +	link = priv->dai_link;
> +
> +	for_each_child_of_node(node, np) {
> +		dlc = devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
> +		if (!dlc)
> +			return ERR_PTR(-ENOMEM);
> +
> +		link->id		= id;
> +		link->cpus		= &dlc[0];
> +		link->platforms		= &dlc[1];
> +		link->num_cpus		= 1;
> +		link->num_codecs	= 1;
> +		link->num_platforms	= 1;
> +
> +		cpu_node = of_get_child_by_name(np, "cpu");
> +		if (!cpu_node) {
> +			dev_err(dev, "Missing CPU/Codec node\n");
> +			ret = -EINVAL;
> +			goto err_cpu_node;
> +		}
> +
> +		ret = snd_soc_of_get_dai_link_cpus(dev, cpu_node, link);
> +		if (ret < 0) {
> +			dev_err(dev, "Error Parsing CPU DAI name\n");
> +			goto err_cpu_name;
> +		}
> +
> +		link->platforms->of_node = link->cpus->of_node;
> +
> +		codec_node = of_get_child_by_name(np, "codec");
> +		if (codec_node) {
> +			ret = snd_soc_of_get_dai_link_codecs(dev, codec_node,
> +					link);
> +			if (ret < 0) {
> +				dev_err(dev, "Error Parsing Codec DAI name\n");
> +				goto err_codec_name;
> +			}
> +		} else {
> +			dlc = devm_kzalloc(dev, sizeof(*dlc), GFP_KERNEL);
> +			if (!dlc) {
> +				ret = -ENOMEM;
> +				goto err_cpu_name;
> +			}
> +
> +			link->codecs = dlc;
> +
> +			link->codecs->dai_name = "snd-soc-dummy-dai";
> +			link->codecs->name = "snd-soc-dummy";
> +			link->dynamic = 1;
> +
> +			snd_soc_dai_link_set_capabilities(link);
> +			link->ignore_suspend = 1;
> +			link->nonatomic = 1;
> +		}
> +
> +		ret = asoc_simple_parse_daifmt(dev, np, codec_node,
> +					FSD_PREFIX, &link->dai_fmt);
> +		if (ret)
> +			link->dai_fmt = SND_SOC_DAIFMT_NB_NF |
> +					SND_SOC_DAIFMT_CBC_CFC |
> +					SND_SOC_DAIFMT_I2S;
> +
> +		ret = of_property_read_string(np, "link-name", &link->name);
> +		if (ret) {
> +			dev_err(card->dev, "Error Parsing link name\n");
> +			goto err_codec_name;
> +		}
> +
> +		link->stream_name = link->name;
> +		link->ops = &fsd_card_ops;
> +
> +		link++;
> +		id++;
> +
> +		of_node_put(cpu_node);
> +		of_node_put(codec_node);
> +	}
> +
> +	card->dai_link = priv->dai_link;
> +	card->num_links = num_links;
> +
> +	return priv;
> +
> +err_codec_name:
> +	of_node_put(codec_node);
> +err_cpu_name:
> +	of_node_put(cpu_node);
> +err_cpu_node:
> +	of_node_put(np);
> +	return ERR_PTR(ret);
> +}
> +
> +static int fsd_platform_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct snd_soc_card *card;
> +	struct fsd_card_priv *fsd_priv;
> +
> +	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
> +	if (!card)
> +		return -ENOMEM;
> +
> +	card->dev	= dev;
> +	fsd_priv	= fsd_card_parse_of(card);

Drop the indentation before =

> +
> +	if (IS_ERR(fsd_priv)) {
> +		dev_err(&pdev->dev, "Error Parsing DAI Link: %ld\n",
> +				PTR_ERR(fsd_priv));
> +		return PTR_ERR(fsd_priv);

return dev_err_probe

> +	}
> +
> +	snd_soc_card_set_drvdata(card, fsd_priv);
> +
> +	return devm_snd_soc_register_card(&pdev->dev, card);
> +}
> +
> +static const struct of_device_id fsd_device_id[] = {
> +	{ .compatible = "tesla,fsd-card" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, fsd_device_id);
> +
> +static struct platform_driver fsd_platform_driver = {
> +	.driver = {
> +		.name = "fsd-card",
> +		.of_match_table = of_match_ptr(fsd_device_id),

of_match_ptr comes with maybe_unused. Or drop it.



Best regards,
Krzysztof

