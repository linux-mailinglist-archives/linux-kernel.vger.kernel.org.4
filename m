Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF106BD80A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCPSSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCPSSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:18:09 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDBAE4C49;
        Thu, 16 Mar 2023 11:17:36 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r4so1484538ila.2;
        Thu, 16 Mar 2023 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678990654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bI/8jCq6po+MlaczI4bLzk/3h/MBLDIro/8WEF8KQL0=;
        b=EhuqrwBMSRmKOpe8tLKTcmazMMMHAA9YU51FLfLOaNE5XEUtLNH10mdQ1Wy/O38ysV
         QkLMt8oq801wfhMirTHPuzI/tvQXobFtnCwOOquDI59bJwJyPBd4SVGTFEcblY24bMLs
         GPm9d8aZyXdJoTsjrCgGdtMsOWAtvFrob75GC7EOsqMStQKPSgnzV4xYIH4BeSjbFt6a
         6Od23rJEE2C8QTQHqdDCvD06zUhEmRkBkFtUQCD6PEXrr7oL9trUdJc8jz5XykBUKFVA
         K1KUoTuuzsK6w4cHAanBFXCchBPSnilvH7HZrpWHBqdTAE2zO3fhHeo+avwf94UfL74w
         W4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678990654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI/8jCq6po+MlaczI4bLzk/3h/MBLDIro/8WEF8KQL0=;
        b=SVqYwy+kIcwt/jvPhZoHygx1J5Dgqt5QtPtRzyso+kygfzOjx98ZUCJjws2TgJIagx
         KZcv9DzLp/mdh9JJ4GydSDc92Z+cZ0oTlTdj0XhCNDzG3A3GCHyfUNCUbSMJjtVwUv9N
         K0vZ1CIeWlfQfaIqdfCzQE4YC99W+DPNxRG/faC/8hZg0hOc/yyWk5KOF+uWEJwyStYV
         vmMuZyiXJHJ+KKwMYdJi8Lj6sndjsfYwuWT5GOaB4oGd/CbTb//lASrxFupBI07HRmvw
         K+9JqbMZ6WgLHHGCj3xRSi/9nWcscnmCtOG6MsRpPoE1+xQvs8BxLBd2g31BQ3es44UC
         1vLQ==
X-Gm-Message-State: AO0yUKVv8awpWOI7hLIFZUQ6qKCWxWEWgB3JS1be8JTJbj/WedJnbert
        Pix5tK2PuClS6UDZ5wk14hNLN6H3LoA=
X-Google-Smtp-Source: AK7set8tQpY8FBEV/bepKFQkoQTm2fBm5x15loX/+3S0vXn+WU6Bm566efKvQ+mipk+EqeShoqwqSw==
X-Received: by 2002:a05:6e02:1a8e:b0:323:338:cc50 with SMTP id k14-20020a056e021a8e00b003230338cc50mr9030414ilv.22.1678990654574;
        Thu, 16 Mar 2023 11:17:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q2-20020a927502000000b003230b8aa2d6sm6984ilc.57.2023.03.16.11.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 11:17:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 16 Mar 2023 11:17:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Phinex Hung <phinex@realtek.com>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
Message-ID: <2b1e7e29-daa6-4f24-9fad-7ebe8b87a5fe@roeck-us.net>
References: <20230315121606.GA71707@threadripper>
 <8dbed631-62b6-1802-8f4e-7141b1a91a56@roeck-us.net>
 <D23B9D06-0DEA-4E3B-A64C-C928CAF2FEF8@realtek.com>
 <aaf0553c-48de-580f-70d5-aafeecb19e16@roeck-us.net>
 <1E8784A0-713E-41A8-A26D-72869E3E5779@realtek.com>
 <5c805125-4cb5-cdf8-6b50-5a6ce7e97149@roeck-us.net>
 <2686E7B8-BD3F-4C86-97B6-447343BFCF22@realtek.com>
 <A6DF8FB3-6318-40CD-A364-603A3E581511@realtek.com>
 <8c835412-f78f-570d-30a5-24f4c02a8438@roeck-us.net>
 <4BC6E9A7-13A6-429F-A586-AC60DC505838@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BC6E9A7-13A6-429F-A586-AC60DC505838@realtek.com>
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

On Thu, Mar 16, 2023 at 02:17:34PM +0000, Phinex Hung wrote:
> 
> 
> On 3/16/23 22:48, Guenter Roeck wrote:
> 
> 
> >That needs to be in the hwmon core. We can not change the device pointer
> >passed to hwmon_device_register_with_info() because that determines the
> >lifetime of the hwmon device.
> 
> 
> >Guenter
> 
> Do you mean something like below?
> 

Yes, except of course for the bugs (see below). That is much less
than perfect, of course, since we'd really want the device node
for the drive, not the controller, but it might be the best we can do.

> Or is it reasonable that we just match a specific compatible string and assign the device node to the original dev->parent used in drivetemp_add function ?
> 

We can't add anything to the parent device node since we don't own it.
Also, I don't know if devicetree maintainers would accept the concept
of "virtual" device nodes (and I don't know how device nodes for drives
would or should look like either).

> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 33edb5c02f7d..a76beeada33e 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -757,6 +757,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>         struct hwmon_device *hwdev;
>         const char *label;
>         struct device *hdev;
> +       struct device *tedv = dev;

			tdev =

>         int i, err, id;
> 
>         /* Complain about invalid characters in hwmon name attribute */
> @@ -826,7 +827,9 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>         hwdev->name = name;
>         hdev->class = &hwmon_class;
>         hdev->parent = dev;
> -       hdev->of_node = dev ? dev->of_node : NULL;
> +       while(!tdev->of_node)

	  while (tdev && !tdev->of_node)

> +               tdev = tdev->parent;
> +       hdev->of_node = tdev ? tdev->of_node : NULL;
>         hwdev->chip = chip;
>         dev_set_drvdata(hdev, drvdata);
> @@ -838,7 +841,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
> 
>         INIT_LIST_HEAD(&hwdev->tzdata);
> 
> -       if (dev && dev->of_node && chip && chip->ops->read &&
> +       if (tdev && tdev->of_node && chip && chip->ops->read &&

This could probably be simplified to
	  if (hdev->of_node && chip && ..

>             chip->info[0]->type == hwmon_chip &&
>             (chip->info[0]->config[0] & HWMON_C_REGISTER_TZ)) {
>                 err = hwmon_thermal_register_sensors(hdev);
> 
> Regards,
> Phinex
> 
> 
