Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856BA690F57
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjBIRiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:38:03 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB7CD53D;
        Thu,  9 Feb 2023 09:38:02 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id i17-20020a4adf11000000b0051abd9835d4so278899oou.1;
        Thu, 09 Feb 2023 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRgbQaat3TvaktqpMQsV43Rlffwg2V4Ut7Dv2IAE0aM=;
        b=QFExAjY+wZcdoLq/Uwj3YiLcKCsp6mJMyaIAvIarvgRmkYCvYeLJ281CJ9Xl50Dwtp
         EuXefx2OMC99olMHYaGCPZiV5lNnJZg0I5s7+Vmk8FVFZ6ACYPDa3fLViJN/QS66j6Qu
         pcwbVkLTvAc9Q20beBr0OteuUbeBGCT1QTgckRZnAByvFseuJZXM1X6+0bTxoHlaHGsL
         Ej10d91Nj12SCJ74HuMbJwjfoaAq+zYJViRKFBphpKoCsZsR/mgjxscMmL6/dmU3tz9f
         HLBLg4H9GUUZXjG+49p5plIZT8vpfFotS6MqQoAOm6PqKoo9Nn3ol+2kS1QgC+ttFtqw
         e/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRgbQaat3TvaktqpMQsV43Rlffwg2V4Ut7Dv2IAE0aM=;
        b=Xb8CYGOrrOdVyRGbYSsoV8jpA7ww/Ofop6w8MbomfSCzplECeSiIbQihkcdu05fZjt
         a/Ezer7vBumnkSmQ5jNqK04GCGXBVuZL2BzCWqPT5T7o4M8G1R71VyZ4zN4AAC6BMQR1
         j1PWyDFR//D2om5Lqx7A2PCkhnRsZdZJwJor/7CP/MuMT+kPuYUGo5I33cANZn5VB6DB
         g/AWckbTvQdJoFLUDc+2tbHb0AT/afA9PmXYU7bW2qI+7sq12UxaOyOn49zEj5nuqpoJ
         TcpRzkOQaHR7jhONbaOSX3cnGyCam4cE+M7NnLuCjZ0NnlNNBMSSXhnsUrfDgHWQW6G0
         LxgQ==
X-Gm-Message-State: AO0yUKVBqhpOry7BCOe02Pe2v7xDHS4KM2a4rfXIiGBGAhmyVDOh1PiB
        ArxWi7hTW+it5izuHQEza5k=
X-Google-Smtp-Source: AK7set+2YA81fQpUX5pAN/VxK19wrRO8T2DI06OKQXZHAM0ct5mzz7MQfyHRFcsqK9yMKtqw20Hlxg==
X-Received: by 2002:a4a:88a2:0:b0:51a:c822:1e02 with SMTP id j31-20020a4a88a2000000b0051ac8221e02mr2216853ooa.7.1675964281385;
        Thu, 09 Feb 2023 09:38:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bn12-20020a056820180c00b004f28d09a880sm982981oob.13.2023.02.09.09.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 09:38:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 9 Feb 2023 09:37:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     ye.xingchen@zte.com.cn
Cc:     nick.hawkins@hpe.com, verdun@hpe.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: =?iso-8859-1?Q?gxp-fan-?=
 =?iso-8859-1?Q?ctrl=3A_use=A0devm=5Fplatform=5Fget=5Fand=5Fioremap=5Freso?=
 =?iso-8859-1?B?dXJjZSgp?=
Message-ID: <20230209173759.GA652733@roeck-us.net>
References: <202302081546067270324@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202302081546067270324@zte.com.cn>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 03:46:06PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/gxp-fan-ctrl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/gxp-fan-ctrl.c b/drivers/hwmon/gxp-fan-ctrl.c
> index 0e9225a8b805..0014b8b0fd41 100644
> --- a/drivers/hwmon/gxp-fan-ctrl.c
> +++ b/drivers/hwmon/gxp-fan-ctrl.c
> @@ -199,7 +199,6 @@ static const struct hwmon_chip_info gxp_fan_ctrl_chip_info = {
>  static int gxp_fan_ctrl_probe(struct platform_device *pdev)
>  {
>  	struct gxp_fan_ctrl_drvdata *drvdata;
> -	struct resource *res;
>  	struct device *dev = &pdev->dev;
>  	struct device *hwmon_dev;
> 
> @@ -208,8 +207,7 @@ static int gxp_fan_ctrl_probe(struct platform_device *pdev)
>  	if (!drvdata)
>  		return -ENOMEM;
> 
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
> +	drvdata->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
>  	if (IS_ERR(drvdata->base))
>  		return dev_err_probe(dev, PTR_ERR(drvdata->base),
>  				     "failed to map base\n");
