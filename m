Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E1F613B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiJaQdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiJaQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:33:02 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6FB12639;
        Mon, 31 Oct 2022 09:33:02 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13bd2aea61bso14083304fac.0;
        Mon, 31 Oct 2022 09:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRI+o3ilNy6BRglFYtPBCSjFHSotex4sZhj80mY7+B0=;
        b=SVnTcl1lpn+/Zo4KZExQ/xtmB3FX28WGvVRwEEmM6Y3UXVdM0216wEGIrQDVlrE3i6
         GkUUpddq2+YYaoFMAhlNlOi/+cJAeDbKWhWUaswhq6ToTVgg1iI+EtlZryDuiLzfW7Ex
         4JOZYW4yggUC3BKOfTGwrR0iP2Qk5z4fXwZ3UM1xGZD+LMT65s8Q7yxehkxMVHYrNrtz
         boaIBC4c7PUqZjGrnJjVtxrVIfeLmB0t0qcCAWFWQDiZT6f982KRMe/Bg2nMWOGwOuV/
         0lUKhMCp/NrLIAbpN1alBTuXkQzSydemuGwMRi3lgRSrCWBYOnU0Uuq3OdTKYX5+JP4N
         5HyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRI+o3ilNy6BRglFYtPBCSjFHSotex4sZhj80mY7+B0=;
        b=38K/uNdClHMVYou1ZFkSUfqWFZLiRbmaIEygwRWXDo+dxeNAl+nSUBeMXl1h/eDP6L
         XrIDfOOCVWGRZtzMiOnfmV2urwug1H14NBQRJry5RW98C9vCm6P/f+1Xr/ryFI3aTd9b
         NMEpPxN/27/WCat/9mRbEgrVR5QRBSq3tfH0EJhE+7saciejYyyfa060MWKjLEX0Q6rO
         VubZ7Iizw04Az1saLRM1xVrWjNOrJevxjPYn1pImsnBT9kUuAEhSyxRkjBAAA32E+5M4
         0TAf+Mo+lq96U1rF98yW6JiaRLNRVKQaSuhXvi/YHQulgU77pY/69tt9hdy8vsIn4y5P
         ieig==
X-Gm-Message-State: ACrzQf1zwi1FLn79VMDmhrsCdaf5zhEyu1m9le5wvuWhrMTFJJLGRjzP
        Qma+KPdYh/a1EuTLL8qfpZM=
X-Google-Smtp-Source: AMsMyM6kBoxiwO1Uv/nlw9plsMsl+O0fwtUzFqGcwTVvhEfCG4duaw0GKD/w5pVjpjUH0wYosdkUVA==
X-Received: by 2002:a05:6870:8883:b0:13b:61ac:a5d4 with SMTP id m3-20020a056870888300b0013b61aca5d4mr7754751oam.75.1667233981127;
        Mon, 31 Oct 2022 09:33:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d17-20020a4aa591000000b004762a830156sm2491672oom.32.2022.10.31.09.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:33:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 31 Oct 2022 09:32:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, lee.jones@linaro.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com,
        garnermic@meta.com
Subject: Re: [PATCH 3/3] hwmon: Add Aspeed ast2600 TACH support
Message-ID: <20221031163258.GC2462187@roeck-us.net>
References: <20221031103809.20225-1-billy_tsai@aspeedtech.com>
 <20221031103809.20225-4-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031103809.20225-4-billy_tsai@aspeedtech.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 06:38:08PM +0800, Billy Tsai wrote:
> This patch add the support of Tachometer which can use to monitor the
> frequency of the input. The tach supports up to 16 channels and it's part
> function of multi-function device "pwm-tach controller".
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/hwmon/Kconfig               |   9 +
>  drivers/hwmon/Makefile              |   1 +
>  drivers/hwmon/tach-aspeed-ast2600.c | 692 ++++++++++++++++++++++++++++

Please also provide Documentation/hwmon/tach-aspeed-ast2600.rst.

[ ... ]

> +	hwmon = devm_hwmon_device_register_with_groups(dev, "aspeed_tach", priv,
> +						       priv->groups);

Please use the new hwmon api (devm_hwmon_device_register_with_info).

> +	ret = PTR_ERR_OR_ZERO(hwmon);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to register hwmon device\n");
> +		goto err_assert_reset;
> +	}
> +	platform_set_drvdata(pdev, priv);
> +	return 0;
> +err_assert_reset:
> +	reset_control_assert(priv->reset);
> +err_disable_clk:
> +	clk_disable_unprepare(priv->clk);

You should be able to use devm_clk_get_enabled() to handle
the clock. If reset handling has to come first, you could use
devm_add_action_or_reset() for it. This way you would
not need the remove function, and error cleanup would
be much simplified.

Thanks,
Guenter

> +	return ret;
> +}
> +
> +static int aspeed_tach_remove(struct platform_device *pdev)
> +{
> +	struct aspeed_tach_data *priv = platform_get_drvdata(pdev);
> +
> +	reset_control_assert(priv->reset);
> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_stach_match_table[] = {
> +	{
> +		.compatible = "aspeed,ast2600-tach",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_stach_match_table);
> +
> +static struct platform_driver aspeed_tach_driver = {
> +	.probe		= aspeed_tach_probe,
> +	.remove		= aspeed_tach_remove,
> +	.driver		= {
> +		.name	= "aspeed_tach",
> +		.of_match_table = of_stach_match_table,
> +	},
> +};
> +
> +module_platform_driver(aspeed_tach_driver);
> +
> +MODULE_AUTHOR("Billy Tsai <billy_tsai@aspeedtech.com>");
> +MODULE_DESCRIPTION("Aspeed ast2600 TACH device driver");
> +MODULE_LICENSE("GPL v2");
> +
> -- 
> 2.25.1
> 
