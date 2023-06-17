Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1173420D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjFQPur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 11:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQPup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:50:45 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205C213E;
        Sat, 17 Jun 2023 08:50:44 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b44b5adfd3so1328603a34.3;
        Sat, 17 Jun 2023 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687017043; x=1689609043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6jpAqFNkP/8S4XUEZft9Vl6zwQ1+A99YTwALsQl1bI=;
        b=VsIFglwHvEbDefxZE/xPqIzgAdul6NIfK3+g7VLKc+XlaueX1qDqx+spQ/1nu/RzkW
         zxpaepiSk3yJr2aSw7txq73PwOSwcb3/8tiXmG7dEm2jcRiFBItGq84mLKXN9tpMx62U
         E8q/yAqkKQuHpOaU/mj66sAcodBqonDtUlm5CGqO/AZARYWKnuwCqEgZi8CNFgsDmqUN
         51MQX47P9gcoP7cdj/wFyebc798+tc7twqzM5Pm41IQZuI2A5i6KjUp2Mh3uT98cTzyI
         zl29wC4bb0K+OHlUnmUTxpRuPA9Ao1phdBdO/AsOESqZcYQO+NMP1Sd42RDlYlrr5Ke0
         ndCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687017043; x=1689609043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6jpAqFNkP/8S4XUEZft9Vl6zwQ1+A99YTwALsQl1bI=;
        b=jFhONp19+Fy/jselNzg/D7I1t6sE/A+QophRoVAqIkpKG/AvBv6jXjjCvI6noI5l5w
         lIe9Yio+cIp2m2UvL2qSSs1ZVpX++FTWT9bfsnlt6o/FHIICPbhHMkrYbPEBWYPvwWRU
         lJzl+K7D7VXcpxRCy7EPbs8Mx1hMew9s+sSpPn7VimUXhtM2Y7EkWp9CaLEmmmpWF3rD
         xrdNRQnX50xav66JrGVgpYfdIBo4MHUPpDLdW730Uz6FELW1BmJDElnzLvcLM+Jvgxv+
         +zc5UmXTPyA8h/RS6b2BSFpvcuQ/Eu488jEJClYmJM/NoxvK65YcKJJldi3dRAhDoNrW
         BdeA==
X-Gm-Message-State: AC+VfDwLY1dak+ooLlFiWBPhITJ31SthS2Bki9zbzTR3dWzq8ifSNQuN
        W3ituIcxX4h5UENhIVwgIwu/wY+4HR8=
X-Google-Smtp-Source: ACHHUZ5JbV2p17FPxWhQdXg2vC8yMKBFBn2Vm2EiOEtdhfNM/gYIiGWoZUxzNFkj7aG/Qjc6BOzQtg==
X-Received: by 2002:a9d:73c3:0:b0:6b4:6119:7d0d with SMTP id m3-20020a9d73c3000000b006b461197d0dmr1411625otk.29.1687017043299;
        Sat, 17 Jun 2023 08:50:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s18-20020aa78d52000000b00653dc27acadsm14992400pfe.205.2023.06.17.08.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 08:50:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 17 Jun 2023 08:50:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] hwmon: (sht3x) remove sht3x_platform_data
Message-ID: <15084315-2f70-4209-933d-b28230e32abd@roeck-us.net>
References: <DB4PR10MB626126FB7226D5AF341197449258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB4PR10MB626126FB7226D5AF341197449258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
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

On Sat, Jun 17, 2023 at 12:00:12AM +0800, JuenKit Yip wrote:
> Since no in-tree driver supports it, sht3x_platform_data has been
> removed and the relevant properties have been moved to sht3x_data.
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/sht3x.rst       |  2 +-
>  drivers/hwmon/sht3x.c               | 20 ++++++++------------
>  include/linux/platform_data/sht3x.h | 15 ---------------
>  3 files changed, 9 insertions(+), 28 deletions(-)
>  delete mode 100644 include/linux/platform_data/sht3x.h
> 
> diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
> index 95a850d5b..31fd36b14 100644
> --- a/Documentation/hwmon/sht3x.rst
> +++ b/Documentation/hwmon/sht3x.rst
> @@ -28,7 +28,7 @@ The device communicates with the I2C protocol. Sensors can have the I2C
>  addresses 0x44 or 0x45, depending on the wiring. See
>  Documentation/i2c/instantiating-devices.rst for methods to instantiate the device.
>  
> -There are two options configurable by means of sht3x_platform_data:
> +There are two options configurable by means of sht3x_data:
>  
>  1. blocking (pull the I2C clock line down while performing the measurement) or
>     non-blocking mode. Blocking mode will guarantee the fastest result but
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index 8305e44d9..580704d93 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -20,7 +20,6 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/jiffies.h>
> -#include <linux/platform_data/sht3x.h>
>  
>  /* commands (high precision mode) */
>  static const unsigned char sht3x_cmd_measure_blocking_hpm[]    = { 0x2c, 0x06 };
> @@ -135,8 +134,8 @@ struct sht3x_data {
>  	const unsigned char *command;
>  	u32 wait_time;			/* in us*/
>  	unsigned long last_update;	/* last update in periodic mode*/
> -
> -	struct sht3x_platform_data setup;
> +	bool blocking_io;
> +	bool high_precision;
>  
>  	/*
>  	 * cached values for temperature and humidity and limits
> @@ -441,13 +440,13 @@ static void sht3x_select_command(struct sht3x_data *data)
>  	if (data->mode > 0) {
>  		data->command = sht3x_cmd_measure_periodic_mode;
>  		data->wait_time = 0;
> -	} else if (data->setup.blocking_io) {
> -		data->command = data->setup.high_precision ?
> +	} else if (data->blocking_io) {
> +		data->command = data->high_precision ?
>  				sht3x_cmd_measure_blocking_hpm :
>  				sht3x_cmd_measure_blocking_lpm;
>  		data->wait_time = 0;
>  	} else {
> -		if (data->setup.high_precision) {
> +		if (data->high_precision) {
>  			data->command = sht3x_cmd_measure_nonblocking_hpm;
>  			data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_HPM;
>  		} else {
> @@ -595,7 +594,7 @@ static ssize_t update_interval_store(struct device *dev,
>  	}
>  
>  	if (mode > 0) {
> -		if (data->setup.high_precision)
> +		if (data->high_precision)
>  			command = periodic_measure_commands_hpm[mode - 1];
>  		else
>  			command = periodic_measure_commands_lpm[mode - 1];
> @@ -690,16 +689,13 @@ static int sht3x_probe(struct i2c_client *client)
>  	if (!data)
>  		return -ENOMEM;
>  
> -	data->setup.blocking_io = false;
> -	data->setup.high_precision = true;
> +	data->blocking_io = false;
> +	data->high_precision = true;
>  	data->mode = 0;
>  	data->last_update = jiffies - msecs_to_jiffies(3000);
>  	data->client = client;
>  	crc8_populate_msb(sht3x_crc8_table, SHT3X_CRC8_POLYNOMIAL);
>  
> -	if (client->dev.platform_data)
> -		data->setup = *(struct sht3x_platform_data *)dev->platform_data;
> -
>  	sht3x_select_command(data);
>  
>  	mutex_init(&data->i2c_lock);
> diff --git a/include/linux/platform_data/sht3x.h b/include/linux/platform_data/sht3x.h
> deleted file mode 100644
> index 14680d2a9..000000000
> --- a/include/linux/platform_data/sht3x.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright (C) 2016 Sensirion AG, Switzerland
> - * Author: David Frey <david.frey@sensirion.com>
> - * Author: Pascal Sachs <pascal.sachs@sensirion.com>
> - */
> -
> -#ifndef __SHT3X_H_
> -#define __SHT3X_H_
> -
> -struct sht3x_platform_data {
> -	bool blocking_io;
> -	bool high_precision;
> -};
> -#endif /* __SHT3X_H_ */
