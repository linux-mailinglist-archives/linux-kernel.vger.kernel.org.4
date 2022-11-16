Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E300862C0B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiKPORM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiKPORH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:17:07 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C67DF57;
        Wed, 16 Nov 2022 06:17:06 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p8so29699153lfu.11;
        Wed, 16 Nov 2022 06:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03AO/d+34sX5YN3fjNIOuZvahaBINhyoO8pKIANrSLg=;
        b=FdKmOSWs5xFN+58wikER67yYa5Vny4ZcI3G1EZaRA47K3g3cxQSoYX2Rf5H2vc84iv
         5hYP4a1AOLTId+qe9ZTmuf6dKhq+6CqIPWkHjQFgCulwkXfOlrbnkEV/t+MAbPVoG0hk
         d8k2SKK1PsulPklunT7RtLkWS560LFjyi1EGSVvH4ymKDViaJdZXdz6xk9ZguePd1R0/
         s8Nq3AkP+h/E8dzSguyzN0C4v3NzhkyF/xmfOoJzWprJC14pMjq47vQkuQZNU0ECOGG5
         ePrAG4QUC+b9qEwIvud9lAp0SnxJtnfwGagSY3+BwLIrtQh7Uy55vM1BPeHJi2LDK67b
         urAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03AO/d+34sX5YN3fjNIOuZvahaBINhyoO8pKIANrSLg=;
        b=uIEU2ylqpDpOdFvv6TlvplLzLphvri+Qm5xnwZeN/coGyrYua96+X6HmZyMgLoyrls
         x/1/Mtz77vaQwVPBoCpXQMwg9ZSbEXFkrRyWcB7wV3dc+Ynz7iXQA33ersiut10Ygs0k
         T0Fppz+W35viJvruKMk1IWxYtvqCmXc8JUPNT59I9z7Qj0dhHkQO6aH+kACGDgNcbBS1
         2zog/+RNuI907e3/wL/Y5ENT/1gZN5L0a3YStSR124zwzA6UFM6RrhEzi80r3y1ZIVo8
         MfwTDdeU0qMWzqugjSaAfJulWwoUsxsMDqzaK6ONCcueUPA+NpZaD6U56X84V118gHAk
         kriw==
X-Gm-Message-State: ANoB5plcIR+QZ/ECPHC49H5tOcD5uy5dTBTKYwLFWXuvpQ35YIIKXxgg
        E/ABGVR1fpbY9d30RUyPr00=
X-Google-Smtp-Source: AA0mqf6JWruVUZBOSSlDanBIhDMGzTs2Upx3yEKchOpWuoY6srpCJEpuwyeVU+HZlq5crpJBj2gaAw==
X-Received: by 2002:a05:6512:3ba8:b0:4b0:7a03:60dc with SMTP id g40-20020a0565123ba800b004b07a0360dcmr6789861lfv.567.1668608224875;
        Wed, 16 Nov 2022 06:17:04 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::7? (dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::7])
        by smtp.gmail.com with ESMTPSA id v15-20020a2ea44f000000b0027738fd1eb6sm3018470ljn.110.2022.11.16.06.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 06:17:04 -0800 (PST)
Message-ID: <d61d8c22-fce5-74d5-6d2b-0eda6f2ace9e@gmail.com>
Date:   Wed, 16 Nov 2022 16:17:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-leds@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org
References: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
 <20221005-mt6357-support-v5-9-8210d955dd3d@baylibre.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 09/10] regulator: add mt6357 regulator
In-Reply-To: <20221005-mt6357-support-v5-9-8210d955dd3d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre, All

Please, treat my review more as initiation for discussion than 'hard 
requirements' for this driver. I am in no point or no "confidence level" 
to give you any requirements ;)

On 11/16/22 14:33, Alexandre Mergnat wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add regulator driver for the MT6357 PMIC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---

//snip

> +/*
> + * MT6357 regulators' information
> + *
> + * @desc: standard fields of regulator description.
> + * @da_vsel_reg: Monitor register for query buck's voltage.
> + * @da_vsel_mask: Mask for query buck's voltage.
> + */
> +struct mt6357_regulator_info {
> +	struct regulator_desc desc;
> +	u32 da_vsel_reg;
> +	u32 da_vsel_mask;
> +};
> +

//snip

> +/**
> + * mt6357_get_buck_voltage_sel - get_voltage_sel for regmap users
> + *
> + * @rdev: regulator to operate on
> + *
> + * Regulators that use regmap for their register I/O can set the
> + * da_vsel_reg and da_vsel_mask fields in the info structure and
> + * then use this as their get_voltage_vsel operation.
> + */
> +static int mt6357_get_buck_voltage_sel(struct regulator_dev *rdev)
> +{
> +	int ret, regval;
> +	struct mt6357_regulator_info *info = rdev_get_drvdata(rdev);
> +
> +	ret = regmap_read(rdev->regmap, info->da_vsel_reg, &regval);
> +	if (ret != 0) {
> +		dev_err(&rdev->dev,
> +			"Failed to get mt6357 Buck %s vsel reg: %d\n",
> +			info->desc.name, ret);
> +		return ret;
> +	}
> +
> +	regval &= info->da_vsel_mask;
> +	regval >>= ffs(info->da_vsel_mask) - 1;
> +
> +	return regval;
> +}

If I read this right, the device has separate register(s) for writing 
and reading the voltage? I wonder if this is a completely unique setup?

If this is not unique, then it might be worth adding another field for 
'vsel_get' register and a flag in regulator desc - and modify the 
generic regmap helpers to handle this in common code if the special 
register? Not sure if this HW design is common enough to warrant the 
added confusion though. You and Mark may have more insight.

> +
> +static const struct linear_range buck_volt_range1[] = {
> +	REGULATOR_LINEAR_RANGE(518750, 0, 0x7f, 6250),
> +};
> +
> +static const struct linear_range buck_volt_range2[] = {
> +	REGULATOR_LINEAR_RANGE(500000, 0, 0x7f, 6250),
> +};
> +
> +static const struct linear_range buck_volt_range3[] = {
> +	REGULATOR_LINEAR_RANGE(500000, 0, 0x3f, 50000),
> +};
> +
> +static const struct linear_range buck_volt_range4[] = {
> +	REGULATOR_LINEAR_RANGE(1200000, 0, 0x7f, 12500),
> +};

I am unsure if we should aim for dropping the REGULATOR_LINEAR_RANGE() 
and using the LINEAR_RANGE(). If yes, then it might simplify things if 
new drivers used LINEAR_RANGE() from the day 1. If we don't, then it 
makes sense to keep consistently using REGULATOR_LINEAR_RANGE() for all 
of the drivers. I am not sure which way is the right way.

> +static int mt6357_regulator_probe(struct platform_device *pdev)
> +{
> +	struct mt6397_chip *mt6357 = dev_get_drvdata(pdev->dev.parent);

I am unsure what data do you need from the parent. If it is just the 
regmap / device-tree node / device, then it does not (in my opinion) 
really warrant using parent's drvdata. One can often get away with the
dev_get_regmap(pdev->dev.parent, NULL).

Anyways, the driver looks good to me.

Yours,
	-- Matti Vaittinen

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

