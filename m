Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377A664E9B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiLPKrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiLPKqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:46:53 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0651A22D;
        Fri, 16 Dec 2022 02:46:47 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id l8-20020a056830054800b006705fd35eceso1113782otb.12;
        Fri, 16 Dec 2022 02:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oPlRWJtPy91L2Kb6SEIniDa6SrU81qnAi/g/vSFbNsQ=;
        b=ME2uhQai/+euu8mQ4vyc/earfOT9jmZQmAZeXUs8hcziF9Fntemu6Y3+ksK5UJg4XS
         mkZbMONyhEEI2y09byESqme/VJyPvVFh/TkR85wNIVhiXQWs0RSiW0AveqiiSVyk1gYb
         PQU7EY1FINMqf9T8Pn+huelj75jafey/DLYs+wqEQ/oQy7Whc4rpwfo3SSiEGkMAq83s
         Dusy3DvPNwE0GemyrLu8mXJaMopO8OaW3X4Vkqw0yltrWyPRAwOJxFYBIslY1FCyJaSz
         ObwwqhxxcwaE/uXck8NzaIRzqHDazaVHHZZqGDZPC8mRrTY5m2ndnO5BNBYVDKih3r9h
         BTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPlRWJtPy91L2Kb6SEIniDa6SrU81qnAi/g/vSFbNsQ=;
        b=FWgOfIbMSX9k8rENKq/qv4jf4T2Ca3wZ4Jga2gVPiiK3IODlNg2rh0XH5+lpXYBhQB
         4ilzsUdrl0xuQFvmQSOyZttI4Gy1Mnm0z2MqBUKMTm+ecwHJnc9NWquF6VHfCwoWsYWb
         Iaeytr4dqwTiLt4CcRjyMOP11GUT6N77BunCdkrS9B0AHg0zX6bybKDtiLg6wTBD46zl
         EKtcTyVmGelu87SfmbQccH3BbDEvXnGP23KzwSegAGp4wFaejuAgSDUxdJPRZ//9yVdX
         toauzeD8DS00QhrJr3N25pNHOEw1wYhazSSFs+pS2gqcYEhu9uDIGaB19FG0Z5HDZv70
         3Yfg==
X-Gm-Message-State: ANoB5plaV11HmDdKnXeP0tyHtBDgMROJyMcG4U2B/8SCCmu2y3kokdOY
        nmJ5WvY/4sXDGusJ8eEkUJEJ4LEr+I0=
X-Google-Smtp-Source: AA0mqf5IJlMBz37NI7a6lgVDCMdTBWv3aS78FXayzJ2k8xCRtqj1wzK616pZkEOh1agAh8rZ0+vh9Q==
X-Received: by 2002:a05:6830:1b7b:b0:670:92b7:366b with SMTP id d27-20020a0568301b7b00b0067092b7366bmr10518929ote.2.1671187606803;
        Fri, 16 Dec 2022 02:46:46 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v15-20020a05683018cf00b0066c3bbe927esm657493ote.21.2022.12.16.02.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 02:46:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <efe041a2-8d5b-f06a-73b8-3151b0a33004@roeck-us.net>
Date:   Fri, 16 Dec 2022 02:46:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] watchdog: da9062: da9063: use unlocked xfer function in
 restart
Content-Language: en-US
To:     Primoz Fiser <primoz.fiser@norik.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     upstream@lists.phytec.de
References: <20221216083645.2574077-1-primoz.fiser@norik.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221216083645.2574077-1-primoz.fiser@norik.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/22 00:36, Primoz Fiser wrote:
> Machine resets via da9062/da9063 PMICs are challenging since one needs
> to use special i2c atomic transfers due to the fact interrupts are
> disabled in such late system stages. This is the reason both PMICs don't
> use regmap and have instead opted for i2c_smbus_write_byte_data() in
> restart handlers.
> 
> However extensive testing revealed that even using atomic safe function
> is not enough and occasional resets fail with error message "Failed to
> shutdown (err =  -11)". This is due to the fact that function
> i2c_smbus_write_byte_data() in turn calls __i2c_lock_bus_helper()
> which might fail with -EAGAIN when bus lock is already taken and cannot
> be released anymore.
> 
> Thus replace i2c_smbus_write_byte_data() with unlocked flavor of
> i2c_smbus_xfer() function to avoid above dead-lock scenario. At this
> system stage we don't care about proper locking anymore and only want
> proper machine reset to be carried out.
> 
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/da9062_wdt.c | 15 ++++++++++++---
>   drivers/watchdog/da9063_wdt.c | 15 ++++++++++++---
>   2 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index f02cbd530538..1ec33b4bd2f2 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -155,11 +155,20 @@ static int da9062_wdt_restart(struct watchdog_device *wdd, unsigned long action,
>   {
>   	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
>   	struct i2c_client *client = to_i2c_client(wdt->hw->dev);
> +	union i2c_smbus_data msg;
>   	int ret;
>   
> -	/* Don't use regmap because it is not atomic safe */
> -	ret = i2c_smbus_write_byte_data(client, DA9062AA_CONTROL_F,
> -					DA9062AA_SHUTDOWN_MASK);
> +	/*
> +	 * Don't use regmap because it is not atomic safe. Additionally, use
> +	 * unlocked flavor of i2c_smbus_xfer to avoid scenario where i2c bus
> +	 * might be previously locked by some process unable to release the
> +	 * lock due to interrupts already being disabled at this late stage.
> +	 */
> +	msg.byte = DA9062AA_SHUTDOWN_MASK;
> +	ret = __i2c_smbus_xfer(client->adapter, client->addr, client->flags,
> +			I2C_SMBUS_WRITE, DA9062AA_CONTROL_F,
> +			I2C_SMBUS_BYTE_DATA, &msg);
> +
>   	if (ret < 0)
>   		dev_alert(wdt->hw->dev, "Failed to shutdown (err = %d)\n",
>   			  ret);
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> index 09a4af4c58fc..684667469b10 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -174,11 +174,20 @@ static int da9063_wdt_restart(struct watchdog_device *wdd, unsigned long action,
>   {
>   	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
>   	struct i2c_client *client = to_i2c_client(da9063->dev);
> +	union i2c_smbus_data msg;
>   	int ret;
>   
> -	/* Don't use regmap because it is not atomic safe */
> -	ret = i2c_smbus_write_byte_data(client, DA9063_REG_CONTROL_F,
> -					DA9063_SHUTDOWN);
> +	/*
> +	 * Don't use regmap because it is not atomic safe. Additionally, use
> +	 * unlocked flavor of i2c_smbus_xfer to avoid scenario where i2c bus
> +	 * might previously be locked by some process unable to release the
> +	 * lock due to interrupts already being disabled at this late stage.
> +	 */
> +	msg.byte = DA9063_SHUTDOWN;
> +	ret = __i2c_smbus_xfer(client->adapter, client->addr, client->flags,
> +			I2C_SMBUS_WRITE, DA9063_REG_CONTROL_F,
> +			I2C_SMBUS_BYTE_DATA, &msg);
> +
>   	if (ret < 0)
>   		dev_alert(da9063->dev, "Failed to shutdown (err = %d)\n",
>   			  ret);

