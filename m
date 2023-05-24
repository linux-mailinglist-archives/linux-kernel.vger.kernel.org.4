Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BB770FAC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbjEXPvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjEXPvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:51:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAE993
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:51:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6042d60b5so12700465e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684943509; x=1687535509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8geeXEOb1JFpSL51yP1LqtEfxAQbaVotjCJur5zhD4=;
        b=r9Xqu5ND0Bk5xdzrVcEKYQlFpEEChNge6LbIG0g17WQIR6Y6FlFTjj1VLIptKxk12Q
         yq45EGDPQw9rNHr+jipV1YSj4asgJuaRjeVL0NZhwSDk/F7WDrzxEpDXrSSJyrZb0/M3
         zBXKIn/cV0bBTAFnJDnUkCCcwvue3vKTmsqLCYu0uVu4CEJS93Dy/yQ+lZNpqtjw/llJ
         /i6QJwMZfnhn0BXjS9g7SEYSgcIwM6tYnNKca4sWH8rz2seGcHobfGaMYO1qrYroAdGx
         05BznJ1hGxFw4jfQNNWBm56IewOjSboZXbEWkM4NBUXJGppz8/FOt58lkiEa84eE4ux7
         4f7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684943509; x=1687535509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8geeXEOb1JFpSL51yP1LqtEfxAQbaVotjCJur5zhD4=;
        b=kKjF7iuuZ0ReCAupDCrm1x/9QcfGutrfAgN0afuHZQ6SUFNAks/fi3eU5g0D2yafK3
         x4X16k7AzHZ1tJtjzpK5BknX/qnEgrYFYTkiWxqQYjVnUBdqfIdx7GjsydKo6w/ks5jH
         IV8CfzBUBblKYzPMW+TlyBqCRVwhHmLU/q1kPTtcjOozC7DiYWVFhC41fKLxkggq91j7
         GbaoIVdchJpCtWAPCmT1k/ZetPH5fKGbH6bQE4NRX58eAov0mrJ1hxyio/QtCF6FSubL
         QW9/1GC/6Z+0/K7/nXXrZXZVqqyhyUQ19cirEvPk2ZAbRANA06+KAxC8LNC1DmrOwuk0
         3pjA==
X-Gm-Message-State: AC+VfDyNb33RUdZkuy8KQRHYEJtZgEH1yZQADZUckdkqxK1seqORIa1H
        N+6IBCgFeT7TvZxpaUxDeEkFiw==
X-Google-Smtp-Source: ACHHUZ5sgxsCI/lVRvjZNq+J7kPDx+SvOmaq/8wjAiMQ785YfC+h5iFAEtyNc1gq4Kqqj6aQ7yTjgQ==
X-Received: by 2002:a7b:cb91:0:b0:3f6:45d:28a1 with SMTP id m17-20020a7bcb91000000b003f6045d28a1mr219488wmi.14.1684943508981;
        Wed, 24 May 2023 08:51:48 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id z26-20020a05600c221a00b003f60101074dsm2721773wml.33.2023.05.24.08.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 08:51:48 -0700 (PDT)
Message-ID: <dcd5050b-8459-e7cc-b5ad-eb435aba6e84@baylibre.com>
Date:   Wed, 24 May 2023 17:51:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 6/7] ASoC: mediatek: mt8188-mt6359: support new board
 with nau88255
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230523021933.3422-1-trevor.wu@mediatek.com>
 <20230523021933.3422-7-trevor.wu@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230523021933.3422-7-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2023 04:19, Trevor Wu wrote:
>   	card_data = (struct mt8188_card_data *)of_device_get_match_data(&pdev->dev);
> @@ -776,9 +1066,38 @@ static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
>   				dai_link->init = mt8188_mt6359_init;
>   				init_mt6359 = true;
>   			}
> +		} else if (strcmp(dai_link->name, "ETDM1_OUT_BE") == 0 ||
> +			   strcmp(dai_link->name, "ETDM2_OUT_BE") == 0 ||
> +			   strcmp(dai_link->name, "ETDM1_IN_BE") == 0 ||
> +			   strcmp(dai_link->name, "ETDM2_IN_BE") == 0) {
> +			if (!strcmp(dai_link->codecs->dai_name, MAX98390_CODEC_DAI)) {
> +				dai_link->ops = &mt8188_max98390_ops;
> +				if (init_max98390)
> +					continue;

I prefer that you do like your patch [PATCH v2 1/7] to be consistent
and easy to read.

+			if (!init_mt6359) {
+				dai_link->init = mt8188_mt6359_init;
+				init_mt6359 = true;
+			}

> +
> +				dai_link->init = mt8188_max98390_codec_init;
> +				init_max98390 = true;
> +			} else if (!strcmp(dai_link->codecs->dai_name, NAU8825_CODEC_DAI)) {
> +				dai_link->ops = &mt8188_nau8825_ops;
> +				if (init_nau8825)
> +					continue;

ditto

> +
> +				dai_link->init = mt8188_nau8825_codec_init;
> +				dai_link->exit = mt8188_nau8825_codec_exit;
> +				init_nau8825 = true;
> +			} else {
> +				if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai")) {

Shouldn't be with a NOT operator ("!") ?
+ if (!strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai")) {


> +					if (init_dumb)
> +						continue;

ditto

> +
> +					dai_link->init = mt8188_dumb_amp_init;
> +					init_dumb = true;
> +				}
> +			}
>   		}
>   	}
>   
> +	priv->private_data = card_data;
>   	snd_soc_card_set_drvdata(card, priv);
>   
>   	ret = devm_snd_soc_register_card(&pdev->dev, card);
> @@ -795,11 +1114,20 @@ static struct mt8188_card_data mt8188_evb_card = {
>   	.name = "mt8188_mt6359",
>   };
>   
> +static struct mt8188_card_data mt8188_nau8825_card = {
> +	.name = "mt8188_nau8825",
> +	.quirk = NAU8825_HS_PRESENT,
> +};
> +
>   static const struct of_device_id mt8188_mt6359_dt_match[] = {
>   	{
>   		.compatible = "mediatek,mt8188-mt6359-evb",
>   		.data = &mt8188_evb_card,
>   	},
> +	{
> +		.compatible = "mediatek,mt8188-nau8825",
> +		.data = &mt8188_nau8825_card,
> +	},
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, mt8188_mt6359_dt_match);

-- 
Regards,
Alexandre

