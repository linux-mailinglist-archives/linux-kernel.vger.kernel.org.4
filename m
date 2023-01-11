Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB26B66508B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjAKAsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbjAKAsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:48:40 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB032116;
        Tue, 10 Jan 2023 16:48:39 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id e205so11552623oif.11;
        Tue, 10 Jan 2023 16:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q06FqpFx0nvKrzdQDalDMDAWRkL1oZcppaMTnZE7VQg=;
        b=LEpqKcFO9ek/11ZsxN3ZV5hy/jP99P0frEJIbbbnjy/IKtwN7qn1KuwY3yxmLMj2tw
         44OLNAYujqUGv5cadkI4IFTwUimOzUJHch/K8rsNndEm/nir4fazy/dPrelIIBWP4XOU
         7ja53Thme/DcJtM7bLeBNLiUDMAu8bLy1iIk86ZrQQCrrDQKlIW2qRqUuIVqI5nT5sTi
         81dZGcSmlC7o7I0x1LhtbS4PABFdQAcCCg1ndST7ve08ATS1AuYsILzzcTtWxL2i21Gj
         dvDXBVbHVIjVqFr7FJNqBp2cGDDGKCUfYdY9mXCwD3uGXhG/kzPFAtnLWtMmHlp76BLJ
         pmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q06FqpFx0nvKrzdQDalDMDAWRkL1oZcppaMTnZE7VQg=;
        b=GoOhrFmBed0vU7VZXCS7VVj5eNPMO58IhAB5wamXwi+4d8SUsc5TN2NA382AvmaIER
         YdZdX9L+sEbXV6CjTSmB1NtG9Y+IQyRWh5RY1xeATtB2If/aUhXH5jHrxPXJmU8zjscs
         iStyB3R8dnmrfD79fvS0ft+LtS4V5qZ/KBxOPhwLSvOEqTbtWejqhqMmr+nY7dEb4KSc
         vDZbiuKUnbd0c89gf5BVc2z8DF/gqHr68HUpmz064GvxxUrK6YkgPBMq8ZUqS4+O1q8G
         ETcb5VflPKxY5MdVLUcrf6lUQfWYnLmxV510pe/O7T7PtkYpkPNwm0GPplusbibbdF2r
         H/2Q==
X-Gm-Message-State: AFqh2kpdzkNjNnDn1KQXZhMK20XckswDxqAq9lH2fMAjQxPEjslNML2+
        onrf0IGyraRZvYlQswcwlP0=
X-Google-Smtp-Source: AMrXdXtWpr98L9SYHWVg+XbPYXbpf+Mt/n2iKRtIgSLmT1/XXKF1RAMj6kwZPy5TNiu4BTmX1ZfJvg==
X-Received: by 2002:a05:6808:1290:b0:355:1df0:9b84 with SMTP id a16-20020a056808129000b003551df09b84mr45177228oiw.2.1673398118919;
        Tue, 10 Jan 2023 16:48:38 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g21-20020a0568080dd500b00360f68d509csm5996950oic.49.2023.01.10.16.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 16:48:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a790fdb2-69f4-aa59-8459-f156774238f7@roeck-us.net>
Date:   Tue, 10 Jan 2023 16:48:33 -0800
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
        sst@poczta.fm, to.eivind@gmail.com, torvic9@mailbox.org
References: <20230110224823.14524-1-pauk.denis@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 1/2] hwmon: (nct6775) Directly call ASUS ACPI WMI
 method
In-Reply-To: <20230110224823.14524-1-pauk.denis@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 1/10/23 14:48, Denis Pauk wrote:
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
> Changes:
> v1:
>    Rename each_port_arg to each_device_arg
>    Rename nct6775_find_asus_acpi to nct6775_asuswmi_device_match
>    Remove unrequired return -EEXIST, and iterate whole list of devices
>    Make asus_acpi_dev static
> v2:
>    Restore break iteration logic in nct6775_asuswmi_device_match
>    Add config check if ACPI disabled and acpi_device_* are undefined
>    Pass device_id as data parameter of acpi_bus_for_each_dev
> 
>>> Also, the use of a static variable makes me wonder: would asus_acpi_dev
>     be the same for both chips if there are two Super-IO chips in the system ?
> 
> Available B550/X570/B650/B660/X670 firmwares have contained only one device
> with WMBD method and provided proxy only to 0x0270 port. Difference between
> board generation is only in name of the such device.
> 
>   drivers/hwmon/Kconfig            |  2 +-
>   drivers/hwmon/nct6775-platform.c | 97 ++++++++++++++++++++++----------
>   2 files changed, 69 insertions(+), 30 deletions(-)
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
> index bf43f73dc835..082f48785999 100644
> --- a/drivers/hwmon/nct6775-platform.c
> +++ b/drivers/hwmon/nct6775-platform.c
> @@ -17,7 +17,6 @@
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
> -#include <linux/wmi.h>

0-day reported various errors. I suspect those are seen with CONFIG_ACPI=n.
Have you tried the build reported as problematic ?

I get

drivers/hwmon/nct6775-platform.c:122:28: error: ‘asus_acpi_dev’ defined but not used [-Werror=unused-variable]
   122 | static struct acpi_device *asus_acpi_dev;

if I try to build nct6775-platform.o with W=1 and CONFIG_ACPI=n.

Overall the #ifdefs in the driver get a bit out of hand. I think it
may be time to consolidate that. Not necessarily now, but sometime soon.

Guenter

>   
>   #include "nct6775.h"
>   
> @@ -107,40 +106,48 @@ struct nct6775_sio_data {
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
> +/*
> + * ASUS boards have only one device with WMI "WMBD" method and have provided
> + * access to only one SuperIO chip at 0x0290.
> + */
> +static struct acpi_device *asus_acpi_dev;
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
> @@ -1099,6 +1106,46 @@ static const char * const asus_wmi_boards[] = {
>   	"TUF GAMING Z490-PLUS (WI-FI)",
>   };
>   
> +#if IS_ENABLED(CONFIG_ACPI)
> +/*
> + * Callback for acpi_bus_for_each_dev() to find the right device
> + * by _UID and _HID and return 1 to stop iteration.
> + */
> +static int nct6775_asuswmi_device_match(struct device *dev, void *data)
> +{
> +	struct acpi_device *adev = to_acpi_device(dev);
> +	const char *uid = acpi_device_uid(adev);
> +	const char *hid = acpi_device_hid(adev);
> +
> +	if (hid && !strcmp(hid, ASUSWMI_DEVICE_HID) &&
> +		uid && !strcmp(uid, data)) {
> +		asus_acpi_dev = adev;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static enum sensor_access nct6775_determine_access(const char *device_uid)
> +{
> +#if IS_ENABLED(CONFIG_ACPI)
> +	u8 tmp;
> +
> +	acpi_bus_for_each_dev(nct6775_asuswmi_device_match, (void *)device_uid);
> +	if (!asus_acpi_dev)
> +		return access_direct;
> +
> +	/* if reading chip id via ACPI succeeds, use WMI "WMBD" method for access */
> +	if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp) && tmp) {
> +		pr_debug("Using Asus WMBD method of %s to access %#x chip.\n", device_uid, tmp);
> +		return access_asuswmi;
> +	}
> +#endif
> +
> +	return access_direct;
> +}
> +
>   static int __init sensors_nct6775_platform_init(void)
>   {
>   	int i, err;
> @@ -1109,7 +1156,6 @@ static int __init sensors_nct6775_platform_init(void)
>   	int sioaddr[2] = { 0x2e, 0x4e };
>   	enum sensor_access access = access_direct;
>   	const char *board_vendor, *board_name;
> -	u8 tmp;
>   
>   	err = platform_driver_register(&nct6775_driver);
>   	if (err)
> @@ -1122,15 +1168,8 @@ static int __init sensors_nct6775_platform_init(void)
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
> -		}
> +		if (err >= 0)
> +			access = nct6775_determine_access(ASUSWMI_DEVICE_UID);
>   	}
>   
>   	/*
> 
> base-commit: b0587c87abc891e313d63946ff8c9f4939d1ea1a

