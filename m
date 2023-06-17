Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D70173420F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 17:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbjFQPvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 11:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQPvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:51:14 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA89E13E;
        Sat, 17 Jun 2023 08:51:13 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666e916b880so623233b3a.2;
        Sat, 17 Jun 2023 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687017073; x=1689609073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTsqi41yQONAZrJvm/wUIzlgKZG5uLPu8/092S2kro8=;
        b=Xbq2utOE8IK5yJY+aTTJ2IFqZHDDY1E9pWEDpg6BHpFn+NOpLTUgycog0nax9nsJyP
         GmXxRPMnseVWgDWzGkIPKs3SDP9F0lQ9ynOwiG1JyfECn3Ua0PxDjYHiE9l6Jx7y++OK
         gkUniuVOjsvXdCdoCtaIsA4+31Sq2amd9a3cEL8Rrv0wlfmmFx34Hg8K64yksueYtpG6
         oetG4/hyoAaPT3qRW9RbdNwetzRU8apIJD4SfuOAOm2V6L09Ic1bv47hxqhyKUWGbVRo
         RT87m0Qr3tReS3pcrF6ERr5NOcEMoY9Iy4NUGEQqfZavupQtLHFJihkFROMVyQH6Ufzg
         u0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687017073; x=1689609073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTsqi41yQONAZrJvm/wUIzlgKZG5uLPu8/092S2kro8=;
        b=UBbgcoplW57UdIGaoWxX4R7iOnlcDWJ+e1ffyOZnG8CBaHcQ/Sd2zNlBo9MXOWCnb3
         v+ScvzB8Zk+5G1R//ujspiwdelNfVkgnOP5Lbz/2OP2F1fpAYUF0QBGjpjdzfhXFifSG
         kEt4xqn+8K6k2XUSlEpaBnkBY4wX0LBT/6NF6VX/KMseQyoq/f0mobHBkNo+pmLIl5nA
         whap549KPCHsJTsJ4eHIHChfZNnXWZq6nA2OXSnWJKYOHAe7Kv6b0VPqeszTnYds1p4c
         q5la/mpBDLHvAUAmPOPtityozTBOm1E5dXA91r4Kr/webzIpuYM82Zxx4VSnGFoAMTi+
         YMXQ==
X-Gm-Message-State: AC+VfDydF+PXzF0RxEWpU10dYuJFjgiD4X96YznGxOBuRoSJULOike1Q
        VdPPZgd59YDPuwm6S0UKNsA=
X-Google-Smtp-Source: ACHHUZ7kOR2HDkcfu5Ayb7nw8zG8JISSDOS3HatK7wSLkmjGn3B7615Lck+qwmtMYcj1/fPNvegwkg==
X-Received: by 2002:a05:6a00:2315:b0:668:69fa:f791 with SMTP id h21-20020a056a00231500b0066869faf791mr943582pfh.3.1687017073231;
        Sat, 17 Jun 2023 08:51:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q21-20020a62ae15000000b0065992d334f4sm1342388pff.177.2023.06.17.08.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 08:51:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 17 Jun 2023 08:51:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] hwmon: (sht3x)remove blocking_io property
Message-ID: <d2c6ce2b-de82-4ef8-a811-5379ee0179ec@roeck-us.net>
References: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
 <DB4PR10MB6261DA9202AF37B4F6ECDD6C9258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB4PR10MB6261DA9202AF37B4F6ECDD6C9258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
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

On Sat, Jun 17, 2023 at 12:00:13AM +0800, JuenKit Yip wrote:
> Due to no support on clock-strench, blocking mode was removed and
> now single-shot mode only uses non-blocking mode.
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/sht3x.rst | 14 ++++++--------
>  drivers/hwmon/sht3x.c         | 33 +++++++++++----------------------
>  2 files changed, 17 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
> index 31fd36b14..be70e2543 100644
> --- a/Documentation/hwmon/sht3x.rst
> +++ b/Documentation/hwmon/sht3x.rst
> @@ -28,16 +28,14 @@ The device communicates with the I2C protocol. Sensors can have the I2C
>  addresses 0x44 or 0x45, depending on the wiring. See
>  Documentation/i2c/instantiating-devices.rst for methods to instantiate the device.
>  
> -There are two options configurable by means of sht3x_data:
> -
> -1. blocking (pull the I2C clock line down while performing the measurement) or
> -   non-blocking mode. Blocking mode will guarantee the fastest result but
> -   the I2C bus will be busy during that time. By default, non-blocking mode
> -   is used. Make sure clock-stretching works properly on your device if you
> -   want to use blocking mode.
> -2. high or low accuracy. High accuracy is used by default and using it is
> +There is only one option configurable by means of sht3x_data:
> +
> +   high or low accuracy. High accuracy is used by default and using it is
>     strongly recommended.
>  
> +Even if sht3x sensor supports clock-strech(blocking mode) and non-strench
> +(non-blocking mode) in single-shot mode, this driver only supports the latter.
> +
>  The sht3x sensor supports a single shot mode as well as 5 periodic measure
>  modes, which can be controlled with the update_interval sysfs interface.
>  The allowed update_interval in milliseconds are as follows:
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index 580704d93..bbe556f44 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -22,12 +22,10 @@
>  #include <linux/jiffies.h>
>  
>  /* commands (high precision mode) */
> -static const unsigned char sht3x_cmd_measure_blocking_hpm[]    = { 0x2c, 0x06 };
> -static const unsigned char sht3x_cmd_measure_nonblocking_hpm[] = { 0x24, 0x00 };
> +static const unsigned char sht3x_cmd_measure_single_hpm[] = { 0x24, 0x00 };
>  
>  /* commands (low power mode) */
> -static const unsigned char sht3x_cmd_measure_blocking_lpm[]    = { 0x2c, 0x10 };
> -static const unsigned char sht3x_cmd_measure_nonblocking_lpm[] = { 0x24, 0x16 };
> +static const unsigned char sht3x_cmd_measure_single_lpm[] = { 0x24, 0x16 };
>  
>  /* commands for periodic mode */
>  static const unsigned char sht3x_cmd_measure_periodic_mode[]   = { 0xe0, 0x00 };
> @@ -41,9 +39,9 @@ static const unsigned char sht3x_cmd_heater_off[]              = { 0x30, 0x66 };
>  static const unsigned char sht3x_cmd_read_status_reg[]         = { 0xf3, 0x2d };
>  static const unsigned char sht3x_cmd_clear_status_reg[]        = { 0x30, 0x41 };
>  
> -/* delays for non-blocking i2c commands, both in us */
> -#define SHT3X_NONBLOCKING_WAIT_TIME_HPM  15000
> -#define SHT3X_NONBLOCKING_WAIT_TIME_LPM   4000
> +/* delays for single-shot mode i2c commands, both in us */
> +#define SHT3X_SINGLE_WAIT_TIME_HPM  15000
> +#define SHT3X_SINGLE_WAIT_TIME_LPM   4000
>  
>  #define SHT3X_WORD_LEN         2
>  #define SHT3X_CMD_LENGTH       2
> @@ -134,7 +132,6 @@ struct sht3x_data {
>  	const unsigned char *command;
>  	u32 wait_time;			/* in us*/
>  	unsigned long last_update;	/* last update in periodic mode*/
> -	bool blocking_io;
>  	bool high_precision;
>  
>  	/*
> @@ -432,26 +429,19 @@ static ssize_t humidity1_limit_store(struct device *dev,
>  static void sht3x_select_command(struct sht3x_data *data)
>  {
>  	/*
> -	 * In blocking mode (clock stretching mode) the I2C bus
> -	 * is blocked for other traffic, thus the call to i2c_master_recv()
> -	 * will wait until the data is ready. For non blocking mode, we
> -	 * have to wait ourselves.
> +	 * For single-shot mode, only non blocking mode is support,
> +	 * we have to wait ourselves for result.
>  	 */
>  	if (data->mode > 0) {
>  		data->command = sht3x_cmd_measure_periodic_mode;
>  		data->wait_time = 0;
> -	} else if (data->blocking_io) {
> -		data->command = data->high_precision ?
> -				sht3x_cmd_measure_blocking_hpm :
> -				sht3x_cmd_measure_blocking_lpm;
> -		data->wait_time = 0;
>  	} else {
>  		if (data->high_precision) {
> -			data->command = sht3x_cmd_measure_nonblocking_hpm;
> -			data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_HPM;
> +			data->command = sht3x_cmd_measure_single_hpm;
> +			data->wait_time = SHT3X_SINGLE_WAIT_TIME_HPM;
>  		} else {
> -			data->command = sht3x_cmd_measure_nonblocking_lpm;
> -			data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_LPM;
> +			data->command = sht3x_cmd_measure_single_lpm;
> +			data->wait_time = SHT3X_SINGLE_WAIT_TIME_LPM;
>  		}
>  	}
>  }
> @@ -689,7 +679,6 @@ static int sht3x_probe(struct i2c_client *client)
>  	if (!data)
>  		return -ENOMEM;
>  
> -	data->blocking_io = false;
>  	data->high_precision = true;
>  	data->mode = 0;
>  	data->last_update = jiffies - msecs_to_jiffies(3000);
