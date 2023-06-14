Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF53872FF44
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244788AbjFNNAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbjFNNAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:00:46 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8CD13E;
        Wed, 14 Jun 2023 06:00:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6667a0811a2so146705b3a.0;
        Wed, 14 Jun 2023 06:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686747645; x=1689339645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=z0efkXJXQRoP2b5ddM9nLHPg0LpXd7kPRZgd4cVIsio=;
        b=o/AcTrtw33RRPhA12x67m8DQ0xENbk9LNyspxNo2W/r0voy5v89rKnadGsYg3Mmwvq
         3tzCy6zQD0Iqbc8tx/9IpUjQaMtXWWWP7+YtRjSeUFtBkTuepy45BaCTrrEhbG6hsM75
         aORkpqLTf5+lYCPGLOPs+KKhY4mNP3Qcr4LUQZticZHHO8UE31CNInhT1wEYrhb+l3Op
         mkZmDq0sORnlrn+nM+SdTITwLFfwIowGHDprtXhiG7l0FhnACqa4j9+9CC+9bRd8ItbS
         mdjT+ONzzgKC91pWVFgFCMbEDy/AmVeerSAqUK5bsYy5OCgmRM3ShKPiHwZim6hoD+iS
         79uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747645; x=1689339645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0efkXJXQRoP2b5ddM9nLHPg0LpXd7kPRZgd4cVIsio=;
        b=OZ6nsd1kw/N1t+tp7v8mOocwSIckOwXI08BrUFwv8gtc37Kn3Bz9miUK/tuoI1Y7Zm
         QfoXiuV8tomMauD1pQsMJlvFFZcNZ1ArqtfeQ0tfqpMQDytuYHxNv9Yg9vbNhspC42WM
         vKne/xlwytErj2mNxjLF3iGGLdjIfELS61aBiPtrchgY9P39P0Pdz+vb/LXgzobW7PVu
         dHozAykrXyc5QJrlQtkuuuQW2mfcR6t1aaGDQzdVHvowq18BB9sbH0UnA/7gxkwr3qQE
         lxJS4TqOfly57i3wOG70GzEVnUzD6ylUa9xNDI0DZL085+Rf+iK/IgyaazBF9BvAmyNg
         VJMQ==
X-Gm-Message-State: AC+VfDybnr96lpTdWgVdbTMDkk9qsgs5jaINS/MmOvGNWHDcg+3VDSpp
        3l+3Qr3fyHldzlFc1QOaBXgmV+TLK0I=
X-Google-Smtp-Source: ACHHUZ5k8hRt8+JNWzzK12jsDb0xJvMAtEqPQgr4wA3edtGtHZxKqjY7EHaecZw27+80y7gDw0MvrQ==
X-Received: by 2002:a05:6a20:734c:b0:ff:a017:2b07 with SMTP id v12-20020a056a20734c00b000ffa0172b07mr1423809pzc.20.1686747644594;
        Wed, 14 Jun 2023 06:00:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v5-20020aa78505000000b006579b062d5dsm1890623pfn.21.2023.06.14.06.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 06:00:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9e9a7066-b841-db97-f8a5-44b2bdac124c@roeck-us.net>
Date:   Wed, 14 Jun 2023 06:00:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] hwmon: (sht3x) add medium repeatability support
Content-Language: en-US
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <DB4PR10MB62615481D91BA8A598234A18925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <DB4PR10MB62615481D91BA8A598234A18925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/13/23 23:27, JuenKit Yip wrote:
> add medium repeatability support for matching datasheet
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
> ---
>   drivers/hwmon/sht3x.c | 29 +++++++++++++++++++++++++++--
>   1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index 5bc0001b1..eb968b9d3 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -25,6 +25,10 @@
>   static const unsigned char sht3x_cmd_measure_blocking_hpm[]    = { 0x2c, 0x06 };
>   static const unsigned char sht3x_cmd_measure_nonblocking_hpm[] = { 0x24, 0x00 };
>   
> +/* commands (medium repeatability mode) */
> +static const unsigned char sht3x_cmd_measure_blocking_mpm[]    = { 0x2c, 0x0d };
> +static const unsigned char sht3x_cmd_measure_nonblocking_mpm[] = { 0x24, 0x0b };
> +
>   /* commands (low repeatability mode) */
>   static const unsigned char sht3x_cmd_measure_blocking_lpm[]    = { 0x2c, 0x10 };
>   static const unsigned char sht3x_cmd_measure_nonblocking_lpm[] = { 0x24, 0x16 };
> @@ -43,6 +47,7 @@ static const unsigned char sht3x_cmd_clear_status_reg[]        = { 0x30, 0x41 };
>   
>   /* delays for non-blocking i2c commands, both in us */
>   #define SHT3X_NONBLOCKING_WAIT_TIME_HPM  15000
> +#define SHT3X_NONBLOCKING_WAIT_TIME_MPM   6000
>   #define SHT3X_NONBLOCKING_WAIT_TIME_LPM   4000
>   
>   #define SHT3X_WORD_LEN         2
> @@ -69,8 +74,9 @@ enum sht3x_limits {
>   };
>   
>   enum sht3x_repeatability {
> -	low_repeatability,
> -	high_repeatability,
> +	low_repeatability    = 0,
> +	medium_repeatability = 1,
> +	high_repeatability   = 2,

Why the assignments ?

>   };
>   
>   DECLARE_CRC8_TABLE(sht3x_crc8_table);
> @@ -89,6 +95,20 @@ static const char periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
>   	{0x27, 0x37},
>   };
>   
> +/* periodic measure commands (medium repeatability) */
> +static const char periodic_measure_commands_mpm[][SHT3X_CMD_LENGTH] = {

FWIW, it might make sense to add the command for blocking mode
(0 measurements per second) into this table to simplify the code.

> +	/* 0.5 measurements per second */
> +	{0x20, 0x24},
> +	/* 1 measurements per second */
> +	{0x21, 0x26},
> +	/* 2 measurements per second */
> +	{0x22, 0x20},
> +	/* 4 measurements per second */
> +	{0x23, 0x22},
> +	/* 10 measurements per second */
> +	{0x27, 0x21},
> +};
> +
>   /* periodic measure commands (low repeatability mode) */
>   static const char periodic_measure_commands_lpm[][SHT3X_CMD_LENGTH] = {
>   	/* 0.5 measurements per second */
> @@ -448,6 +468,9 @@ static void sht3x_select_command(struct sht3x_data *data)
>   		if (data->repeatability == high_repeatability) {
>   			data->command = sht3x_cmd_measure_nonblocking_hpm;
>   			data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_HPM;
> +		} else if (data->repeatability ==  medium_repeatability) {
> +			data->command = sht3x_cmd_measure_nonblocking_mpm;
> +			data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_MPM;
>   		} else {
>   			data->command = sht3x_cmd_measure_nonblocking_lpm;
>   			data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_LPM;
> @@ -595,6 +618,8 @@ static ssize_t update_interval_store(struct device *dev,
>   	if (mode > 0) {
>   		if (data->repeatability == high_repeatability)
>   			command = periodic_measure_commands_hpm[mode - 1];
> +		else if (data->repeatability == medium_repeatability)
> +			command = periodic_measure_commands_mpm[mode - 1];
>   		else
>   			command = periodic_measure_commands_lpm[mode - 1];
>   

