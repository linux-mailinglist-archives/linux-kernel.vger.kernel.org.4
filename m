Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82E6637B85
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiKXOft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:35:47 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BDE85EF4;
        Thu, 24 Nov 2022 06:35:47 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1432a5f6468so2128088fac.12;
        Thu, 24 Nov 2022 06:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6xD/F0jYBC276f58xCfsGqi3f/gw81uLwWLcRF5aus=;
        b=QXC8pTTXNAGpslmkmCnNdQbVBhAcMj+ubcWVDmVbl7uVO2Z0Al2CEmCBAsKzZwgDIx
         Kq2XYH0MqCSevs7zc5HEFYST6qkLENfgC8zgxzGEyDqpGFEjCoSsYOFao8h0N6BiY7vy
         Lfh1hDPOiBBkZa+GJZnj6pQKr79XjTVE/1ZxslChbDZw3KZQEyxASNHqVgonSintx9LS
         PK3WpNEetWOL8GU+YDWLvVQfREqbReW811e//FyQOjctqP70af6iaTJ32KHns7Wt2jol
         ynMQusAFzwjop7DbLLpH+563bVlRdbftYo0f0ERKkYowslYfJ7E3fPQY8bcz0JM8zvfr
         dDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6xD/F0jYBC276f58xCfsGqi3f/gw81uLwWLcRF5aus=;
        b=itOdwisGv1PXThtwi2Ev5moSGvRXFybUABFi1qzmVMr5362C/BpQlk1MHWeY23i1YL
         vGNMpdYpL09AbaRux/v6t5LE3G/be0wfsmvNsdVPEHltPYdeGUDqe7AoOVzYrv0iGPLA
         QuaTGIGZHwlZ9ut0nBvSKWQ3INh3FnCwnLkxoUFcliVAh8fCEj3dbxYTcx6RRvSU2SUY
         m7MCHuM432NLIwhJpLC25+iAWkfYKwiLuDDk5cMrS+jj2l2BlCxGyBJABIxORcRp0aYw
         NDrI/meZntk1u9dFb4mWX8DiPvwTHXfGYLO6sF04uPMp3n85cjkMTABJJU+6L5AKDKPO
         NN7Q==
X-Gm-Message-State: ANoB5pmqcDrVnBhXDM+n4bdbQYv4Cj7IYPQW62VubeOj6QCRV+pyfNZw
        TaDACdfBSZA6sVGnadDrAj4=
X-Google-Smtp-Source: AA0mqf45TumtbNTfIwWJbVngsAlUqVKKQwsD3NLEt804oI6bTmViiwEdph3/3BRPGaab0EQU3q5P8A==
X-Received: by 2002:a05:6871:4211:b0:132:354d:71ac with SMTP id li17-20020a056871421100b00132354d71acmr7510413oab.107.1669300546383;
        Thu, 24 Nov 2022 06:35:46 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cy26-20020a056870b69a00b0012779ba00fesm639254oab.2.2022.11.24.06.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 06:35:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6315d4e8-c3f4-6df7-b529-54f34e4e2194@roeck-us.net>
Date:   Thu, 24 Nov 2022 06:35:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Wang Honghui <honghui.wang@ucas.com.cn>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1CD578BA572E3037+Y37fk/eKlI3u5+77@TP-P15V.lan>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/3]hwmon: Modify to support Phytium FT2000/4 CPU for acpi
In-Reply-To: <1CD578BA572E3037+Y37fk/eKlI3u5+77@TP-P15V.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 19:05, Wang Honghui wrote:
> Modify to support Phytium FT2000/4 CPU for acpi
> 
> Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
> ---
>   drivers/hwmon/scpi-hwmon.c | 30 +++++++++++++++++++++++++-----
>   1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> index 4d75385f7d5e..6021ae00b334 100644
> --- a/drivers/hwmon/scpi-hwmon.c
> +++ b/drivers/hwmon/scpi-hwmon.c
> @@ -14,6 +14,7 @@
>   #include <linux/slab.h>
>   #include <linux/sysfs.h>
>   #include <linux/thermal.h>
> +#include <linux/acpi.h>
>   
Alphabetic include file order, please.

>   struct sensor_data {
>   	unsigned int scale;
> @@ -132,6 +133,13 @@ static const struct of_device_id scpi_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, scpi_of_match);
>   
> +/* Wang Honghui add to support Phytium FT2000/4 CPU for acpi */

Irrelevant comment.

> +static const struct acpi_device_id scpi_sensors_acpi_match[] = {
> +        { .id = "PHYT000D" },
> +        { }
> +};
> +MODULE_DEVICE_TABLE(acpi, scpi_sensors_acpi_match);
> +
>   static int scpi_hwmon_probe(struct platform_device *pdev)
>   {
>   	u16 nr_sensors, i;
> @@ -141,6 +149,7 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>   	struct scpi_ops *scpi_ops;
>   	struct device *hwdev, *dev = &pdev->dev;
>   	struct scpi_sensors *scpi_sensors;
> +	const struct acpi_device_id *match;
>   	int idx, ret;
>   
>   	scpi_ops = get_scpi_ops();
> @@ -170,11 +179,22 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>   
>   	scpi_sensors->scpi_ops = scpi_ops;
>   
> -	scale = of_device_get_match_data(&pdev->dev);
> -	if (!scale) {
> -		dev_err(&pdev->dev, "Unable to initialize scpi-hwmon data\n");
> -		return -ENODEV;
> -	}
> +	/* Wang Honghui modified to support Phytium FT2000/4 CPU for acpi */

Irrelevant comment.

> +	if (dev->of_node) {
> +		scale = of_device_get_match_data(&pdev->dev);
> +		if (!scale) {
> +			dev_err(&pdev->dev, "Unable to initialize scpi-hwmon data\n");
> +			return -ENODEV;
> +		}
> +	} else {
> +                match = acpi_match_device(dev->driver->acpi_match_table, dev);
> +                if (!match) {
> +                        dev_err(dev, "scpi-hwmon: Error ACPI match data is missing\n");
> +                        return -ENODEV;
> +                }
> +
> +                scale = scpi_scale;
> +        }

	scale = device_get_match_data(&pdev->dev);

should do after setting it in the acpi_device_id array.

Guenter

>   
>   	for (i = 0, idx = 0; i < nr_sensors; i++) {
>   		struct sensor_data *sensor = &scpi_sensors->data[idx];

