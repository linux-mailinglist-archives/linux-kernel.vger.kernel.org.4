Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B302B673F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjASQpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjASQpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:45:01 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6B89020;
        Thu, 19 Jan 2023 08:45:00 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso3308555wmb.0;
        Thu, 19 Jan 2023 08:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p31jk7oJoppAGvipyfcQkOKfkHgOguOdfo62urZGHvU=;
        b=F2Zg/HFTLqmm+K1UCvTm13AYT09XXrhVLj5hyL4jJzM4ETw/oOfzGJ91QHVQkKygP+
         x5y4xrP/fP88kOijUZOpztyQO8KlV06CatSaAeNbLBwtnhJVIReIlVvOIpInkE8+kAyf
         9nAeUejSX/oHASky6LXt2uBUaNsmQeK8y4uGiTfWM+KDvfI+y9FZdsdect0DJx4BwBG9
         HwlK16lDRcL44GL03o+SSUbYtmcLlryq1YiO94/ea+TlXxvUM7TiIWf9Ct1pNMc6RhZe
         6VNJK6f1HZzLK6RHy848hcKXBzGUQYF5+vkhN19ULZCcflfkElRxloScVVjeyG7QMr/6
         MxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p31jk7oJoppAGvipyfcQkOKfkHgOguOdfo62urZGHvU=;
        b=YfM8fg87zGLrXxkTPy1xtZVhHIEuqC/KP3zo2RUfUZpsosLlyYSla1HJHqtJXbWHWm
         fd/wchkLK40PqvGQCl9IYVr4J8q4TfRU+LYnqdG5l0Jxr+nKhch6z2iAPSslisFh9FvW
         E3N0jS3gfyc0INu6R1zCGvx4KG5SyyhNBeouMJAY5GkBmdl1ocaw8aBNBrSf1UEXRMaV
         n20zjRVOtoE57ng5v9EpnwfaD44Qx6cH9z6WwJrWB8vHoPZjkwnWQOi6ibobWcNbKUvG
         xlyi+mc1IhllFYpC/F+1qaV8B8CkasLUHEfBFp6iNWQRQbIAesQcwM3K5EbQhrJ4outK
         20yQ==
X-Gm-Message-State: AFqh2kqGuLIxFSyNaU6eGQ+ZPQcMah+VPO56XVFIWCxpA1e4VMN73ie/
        nzV4Mh9Dssjl2bSSqm3peTg9UlOMULmn/g==
X-Google-Smtp-Source: AMrXdXtXLoOKeiDjNOplfKgIStlJLK1HdxG/83Z7TnVyHlxxEPOdE51VTk5wzMunD8ESCyTjAqw84Q==
X-Received: by 2002:a05:600c:920:b0:3da:22a6:7b6b with SMTP id m32-20020a05600c092000b003da22a67b6bmr10978954wmp.13.1674146698929;
        Thu, 19 Jan 2023 08:44:58 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j30-20020a05600c1c1e00b003daf89e01d3sm6287926wms.11.2023.01.19.08.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 08:44:58 -0800 (PST)
Message-ID: <36bb49f6-91ac-148d-2caf-c4f52da57aed@gmail.com>
Date:   Thu, 19 Jan 2023 17:44:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/2] thermal/drivers/mtk: use function pointer for
 raw_to_mcelsius
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Steven Liu <steven.liu@mediatek.com>,
        Henry Yen <Henry.Yen@mediatek.com>,
        Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>
References: <cover.1674055882.git.daniel@makrotopia.org>
 <69c17529e8418da3eec703dde31e1b01e5b0f7e8.1674055882.git.daniel@makrotopia.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <69c17529e8418da3eec703dde31e1b01e5b0f7e8.1674055882.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2023 16:40, Daniel Golle wrote:
> Instead of having if-else logic selecting either raw_to_mcelsius_v1 or
> raw_to_mcelsius_v2 in mtk_thermal_bank_temperature introduce a function
> pointer raw_to_mcelsius to struct mtk_thermal which is initialized in the
> probe function.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/thermal/mtk_thermal.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 0084b76493d9a..992750ee09e62 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -292,6 +292,8 @@ struct mtk_thermal {
>   
>   	const struct mtk_thermal_data *conf;
>   	struct mtk_thermal_bank banks[MAX_NUM_ZONES];
> +
> +	int (*raw_to_mcelsius)(struct mtk_thermal *mt, int sensno, s32 raw);
>   };
>   
>   /* MT8183 thermal sensor data */
> @@ -656,13 +658,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>   	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
>   		raw = readl(mt->thermal_base + conf->msr[i]);
>   
> -		if (mt->conf->version == MTK_THERMAL_V1) {
> -			temp = raw_to_mcelsius_v1(
> -				mt, conf->bank_data[bank->id].sensors[i], raw);
> -		} else {
> -			temp = raw_to_mcelsius_v2(
> -				mt, conf->bank_data[bank->id].sensors[i], raw);
> -		}
> +		temp = mt->raw_to_mcelsius(
> +			mt, conf->bank_data[bank->id].sensors[i], raw);
> +
>   
>   		/*
>   		 * The first read of a sensor often contains very high bogus
> @@ -1075,6 +1073,11 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   		mtk_thermal_release_periodic_ts(mt, auxadc_base);
>   	}
>   
> +	if (mt->conf->version == MTK_THERMAL_V1)
> +		mt->raw_to_mcelsius = raw_to_mcelsius_v1;
> +	else
> +		mt->raw_to_mcelsius = raw_to_mcelsius_v2;
> +
>   	for (ctrl_id = 0; ctrl_id < mt->conf->num_controller ; ctrl_id++)
>   		for (i = 0; i < mt->conf->num_banks; i++)
>   			mtk_thermal_init_bank(mt, i, apmixed_phys_base,
