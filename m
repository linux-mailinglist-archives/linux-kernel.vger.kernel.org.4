Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCB96898D2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjBCMcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjBCMcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:32:16 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4E75B5B8;
        Fri,  3 Feb 2023 04:32:14 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso5896258wmp.3;
        Fri, 03 Feb 2023 04:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eCtsGF41WjTzwj4MiFKnyo2/eolWQk6TBMwedwS+GA=;
        b=kIyp6KZ9t6gqZ422axb8Y3xXddye1aQeR3SpqwKHb9KL+wwEeTlv45VdsnqpwibyUF
         FYERsxE76QWspJEMIlt0kDV4Il2sZlaZLzRwtSD9I2t6iQQLD/b2+B02dOV5h2mHphYN
         BsOpj5uLCAnBECldPaMKcPFsk/ZmI1M2W+kAVJT6mpjsMmwZGDMnG1R4PEUujP6dukOI
         gVpjB51enE9NjNHZBLXSIAk0Lrs01vr1GOarE5poGB/4NgxhCE2yMxHuQJ2u33cogE8x
         O190KYijsBCbVyqoBhyxkQAlGMyxJfy9SX1tH2suQ+LPkVivuCxmGqNFcWNpMx5KswML
         4c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eCtsGF41WjTzwj4MiFKnyo2/eolWQk6TBMwedwS+GA=;
        b=aMho3twtTYzonj5QfJeMjqBVbgQ89Rpr+gK88TY95xFwQYdGW/ykAjLGByXwn5KVYW
         k2cQudm0maIhoqGzwGnVc48yrn5gogAcYDWPObeE0taznthHeZ3PAq6CvFSHBS3hvGwq
         SrBoFmCeXjhkKPIXvreSYK4dq0m0XQWp8uK8rCFkf1EdKG1xxmYyGH1DxKS3Nn4ZbhFV
         yxhw2u5ombZG2NAhh95c2HvONFFs1y+5KkVSG5INarsOHhK04w1KTLAGJG9yTpSLmL9d
         W6HKEHemh/wm1XLkE202Y2Ngage090XlMPLojCOd4jEUKTklefZP7wa4hI+rYPMuo+WX
         tcuQ==
X-Gm-Message-State: AO0yUKXYnf7Ax3PALGh+OdK8iGn+4+3rU8Gu9VcgZdSZYV1lrf1Vk2di
        pz9l+4YxnzGgLgJTZCZhFo4=
X-Google-Smtp-Source: AK7set/bhNPKI2837cPL0+Z8686YxoP/jGLaYlKihTYitHEjiZgeRhGyDr5j2uRpvxfFiiS27awlMg==
X-Received: by 2002:a05:600c:3b14:b0:3dc:5c86:12f3 with SMTP id m20-20020a05600c3b1400b003dc5c8612f3mr11940588wms.1.1675427533293;
        Fri, 03 Feb 2023 04:32:13 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b003dfeea6a85csm82235wmo.31.2023.02.03.04.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 04:32:12 -0800 (PST)
Message-ID: <fb36ce3f-dd67-32b5-7ce0-ad15dd3b540a@gmail.com>
Date:   Fri, 3 Feb 2023 13:32:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230105170735.1637416-1-msp@baylibre.com>
 <20230105170735.1637416-4-msp@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/8] soc: mediatek: pm-domains: Create bus protection
 operation functions
In-Reply-To: <20230105170735.1637416-4-msp@baylibre.com>
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



On 05/01/2023 18:07, Markus Schneider-Pargmann wrote:
> Separate the register access used for bus protection enable/disable into
> their own functions. These will be used later for WAY_EN bits.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   drivers/soc/mediatek/mtk-pm-domains.c | 68 +++++++++++++++------------
>   1 file changed, 39 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 4333cd297405..999e1f6c86b0 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -117,26 +117,50 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
>   					MTK_POLL_TIMEOUT);
>   }
>   
> +static int scpsys_bus_protect_clear(const struct scpsys_bus_prot_data *bpd,
> +				    struct regmap *regmap)
> +{
> +	u32 val;
> +	u32 sta_mask = bpd->bus_prot_sta_mask;
> +
> +	if (bpd->bus_prot_reg_update)
> +		regmap_clear_bits(regmap, bpd->bus_prot_clr, bpd->bus_prot_set_clr_mask);
> +	else
> +		regmap_write(regmap, bpd->bus_prot_clr, bpd->bus_prot_set_clr_mask);
> +
> +	if (bpd->ignore_clr_ack)
> +		return 0;
> +
> +	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
> +					val, !(val & sta_mask),
> +					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +}
> +

NIT: please move this function below
static int scpsys_bus_protect_enable(struct scpsys_domain *pd) {...}

This allows for better readability.

> +static int scpsys_bus_protect_set(const struct scpsys_bus_prot_data *bpd,
> +				  struct regmap *regmap)
> +{
> +	u32 val;
> +	u32 sta_mask = bpd->bus_prot_sta_mask;
> +
> +	if (bpd->bus_prot_reg_update)
> +		regmap_set_bits(regmap, bpd->bus_prot_set, bpd->bus_prot_set_clr_mask);
> +	else
> +		regmap_write(regmap, bpd->bus_prot_set, bpd->bus_prot_set_clr_mask);
> +
> +	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
> +					val, (val & sta_mask) == sta_mask,
> +					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +}
> +
>   static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
>   {
>   	int i, ret;
>   
>   	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
> -		u32 val;
> -		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
> -		u32 sta_mask = bpd[i].bus_prot_sta_mask;
> -
> -		if (!set_clr_mask)
> +		if (!bpd[i].bus_prot_set_clr_mask)
>   			break;
>   
> -		if (bpd[i].bus_prot_reg_update)
> -			regmap_set_bits(regmap, bpd[i].bus_prot_set, set_clr_mask);
> -		else
> -			regmap_write(regmap, bpd[i].bus_prot_set, set_clr_mask);
> -
> -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> -					       val, (val & sta_mask) == sta_mask,
> -					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +		ret = scpsys_bus_protect_set(&bpd[i], regmap);
>   		if (ret)
>   			return ret;
>   	}
> @@ -161,24 +185,10 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
>   	int i, ret;
>   
>   	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
> -		u32 val;
> -		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
> -		u32 sta_mask = bpd[i].bus_prot_sta_mask;
> -
> -		if (!set_clr_mask)
> -			continue;
> -
> -		if (bpd[i].bus_prot_reg_update)
> -			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, set_clr_mask);
> -		else
> -			regmap_write(regmap, bpd[i].bus_prot_clr, set_clr_mask);
> -
> -		if (bpd[i].ignore_clr_ack)
> +		if (!bpd[i].bus_prot_set_clr_mask)
>   			continue;
>   
> -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> -					       val, !(val & sta_mask),
> -					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +		ret = scpsys_bus_protect_clear(&bpd[i], regmap);
>   		if (ret)
>   			return ret;
>   	}
