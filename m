Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC4A6B4D70
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCJQp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjCJQpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:45:16 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BDB7DB6;
        Fri, 10 Mar 2023 08:42:58 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1755e639b65so6471840fac.3;
        Fri, 10 Mar 2023 08:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678466578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B29QGOV1oU2OAPPIlwHXxzMdgo8tuidvdIqMcEjr/vw=;
        b=BFRQ0+/nXreA7BSsEcFenRU0URS5rguQ1hSCbD6rNSJewxQTJNgUBhj52fG6Z9achO
         LxTmwlDQ8b+eYRfDGULK1SO68dtlfjbbT7M4rAxSGT7FrX+9mOU2GTNTsrnzFtnN0p6Q
         jdvzB2oGfqdP+zKSLeQv7YWZQgesxSLzLsbfwdOgoAQjUaJ8Vv4lxtbFgAfhfAbhi9Ir
         4D/GQrRCf4zP7LTTGWbk68ebG7bFXMORia8UvlcvTvMTPjeVAtWnRVW11PXcjcxisVPz
         qiHBaQORUFPdZcxUgQJEqB9MlSUYRkdq7JSyyCuz/UchbSQqVM3FPeMIn3BrZLLhUXIT
         aw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678466578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B29QGOV1oU2OAPPIlwHXxzMdgo8tuidvdIqMcEjr/vw=;
        b=urRoZ7NYQ9FnNUCYxi1X2j8emnNWhZ1Yz8YFEwSGWOMHwDoqX92To7aj0Fokz0TfhC
         GXTgewbXqY0s0w3rx4G+SNTf5wW2fc2ESoq+S0W9iaP7J4dwxTEd+QD9ekIcpLLRZjro
         rRQFAoGbiK713PeuTGH/9HbA72BuOEkG0Zaxtt0Fka5eE4XHip2XbYwTVXhgwg5VOriY
         6Aqalla8bgtZxLcW64FGOOXS4RbGcxO1l6hzCazmPvSwzjdh6l0anXNADCCH4H76q7sY
         ngZBuqZfBBWxgaU1GK/xYuoU/sp/KkJie0iM9NCrukmxPt2HrVdgOVk04XSR+0EvGucO
         1ZfA==
X-Gm-Message-State: AO0yUKWiLdTQzOMKe9ajIcd7d4P+xys9tzykysfISBtPNx0S4FZPxv6E
        PINF6fEzjQA/TR74NuUAuz87Wc1QGyg=
X-Google-Smtp-Source: AK7set/otLxjU6FVcmOy+zMvWy/+ibTNVpcRUYxVYJoAyuFjFlQnV6L7WiOdptb1sKd/Ku0lM2rP3A==
X-Received: by 2002:a05:6870:d389:b0:176:361c:8abb with SMTP id k9-20020a056870d38900b00176361c8abbmr17102425oag.37.1678466578287;
        Fri, 10 Mar 2023 08:42:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i18-20020a9d6112000000b0068bcef4f543sm239623otj.21.2023.03.10.08.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 08:42:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 10 Mar 2023 08:42:56 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     void0red <void0red@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mezin.alexander@gmail.com
Subject: Re: [PATCH v2 1/2] hwmon: g762: add a check of devm_add_action in
 g762_of_clock_enable
Message-ID: <4f4b71ed-2c9c-4e87-aceb-1d2f098e0408@roeck-us.net>
References: <42cdd5e4-c9da-b31a-0ffd-76846757645c@roeck-us.net>
 <20230227030913.893004-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227030913.893004-1-void0red@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:09:12AM +0800, void0red wrote:
> From: Kang Chen <void0red@gmail.com>
> 
> devm_add_action may fails, check it and do the cleanup.
> 
> Signed-off-by: Kang Chen <void0red@gmail.com>

Applied.

Thanks,
Guenter

> ---
> v2 -> v1: split the patch
> 
>  drivers/hwmon/g762.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
> index 64a0599b2..e2c3c34f0 100644
> --- a/drivers/hwmon/g762.c
> +++ b/drivers/hwmon/g762.c
> @@ -620,7 +620,12 @@ static int g762_of_clock_enable(struct i2c_client *client)
>  	data = i2c_get_clientdata(client);
>  	data->clk = clk;
>  
> -	devm_add_action(&client->dev, g762_of_clock_disable, data);
> +	ret = devm_add_action(&client->dev, g762_of_clock_disable, data);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to add disable clock action\n");
> +		goto clk_unprep;
> +	}
> +
>  	return 0;
>  
>   clk_unprep:
