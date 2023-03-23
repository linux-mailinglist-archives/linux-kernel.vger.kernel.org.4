Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E836C62FA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjCWJMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjCWJM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:12:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42221C7FE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:12:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d17so11204281wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679562743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFctY62Fu/oerMamaIjbU4d8HvtLi/rh0sE4EKaYOE4=;
        b=36fYa/ni7ysZ5y5TDytFuzn2/ZhJ5cmxm21cABzySX6BmlX8zVq48bPOkprqHyTcJ5
         zzg7Qf6tBUYt1Gybs3TN7FRJhcDVKCHmacgztIUPSFT0Af/qiHUD8HFfUK6o9xQqKS4e
         lVI+iNooLMaKDC+qDdGmf6WM/wUInJxFAAlHmATXUaPTEg1f7ZU6SDcs2eE4CEYJHtOQ
         EbXJU3FqtNVZwFhWKULQi7yo3ai6JEKf+tuWuHRWPBZZt11QEXWrA3hSLq2dgP3lW8EW
         40QPG8ldYh7NuL7c5hO86kmzwRJXTzpw/aPZCcOlVhkXBwT3sI9Rj/T/P0u/7/8zaA2S
         HzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679562743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFctY62Fu/oerMamaIjbU4d8HvtLi/rh0sE4EKaYOE4=;
        b=cIRpuRUhxUFPHtp8EPk/bDmbJ2k5c8UIGhgAtMi2oZooevVSa/xqa6n/focFSv8nFI
         VuaCq4GG4iqKZtlENVJmdKHHWulPeSllENUgc9H5aFuEb479dCF/Z7kH5jUI94kSlSbe
         qImKjO2oS0dZ79XUVar/KwnBzkAOC0TBWkFWBtF/AlhlmawXNdQVXkJ2w6ueYgubQZlk
         L+ehCit5toA1Uav9LgXMi+qV+vCd/v6hyec1KntDnBwmV78XeErb2WXkKKLui8iUi3Eo
         KNz/iCtqXA+tt/rYAps1CdT4Ug6C3lfEIx/jfExcHmaPhyKLm6Wdz+Z9yifh/usSQyPi
         r1tw==
X-Gm-Message-State: AAQBX9cs56Hrd0y8y8nImpxVfEppxGwBCSh0totLBkYyKVexbT5a5Nh9
        IFtARbrVNPTKY/bnGsIxrguAQw==
X-Google-Smtp-Source: AKy350bIXyKctpx/1wqip3Rp2mheJwmbgFP+LGEPKZLQHpj9doYPwLwDb6cxO863qF14Dp5zVyQigg==
X-Received: by 2002:a5d:4487:0:b0:2c5:a742:572f with SMTP id j7-20020a5d4487000000b002c5a742572fmr1950315wrq.49.1679562743221;
        Thu, 23 Mar 2023 02:12:23 -0700 (PDT)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id u13-20020adfdb8d000000b002d2b117a6a6sm15687914wri.41.2023.03.23.02.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 02:12:22 -0700 (PDT)
Message-ID: <bd4aa2ad-4535-94ca-7630-846546ae3d82@baylibre.com>
Date:   Thu, 23 Mar 2023 10:12:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH INTERNAL v1 3/3] regulator: tps6594-regulator: Add driver
 for TI TPS6594 regulators
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com
References: <20230224133129.887203-1-eblanc@baylibre.com>
 <20230224133129.887203-4-eblanc@baylibre.com>
 <Y/i+wVSy+eQxDFJ3@sirena.org.uk>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <Y/i+wVSy+eQxDFJ3@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static int tps6594_get_rdev_by_name(const char *regulator_name,
>> +				    struct regulator_dev *rdevbucktbl[BUCK_NB],
>> +				    struct regulator_dev *rdevldotbl[LDO_NB],
>> +				    struct regulator_dev *dev)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i <= BUCK_NB; i++) {
>> +		if (strcmp(regulator_name, buck_regs[i].name) == 0) {
>> +			dev = rdevbucktbl[i];
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	for (i = 0; i < ARRAY_SIZE(ldo_regs); i++) {
>> +		if (strcmp(regulator_name, ldo_regs[i].name) == 0) {
>> +			dev = rdevldotbl[i];
>> +			return 0;
>> +		}
>> +	}
>> +	return -EINVAL;
>> +}
> 
>> +	for (i = 0; i < ARRAY_SIZE(tps6594_regulator_irq_types); ++i) {
>> +		irq_type = &tps6594_regulator_irq_types[i];
>> +
>> +		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
>> +		if (irq < 0)
>> +			return -EINVAL;
>> +
>> +		irq_data[i].dev = tps->dev;
>> +		irq_data[i].type = irq_type;
>> +
>> +		tps6594_get_rdev_by_name(irq_type->regulator_name, rdevbucktbl,
>> +					 rdevldotbl, rdev);
> 
> This would be simpler and you wouldn't need this lookup function if the
> regulator descriptions included their IRQ names, then you could just
> request the interrupts while registering the regulators.
I changed the code to follow your recommendations then now in case of a 
multiphase buck, only one set of interrupt is requested.
ex: multiphase buck1234 single buck5
cat /proc/interrupts:
563:          0          0  tps6594-0-0x4c   0 Edge      buck1_ov
564:          0          0  tps6594-0-0x4c   1 Edge      buck1_uv
565:          0          0  tps6594-0-0x4c   2 Edge      buck1_sc
566:          0          0  tps6594-0-0x4c   3 Edge      buck1_ilim
579:          0          0  tps6594-0-0x4c  16 Edge      buck5_ov
580:          0          0  tps6594-0-0x4c  17 Edge      buck5_uv
581:          0          0  tps6594-0-0x4c  18 Edge      buck5_sc
582:          0          0  tps6594-0-0x4c  19 Edge      buck5_ilim

buck2, buck3, buck4 are not associated to a regulator device because 
buck1 registers control all the multiphase bucks (only one logic 
regulator). Consequently the mapping for the associated interrupts does 
not occur.
I'm not sure it's the right option.
Do you suggest to keep it like that for multiphase?
Is it better to request all the interrupts anyway and map it to the same 
rdev?

> 
>> +		error = devm_request_threaded_irq(tps->dev, irq, NULL,
>> +						  tps6594_regulator_irq_handler,
>> +						  IRQF_ONESHOT,
>> +						  irq_type->irq_name,
>> +						  &irq_data[i]);
>> +		if (error) {
>> +			dev_err(tps->dev, "failed to request %s IRQ %d: %d\n",
>> +				irq_type->irq_name, irq, error);
>> +			return error;
>> +		}
> 
> This leaks all previously requested interrupts.
I'm not sure to understand this sentence correctly. You mean all the 
interrupts already requested are still allocated after the error occurs?
