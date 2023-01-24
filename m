Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245EF679D02
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjAXPKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjAXPKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:10:02 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DCA4A1ED
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:09:48 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t18so1370826wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bd7QOS6DKQNvC+u0Ay2yK9OLDkUOBEv/PXTWAR2BBBM=;
        b=uQujS7Lb/d8GruUmQRDuEQniQPoaVA1Bue2lzduwBpvn9y5qiBepZ04DLH4S++hCO/
         v0dfmjIKlKVT+qHGTnGDPfL/zog/atFMKIwaq7F4MNVmmx8rHwb7sg0gWMZ05SK2MCfU
         E35HnauqPSRCqlIAQb4e8jek6nmkK2Zka6e2c5CboM9qTYyQkKyL0v/LfSJFm+rQyctX
         pg8dy1o1MXGQVftjW5pmF4eAdnwKS/wV2WqwbBRC+/GKQjmQ/lbLDRU2S+R78xs0nAgD
         HL0dskJh1CNqjtgu+sZCqPnY9TRC2FAWnjIWgWKGil1CYQydhefziT36iRjZQ3Pkrr8q
         2LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bd7QOS6DKQNvC+u0Ay2yK9OLDkUOBEv/PXTWAR2BBBM=;
        b=YphUlvmXLwLDoNqB3X+6kSA1OMBtKFaUClnMly7pOlM+wKmEbKq1CFca3jgCux+eNJ
         6PFxEuG+FIa7KHfXz3t+s5IeajP/sJxT8q1H3E8tSenHs7GgKN8ftYQb7FZLyIZ/r4Cc
         JcsPVPv2Ol7cT4fJztJuc3dP1JPVyoUwOhemferpjlu7LbeimMjMkFs4kXe7h39mjPMn
         ARxUeSL5EXxuz01qO7W69aRi5cIhAh71IKFzsd5+ic5ysPemTw0Op1Ks3DToQ5+lyjLo
         gCqw1T4ylTsgLjqfLw661lljzyho6ckMOsK5HtZTWoDsTly3/LCqqDg+u4kB4aJwpsTZ
         m+VQ==
X-Gm-Message-State: AFqh2kprKwIV62synxf5DxI/px62uhHDSz0ztde5+XmybgnETdRQMDUv
        QYjxw8w74T80BupGoA1ZHyDg4nDMdO5LGXg9
X-Google-Smtp-Source: AMrXdXuc/zx2xSMvHW7hkFLFb09tioxWpLyLzKdpmMKXs1CBsxLR9q9g0BwnxuyCYKDy1ki6ArsXmw==
X-Received: by 2002:a5d:5949:0:b0:2bb:ea1d:e36e with SMTP id e9-20020a5d5949000000b002bbea1de36emr23455035wri.15.1674572986894;
        Tue, 24 Jan 2023 07:09:46 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g9-20020adfa489000000b002b065272da2sm2180246wrb.13.2023.01.24.07.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 07:09:46 -0800 (PST)
Message-ID: <94176a1b-f9ad-b096-fc39-5e333f4eb09f@linaro.org>
Date:   Tue, 24 Jan 2023 16:09:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 2/2] hwmon: (pmbus/tda38640) Add driver for Infineon
 TDA38640 Voltage Regulator
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20230124144847.423129-1-Naresh.Solanki@9elements.com>
 <20230124144847.423129-2-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124144847.423129-2-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 15:48, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add the pmbus driver for the Infineon TDA38640 voltage regulator.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---

(...)

> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regulator/driver.h>
> +#include "pmbus.h"
> +
> +static const struct regulator_desc __maybe_unused tda38640_reg_desc[] = {
> +	PMBUS_REGULATOR("vout", 0),
> +};
> +
> +static struct pmbus_driver_info tda38640_info = {
> +	.pages = 1,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_POWER] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
> +	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
> +	    | PMBUS_HAVE_IIN
> +	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
> +	    | PMBUS_HAVE_POUT | PMBUS_HAVE_PIN,
> +#if IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR)
> +	.num_regulators = 1,
> +	.reg_desc = tda38640_reg_desc,
> +#endif
> +};
> +
> +static int tda38640_probe(struct i2c_client *client)
> +{
> +	return pmbus_do_probe(client, &tda38640_info);
> +}
> +
> +static const struct i2c_device_id tda38640_id[] = {
> +	{"tda38640", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, tda38640_id);
> +
> +static const struct of_device_id __maybe_unused tda38640_of_match[] = {
> +	{ .compatible = "infineon,tda38640"},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, tda38640_of_match);

No improvements here. Do not send new version without solving the
feedback (or finishing the discussion). Its usage is still missing in
your i2c_driver.

Best regards,
Krzysztof

