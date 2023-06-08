Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D4A728175
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbjFHNgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjFHNgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:36:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54224268E;
        Thu,  8 Jun 2023 06:36:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b24eba185cso3162125ad.2;
        Thu, 08 Jun 2023 06:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686231377; x=1688823377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SyrwbuUr776SC2K8+O8G4rOMXSZnIJmVLUQTvFM48oM=;
        b=Ip1V9XqFu4mMt4kvofbtTw68g1yrjQP2WuOdQe+Fl49EzLKD3o1Z38RBIG1PMfOLvW
         xWqcosrR4qz7lkstcC+kzL11j0qFTj7rPlHZM5cukMx1JGqN742XTPbj9JfJFDbFXBkM
         J3uEri+WabUxP4ebNed0GLNXd8CKHXs4UvPVfgMGpg9g85g0vsSDse7I6Wnuo3PZIftn
         RbP92JwABevhVtY4WlFEJ3UttU6reXPUuM+8lZpTkA7ge0yOqoQk++fD+CAcGJQeOg22
         3rmmsGrem0KADOp//NcFyzPV0wdMghfGsicF/g0uxLJn2om8jJbPevvUmIg2aMssGqSh
         NsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686231377; x=1688823377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyrwbuUr776SC2K8+O8G4rOMXSZnIJmVLUQTvFM48oM=;
        b=iZuMu+YBPs5IGY+DVxKmTSUchXPKce2TsFOKBCR7fAVB1XFWzL/dRefdJl9zUTWjHg
         9YWijYtYlRnhHlyTYbeHn8rzDHHWGGlTgHTKoqwJhZJPhLbTU83UYAxCqlq/nBBNuEz0
         bje/d4+sA8QHW9WkkTRwskxA49OFKjPZ0RLhnoaKhtO5h0VyiI2mTzVDzZQai960aUoj
         G209IlB7MhohcYPU7SGYQ8kxpw6hcMHSzZSEVienOD4E1qjqjqOTYst3zgotvaApLvu5
         J7n+3m+McQYXog0f5ICnz8Zafj33OnPaVpSXQbLmYNu9WHmCYT1+ZqBUQXMTGoRRMF7z
         4Z9g==
X-Gm-Message-State: AC+VfDy5ePqEncjyudmJj2PrGbacJiW3RArkmceSjbLoc0kiAMtgWsnl
        ETvFLYq+nihdBGKjEU6uSYvunFg3rr0=
X-Google-Smtp-Source: ACHHUZ6uq3+K8KP81mA2v6LknKsjp0S2YMs1XMeXh7E8PzGJE/gQxaLPwYLeRyTGmlzayyOFmdTDTA==
X-Received: by 2002:a17:902:ba83:b0:1b1:d51c:f3f6 with SMTP id k3-20020a170902ba8300b001b1d51cf3f6mr4599445pls.57.1686231376751;
        Thu, 08 Jun 2023 06:36:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902694100b00199203a4fa3sm1430740plt.203.2023.06.08.06.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 06:36:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 8 Jun 2023 06:36:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH] hwmon: (gsc-hwmon) fix fan pwm temperature scaling
Message-ID: <5acc2640-7bf9-488f-bbca-c35542915a2f@roeck-us.net>
References: <20230606153004.1448086-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606153004.1448086-1-tharvey@gateworks.com>
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

On Tue, Jun 06, 2023 at 08:30:04AM -0700, Tim Harvey wrote:
> The GSC fan pwm temperature register is in centidegrees celcius but the
> Linux hwmon convention is to use milidegrees celcius. Fix the scaling.
> 
> Fixes: 3bce5377ef66 ("hwmon: Add Gateworks System Controller support")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/gsc-hwmon.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
> index 73e5d92b200b..1501ceb551e7 100644
> --- a/drivers/hwmon/gsc-hwmon.c
> +++ b/drivers/hwmon/gsc-hwmon.c
> @@ -82,8 +82,8 @@ static ssize_t pwm_auto_point_temp_store(struct device *dev,
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
>  
> -	temp = clamp_val(temp, 0, 10000);
> -	temp = DIV_ROUND_CLOSEST(temp, 10);
> +	temp = clamp_val(temp, 0, 100000);
> +	temp = DIV_ROUND_CLOSEST(temp, 100);
>  
>  	regs[0] = temp & 0xff;
>  	regs[1] = (temp >> 8) & 0xff;
> @@ -100,7 +100,7 @@ static ssize_t pwm_auto_point_pwm_show(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  
> -	return sprintf(buf, "%d\n", 255 * (50 + (attr->index * 10)) / 100);
> +	return sprintf(buf, "%d\n", 255 * (50 + (attr->index * 10)));
>  }
>  
>  static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point1_pwm, pwm_auto_point_pwm, 0);
