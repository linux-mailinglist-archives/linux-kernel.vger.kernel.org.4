Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8D76C45D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCVJLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCVJK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:10:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D194977A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:10:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so6076318wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679476225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovrBn6XPxYUDXZ6TqJALCD62LFL/C1a6JXlrzcVVchg=;
        b=cJcm+5nrTY2Ye1VvjpgZgsnRmOxK0ACJKxHYyNldG6fGsVPJxEUn+A9HH2RNliyTRv
         NyfLpiQNqDi2HtfMK6SQiCr2ynPg9Opy86P+GFGGGpwhiCPXPMLLUpdYXxWXdRbzSTgq
         N3ooUpi1YCzy9YGI6F5aZ5Zip8c+oZwbzCX0dWypaf+/iOO3HfTWMxvdlP+6BN1LzhEV
         9p5oWee4Dv5jO1Obf4059B1tTSZHK1pcst+CwqrEvaNJikfRl3DZi1hwjl09ecGDdT1K
         J0w2/ovxJOlECqPTdkS4IzUCPWRhm+rlt3WqcPXWd/NSm5HK//btSC5pNrO2KZ/Uz+tC
         7c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovrBn6XPxYUDXZ6TqJALCD62LFL/C1a6JXlrzcVVchg=;
        b=VGLeTQrQMdAT6aNRfiD8GAa8yaSflhMc3sQg1x8kIST8EDI4L1xxMhdqyymOBZhGYQ
         TkcaDbY4fqm/DWQBM1CQsuerWwHCC43uZmSw+DdBn5YjctPKC/VFZlLCzzx46a5AFyWM
         W34GepyZiULKYE7NdkNwy7WSTemtT4GAF67MRmiek/TsXroi52JElRK3cCbKDTK4qtQP
         44cCPbVD7sYTH4o09WDgmAfmsONwmcnOcwzBl3IUCiUZgLjWu9moxgfqOc/q/U+tToIK
         4EwxKP3i5lwFTwX4psrpEWwVdHY6eDFT/+euN1dCKQAmAD0wEBp1bZpQssGj6sw8QfOY
         z0mQ==
X-Gm-Message-State: AO0yUKUVaTe56st3pwW5w4vk6PfQNaMDM6xR3y5qy8U1PkIHaRmArPTF
        KzPEZ4lvmmW3tSqzXObS7Qq31w==
X-Google-Smtp-Source: AK7set9Ml0a40IciGXQHSgRw0rALE4oqBwXtJ8GyQOJY478RsNUaRDn3DpclGi+b5ehfWidoBqeEDw==
X-Received: by 2002:a7b:cb90:0:b0:3ed:31fa:f563 with SMTP id m16-20020a7bcb90000000b003ed31faf563mr4480590wmi.20.1679476225490;
        Wed, 22 Mar 2023 02:10:25 -0700 (PDT)
Received: from [192.168.1.70] (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c469400b003ee2a0d49dbsm5240947wmo.25.2023.03.22.02.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 02:10:25 -0700 (PDT)
Message-ID: <205a4e62-fd87-629c-ea34-d863ff1549d8@baylibre.com>
Date:   Wed, 22 Mar 2023 10:10:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH INTERNAL v1 3/3] regulator: tps6594-regulator: Add driver
 for TI TPS6594 regulators
Content-Language: en-US
To:     Esteban Blanc <eblanc@baylibre.com>, linus.walleij@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jneanne@baylibre.com
References: <20230224133129.887203-1-eblanc@baylibre.com>
 <20230224133129.887203-4-eblanc@baylibre.com>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20230224133129.887203-4-eblanc@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/23 14:31, Esteban Blanc wrote:
> From: Jerome Neanne <jneanne@baylibre.com>
>
> This patch adds support for TPS6594 regulators (bucks and LDOs).
> The output voltages are configurable and are meant to supply power
> to the main processor and other components.
> Bucks can be used in single or multiphase mode, depending on PMIC
> part number.
>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> ---

(...)

> +static int tps6594_regulator_probe(struct platform_device *pdev)
> +{
> +	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
> +	struct regulator_dev *rdev;
> +	struct regulator_config config = {};
> +	u8 buck_configured[BUCK_NB] = { 0 };
> +	u8 buck_multi[MULTI_PHASE_NB] = { 0 };
> +	int i;
> +	int error;
> +	int irq;
> +	int ext_reg_irq_nb = 2;
> +	struct tps6594_regulator_irq_data *irq_data;
> +	struct tps6594_ext_regulator_irq_data *irq_ext_reg_data;
> +	struct tps6594_regulator_irq_type *irq_type;
> +	struct regulator_dev *rdevbucktbl[BUCK_NB];
> +	struct regulator_dev *rdevmultitbl[MULTI_PHASE_NB];
> +	struct regulator_dev *rdevldotbl[LDO_NB];
> +
> +	int multi_phase_id;
> +	int multi_phase_case = 0xFFFF;
> +
> +	config.dev = tps->dev;
> +	config.driver_data = tps;
> +	config.regmap = tps->regmap;
> +
> +	/*
> +	 * Switch case defines different possible multi phase config
> +	 * This is based on dts custom property: multi-phase-id
> +	 * Using compatible or device rev is a too complex alternative
> +	 * Default case is no Multiphase buck.
> +	 * In case of Multiphase configuration, value should be defined for
> +	 * buck_configured to avoid creating bucks for every buck in multiphase
> +	 */
> +
> +	if (device_property_present(tps->dev, "ti,multi-phase-id")) {

Question @ Mark/Liam:
Shouldn't we use the generic 'regulator-coupled-with' property
instead of 'ti,multi-phase-id' ?
I am in charge of upstreaming dt-bindings and maintainers
pointed out the similarity between 'multi-phase' and 'coupled'
regulator concepts. Does 'regulator-coupled-with' mean that
outputs of buck converters are combined ? If so, this generic
property should replace our specific 'ti,multi-phase-id' prop,
I guess.

> +		device_property_read_u32(tps->dev, "ti,multi-phase-id", &multi_phase_id);
> +		switch (multi_phase_id) {
> +		case 12:
> +			buck_multi[0] = 1;
> +			buck_configured[0] = 1;
> +			buck_configured[1] = 1;
> +			multi_phase_case = TPS6594_BUCK_12;
> +			break;
> +		case 34:
> +			buck_multi[1] = 1;
> +			buck_configured[2] = 1;
> +			buck_configured[3] = 1;
> +			multi_phase_case = TPS6594_BUCK_34;
> +			break;
> +		case 123:
> +			buck_multi[2] = 1;
> +			buck_configured[0] = 1;
> +			buck_configured[1] = 1;
> +			buck_configured[2] = 1;
> +			multi_phase_case = TPS6594_BUCK_123;
> +			break;
> +		case 1234:
> +			buck_multi[3] = 1;
> +			buck_configured[0] = 1;
> +			buck_configured[1] = 1;
> +			buck_configured[2] = 1;
> +			buck_configured[3] = 1;
> +			multi_phase_case = TPS6594_BUCK_1234;
> +			break;
> +		}
> +	}
> +
> +	for (i = 0; i < MULTI_PHASE_NB; i++) {
> +		if (buck_multi[i] == 0)
> +			continue;
> +
> +		rdev = devm_regulator_register(&pdev->dev, &multi_regs[i], &config);
> +		if (IS_ERR(rdev)) {
> +			dev_err(tps->dev, "failed to register %s regulator\n",
> +				pdev->name);
> +			return PTR_ERR(rdev);
> +		}
> +		rdevmultitbl[i] = rdev;
> +	}
> +

(...)
