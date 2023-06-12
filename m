Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4472C647
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjFLNp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjFLNpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:45:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD47102;
        Mon, 12 Jun 2023 06:45:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b02fcde49aso22300925ad.0;
        Mon, 12 Jun 2023 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686577521; x=1689169521;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xp+ysS/v9KjrS28d21jERvbnIuHl+Kng4UDxOGkkdY0=;
        b=bfDbHZvF1XV0x+cey7Oft91rGZaLWrcKVuUguVzSUpZKXsnR7qMOqzr82YmdFFDIZa
         oUt5UVhPuej4Fc0VwahKHok28jzeXJ95/caW8bd3y0toAhgQccgeOi5nG0H4ILHePXwT
         sjentxDcMJbFiQ/eZpDOIiy9upFLMhTWW7RCFwhGKfKEBTi8ilQpzFgb2rUCWnqZuahc
         G6AnJ3VZRbb33v+82ouW4oKEbVmcz8CoyNTNHtDZBwkrQMVepZ3MlRsJyccpjIUyaVf/
         4UDGknkiqfvQze3DaHc/+Dla0Z+REc1jrfApjav7aw2sPBEusX80kIgz4WPbD35oh/Qs
         47ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686577521; x=1689169521;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xp+ysS/v9KjrS28d21jERvbnIuHl+Kng4UDxOGkkdY0=;
        b=V2CDLg7qPC9GGu8LwBymoon1vE3uRMbJgi9rolGcKIJM9D5MriB/B01Rvz6/8HEJBC
         RqPP0rqLc2sCcOjDYTgImXVjOnJ2eco30pl4wouwSPC281JH/5VtKOl2Lz00ix8AP+AZ
         6zs2MLmgehOkSrKYr0652ap4leUWIowMrMae6dv5I2+fFmEUM9XWxSwfCQ/EkcnO+nAx
         YAnTf1tcu7+OLRlIC5qXumbxqdc28YckZu84spOItuACcb0Y58qompSX9yzg/9k1Gq3t
         iXJWjje8x8I8Mg1eUZ/4232Iqj/QR/8kufAIVTdo2NY+ycpn5k34rmljIrtAvwiVdNt2
         +uvw==
X-Gm-Message-State: AC+VfDx11PxitSCkhSk3CiYLNs+wJCFXf5c5LVPseV7TzNjGFMfDtqR4
        TyY5yQ62ceQHXeVTrJ6zF8I=
X-Google-Smtp-Source: ACHHUZ4e7YHs8lzAsa4Zx6aQaXABlBueRy897bpfyCBonC8Uci1An3iD9iSrmd9c7Ze8MNNht1oCzQ==
X-Received: by 2002:a17:902:d2c9:b0:1b1:e6a4:2797 with SMTP id n9-20020a170902d2c900b001b1e6a42797mr7516147plc.45.1686577520853;
        Mon, 12 Jun 2023 06:45:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090341c200b001b3d7499141sm1478482ple.72.2023.06.12.06.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 06:45:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c88abaaa-6df9-ed27-698e-568357449393@roeck-us.net>
Date:   Mon, 12 Jun 2023 06:45:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <DB4PR10MB62612F917CF1BF8FB03927609254A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
 <898a6ebb-b0cc-5a48-30da-c4a5dc19d1a4@roeck-us.net>
 <DB4PR10MB6261BFA04779E6BCFF7A07799254A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC] sht3x code modifcation
In-Reply-To: <DB4PR10MB6261BFA04779E6BCFF7A07799254A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 02:58, JuenKit Yip wrote:
> The original code only support two mode: high-precision mode(high repeatability and
> 10Hz periodic measurement) and low-power mode(low repeatability and 0.5Hz measurement),
> but in fact this sensor support 5 periodic measurement duration(and single shot) and
> 3 repeatability which are not fully implemented.
> High-precision mode was defined manually so that I think that we should reserve the
> right to user to choose which one repeatability and periodic measurement is the best.
> I just put the patch for reference and hope you could give any comments.
> Medium-repeatability was not added into code and I hope put it later.
> 
> If you have any other further question, kindly contact to me.
> Thanks
> 
> Juen Kit Yip
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
> 

So this patch replaces the term "high precision" with "high repeatability",
"low power" with "low repeatability", and it removes the ability to select
high vs. low precision / repeatability from platform data.

I would accept a patch removing platform data entirely since there is
no in-tree driver supporting it. The ability to select precision
(or reliability) should still be supported, possibly with a non-standard
sysfs attribute. You might consider sending a series of patches.

1) Remove platform data support
2) (optional) Convert driver to with_info API
3) Replace "precision" with "repeatability" to match datasheet
    terminology
4) Implement a non-standard sysfs attribute such as "repeatability"
    to support selecting high/medium/low repeatability.
5) (optional) Implement devicetree support.

Guenter

> ---
>   Documentation/hwmon/sht3x.rst       |  6 ++----
>   drivers/hwmon/sht3x.c               | 27 +++++++++++++++++----------
>   include/linux/platform_data/sht3x.h |  1 -
>   3 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
> index 95a850d5b..c6b7a1aa5 100644
> --- a/Documentation/hwmon/sht3x.rst
> +++ b/Documentation/hwmon/sht3x.rst
> @@ -28,15 +28,13 @@ The device communicates with the I2C protocol. Sensors can have the I2C
>   addresses 0x44 or 0x45, depending on the wiring. See
>   Documentation/i2c/instantiating-devices.rst for methods to instantiate the device.
> 
> -There are two options configurable by means of sht3x_platform_data:
> +There is only one option configurable by means of sht3x_platform_data:
> 
> -1. blocking (pull the I2C clock line down while performing the measurement) or
> +   blocking (pull the I2C clock line down while performing the measurement) or
>      non-blocking mode. Blocking mode will guarantee the fastest result but
>      the I2C bus will be busy during that time. By default, non-blocking mode
>      is used. Make sure clock-stretching works properly on your device if you
>      want to use blocking mode.
> -2. high or low accuracy. High accuracy is used by default and using it is
> -   strongly recommended.
> 
>   The sht3x sensor supports a single shot mode as well as 5 periodic measure
>   modes, which can be controlled with the update_interval sysfs interface.
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index 8305e44d9..6065312ae 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -22,11 +22,11 @@
>   #include <linux/jiffies.h>
>   #include <linux/platform_data/sht3x.h>
> 
> -/* commands (high precision mode) */
> +/* commands (high repeatability mode) */
>   static const unsigned char sht3x_cmd_measure_blocking_hpm[]    = { 0x2c, 0x06 };
>   static const unsigned char sht3x_cmd_measure_nonblocking_hpm[] = { 0x24, 0x00 };
> 
> -/* commands (low power mode) */
> +/* commands (low repeatability mode) */
>   static const unsigned char sht3x_cmd_measure_blocking_lpm[]    = { 0x2c, 0x10 };
>   static const unsigned char sht3x_cmd_measure_nonblocking_lpm[] = { 0x24, 0x16 };
> 
> @@ -69,9 +69,14 @@ enum sht3x_limits {
>       limit_min_hyst,
>   };
> 
> +enum sht3x_repeatability {
> +    high_repeatability,
> +    low_repeatability,
> +};
> +
>   DECLARE_CRC8_TABLE(sht3x_crc8_table);
> 
> -/* periodic measure commands (high precision mode) */
> +/* periodic measure commands (high repeatability mode) */
>   static const char periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
>       /* 0.5 measurements per second */
>       {0x20, 0x32},
> @@ -85,7 +90,7 @@ static const char periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
>       {0x27, 0x37},
>   };
> 
> -/* periodic measure commands (low power mode) */
> +/* periodic measure commands (low repeatability mode) */
>   static const char periodic_measure_commands_lpm[][SHT3X_CMD_LENGTH] = {
>       /* 0.5 measurements per second */
>       {0x20, 0x2f},
> @@ -132,6 +137,7 @@ struct sht3x_data {
>       struct mutex data_lock; /* lock for updating driver data */
> 
>       u8 mode;
> +    enum sht3x_repeatability repeatability;
>       const unsigned char *command;
>       u32 wait_time;            /* in us*/
>       unsigned long last_update;    /* last update in periodic mode*/
> @@ -442,12 +448,13 @@ static void sht3x_select_command(struct sht3x_data *data)
>           data->command = sht3x_cmd_measure_periodic_mode;
>           data->wait_time = 0;
>       } else if (data->setup.blocking_io) {
> -        data->command = data->setup.high_precision ?
> -                sht3x_cmd_measure_blocking_hpm :
> -                sht3x_cmd_measure_blocking_lpm;
> +        if(data->repeatability == high_repeatability)
> +            data->command = sht3x_cmd_measure_blocking_hpm;
> +        else if(data->repeatability == low_repeatability)
> +            data->command = sht3x_cmd_measure_blocking_lpm;
>           data->wait_time = 0;
>       } else {
> -        if (data->setup.high_precision) {
> +        if (data->repeatability == high_repeatability) {
>               data->command = sht3x_cmd_measure_nonblocking_hpm;
>               data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_HPM;
>           } else {
> @@ -595,7 +602,7 @@ static ssize_t update_interval_store(struct device *dev,
>       }
> 
>       if (mode > 0) {
> -        if (data->setup.high_precision)
> +        if (data->repeatability == high_repeatability)
>               command = periodic_measure_commands_hpm[mode - 1];
>           else
>               command = periodic_measure_commands_lpm[mode - 1];
> @@ -691,7 +698,7 @@ static int sht3x_probe(struct i2c_client *client)
>           return -ENOMEM;
> 
>       data->setup.blocking_io = false;
> -    data->setup.high_precision = true;
> +    data->repeatability = high_repeatability;
>       data->mode = 0;
>       data->last_update = jiffies - msecs_to_jiffies(3000);
>       data->client = client;
> diff --git a/include/linux/platform_data/sht3x.h b/include/linux/platform_data/sht3x.h
> index 14680d2a9..626c1404a 100644
> --- a/include/linux/platform_data/sht3x.h
> +++ b/include/linux/platform_data/sht3x.h
> @@ -10,6 +10,5 @@
> 
>   struct sht3x_platform_data {
>       bool blocking_io;
> -    bool high_precision;
>   };
>   #endif /* __SHT3X_H_ */

