Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0251E70A833
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjETMyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETMyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:54:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BD9F3;
        Sat, 20 May 2023 05:54:12 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-52cb78647ecso2983941a12.1;
        Sat, 20 May 2023 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684587252; x=1687179252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBGZTEHxFzh1C5Lslp4jncjBXYVdmNg9K47Jx88WGQE=;
        b=Y++gwQjI7BH9qpbeM8vS1ykEmFOkabkIevFlGvlme+h20rrtj8tVgj1nV+A8NcIl1o
         W6NshtKVeSSx52YMR8uYNkvg7pX9HIqdAa3Cu7WQHCuPV6zzB2/q8SvFVpa9FyaIq+2Y
         QiuTpyEBuPy5hrYXeIWgUSrv2GpQGkT5FEo6Wsd1gpG48cSLXhGTbcEEzLzIOpKhp5T0
         NTePBN89GVC2khXYwwEsCFxcJs+L45wi9W+LVkyx42zMUABWW4MvZCq6wfjaaarXw579
         qFF6ZEF0ZslOrdTttcV8qUTxRJuRWERRTwt0Rd22io2WN+qlufcOQdWnp+CTP4hXJflr
         YTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684587252; x=1687179252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBGZTEHxFzh1C5Lslp4jncjBXYVdmNg9K47Jx88WGQE=;
        b=c3QV4Hj9NEowIRk3LnRyA2C2IA1ch+x+h9/PhjDCcyS8YmZT8D5R2V1fUtvpx8b6zs
         RL+eOwuicHOvTh5xsKxPgGtZY0pzu0Vn/WLH0UrFSqE4XfWI16rnJz2hrEBngdsjIMXq
         l/QChLvdjvxOTiO+fM1kkZBX0sUSTtXONEymfEF9jhHgfg9Aq5fqShQtcrnkToqf2r2S
         o0G0To4yOQ9sxsOwz5+YV49b3lhN3sQVmTWtvEa2YX6232TwYWStTH9RdOpRac48k0F0
         +cQcVJwISfgqgbrJ3+NGgQcY69upqYu9p8Q47lYF6P7nd1tG4r+5X/m/nz8iZUkAmYT9
         yAkw==
X-Gm-Message-State: AC+VfDxVQzheagAAMKznGiqzjVKfR5nNqT4GGBBET7G/fyrbD0udUbBR
        TzhAOYBdXhQW4NiK48EUG14=
X-Google-Smtp-Source: ACHHUZ4gprIGVTucYq7ZZC7xXNIIemykJOQyrJJ1HQMaCnWUui1ZWPF5ayC0FtppAcqYmgdrTkyM3A==
X-Received: by 2002:a17:903:2306:b0:1ac:656f:a697 with SMTP id d6-20020a170903230600b001ac656fa697mr6388701plh.21.1684587251865;
        Sat, 20 May 2023 05:54:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902b59200b001a988a71617sm1429545pls.192.2023.05.20.05.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 05:54:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 20 May 2023 05:54:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, main@ehvag.de,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (aquacomputer_d5next) Rename
 AQC_TEMP_SENSOR_DISCONNECTED
Message-ID: <ad8bd083-9fc4-4745-a272-21d79f728ad1@roeck-us.net>
References: <20230520095447.509287-1-savicaleksa83@gmail.com>
 <20230520095447.509287-2-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520095447.509287-2-savicaleksa83@gmail.com>
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

On Sat, May 20, 2023 at 11:54:46AM +0200, Aleksa Savic wrote:
> Rename the macro in question to AQC_SENSOR_NA because
> more than just temperature sensors use this value to
> indicate that they don't have a reading. Implemented by
> Noah Bergbauer [1].
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/41
> 
> Originally-from: Noah Bergbauer <main@ehvag.de>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter

> ---
> Changes in v2:
> - Introduced this patch
> ---
>  drivers/hwmon/aquacomputer_d5next.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index a4fcd4ebf76c..834d011e220f 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -93,7 +93,7 @@ static u8 aquaero_secondary_ctrl_report[] = {
>  #define AQC_FIRMWARE_VERSION		0xD
>  
>  #define AQC_SENSOR_SIZE			0x02
> -#define AQC_TEMP_SENSOR_DISCONNECTED	0x7FFF
> +#define AQC_SENSOR_NA			0x7FFF
>  #define AQC_FAN_PERCENT_OFFSET		0x00
>  #define AQC_FAN_VOLTAGE_OFFSET		0x02
>  #define AQC_FAN_CURRENT_OFFSET		0x04
> @@ -1224,7 +1224,7 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>  		sensor_value = get_unaligned_be16(data +
>  						  priv->temp_sensor_start_offset +
>  						  i * AQC_SENSOR_SIZE);
> -		if (sensor_value == AQC_TEMP_SENSOR_DISCONNECTED)
> +		if (sensor_value == AQC_SENSOR_NA)
>  			priv->temp_input[i] = -ENODATA;
>  		else
>  			priv->temp_input[i] = sensor_value * 10;
> @@ -1235,7 +1235,7 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>  		sensor_value = get_unaligned_be16(data +
>  						  priv->virtual_temp_sensor_start_offset +
>  						  j * AQC_SENSOR_SIZE);
> -		if (sensor_value == AQC_TEMP_SENSOR_DISCONNECTED)
> +		if (sensor_value == AQC_SENSOR_NA)
>  			priv->temp_input[i] = -ENODATA;
>  		else
>  			priv->temp_input[i] = sensor_value * 10;
> @@ -1277,7 +1277,7 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>  			sensor_value = get_unaligned_be16(data +
>  					priv->calc_virt_temp_sensor_start_offset +
>  					j * AQC_SENSOR_SIZE);
> -			if (sensor_value == AQC_TEMP_SENSOR_DISCONNECTED)
> +			if (sensor_value == AQC_SENSOR_NA)
>  				priv->temp_input[i] = -ENODATA;
>  			else
>  				priv->temp_input[i] = sensor_value * 10;
