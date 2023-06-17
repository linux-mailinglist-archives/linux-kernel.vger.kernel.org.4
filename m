Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4A8734211
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 17:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjFQPy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 11:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQPy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:54:27 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64E01AB;
        Sat, 17 Jun 2023 08:54:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666e916b880so624208b3a.2;
        Sat, 17 Jun 2023 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687017265; x=1689609265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8N1Hnn5jyj1NCF8C68i/SNe0pcPIpPHkx+0YD/fzR00=;
        b=EYr9Ogs2KWlWb3NSybj38RlWJ2J9NddfoMbT3UNAFgDBYVlilDY0uq+RPuZYxbNxcX
         Pf8+BRrutoX34U1XKyCvaAezzOjySfnLuh2aBtGZJFYNrpOf62UGgfmuKK2+NWjmhjPM
         Fe7IFLxHt4PTCMOK1cwOwXrMwF2ut74KY7j4ZgdOP2n9009DFCrNfyMvgADG3mzfZmcg
         /rsI0FFx1qa8dw+PnPejf5HGlASQj9feDKeLHW6JnF6vy7MQnOTy5VycMSLBxaF8S1Cq
         Bq+l81U2tBr94nTy5YnwrynboBSopXDWhndJLMN4UF6eHI5NfpHoHVDVRF2tZcAgCyJ7
         8ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687017265; x=1689609265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8N1Hnn5jyj1NCF8C68i/SNe0pcPIpPHkx+0YD/fzR00=;
        b=SNrdchm7mdIZlxAc2xJxQrC56SmXRTXsajxx+BXC9Sq2gZpNvaLdQevunCvshOtY/r
         Cu661S/AO0TkZjbCMddJ2NyNN3Vw3jLk+Q1B91d8NPrvOoMCWZAE/7S1cvoRrauuZBE1
         V0wgYMHkpCx6TEj6oeMj6fLwX2CTC+OoWNDffXJo0iHZqkC2BdySEXkEANBzpXFUVqjJ
         svWOxqMWPnHuY73OZwkWaBNVevMcXtVRKKjHfOLDxu3XJ5V3SoIuRVkxB8IMNwHBS2hz
         w+vmgH7/sFeBuldK9IEWKNriXFHRpPnxUMmE2BFfQA6K0u9X6gMnx0yasnI0dHDQTboi
         pyBA==
X-Gm-Message-State: AC+VfDyzUju+cIzDU/CScjVfsmA8NcPuYbUybl07ee24SEE9qmJJZ/i3
        70IkTgFFz2ud5/FlPzr6bko=
X-Google-Smtp-Source: ACHHUZ78Acu1FEDehx51UI0cVLf/NTQPojYXDyOADeOaujFfi85Eh0hu/24HpAgZJ9sMHOJt7IxvkA==
X-Received: by 2002:a17:90a:de94:b0:256:5a84:c837 with SMTP id n20-20020a17090ade9400b002565a84c837mr3288792pjv.39.1687017265185;
        Sat, 17 Jun 2023 08:54:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a74c900b0025de9b9542dsm3024091pjl.39.2023.06.17.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 08:54:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 17 Jun 2023 08:54:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] hwmon: (sht3x)replace "high-precision" property
 to "repeatability"
Message-ID: <1ff795fe-2fe6-42dd-861c-ae9a7886096c@roeck-us.net>
References: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
 <DB4PR10MB626113BFFA66DE32C3479D229258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB4PR10MB626113BFFA66DE32C3479D229258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
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

On Sat, Jun 17, 2023 at 12:00:14AM +0800, JuenKit Yip wrote:
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>

Checkpatch rightfully says:

WARNING: Missing commit description - Add an appropriate one

Please always provide a commit description. I'll do that here,
so no need to resend, but please keep it in mind when sending
future patches.

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/sht3x.rst |  2 +-
>  drivers/hwmon/sht3x.c         | 21 +++++++++++++--------
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
> index be70e2543..b4aa561f0 100644
> --- a/Documentation/hwmon/sht3x.rst
> +++ b/Documentation/hwmon/sht3x.rst
> @@ -30,7 +30,7 @@ Documentation/i2c/instantiating-devices.rst for methods to instantiate the devic
>  
>  There is only one option configurable by means of sht3x_data:
>  
> -   high or low accuracy. High accuracy is used by default and using it is
> +   repeatability: high repeatability is used by default and using it is
>     strongly recommended.
>  
>  Even if sht3x sensor supports clock-strech(blocking mode) and non-strench
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index bbe556f44..ecc64febc 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -21,10 +21,10 @@
>  #include <linux/slab.h>
>  #include <linux/jiffies.h>
>  
> -/* commands (high precision mode) */
> +/* commands (high repeatability mode) */
>  static const unsigned char sht3x_cmd_measure_single_hpm[] = { 0x24, 0x00 };
>  
> -/* commands (low power mode) */
> +/* commands (low repeatability mode) */
>  static const unsigned char sht3x_cmd_measure_single_lpm[] = { 0x24, 0x16 };
>  
>  /* commands for periodic mode */
> @@ -66,9 +66,14 @@ enum sht3x_limits {
>  	limit_min_hyst,
>  };
>  
> +enum sht3x_repeatability {
> +	low_repeatability,
> +	high_repeatability,
> +};
> +
>  DECLARE_CRC8_TABLE(sht3x_crc8_table);
>  
> -/* periodic measure commands (high precision mode) */
> +/* periodic measure commands (high repeatability mode) */
>  static const char periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
>  	/* 0.5 measurements per second */
>  	{0x20, 0x32},
> @@ -82,7 +87,7 @@ static const char periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
>  	{0x27, 0x37},
>  };
>  
> -/* periodic measure commands (low power mode) */
> +/* periodic measure commands (low repeatability mode) */
>  static const char periodic_measure_commands_lpm[][SHT3X_CMD_LENGTH] = {
>  	/* 0.5 measurements per second */
>  	{0x20, 0x2f},
> @@ -132,7 +137,7 @@ struct sht3x_data {
>  	const unsigned char *command;
>  	u32 wait_time;			/* in us*/
>  	unsigned long last_update;	/* last update in periodic mode*/
> -	bool high_precision;
> +	enum sht3x_repeatability repeatability;
>  
>  	/*
>  	 * cached values for temperature and humidity and limits
> @@ -436,7 +441,7 @@ static void sht3x_select_command(struct sht3x_data *data)
>  		data->command = sht3x_cmd_measure_periodic_mode;
>  		data->wait_time = 0;
>  	} else {
> -		if (data->high_precision) {
> +		if (data->repeatability == high_repeatability) {
>  			data->command = sht3x_cmd_measure_single_hpm;
>  			data->wait_time = SHT3X_SINGLE_WAIT_TIME_HPM;
>  		} else {
> @@ -584,7 +589,7 @@ static ssize_t update_interval_store(struct device *dev,
>  	}
>  
>  	if (mode > 0) {
> -		if (data->high_precision)
> +		if (data->repeatability == high_repeatability)
>  			command = periodic_measure_commands_hpm[mode - 1];
>  		else
>  			command = periodic_measure_commands_lpm[mode - 1];
> @@ -679,7 +684,7 @@ static int sht3x_probe(struct i2c_client *client)
>  	if (!data)
>  		return -ENOMEM;
>  
> -	data->high_precision = true;
> +	data->repeatability = high_repeatability;
>  	data->mode = 0;
>  	data->last_update = jiffies - msecs_to_jiffies(3000);
>  	data->client = client;
