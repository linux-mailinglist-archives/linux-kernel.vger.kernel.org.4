Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBFC7267B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjFGRpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjFGRpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:45:30 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842D51BF1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:45:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977cf86aae5so663532966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686159928; x=1688751928;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XxW7nL1eX+5FPRhCjmj+SIcQXT7uzv8fsXCgUREBOYE=;
        b=h+WNrdFjmAPyVmqrl8m06KrDelxGtj1GSTDfB/twyaXrpxG6yqmU66LdrIetvsYISp
         sA9FEJzoVdtnhzpqi8sOobRNTCQPLFriZotutmc715DsCfT6eQAxvh5+GSJv84tJClI2
         OwbuhfXOGzh0GKTHoy2Cxyv3g9lpuRbXtqEaCmVqw5140X4GyA1PK6HaESkXRWjk6++L
         P5keTkiX+nfGbepPwf7M9P4GvAFrdP3TMKxFIFpA9lwej4lmo0vllg8qW82drcKdsS7Y
         Go/ornv/aeCZOMNnHHikB2XLvp8ZYlZTz+G4ygyNTh92CIu91S7/SEThMGCWIhxE7RoE
         dgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686159928; x=1688751928;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxW7nL1eX+5FPRhCjmj+SIcQXT7uzv8fsXCgUREBOYE=;
        b=jczBReg/2ouykGmQpyI4Ye5oCj/+kRNDY2p1SaEor9TJ+zhknltJN0cF47qUTo82Cr
         lPKnuMQIMRvgBYwqHyv8a0IFiPEOqjLVKWAYrG7HyTYKiStZUG8VQkUgTRcD28kLLxZn
         LPKabzCDta7cjl+hxyjpqqrn/n0tULUeXtrA2eU/GBJrpIjBZO2YY8z+NK6ZldxIv1zb
         ZST/B9CWuHOal54qtW5EAnuGOjjuw72mOPjW9IA85nZnsSUTvPrKzRQ2N1CRamp2hSXD
         VqbkMJWQE3mN8kHgdhFd1eqba9llxwpFSEaEdiJmoNBP9MQV3/0aP6z1vYxEAh0Qm/7T
         Y/Wg==
X-Gm-Message-State: AC+VfDxsg7s05NE0JMj+8qo3TVLzNrS1pnh1tGKoZDHFyhAObg0kvzid
        cGuhZwHq22kbWiVIEe8vuR31aA==
X-Google-Smtp-Source: ACHHUZ4d0RVijM4MVpNsN1YOU7p+/14qoJL+ZVESbUW9GjbNKGL+J88JvOW+Wq1xlX80s7JUZaA/fQ==
X-Received: by 2002:a17:907:60d4:b0:96f:5747:a0de with SMTP id hv20-20020a17090760d400b0096f5747a0demr6189489ejc.6.1686159927910;
        Wed, 07 Jun 2023 10:45:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906260f00b00977e6992962sm3621333ejc.106.2023.06.07.10.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 10:45:27 -0700 (PDT)
Message-ID: <07b33c1e-895e-d7d7-a108-0ee5f2812ffa@linaro.org>
Date:   Wed, 7 Jun 2023 19:45:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC net 1/2] nfc: nxp-nci: Fix i2c read on ThinkPad
 hardware
Content-Language: en-US
To:     Marco Giorgi <giorgi.marco.96@disroot.org>, netdev@vger.kernel.org
Cc:     u.kleine-koenig@pengutronix.de, davem@davemloft.net,
        michael@walle.cc, kuba@kernel.org, linux-kernel@vger.kernel.org
References: <20230607170009.9458-1-giorgi.marco.96@disroot.org>
 <20230607170009.9458-2-giorgi.marco.96@disroot.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607170009.9458-2-giorgi.marco.96@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 19:00, Marco Giorgi wrote:
> Add the IRQ GPIO configuration.

Why? Please include reasons in commit msg. What you are doing is quite
easy to see.

> 
> Signed-off-by: Marco Giorgi <giorgi.marco.96@disroot.org>
> ---
>  drivers/nfc/nxp-nci/i2c.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
> index d4c299be7949..4ba26a958258 100644
> --- a/drivers/nfc/nxp-nci/i2c.c
> +++ b/drivers/nfc/nxp-nci/i2c.c
> @@ -35,6 +35,7 @@ struct nxp_nci_i2c_phy {
>  
>  	struct gpio_desc *gpiod_en;
>  	struct gpio_desc *gpiod_fw;
> +	struct gpio_desc *gpiod_irq;
>  
>  	int hard_fault; /*
>  			 * < 0 if hardware error occurred (e.g. i2c err)
> @@ -254,10 +255,12 @@ static irqreturn_t nxp_nci_i2c_irq_thread_fn(int irq, void *phy_id)
>  	return IRQ_NONE;
>  }
>  
> +static const struct acpi_gpio_params irq_gpios = { 0, 0, false };
>  static const struct acpi_gpio_params firmware_gpios = { 1, 0, false };
>  static const struct acpi_gpio_params enable_gpios = { 2, 0, false };
>  
>  static const struct acpi_gpio_mapping acpi_nxp_nci_gpios[] = {
> +	{ "irq-gpios", &irq_gpios, 1 },
>  	{ "enable-gpios", &enable_gpios, 1 },
>  	{ "firmware-gpios", &firmware_gpios, 1 },
>  	{ }
> @@ -286,6 +289,12 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
>  	if (r)
>  		dev_dbg(dev, "Unable to add GPIO mapping table\n");
>  
> +	phy->gpiod_irq = devm_gpiod_get(dev, "irq", GPIOD_IN);

Bindings do not allow it. Please update bindings... or not, because they
clearly state that interrupts are already there.

You need to explain what is this.



Best regards,
Krzysztof

