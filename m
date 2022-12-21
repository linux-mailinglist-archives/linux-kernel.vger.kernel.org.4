Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE9E652EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiLUJx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiLUJwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:52:42 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38B12338B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:49:25 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id s10so15098167ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4pOTa7XD14Zbi1zXxlhwo2uq1WAQLtH0H1dvVBr/wM=;
        b=TatoTF6KDCty9jYvwLHt8LUJBG4EfDHIWY7OIX8gecMCtklkbUY83XvdqNexPWzVHh
         7aHcj6cell6x9syMMMUvBbd8IhMjN1Ix2O2vsj7WocOoSuFZ648iIhqPZhcTYevUeYdq
         6oxyrVV/PxZazRP/iKy3JHVjRKyCE5XANvaaI2OcyddGsO58OUrq7Z5T494E2mOB2uqA
         F1ga1FNHs+RVzr2KiNpV9JxdgiuANgeWGzt978v2rBbuOVX9+jVyPWqwofW5nJEl0mFc
         2/TqloOr9Aav3Y6Y0mHnlbIVWq9I0gPrYXhF+V/yZ9FLrz0NcxH3wTQIHdsKqLB1okOk
         uYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4pOTa7XD14Zbi1zXxlhwo2uq1WAQLtH0H1dvVBr/wM=;
        b=zYR7+ha4DMJCFgkRk6JRIjsjqBThaZjEBnFCEb+UAY64PI8qHOAwrTIV/lMnDQaU3f
         YEiX2IMoolx/UJoJGdlRy2Ly4KVOqX5w8tVDki2HgGofxyL/pvxLnKangRaHvUe6QFjk
         1G9Sgqv9FxnB/0auB3OQ6ZPp37pfCcZyxkluu0YnL1GF3n1+I/0UvKzgXJkumyUg/5M0
         hK9ERmW1ljM8c+yVPJYJV3/w9fSZyP99cTcH1RZ8Tr0f5qLdHH3f5nu0t2xXramynI9t
         4eBXRT+TcG4AUIIf3guMvdhbFtZ8mxCeZbOOVH+voeiUWHY/4NKDlpyq1VDCoFaK0Z5e
         53bA==
X-Gm-Message-State: AFqh2krVpGbw1OZHzzFDtcSJcbaQ4Me7GTHzAX7mvD32U8ioI5Jn6qhM
        Yu0FtguqUqph6eMsoUMs8WBCzA==
X-Google-Smtp-Source: AMrXdXssO9jKbgSHpDGsWvD2A8uvCkDgxTfqEYUdI6PAsmQUFbP3WJ19muNo/XTSwSkvzcwBi9mWuw==
X-Received: by 2002:a2e:bc87:0:b0:27f:6978:583f with SMTP id h7-20020a2ebc87000000b0027f6978583fmr419058ljf.44.1671616164053;
        Wed, 21 Dec 2022 01:49:24 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g5-20020a2eb5c5000000b00279a7266874sm1273754ljn.98.2022.12.21.01.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 01:49:23 -0800 (PST)
Message-ID: <05aaa9f8-7a97-51c9-e18a-1c3753f2006b@linaro.org>
Date:   Wed, 21 Dec 2022 10:49:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/3] hwrng: starfive - Add TRNG driver for StarFive SoC
Content-Language: en-US
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20221221090819.1259443-1-jiajie.ho@starfivetech.com>
 <20221221090819.1259443-3-jiajie.ho@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221221090819.1259443-3-jiajie.ho@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 10:08, Jia Jie Ho wrote:
> This adds driver support for the hardware random number generator in
> Starfive SoCs and adds StarFive TRNG entry to MAINTAINERS.
> 
> Co-developed-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> Signed-off-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> ---
>  MAINTAINERS                            |   6 +
>  drivers/char/hw_random/Kconfig         |  11 +
>  drivers/char/hw_random/Makefile        |   1 +
>  drivers/char/hw_random/starfive-trng.c | 403 +++++++++++++++++++++++++
>  4 files changed, 421 insertions(+)
>  create mode 100644 drivers/char/hw_random/starfive-trng.c
> 

(...)

> +static const struct of_device_id trng_dt_ids[] = {
> +	{ .compatible = "starfive,jh7110-trng" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, trng_dt_ids);
> +
> +static struct platform_driver starfive_trng_driver = {
> +	.probe	= starfive_trng_probe,
> +	.driver	= {
> +		.name		= "starfive-trng",
> +		.pm		= &starfive_trng_pm_ops,
> +		.of_match_table	= of_match_ptr(trng_dt_ids),

of_match_ptr goes with __maybe_unused. You will have now warnings, so
please test more your patches (W=1, sparse, smatch).

Best regards,
Krzysztof

