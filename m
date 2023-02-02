Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8DE687D13
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjBBMTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBBMTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:19:41 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A47950878;
        Thu,  2 Feb 2023 04:19:40 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o18so1539201wrj.3;
        Thu, 02 Feb 2023 04:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Obxz9fH35OWB4UXxiqSp3CJYqzK8VLJncs58vA/I1w=;
        b=hGavQITnzkxfZqIrRHR/2XSpzp2m8GPHONYsjIwWEbYgAi16e05vrSDeaHsKjKvl5i
         /93+b/uh8LPctsU7akwIsoOgqel3WzEGEvNTWJOnGj2ZEW2ZSpzNPkHI7XK0XLwxXEYF
         +aJH6kyveI5s8zMSR/Gu+KJjDcPP8Rlh+zmLg6sS6Gb6b7Lp+9eLL5s4imARqnwE25VI
         XLS+oxwfKS6P9KEQzINoe2iDh6DWCpKXOvVZyhSyLLpgdcdgomq6fXT6oVCbtMRLIYyK
         x5bUFz/HnCo2n3xfKPTYnb7JK4+uLCVSSEsyNyyLG2ERESsIxWbVGoZBkk/q5txRdxB+
         nkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Obxz9fH35OWB4UXxiqSp3CJYqzK8VLJncs58vA/I1w=;
        b=esRyMkEVXsYkQxM835PcjMeolGUaTU4KQTNmhOp4td0JWpsrnKnBxgza6usOAfoixX
         /PjUjhD0p5MMkFox44bCHMPArxI4bg/A+h+fNEqTQn9CbUCQaVZJKnTQtcuQ0F4u9eWs
         431bNeyd45hmZG1JzHXxeOqs9QyK3jUaKuOl5k0IHDjkkiTZZs0WYq9P/qBimOK4ggGP
         qREX8yqLZmqQ+9sM+ENwQngxossxboicMDBjIfnFRMk69bdq7AB2wfXzmYw26bWGWR9a
         AESs1ks2z4ScosEQowLZ+E2+dqyre/MyE3KJWFFU0z6ERYKzwL4HJ9tHyYOFotfdsQG9
         05FQ==
X-Gm-Message-State: AO0yUKURaqmtfgqtmNZaaSapoqb3uR/82psjAe6zRyR/4lX7r/wD42BS
        BcjQs4a/AccFrdZq0XOM25BCiT3Ha2cw1g==
X-Google-Smtp-Source: AK7set/4lyENg811N/tf0ykVq/rm55qR04z2wrUgYTqv/PP7TDtGNwCZFpOJaeB9bXho9exywA3evQ==
X-Received: by 2002:adf:fa07:0:b0:2c0:6217:8459 with SMTP id m7-20020adffa07000000b002c062178459mr4765480wrr.16.1675340378510;
        Thu, 02 Feb 2023 04:19:38 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id h4-20020adfaa84000000b002bfbf4c3f9fsm19786807wrc.17.2023.02.02.04.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 04:19:38 -0800 (PST)
Message-ID: <27d1f8ae-4948-317d-b4a6-be7dc0dfe22a@gmail.com>
Date:   Thu, 2 Feb 2023 13:19:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 5/5] mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        benliang.zhao@mediatek.com, bin.zhang@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20230201021500.26769-1-xiangsheng.hou@mediatek.com>
 <20230201021500.26769-6-xiangsheng.hou@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230201021500.26769-6-xiangsheng.hou@mediatek.com>
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



On 01/02/2023 03:15, Xiangsheng Hou wrote:
> Add ECC support fot MT7986 IC, and change err_mask value with
> GENMASK macro.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/mtd/nand/ecc-mtk.c | 28 +++++++++++++++++++++++++---
>   1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/ecc-mtk.c b/drivers/mtd/nand/ecc-mtk.c
> index 9f9b201fe706..c75bb8b80cc1 100644
> --- a/drivers/mtd/nand/ecc-mtk.c
> +++ b/drivers/mtd/nand/ecc-mtk.c
> @@ -40,6 +40,10 @@
>   #define ECC_IDLE_REG(op)	((op) == ECC_ENCODE ? ECC_ENCIDLE : ECC_DECIDLE)
>   #define ECC_CTL_REG(op)		((op) == ECC_ENCODE ? ECC_ENCCON : ECC_DECCON)
>   
> +#define ECC_ERRMASK_MT7622	GENMASK(4, 0)
> +#define ECC_ERRMASK_MT2701	GENMASK(5, 0)
> +#define ECC_ERRMASK_MT2712	GENMASK(6, 0)
> +
>   struct mtk_ecc_caps {
>   	u32 err_mask;
>   	u32 err_shift;
> @@ -79,6 +83,10 @@ static const u8 ecc_strength_mt7622[] = {
>   	4, 6, 8, 10, 12
>   };
>   
> +static const u8 ecc_strength_mt7986[] = {
> +	4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24
> +};
> +
>   enum mtk_ecc_regs {
>   	ECC_ENCPAR00,
>   	ECC_ENCIRQ_EN,
> @@ -451,7 +459,7 @@ unsigned int mtk_ecc_get_parity_bits(struct mtk_ecc *ecc)
>   EXPORT_SYMBOL(mtk_ecc_get_parity_bits);
>   
>   static const struct mtk_ecc_caps mtk_ecc_caps_mt2701 = {
> -	.err_mask = 0x3f,
> +	.err_mask = ECC_ERRMASK_MT2701,
>   	.err_shift = 8,
>   	.ecc_strength = ecc_strength_mt2701,
>   	.ecc_regs = mt2701_ecc_regs,
> @@ -462,7 +470,7 @@ static const struct mtk_ecc_caps mtk_ecc_caps_mt2701 = {
>   };
>   
>   static const struct mtk_ecc_caps mtk_ecc_caps_mt2712 = {
> -	.err_mask = 0x7f,
> +	.err_mask = ECC_ERRMASK_MT2712,
>   	.err_shift = 8,
>   	.ecc_strength = ecc_strength_mt2712,
>   	.ecc_regs = mt2712_ecc_regs,
> @@ -473,7 +481,7 @@ static const struct mtk_ecc_caps mtk_ecc_caps_mt2712 = {
>   };
>   
>   static const struct mtk_ecc_caps mtk_ecc_caps_mt7622 = {
> -	.err_mask = 0x1f,
> +	.err_mask = ECC_ERRMASK_MT7622,
>   	.err_shift = 5,
>   	.ecc_strength = ecc_strength_mt7622,
>   	.ecc_regs = mt7622_ecc_regs,
> @@ -483,6 +491,17 @@ static const struct mtk_ecc_caps mtk_ecc_caps_mt7622 = {
>   	.pg_irq_sel = 0,
>   };
>   
> +static const struct mtk_ecc_caps mtk_ecc_caps_mt7986 = {
> +	.err_mask = ECC_ERRMASK_MT7622,
> +	.err_shift = 8,
> +	.ecc_strength = ecc_strength_mt7986,
> +	.ecc_regs = mt2712_ecc_regs,
> +	.num_ecc_strength = 11,
> +	.ecc_mode_shift = 5,
> +	.parity_bits = 14,
> +	.pg_irq_sel = 1,
> +};
> +
>   static const struct of_device_id mtk_ecc_dt_match[] = {
>   	{
>   		.compatible = "mediatek,mt2701-ecc",
> @@ -493,6 +512,9 @@ static const struct of_device_id mtk_ecc_dt_match[] = {
>   	}, {
>   		.compatible = "mediatek,mt7622-ecc",
>   		.data = &mtk_ecc_caps_mt7622,
> +	}, {
> +		.compatible = "mediatek,mt7986-ecc",
> +		.data = &mtk_ecc_caps_mt7986,
>   	},
>   	{},
>   };
