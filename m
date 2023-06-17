Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299B873421A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 18:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjFQQGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 12:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQQGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 12:06:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E689710E0;
        Sat, 17 Jun 2023 09:06:13 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso691042b3a.3;
        Sat, 17 Jun 2023 09:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687017973; x=1689609973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y061kk89VJ6wNb9fmZPNbda44lNGbLDWR8S1Z5z3wwg=;
        b=OKlPwuWog5pKrBNH1FYDn8TcV1uYcj4oHUFPfqWtBbRnFgdkH8svkLgaBdIfTmM0N+
         7gVCwoKuDP4OUpwHaLqAKwMwrQeJj9KgW5EKBSkulGoRmtXOfaZwgcGFiNjKYy5AkKhp
         H8yZ0rAvZvTqmV43jEF82upl7WMPIueJbapcWbJ5JU1SxFyImmO7F5wUMJuNY/Mxggdw
         9Zu6q92xkSmxfflSST8+Tp/l7edCXQZEzoHmVBGFXdt2nDQ32SeScFBYFVi5Y8QM3OF+
         Os/+QXfv0c0jNexZFQ3tM+Q2d7ok44N2Zg4LGe6t3xq8Jzpy40wNVF2bDDwejJAz4t5B
         u2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687017973; x=1689609973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y061kk89VJ6wNb9fmZPNbda44lNGbLDWR8S1Z5z3wwg=;
        b=GCZsUbrSBLYntREk570SYMXIF+x64c4KONTuYOv9/krw/My2uJT56eJ6Gg8jqsQzNa
         keyW1QLq6TWq6wQvWAVCVQ41GwxyVzJG4tZN5qYFof1Jf6WeH12fJp+W/NLEhCp4qKwW
         LpSsaiFMUy+38b2K6ZCN1yvdxmDn2Ku5IvV6prTvadsam+9yoBqLyRN1/G8cj+14kojm
         ON5L3qEUO0wKiz0bME3v6x4Rzt42rEEeQ25vyTDnUxOY7/gUe4wxyJBmNEJFvbaujV4K
         fgq2Z9XRqXb2nPnf+AHVh3O9gwXCmqregLT88AZ+5ed4i3FkzwaBreRWh6qbb5iGhs++
         CiUw==
X-Gm-Message-State: AC+VfDwpMdrBQcia4ZWkmyiJz8qHrO9nd9Jbvs0oQAk16Tl9r3q1kbGh
        Ift5d3xP6XV0KLCumyY7/pU=
X-Google-Smtp-Source: ACHHUZ7HOdJZSf4pfvuFtATA6tAdPlarqg6JRO1o2Mtyub5TI+xFtMoTjPHYbl8d4/ykpQGUeKG0hQ==
X-Received: by 2002:a05:6a00:1141:b0:663:ee11:b1 with SMTP id b1-20020a056a00114100b00663ee1100b1mr4477330pfm.28.1687017973050;
        Sat, 17 Jun 2023 09:06:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k4-20020aa790c4000000b0063b8d21be5asm15601153pfk.147.2023.06.17.09.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 09:06:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 17 Jun 2023 09:06:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] hwmon: (sht3x)add new non-stardard sysfs interface
Message-ID: <76df2fe5-fcdb-4cfa-a171-80e2f99fb93c@roeck-us.net>
References: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
 <DB4PR10MB6261B507C7656E3568DA33E39258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB4PR10MB6261B507C7656E3568DA33E39258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
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

On Sat, Jun 17, 2023 at 12:00:16AM +0800, JuenKit Yip wrote:
> add "repeatability" interface to sysfs, it could be
> read or written to control the sensor.
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>

Checkpatch:

CHECK: Alignment should match open parenthesis
#149: FILE: drivers/hwmon/sht3x.c:650:
+static ssize_t repeatability_store(struct device *dev,
+				     struct device_attribute *attr,

Another comment inline below. I fixed that up, no need to resend.
But please keep it in mind for future patches.

Thanks,
Guenter

> ---
>  Documentation/hwmon/sht3x.rst | 12 +++++++-----
>  drivers/hwmon/sht3x.c         | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
> index b4aa561f0..87864ffd1 100644
> --- a/Documentation/hwmon/sht3x.rst
> +++ b/Documentation/hwmon/sht3x.rst
> @@ -28,11 +28,6 @@ The device communicates with the I2C protocol. Sensors can have the I2C
>  addresses 0x44 or 0x45, depending on the wiring. See
>  Documentation/i2c/instantiating-devices.rst for methods to instantiate the device.
>  
> -There is only one option configurable by means of sht3x_data:
> -
> -   repeatability: high repeatability is used by default and using it is
> -   strongly recommended.
> -
>  Even if sht3x sensor supports clock-strech(blocking mode) and non-strench
>  (non-blocking mode) in single-shot mode, this driver only supports the latter.
>  
> @@ -83,4 +78,11 @@ heater_enable:      heater enable, heating element removes excess humidity from
>  update_interval:    update interval, 0 for single shot, interval in msec
>  		    for periodic measurement. If the interval is not supported
>  		    by the sensor, the next faster interval is chosen
> +repeatability:      write or read repeatability, higher repeatability means
> +                    longer measurement duration, lower noise level and
> +                    larger energy consumption:
> +
> +                        - 0: low repeatability
> +                        - 1: medium repeatability
> +                        - 2: high repeatability
>  =================== ============================================================
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index 6174b8fa7..adfc11c12 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -637,6 +637,37 @@ static ssize_t update_interval_store(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t repeatability_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct sht3x_data *data = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", data->repeatability);
> +}
> +
> +static ssize_t repeatability_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf,
> +				     size_t count)
> +{
> +	u8 val;
> +	int ret;
> +
> +	struct sht3x_data *data = dev_get_drvdata(dev);
> +
> +	ret = kstrtou8(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val < 0 || val > 2)
> +		return -EINVAL;
> +
> +	data->repeatability = val;
> +
> +	return count;
> +}
> +
>  static SENSOR_DEVICE_ATTR_RO(temp1_input, temp1_input, 0);
>  static SENSOR_DEVICE_ATTR_RO(humidity1_input, humidity1_input, 0);
>  static SENSOR_DEVICE_ATTR_RW(temp1_max, temp1_limit, limit_max);
> @@ -653,6 +684,7 @@ static SENSOR_DEVICE_ATTR_RO(temp1_alarm, temp1_alarm, 0);
>  static SENSOR_DEVICE_ATTR_RO(humidity1_alarm, humidity1_alarm, 0);
>  static SENSOR_DEVICE_ATTR_RW(heater_enable, heater_enable, 0);
>  static SENSOR_DEVICE_ATTR_RW(update_interval, update_interval, 0);
> +static SENSOR_DEVICE_ATTR_RW(repeatability, repeatability, 0);
>  
>  static struct attribute *sht3x_attrs[] = {
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
> @@ -669,6 +701,7 @@ static struct attribute *sht3x_attrs[] = {
>  	&sensor_dev_attr_humidity1_alarm.dev_attr.attr,
>  	&sensor_dev_attr_heater_enable.dev_attr.attr,
>  	&sensor_dev_attr_update_interval.dev_attr.attr,
> +	&sensor_dev_attr_repeatability.dev_attr.attr,
>  	NULL
>  };
>  
