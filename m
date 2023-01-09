Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADE2662B16
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjAIQWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjAIQWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:22:42 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A32231;
        Mon,  9 Jan 2023 08:22:41 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id e17-20020a9d7311000000b00678202573f1so5421608otk.8;
        Mon, 09 Jan 2023 08:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQm8dR/XHPVykaByHc76wRoeysV+gD3DuL1oGzIuixk=;
        b=R8iupi7BoPbpnRhTmvb9KW+bNBmHtOqNgYvHtWAGtTw2a9ljRkM2bNJyhpx/aG1tBO
         LVRPTUvTlmaW0SJ6V0SFJ4eYuMxexjWW413IJbS9wk38B1kJGbPszmM21RirBcj0HbCd
         dM/JayPgouzqoBglh05qvwp0ML3Dsx4iSsZluijjpcX3tS6jfHhef2tzoqdKRtHqAGu8
         PbSEYP13Qow9UXpOdyWTSb+dEN+62PQbBo4N4BgWqkyptyaZX3rTkKPEeKwq88AGIYyy
         kuy4SALEUBJPUAgd3DueKfNbEvbZqBPtWz9YBS/JdrWgFfcFgsP4GA5mW2GCpw5UlpGJ
         srrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQm8dR/XHPVykaByHc76wRoeysV+gD3DuL1oGzIuixk=;
        b=a5D9EBAkAzTrbn5lScL8sNigFIDq+nInlYFbAGvtJ+G8VXJ7vI8hr3P8P7sjO7+JZF
         Bz6pqe8/3jfm8K81yoLOc1L9vQQT3TAtjHG9V4BUFuV/9ZzxOVHXk0qMJOcxv7Z9Vfm7
         YH85QHj+CENXJpPfkSATNnkyDY7CBu6E5grzfBJoW+Lf4pv5dzNgGHDkGysdIpqS2byO
         1H6Qx3CB8rDcplqEVoUZj3BDRDhj+VIgQMO4WKmbDY/SzqrjmgLe8pqza8iB9B9LEB7h
         7c7SoQYVSgQFlaX6NfD3BUNgSPUQ9kc0n/gmBF8PnQ30YHO6OcDzG1DyQkeV8Ab8hoVW
         dzNQ==
X-Gm-Message-State: AFqh2kpf4Aq/bBoGuxE74IF3LXmQX8Qvc7IVYE1+RbHKiRUq1WljB020
        Yj8R5qIxdk95DIRBTY2BLNI=
X-Google-Smtp-Source: AMrXdXvteD1YsNjg3D04ZpZ2ivFboNHM0uD8eMCnF69EtkjtArFkwRdiqXcMFx4dvdHz4grRDMrvvw==
X-Received: by 2002:a05:6830:929:b0:670:9f08:2c48 with SMTP id v41-20020a056830092900b006709f082c48mr41665961ott.9.1673281361068;
        Mon, 09 Jan 2023 08:22:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ca18-20020a056830611200b0066e873e4c2csm4926372otb.45.2023.01.09.08.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 08:22:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4ded6dcb-0bf0-60a4-9386-b39cea457cc7@roeck-us.net>
Date:   Mon, 9 Jan 2023 08:22:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     ahmad@khalifa.ws, chunkeey@gmail.com, greg@krypto.org,
        hubert.banas@gmail.com, igor@svelig.com, jaap.dehaan@freenet.de,
        jdelvare@suse.com, jeroen@beerstra.org, jonfarr87@gmail.com,
        jwp@redhat.com, kdudka@redhat.com, kernel@melin.net,
        kpietrzak@disroot.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, me@rebtoor.com,
        metalcaedes@gmail.com, michael@theoddone.net,
        mikhail.v.gavrilov@gmail.com, mundanedefoliation@gmail.com,
        nephartyz@gmail.com, oleksandr@natalenko.name, pehlm@pekholm.org,
        renedis@hotmail.com, robert@swiecki.net,
        sahan.h.fernando@gmail.com, sebastian.arnhold@posteo.de,
        sefoci9222@rerunway.com, sst@poczta.fm, to.eivind@gmail.com,
        torvic9@mailbox.org
References: <20230109133536.5720-1-pauk.denis@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] hwmon: (nct6775) Directly call ASUS ACPI WMI method
In-Reply-To: <20230109133536.5720-1-pauk.denis@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 05:35, Denis Pauk wrote:
> New ASUS B650/B660/X670 boards firmware have not exposed WMI monitoring
> GUID  and entrypoint method WMBD could be implemented for different device
> UID.
> 
> Implement the direct call to entrypoint method for monitoring the device
> UID of B550/X570 boards.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Co-developed-by: Ahmad Khalifa <ahmad@khalifa.ws>
> Signed-off-by: Ahmad Khalifa <ahmad@khalifa.ws>
> ---
>   drivers/hwmon/Kconfig            |   2 +-
>   drivers/hwmon/nct6775-platform.c | 100 ++++++++++++++++++++++---------
>   2 files changed, 72 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 3176c33af6c6..300ce8115ce4 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1516,7 +1516,7 @@ config SENSORS_NCT6775_CORE
>   config SENSORS_NCT6775
>   	tristate "Platform driver for Nuvoton NCT6775F and compatibles"
>   	depends on !PPC
> -	depends on ACPI_WMI || ACPI_WMI=n
> +	depends on ACPI || ACPI=n
>   	select HWMON_VID
>   	select SENSORS_NCT6775_CORE
>   	help
> diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
> index bf43f73dc835..7f5b430e1e2c 100644
> --- a/drivers/hwmon/nct6775-platform.c
> +++ b/drivers/hwmon/nct6775-platform.c
> @@ -17,7 +17,6 @@
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
> -#include <linux/wmi.h>
>   
>   #include "nct6775.h"
>   
> @@ -107,40 +106,44 @@ struct nct6775_sio_data {
>   	void (*sio_exit)(struct nct6775_sio_data *sio_data);
>   };
>   
> -#define ASUSWMI_MONITORING_GUID		"466747A0-70EC-11DE-8A39-0800200C9A66"
> +#define ASUSWMI_METHOD			"WMBD"
>   #define ASUSWMI_METHODID_RSIO		0x5253494F
>   #define ASUSWMI_METHODID_WSIO		0x5753494F
>   #define ASUSWMI_METHODID_RHWM		0x5248574D
>   #define ASUSWMI_METHODID_WHWM		0x5748574D
>   #define ASUSWMI_UNSUPPORTED_METHOD	0xFFFFFFFE
> +#define ASUSWMI_DEVICE_HID		"PNP0C14"
> +#define ASUSWMI_DEVICE_UID		"ASUSWMI"
> +
> +struct acpi_device *asus_acpi_dev;
>   
>   static int nct6775_asuswmi_evaluate_method(u32 method_id, u8 bank, u8 reg, u8 val, u32 *retval)
>   {
> -#if IS_ENABLED(CONFIG_ACPI_WMI)
> +#if IS_ENABLED(CONFIG_ACPI)
> +	acpi_handle handle = acpi_device_handle(asus_acpi_dev);
>   	u32 args = bank | (reg << 8) | (val << 16);
> -	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
> -	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct acpi_object_list input;
> +	union acpi_object params[3];
> +	unsigned long long result;
>   	acpi_status status;
> -	union acpi_object *obj;
> -	u32 tmp = ASUSWMI_UNSUPPORTED_METHOD;
> -
> -	status = wmi_evaluate_method(ASUSWMI_MONITORING_GUID, 0,
> -				     method_id, &input, &output);
>   
> +	params[0].type = ACPI_TYPE_INTEGER;
> +	params[0].integer.value = 0;
> +	params[1].type = ACPI_TYPE_INTEGER;
> +	params[1].integer.value = method_id;
> +	params[2].type = ACPI_TYPE_BUFFER;
> +	params[2].buffer.length = sizeof(args);
> +	params[2].buffer.pointer = (void *)&args;
> +	input.count = 3;
> +	input.pointer = params;
> +
> +	status = acpi_evaluate_integer(handle, ASUSWMI_METHOD, &input, &result);
>   	if (ACPI_FAILURE(status))
>   		return -EIO;
>   
> -	obj = output.pointer;
> -	if (obj && obj->type == ACPI_TYPE_INTEGER)
> -		tmp = obj->integer.value;
> -
>   	if (retval)
> -		*retval = tmp;
> -
> -	kfree(obj);
> +		*retval = (u32)result & 0xFFFFFFFF;
>   
> -	if (tmp == ASUSWMI_UNSUPPORTED_METHOD)
> -		return -ENODEV;
>   	return 0;
>   #else
>   	return -EOPNOTSUPP;
> @@ -1099,6 +1102,53 @@ static const char * const asus_wmi_boards[] = {
>   	"TUF GAMING Z490-PLUS (WI-FI)",
>   };
>   
> +struct each_port_arg {
> +	struct acpi_device *adev;
> +	const char *match;
> +};
> +
> +/*
> + * Callback for acpi_bus_for_each_dev() to find the
> + * right device by _UID and _HID and stop.
> + * return is an error to exit the loop

This is a match function, which does not and should not return error/0
but a match result (true / false or 1/0), and it should be named
accordingly.

> + */
> +static int nct6775_find_asus_acpi(struct device *dev, void *data)
> +{
> +	struct acpi_device *adev = to_acpi_device(dev);
> +	const char *uid = acpi_device_uid(adev);
> +	const char *hid = acpi_device_hid(adev);
> +	struct each_port_arg *arg = data;
> +
> +	if (hid && !strcmp(hid, ASUSWMI_DEVICE_HID) &&
> +		uid && !strcmp(uid, arg->match)) {
> +		arg->adev = adev;
> +		return -EEXIST;

... and is most definitely should not return "File Exists".

> +	}
> +
> +	return 0;
> +}
> +
> +static enum sensor_access nct6775_determine_access(const char *device_uid)
> +{
> +	struct each_port_arg arg;
> +	u8 tmp;
> +
> +	arg.match = device_uid;
> +	acpi_bus_for_each_dev(nct6775_find_asus_acpi, &arg);
> +	if (!arg.adev)
> +		return access_direct;
> +
> +	asus_acpi_dev = arg.adev;
> +	/* if reading chip id via ACPI succeeds, use WMI "WMBD" method for access */
> +	if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp) && tmp) {
> +		pr_info("Using Asus ACPI to access %#x chip.\n", tmp);

Please reduce the noise. Make this a debug message if you think you need it.

> +		return access_asuswmi;
> +	}
> +
> +	pr_err("Can't read ChipID by Asus ACPI %s device.\n", device_uid);

If this is an error, I expect the code to return an error and abort
the probe function. Otherwise make it a debug message. Also, even as
debug message this is misleading, because it suggests and error when
the result is really that the code uses direct access. There should
be something like "Using direct access" or "Accessing chip registers
directly" in the message.

> +	return access_direct;
> +}
> +
>   static int __init sensors_nct6775_platform_init(void)
>   {
>   	int i, err;
> @@ -1109,7 +1159,6 @@ static int __init sensors_nct6775_platform_init(void)
>   	int sioaddr[2] = { 0x2e, 0x4e };
>   	enum sensor_access access = access_direct;
>   	const char *board_vendor, *board_name;
> -	u8 tmp;
>   
>   	err = platform_driver_register(&nct6775_driver);
>   	if (err)
> @@ -1122,15 +1171,8 @@ static int __init sensors_nct6775_platform_init(void)
>   	    !strcmp(board_vendor, "ASUSTeK COMPUTER INC.")) {
>   		err = match_string(asus_wmi_boards, ARRAY_SIZE(asus_wmi_boards),
>   				   board_name);
> -		if (err >= 0) {
> -			/* if reading chip id via WMI succeeds, use WMI */
> -			if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp) && tmp) {
> -				pr_info("Using Asus WMI to access %#x chip.\n", tmp);
> -				access = access_asuswmi;
> -			} else {
> -				pr_err("Can't read ChipID by Asus WMI.\n");
> -			}

Ah, that noise was already there. Comments above still apply, though.

Thanks,
Guenter

> -		}
> +		if (err >= 0)
> +			access = nct6775_determine_access(ASUSWMI_DEVICE_UID);
>   	}
>   
>   	/*
> 
> base-commit: b0587c87abc891e313d63946ff8c9f4939d1ea1a

