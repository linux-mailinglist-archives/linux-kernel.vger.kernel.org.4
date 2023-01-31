Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F377682E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjAaNlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjAaNlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:41:18 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E971A2D75;
        Tue, 31 Jan 2023 05:41:16 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso630368wms.3;
        Tue, 31 Jan 2023 05:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZP0P6BPjpTycjws87uMdBob8rEGrXXOXGVK5egAH/A=;
        b=Oivea9/Iy3KwEakTbBE/jJKb7XFNmSXBXIm0CdMEk5UYzzcmCnJlik4RS24QKOjjEX
         UQqsg/pp0PeI6SW2AYM9NXGWNYeVQxD1jy1Jyp6WOZX06+5j3l71suA95oS1QqHwft66
         nPEgN2EzNn3s3Dxuaf4q0AqpgMkh1Ykhug8IAW8BLEjiJJN4HTChgDqFicvxasy8nG7l
         5vBQo7J9lFU9/B+SPovlZuT8+crL1MGRLrqz0IfKXwOZTCm4TLWnkKxNAq47Em+Kh6K+
         X1gzqO9vvfq2ZVkcRMzn3SiyC+JCzgbrdj8xmqDEeIBHC4vWXbrI5lHrkCsEw/Hlk6iS
         ZbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZP0P6BPjpTycjws87uMdBob8rEGrXXOXGVK5egAH/A=;
        b=yQPpWJVxBvqK1d2446cJupLQwzgLUJ3X+Ec7uiOwDKcd+T+SIRmp7Gq3V42gShGmaB
         JwD6l2GwpOvbqnz/nMy2jcf9R5ZcJwbQ1wZ3cIh6Eq/wVjnwVBNlOqWlN9/NrVa/7XzT
         XfNo0OpskkUMaMryRHvg6ubaynYRKaqQeOjcgy4x2I2TLYOzD3LKh1Q+o+KgF+JwAeXj
         m1ndiYSVqivxpkEcYEXsgvmiNjD86kgvY0+jaYDlxkvY8MGIe/7yYKa3xEbgWbZm6vlu
         oKMvehnfewUAPLO31UNGMM7tYPGDHptX61BMhaYX6Orak1KIHm7ZYGFozbztIFRAMtMr
         XPFw==
X-Gm-Message-State: AO0yUKXS5qUbAV3Vmva1NbDQFaIlr2HuO76hUWsMA+o/k9pLF5CFLe/s
        JaBgh9EGpYkiRGGKNbQEZ1h4v9hA72E=
X-Google-Smtp-Source: AK7set8yxn3VlOGMhryXV9o5wgcPRLjDRGFzg6jcqOwrzlU/5pigFTF/ueOTr/AKj6XbvPKhQDiuuw==
X-Received: by 2002:a05:600c:3511:b0:3dc:58a2:38e3 with SMTP id h17-20020a05600c351100b003dc58a238e3mr8102103wmq.26.1675172475450;
        Tue, 31 Jan 2023 05:41:15 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id y21-20020a05600c341500b003da28dfdedcsm10220004wmp.5.2023.01.31.05.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:41:14 -0800 (PST)
Message-ID: <4ef03681-4da9-b7d6-516c-19bd37b8dc6f@gmail.com>
Date:   Tue, 31 Jan 2023 14:41:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 14/14] soc: mtk-svs: mt8183: refactor o_slope
 calculation
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230111074528.29354-1-roger.lu@mediatek.com>
 <20230111074528.29354-15-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230111074528.29354-15-roger.lu@mediatek.com>
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



On 11/01/2023 08:45, Roger Lu wrote:
> The o_slope value is dependent of the o_slope_sign, refactor code to get
> rid of unnecessary if constructs.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

> ---
>   drivers/soc/mediatek/mtk-svs.c | 51 +++++++++++++++-------------------
>   1 file changed, 22 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 89117807e85d..8cfbf8ffb138 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -1944,26 +1944,27 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
>   	o_slope_sign = (svsp->tefuse[0] >> 7) & BIT(0);
>   
>   	ts_id = (svsp->tefuse[1] >> 9) & BIT(0);
> -	o_slope = (svsp->tefuse[0] >> 26) & GENMASK(5, 0);
> -
> -	if (adc_cali_en_t == 1) {
> -		if (!ts_id)
> -			o_slope = 0;
> -
> -		if (adc_ge_t < 265 || adc_ge_t > 758 ||
> -		    adc_oe_t < 265 || adc_oe_t > 758 ||
> -		    o_vtsmcu[0] < -8 || o_vtsmcu[0] > 484 ||
> -		    o_vtsmcu[1] < -8 || o_vtsmcu[1] > 484 ||
> -		    o_vtsmcu[2] < -8 || o_vtsmcu[2] > 484 ||
> -		    o_vtsmcu[3] < -8 || o_vtsmcu[3] > 484 ||
> -		    o_vtsmcu[4] < -8 || o_vtsmcu[4] > 484 ||
> -		    o_vtsabb < -8 || o_vtsabb > 484 ||
> -		    degc_cali < 1 || degc_cali > 63) {
> -			dev_err(svsp->dev, "bad thermal efuse, no mon mode\n");
> -			goto remove_mt8183_svsb_mon_mode;
> -		}
> +	if (!ts_id) {
> +		o_slope = 1534;
>   	} else {
> -		dev_err(svsp->dev, "no thermal efuse, no mon mode\n");
> +		o_slope = (svsp->tefuse[0] >> 26) & GENMASK(5, 0);
> +		if (!o_slope_sign)
> +			o_slope = 1534 + o_slope * 10;
> +		else
> +			o_slope = 1534 - o_slope * 10;
> +	}
> +
> +	if (adc_cali_en_t == 0 ||
> +	    adc_ge_t < 265 || adc_ge_t > 758 ||
> +	    adc_oe_t < 265 || adc_oe_t > 758 ||
> +	    o_vtsmcu[0] < -8 || o_vtsmcu[0] > 484 ||
> +	    o_vtsmcu[1] < -8 || o_vtsmcu[1] > 484 ||
> +	    o_vtsmcu[2] < -8 || o_vtsmcu[2] > 484 ||
> +	    o_vtsmcu[3] < -8 || o_vtsmcu[3] > 484 ||
> +	    o_vtsmcu[4] < -8 || o_vtsmcu[4] > 484 ||
> +	    o_vtsabb < -8 || o_vtsabb > 484 ||
> +	    degc_cali < 1 || degc_cali > 63) {
> +		dev_err(svsp->dev, "bad thermal efuse, no mon mode\n");
>   		goto remove_mt8183_svsb_mon_mode;
>   	}
>   
> @@ -1982,11 +1983,7 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
>   		x_roomt[i] = (((format[i] * 10000) / 4096) * 10000) / gain;
>   
>   	temp0 = (10000 * 100000 / gain) * 15 / 18;
> -
> -	if (!o_slope_sign)
> -		mts = (temp0 * 10) / (1534 + o_slope * 10);
> -	else
> -		mts = (temp0 * 10) / (1534 - o_slope * 10);
> +	mts = (temp0 * 10) / o_slope;
>   
>   	for (idx = 0; idx < svsp->bank_max; idx++) {
>   		svsb = &svsp->banks[idx];
> @@ -2013,11 +2010,7 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
>   		temp0 = (degc_cali * 10 / 2);
>   		temp1 = ((10000 * 100000 / 4096 / gain) *
>   			 oe + tb_roomt * 10) * 15 / 18;
> -
> -		if (!o_slope_sign)
> -			temp2 = temp1 * 100 / (1534 + o_slope * 10);
> -		else
> -			temp2 = temp1 * 100 / (1534 - o_slope * 10);
> +		temp2 = temp1 * 100 / o_slope;
>   
>   		svsb->bts = (temp0 + temp2 - 250) * 4 / 10;
>   	}
