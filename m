Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8718A729F00
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241428AbjFIPqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjFIPqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:46:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947273586
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:46:36 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b1a86cdec6so21263131fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686325595; x=1688917595;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CsymM+sZ3qbYclB4M5H6X6tKIPBYp8xhsDNrjslRkGA=;
        b=U0R15ttGv/TbjJ/B0vIXcPj2HSXCDddhALpM01VZFZQTSUX/D+s7Ehb/WdfHwXH6Lx
         VVA5/zt+L6jd1UrKxu/koUhE7WKHHaMNKpruaUwQk7ELsOvZTCS5cJZmD2JEl1TMomI4
         wlWYjgUVgX0TMvBj49rT8ipW6imBtR6LNkDvKEQQ5cTdk3hH4yYDETtRAb3pLLo74baL
         QEGwXfrVHhuyCjVWf5WjSwPeDvHlFZcKTx6PoH55pi4fwThFNo/PoAd0UEse6X4/pc30
         5jm0ZR8uVHdIaKH0Bm/Xav7bIzsZPjrLKkm7v5OywhVgXxKdjSl6+vprnrBK3n4mrbDS
         vGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686325595; x=1688917595;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CsymM+sZ3qbYclB4M5H6X6tKIPBYp8xhsDNrjslRkGA=;
        b=Bc4cjufXlVWCxC2lbtQvBBH4ihZzi5sv2MN8qGmCrliRQESl2QHx4aKgyL1kWTGSDQ
         Z9eODnOTBQUuYKg9FVHbPPaPdTwZ5hD+jzwCijkqGHHik5XZBFFeHJylWryPL+Ucz6Sy
         LD6qIdnLFdIO0AXSTG2oafamORkViq3BvfLYmm1jG8m0v8CSP6nyN7HnuKF4NOrjjV8P
         Pa73Z9B+mrcQXxgT4sxqLgqD+Xzrl+AVK6FSl6Frg9USoocVZQRRFFNITPntbCATfyWR
         Q+0nHMXwCkP/5L+PQihBOUeAFk3jk7jjQxfZCgopCrYnC1gm7pmAt4G5vkJ0wVNOOgGf
         fm3Q==
X-Gm-Message-State: AC+VfDyJ+9st/OkH99gshyZ4bs4m6WL8mXjE/M1rNCiImBKtWbwcBdlx
        Fl3l7SSVHLqXiq8v04sAuJmQwg==
X-Google-Smtp-Source: ACHHUZ6H7GAfgliIQ7vuLHDItb52P6CVINhTdC1Q32aXlHSelmdJ38e92Lqf8weZj9+3H/UIebQ3Ig==
X-Received: by 2002:a2e:a402:0:b0:2b1:b301:e650 with SMTP id p2-20020a2ea402000000b002b1b301e650mr1433992ljn.1.1686325594809;
        Fri, 09 Jun 2023 08:46:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id l14-20020aa7c30e000000b00514b0f6a75esm1869455edq.97.2023.06.09.08.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:46:34 -0700 (PDT)
Message-ID: <e2bb439c-9b72-991b-00f6-0b5e7602efd9@linaro.org>
Date:   Fri, 9 Jun 2023 17:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/2] NFC: nxp-nci: Add pad supply voltage pvdd-supply
Content-Language: en-US
To:     Raymond Hackley <raymondhackley@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230609154033.3511-1-raymondhackley@protonmail.com>
 <20230609154200.3620-1-raymondhackley@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609154200.3620-1-raymondhackley@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 17:42, Raymond Hackley wrote:
> PN547/553, QN310/330 chips on some devices require a pad supply voltage
> (PVDD). Otherwise, the NFC won't power up.
> 
> Implement support for pad supply voltage pvdd-supply that is enabled by
> the nxp-nci driver so that the regulator gets enabled when needed.
> 
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> ---
>  drivers/nfc/nxp-nci/i2c.c | 42 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
> index d4c299be7949..1b8877757cee 100644
> --- a/drivers/nfc/nxp-nci/i2c.c
> +++ b/drivers/nfc/nxp-nci/i2c.c
> @@ -35,6 +35,7 @@ struct nxp_nci_i2c_phy {
>  
>  	struct gpio_desc *gpiod_en;
>  	struct gpio_desc *gpiod_fw;
> +	struct regulator *pvdd;
>  
>  	int hard_fault; /*
>  			 * < 0 if hardware error occurred (e.g. i2c err)
> @@ -263,6 +264,22 @@ static const struct acpi_gpio_mapping acpi_nxp_nci_gpios[] = {
>  	{ }
>  };
>  
> +static void nxp_nci_i2c_poweroff(void *data)
> +{
> +	struct nxp_nci_i2c_phy *phy = data;
> +	struct device *dev = &phy->i2c_dev->dev;
> +	struct regulator *pvdd = phy->pvdd;
> +	int r;
> +
> +	if (!IS_ERR(pvdd) && regulator_is_enabled(pvdd)) {

Why do you need these checks? This should be called in correct context,
so when regulator is valid and enabled. If you have such checks it
suggests that code is buggy and this is being called in wrong contexts.

> +		r = regulator_disable(pvdd);
> +		if (r < 0)
> +			dev_warn(dev,
> +				 "Failed to disable regulator pvdd: %d\n",
> +				 r);

Weird wrapping. Why r is wrapped?

> +	}
> +}
> +
>  static int nxp_nci_i2c_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -298,6 +315,29 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
>  		return PTR_ERR(phy->gpiod_fw);
>  	}
>  
> +	phy->pvdd = devm_regulator_get_optional(dev, "pvdd");
> +	if (IS_ERR(phy->pvdd)) {
> +		r = PTR_ERR(phy->pvdd);
> +		if (r != -ENODEV)
> +			return dev_err_probe(dev, r,
> +					     "Failed to get regulator pvdd\n");
> +	} else {
> +		r = regulator_enable(phy->pvdd);
> +		if (r < 0) {
> +			nfc_err(dev,
> +				"Failed to enable regulator pvdd: %d\n",
> +				r);

Weird wrapping. Why r is wrapped?

> +			return r;
> +		}
> +	}
> +
> +	r = devm_add_action_or_reset(dev, nxp_nci_i2c_poweroff, phy);
> +	if (r < 0) {
> +		nfc_err(dev, "Failed to install poweroff handler: %d\n",
> +			r);

Weird wrapping. Why r is wrapped?

Just move it to the success path of enabling regulator.


> +		return r;
> +	}
> +
>  	r = nxp_nci_probe(phy, &client->dev, &i2c_phy_ops,
>  			  NXP_NCI_I2C_MAX_PAYLOAD, &phy->ndev);
>  	if (r < 0)
> @@ -319,6 +359,8 @@ static void nxp_nci_i2c_remove(struct i2c_client *client)
>  
>  	nxp_nci_remove(phy->ndev);
>  	free_irq(client->irq, phy);
> +
> +	nxp_nci_i2c_poweroff(phy);

Why? This code is buggy...



Best regards,
Krzysztof

