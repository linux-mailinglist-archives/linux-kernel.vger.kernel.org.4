Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A483B742EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjF2Uom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjF2Uoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:44:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A5430DD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:44:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso1734023e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688071476; x=1690663476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yaz00FEgGCTPJB8nvCETL7NnrgelsFGdklYuZ97nPlY=;
        b=ZiLvRjrx0hTzcGSqqZFobRZbdbjQYk5Ph8ozUtUffExhYwZt8uGNvPdc+o1z0Ynp4X
         VZ+tu2UtkoXGOO5pr6F0I+l90UmhOQWGOCBPcFZg8E5oWWVipkpFIZ1zV9ZcgHMYJWkt
         dTcDBSQW8yiI0G2PBISA6VNQ7Xr7z8j0w0H/y4nDHDXLdG5/yKTTmv5cV5OH+DOWrz9C
         KdxfJp7VRpS5EI9IocXPkDD2OdnmEmDoozkoyLzlA5VRZEY+LOEmKxtkgVKVHK8JKGWY
         vr6HKRydRWhVOVLw8HUZLVnqz/TK4EF1jtbIv+SPcfggbpwA3p+8+HfyRkqimRUEyNVU
         A03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688071476; x=1690663476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yaz00FEgGCTPJB8nvCETL7NnrgelsFGdklYuZ97nPlY=;
        b=bcQdqOCE5MkwBGvTi1HQ3JLKdw1g+wAzOf3Hsxr32ED9pzap8eySksnSWX2hSkUYDN
         Yxq88FfNXJTZqJt3qftR34Tkp+cKjZdJ4EiTCdhJHXhenMiqwP52DCG7SK+KIigytAhZ
         KqxBFj+t4kbq88EpyR8BQXLqFdGgMMlCVs0gv7NaUSgHC7Tx2Ug6PYi97b5d8MNNwgvE
         xzqXdwKClrAJhRAoMveuH54ZOqe9Karssiiy1OpWzBnSuRePP2Nk58PiMWILuDL6cES8
         xnhXvsMx1o7yXtOk5YkZDKfOzT7BN1//nsTfHUozAVnIgyeboZMGK9Y9pKimpHHF0xKG
         7emQ==
X-Gm-Message-State: ABy/qLY09K+TRyZKE6LLOBE7s0zFI8mfAvceukeuexUGR879XIYnAPtX
        Rk8K0tXp9M9FFmquAWgb1YbQGw==
X-Google-Smtp-Source: APBJJlHY6jW97U1D4G7rtrJ9N/FSbLkfUZXVa4JplOMQ3ixUjo5atHOSwdsjaRQRK6wNO8jyUxStRA==
X-Received: by 2002:a19:4f10:0:b0:4f9:607a:6508 with SMTP id d16-20020a194f10000000b004f9607a6508mr787367lfb.50.1688071476300;
        Thu, 29 Jun 2023 13:44:36 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id m11-20020a056512014b00b004fb326d4ff0sm2045647lfo.77.2023.06.29.13.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 13:44:35 -0700 (PDT)
Message-ID: <8ddbd947-6cb6-8c86-eb48-8b6ae9b4be2b@linaro.org>
Date:   Thu, 29 Jun 2023 22:44:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] regulator: Introduce Qualcomm REFGEN regulator
 driver
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20230628-topic-refgen-v2-0-6136487c78c5@linaro.org>
 <20230628-topic-refgen-v2-2-6136487c78c5@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230628-topic-refgen-v2-2-6136487c78c5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.06.2023 22:35, Konrad Dybcio wrote:
> Modern Qualcomm SoCs have a REFGEN (reference voltage generator)
> regulator, providing reference voltage to on-chip IP, like PHYs.
> 
> Add a driver to support toggling that regulator.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
Ugh. Missed the 'const' here and below. LMK if that warrants a resend
(or.. perhaps you just have other comments)

Konrad
> +	.ops = &(struct regulator_ops) {
> +		.enable		= qcom_sdm845_refgen_enable,
> +		.disable	= qcom_sdm845_refgen_disable,
> +		.is_enabled	= qcom_sdm845_refgen_is_enabled,
> +	},
> +};
> +
> +static struct regulator_desc sm8250_refgen_desc = {
> +	.enable_reg = REFGEN_REG_PWRDWN_CTRL5,
> +	.enable_mask = REFGEN_PWRDWN_CTRL5_MASK,
> +	.enable_val = REFGEN_PWRDWN_CTRL5_ENABLE,
> +	.disable_val = 0,
> +	.enable_time = 5,
> +	.name = "refgen",
> +	.owner = THIS_MODULE,
> +	.type = REGULATOR_VOLTAGE,
> +	.ops = &(struct regulator_ops) {
> +		.enable		= regulator_enable_regmap,
> +		.disable	= regulator_disable_regmap,
> +		.is_enabled	= regulator_is_enabled_regmap,
> +	},
> +};
> +
> +static const struct regmap_config qcom_refgen_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.fast_io = true,
> +};
> +
> +static int qcom_refgen_probe(struct platform_device *pdev)
> +{
> +	struct regulator_init_data *init_data;
> +	struct regulator_config config = {};
> +	const struct regulator_desc *rdesc;
> +	struct device *dev = &pdev->dev;
> +	struct regulator_dev *rdev;
> +	struct regmap *regmap;
> +	void __iomem *base;
> +
> +	rdesc = of_device_get_match_data(dev);
> +	if (!rdesc)
> +		return -ENODATA;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio(dev, base, &qcom_refgen_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	init_data = of_get_regulator_init_data(dev, dev->of_node, rdesc);
> +	if (!init_data)
> +		return -ENOMEM;
> +
> +	config.dev = dev;
> +	config.init_data = init_data;
> +	config.of_node = dev->of_node;
> +	config.regmap = regmap;
> +
> +	rdev = devm_regulator_register(dev, rdesc, &config);
> +	if (IS_ERR(rdev))
> +		return PTR_ERR(rdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qcom_refgen_match_table[] = {
> +	{ .compatible = "qcom,sdm845-refgen-regulator", .data = &sdm845_refgen_desc },
> +	{ .compatible = "qcom,sm8250-refgen-regulator", .data = &sm8250_refgen_desc },
> +	{ }
> +};
> +
> +static struct platform_driver qcom_refgen_driver = {
> +	.probe = qcom_refgen_probe,
> +	.driver = {
> +		.name = "qcom-refgen-regulator",
> +		.of_match_table = qcom_refgen_match_table,
> +	},
> +};
> +module_platform_driver(qcom_refgen_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Qualcomm REFGEN regulator driver");
> 
