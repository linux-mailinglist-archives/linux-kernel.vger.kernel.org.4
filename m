Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0AE5B3AE6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiIIOnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiIIOn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:43:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFE5110AA3;
        Fri,  9 Sep 2022 07:43:28 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l10so1981906plb.10;
        Fri, 09 Sep 2022 07:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=itwUGd1Te1mSjRZ83ukeLvlZZen/Z6jAc3c4dT7PUuM=;
        b=eiTxh5Z/TuXFJclg3CW7GlqMhzXIzs40Q5nb6sMkkchg5kEMtgl8V7NcCc+V/AFFy1
         iNwpBGFlbAHewEmKfdCbgqalyRW5fGfDW8hdPgjZipthynyfGbvPewpGLZt39j/9tcuh
         PEwkyJplF4dwjTWipSWEXhMr/9QW5/PwT9Zqli4rEEaDMIpIZ3fKdGTHa0UJDDDXXB2A
         yfYWlekEa3993lE4w/YiRo8nOCMMwAjLPfLnLcCJtiO4m1dc/wZp8IxKsdhni9B0qsz4
         Ri/Jju+RPq1wjL/pJjr+XKhvUKvHx/Nqr/k+MB+hTWeYOJEWW8MjMvrYG5VrgV36SUsV
         lsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=itwUGd1Te1mSjRZ83ukeLvlZZen/Z6jAc3c4dT7PUuM=;
        b=Fb7rTz4Q0WZfS7S96mZ52gRNvzpwSB6I52CLqHXoFvjnLinISOyimR7rNusOza7c58
         nBRKZN56d5KKeNxE8WN13glsxqD658JuiZFDmqjOchk9TB9Te4hVBQAcN/2Hm9zwivX4
         04Sda8dBBHa5UKPwmdtZaTCwCQCEnL2AdPI+qwsLysEJqdt9dL2XGDQZPHi4qHElZoXR
         oh0j70Czoq4MLczJ/ickn6OsEjf5hGFmtnnP7r3brcTKuqpeXOl5Is8Wg1sSgZzV89Vo
         JIS3Hc9bPCzKqhCgL07he/BuPTE1z/DJLiyJxEZRR5J4PT41ivzaduF+T9ljflIMfP/1
         Ud3Q==
X-Gm-Message-State: ACgBeo0+7Nb+4ichD+h5XV2ou+bv/jCkHzjXe+x8lkp1Ty9qbD4gDn4I
        BkaZlW0QJOMsMHPgHeNoGJU=
X-Google-Smtp-Source: AA6agR5/Uh8A5sMDltA5OxD66RX3Nj35zygvhPbwQ0qODJgYHrZHZvjluWlMY0tp0uCHbPulGQz+HQ==
X-Received: by 2002:a17:902:6b42:b0:174:4308:ce52 with SMTP id g2-20020a1709026b4200b001744308ce52mr14023716plt.81.1662734607666;
        Fri, 09 Sep 2022 07:43:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u16-20020a17090a0c5000b00200b2894648sm489793pje.52.2022.09.09.07.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:43:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 9 Sep 2022 07:43:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) autoload module via DMI data
Message-ID: <20220909144324.GA2951669@roeck-us.net>
References: <20220909113820.92360-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909113820.92360-1-eugene.shalygin@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 01:38:20PM +0200, Eugene Shalygin wrote:
> Replace autoloading data based on the ACPI EC device with the DMI
> records for motherboards models. The ACPI method created a bug that when
> this driver returns error from the probe function because of the
> unsupported motherboard model, the ACPI subsystem concludes
> that the EC device does not work properly.
> 
> Fixes: 5cd29012028d
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=216412
> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=2121844
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> ---
>  drivers/hwmon/asus-ec-sensors.c | 413 ++++++++++++++++++--------------
>  1 file changed, 227 insertions(+), 186 deletions(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 61a4684fc020..206265ea8122 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c

[ ... ]

> +
> +static void cleanup_device(void)
> +{
> +	platform_device_unregister(asus_ec_sensors_platform_device);
> +	platform_driver_unregister(&asus_ec_sensors_platform_driver);
> +}
> +
> +static int __init asus_ec_init(void)
> +{
> +	asus_ec_sensors_platform_device =
> +		platform_create_bundle(&asus_ec_sensors_platform_driver,
> +				       asus_ec_probe, NULL, 0, NULL, 0);
> +
> +	if (IS_ERR(asus_ec_sensors_platform_device))
> +		return PTR_ERR(asus_ec_sensors_platform_device);
> +
> +	return 0;
> +}
> +
> +static void __exit asus_ec_exit(void)
> +{
> +	cleanup_device();

I don't see the point of that extra function. Please drop and call
platform_device_unregister() as well as platform_driver_unregister()
directly.

> +}
> +
> +module_init(asus_ec_init);
> +module_exit(asus_ec_exit);
>  
>  module_param_named(mutex_path, mutex_path_override, charp, 0);
>  MODULE_PARM_DESC(mutex_path,
> -- 
> 2.37.3
> 
