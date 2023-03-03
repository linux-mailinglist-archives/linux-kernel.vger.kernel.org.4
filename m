Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2189C6A9A26
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjCCPCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCCPCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:02:36 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C418E11670
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:02:34 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so3534140wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnIOnNRt4JVqThxM0+CX1uQMFZb/6/ZcZPc0zJV+qsU=;
        b=1NTWDe3nj/7cYwGHxGT/1Dv3jcXKmlBfvIB7ZFF6Eukp99/Q5f0jc8s+NWoEr02K9z
         73ZyzmWFH+oTrMBPqkcFdHeo4ZIzZPq59uwtXr5K3wHjOeRMEmB++/fj/wKllZGu6mWj
         tcFJUkFUrOOzZ+2NOLRqjDcrUaYVSCn5xLMSTmA5SxeU5GPflswIBAamOXkb4geXBQuz
         C7a+CoxZ9NrJZI9Ty+ZUQtfLgKzzLppVi7jK8IUmrDqOTRitSvRQpPkmAfIJsUoz1za8
         c2n9+U6I3II8LgJpwJBMMXqnlXbMDih7kpp1egeT9hwcdRJFX7++gZH45w5o43ywgNAb
         3AsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnIOnNRt4JVqThxM0+CX1uQMFZb/6/ZcZPc0zJV+qsU=;
        b=4ojjp+MpH9b3MznkIfNohPcMjSGat5Wo1AcjrddBTb7LSkAxNQLH1c8X6dDxP+/Q9E
         IPlyCWU5WjANlr2Segb+oGhFB2vNUG5/hWR4dW5SavyfI4d4RWEtyDcIRtBI03dMTEDp
         CfTsPGfjUdL7dg1CXXbatdAfXM92rPhkeN2gUJ7OQ6dD0el6jSa/RkZZTKLnV5LWGnxK
         r5i6+H9nZGyWYLR2SL14ZQNP/yIrY+eeqZTFYorfnCjwsjAlHVqHaBrg4mU7A4plkEQ+
         FvbzUHMF6X1s5BmitDnhP4V+aYjEeqVBkyWCsqiz/6bT6NV33Bnj+CHkYvdCW4YGmFXe
         VssA==
X-Gm-Message-State: AO0yUKU63CapItXwOgvtnZweN2iqJNmEmbRG/v3tWov2KMgSJUD2aOcE
        gxEEz8oLsDAZ3lvcLvbsZiHy7A==
X-Google-Smtp-Source: AK7set/Hs0IS13V87cGQUUtuXtDk4qY0YBJ62x3fonEQK7SCQA+YAxhfYlZ/z74YwVIR7QT2byQv1w==
X-Received: by 2002:a05:600c:444c:b0:3dc:16d2:ae5e with SMTP id v12-20020a05600c444c00b003dc16d2ae5emr1980396wmn.32.1677855753191;
        Fri, 03 Mar 2023 07:02:33 -0800 (PST)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id hu21-20020a05600ca29500b003eaee9e0d22sm2617183wmb.33.2023.03.03.07.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 07:02:32 -0800 (PST)
Message-ID: <377c6c53-e2f1-cb0d-c4d5-611efccf9717@baylibre.com>
Date:   Fri, 3 Mar 2023 16:02:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/02/2023 14:42, Mark Brown wrote:
> On Fri, Feb 24, 2023 at 02:31:29PM +0100, Esteban Blanc wrote:
>> From: Jerome Neanne <jneanne@baylibre.com>
>>
>> This patch adds support for TPS6594 regulators (bucks and LDOs).
>> The output voltages are configurable and are meant to supply power
>> to the main processor and other components.
>> Bucks can be used in single or multiphase mode, depending on PMIC
>> part number.
>>
>> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
>> ---
> 
> You've not provided a Signed-off-by for this so I can't do anything with
> it, please see Documentation/process/submitting-patches.rst for details
> on what this is and why it's important.
> 
I did this patch but Esteban sent the whole patch-list. The sign-off has 
not been updated accordingly. Sorry for disturbance. We'll fix that.
>> @@ -0,0 +1,559 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Regulator driver for tps6594 PMIC
>> + *
>> + * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
> 
> Please make the entire comment block a C++ one so things look more
> intentional.
> 
>> +static unsigned int tps6594_get_mode(struct regulator_dev *dev)
>> +{
>> +	return REGULATOR_MODE_NORMAL;
>> +}
> 
> If configuring modes isn't supported just omit all mode operations.
> 
>> +	}
>> +
>> +	regulator_notifier_call_chain(irq_data->rdev,
>> +				      irq_data->type->event, NULL);
>> +
>> +	dev_err(irq_data->dev, "Error IRQ trap %s for %s\n",
>> +		irq_data->type->event_name, irq_data->type->regulator_name);
> 
> I suspect it might avoid future confusion to log the error before
> notifying so that any consequences of the error more clearly happen in
> response to the error.
> 
I'll rework all that section for v2 following your recommendations
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
Thanks for your time and precious feedback.
