Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B356B68F0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjCLRpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCLRpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:45:42 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D6937F01;
        Sun, 12 Mar 2023 10:45:41 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id bh20so7949906oib.9;
        Sun, 12 Mar 2023 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678643141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PCXCOc7UOFMl4Vb7h2+J8ppg8wMSZyLJTnme/0rhek=;
        b=V/OuAyA3XU2ysqrpHU4OY5/mSMlewEnqq5nxVePqYuGLq+aa99JDpEPuiotFbx/h79
         2r+zsXOmBJCbn7bMZY28tWAnQ1Srry9MEW2DjPtnYP0Nmi2C9f+oL1DCCoGDMdbKorZM
         6TRkRwO1t2pbBORrnb8UJExL1QTz4wYnH9mAqvY6E5+TUww5MgD4xpOLWCpApq5pp2Hd
         eJmS9Xu9iI7HhhoVP7gsc8/oE2bcRMe0Y9pr7bgkQqRp4uBBmptOEXIjdPQbRPdEgB5m
         ZSNgCtwPWb977+KzwzMfvhyChtGaFIKuAsW9NN1wK3EQ7c/M5L6tyNjwBnPGuSwyuVoM
         TXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678643141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PCXCOc7UOFMl4Vb7h2+J8ppg8wMSZyLJTnme/0rhek=;
        b=7brypKlkobYiJCub6AYDuwRQE9t5dUMFnZM83tKRdefZ6UHhKjfgDBOE8NPtKjfG6v
         243jbl3odZB9rjr85P/J80LRjAMil8hb0hpR5epZ5MjHvkMzw1ilXhP2ETLpEBFf0/O0
         g+YejezrCpkgOdPHLyqFhqrK3+1+/ZiJe/AALmCQvXps/mGzfrxvv1HDrFr0ahwvUvqs
         p/z64fbvjJ7lYqg7DqzHX/NzSuxuBaw2Ou48PxpOIPxN6EZXJpIeOuzJPHoyur6r/xlU
         aJUBR+zgVoaVl0wky5G1SRdV4YhdKLOC6jclncwATvxsdQc8wzG2ccxflIafFmu9NCMn
         EndQ==
X-Gm-Message-State: AO0yUKUr5hmKOMV1w93I/fE1Jdwymt7DHgBG/M7THL38EYv92kRHkTdD
        gpPM2ks7ElsAmo8pEoc7KTto3I5n+dk=
X-Google-Smtp-Source: AK7set9X8HnR7vskS7ttrrZbZRj97wroNaMAfKod680WGvNzCTsfDpltbBzTv4Wh0+MH+KgTudwu+A==
X-Received: by 2002:a05:6808:a8f:b0:383:fc9b:fb5f with SMTP id q15-20020a0568080a8f00b00383fc9bfb5fmr13614234oij.47.1678643141081;
        Sun, 12 Mar 2023 10:45:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h11-20020a4a940b000000b0051ac0f54447sm2290386ooi.33.2023.03.12.10.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:45:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 10:45:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Leonard Anderweit <leonard.anderweit@gmail.com>
Cc:     linux-hwmon@vger.kernel.org,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] hwmon: (aquacomputer_d5next) Add temperature
 offset control for Aquaero
Message-ID: <8ae89aef-233d-49b8-85b4-ce3aa888511c@roeck-us.net>
References: <20230214220221.15003-1-leonard.anderweit@gmail.com>
 <20230214220221.15003-6-leonard.anderweit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214220221.15003-6-leonard.anderweit@gmail.com>
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

On Tue, Feb 14, 2023 at 11:02:20PM +0100, Leonard Anderweit wrote:
> Adds control over the Aquacomputer Aquaero temperature offset for all eight
> temperature sensors.
> 
> Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/aquacomputer_d5next.rst |  4 ++--
>  drivers/hwmon/aquacomputer_d5next.c         | 12 ++++++++----
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index 7d0d015b1a52..618c826093a2 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -25,7 +25,7 @@ communicate through proprietary USB HID protocols.
>  
>  The Aquaero devices expose eight physical, eight virtual and four calculated
>  virtual temperature sensors, as well as two flow sensors. The fans expose their
> -speed (in RPM), power, voltage and current.
> +speed (in RPM), power, voltage and current. Temperature offsets can be controlled.
>  
>  For the D5 Next pump, available sensors are pump and fan speed, power, voltage
>  and current, as well as coolant temperature and eight virtual temp sensors. Also
> @@ -75,7 +75,7 @@ Sysfs entries
>  
>  ================ ==============================================================
>  temp[1-20]_input Physical/virtual temperature sensors (in millidegrees Celsius)
> -temp[1-4]_offset Temperature sensor correction offset (in millidegrees Celsius)
> +temp[1-8]_offset Temperature sensor correction offset (in millidegrees Celsius)
>  fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
>  fan5_pulses      Quadro flow sensor pulses
>  power[1-8]_input Pump/fan power (in micro Watts)
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index eb185318098a..61c1ffcd8f3b 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -116,6 +116,9 @@ static u8 aquaero_secondary_ctrl_report[] = {
>  #define AQUAERO_FAN_SPEED_OFFSET		0x00
>  static u16 aquaero_sensor_fan_offsets[] = { 0x167, 0x173, 0x17f, 0x18B };
>  
> +/* Control report offsets for the Aquaero fan controllers */
> +#define AQUAERO_TEMP_CTRL_OFFSET	0xdb
> +
>  /* Specs of the D5 Next pump */
>  #define D5NEXT_NUM_FANS			2
>  #define D5NEXT_NUM_SENSORS		1
> @@ -988,10 +991,10 @@ static const struct hwmon_channel_info *aqc_info[] = {
>  			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
>  			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
>  			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
> -			   HWMON_T_INPUT | HWMON_T_LABEL,
> -			   HWMON_T_INPUT | HWMON_T_LABEL,
> -			   HWMON_T_INPUT | HWMON_T_LABEL,
> -			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
>  			   HWMON_T_INPUT | HWMON_T_LABEL,
>  			   HWMON_T_INPUT | HWMON_T_LABEL,
>  			   HWMON_T_INPUT | HWMON_T_LABEL,
> @@ -1295,6 +1298,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->flow_sensors_start_offset = AQUAERO_FLOW_SENSORS_START;
>  
>  		priv->buffer_size = AQUAERO_CTRL_REPORT_SIZE;
> +		priv->temp_ctrl_offset = AQUAERO_TEMP_CTRL_OFFSET;
>  
>  		priv->temp_label = label_temp_sensors;
>  		priv->virtual_temp_label = label_virtual_temp_sensors;
