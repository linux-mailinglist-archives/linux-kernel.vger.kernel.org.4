Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E29A6634DA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbjAIXKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjAIXJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:09:57 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7237E3B90E;
        Mon,  9 Jan 2023 15:09:56 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id e205so8565988oif.11;
        Mon, 09 Jan 2023 15:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NeB2WP3G3p2A8QP68r0F1gYeM3d0wPSRqqdorg4gDko=;
        b=UJ50J9UWJVNGirM1cO/n4wtv1M4LaPceOI+f2v+rWSasLuUej6MWBQMA7Ssjg3Okhs
         0iSyCBZeuGBZYfakVf5lS2xwqVZobI2J6TvsEisykvjJKvEoATJHo8317XXuPnj9/ZYF
         ru7LnRPGHCjiRCBIn6ELCZMKrU+bV9hG3BwXGKfvUXMpMyRIlH/1Dx157yHzDcw5lDEw
         kNXTdOOF6FUhyG24bBLRLfjETDSD2DSn0j/Zjkn+9eZzH7Yp5rakscFNOEjdxcax5yx/
         2agJltd92ztxq3K9D8kw4oiGkjgq924fv0FeFkIJE3ECgMleJHVxNJ1fXrze1a4VtipP
         3vwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NeB2WP3G3p2A8QP68r0F1gYeM3d0wPSRqqdorg4gDko=;
        b=Pjng5HW0D0yEjz3mhMJMx5nKUKyuRz4fTOF73MrKpQ43KXmG/7KfUM5EUOHYxLWVOn
         A4a7KE8wnhLtJcJmbFjoyFAmtfbt+N6oKw9qHx0LTmBeO844iM7lO+N6ujcshBvdVBNj
         aM6qj/blRGeg9fiRQvsp/npYCipOOGdqIgc0PLhEcIQaCgi5QUvjd6NhmBFv7v6DQhiT
         sEdXIAhnZeVdg3JdrpkVMZt308J3sTe6t50Pg6VoU3fBkgebZ0r3ho6fQv9r/vOJ9Qwr
         /vNSCSOjasxAvaaY2VLHvIUNn0D9QzuvmAZjzrktFH+JX2SvrTYTqu2ULmInpSimA2m6
         bCsw==
X-Gm-Message-State: AFqh2kr+0aiIqmXIro8fe7rNgbqmn9p4wIBMXA1mx6P7lFfLeyuJmJYD
        /eiTZng2FU0RAV8StR1PuFs=
X-Google-Smtp-Source: AMrXdXuHtViA3tqLKWXJA0PXwyBGtGE+ohpPxoSq4diLbmvjNkVfE1VS+GSIOAuwatY/du0cHsOGZQ==
X-Received: by 2002:a05:6808:1993:b0:35e:9090:2969 with SMTP id bj19-20020a056808199300b0035e90902969mr35913445oib.13.1673305795705;
        Mon, 09 Jan 2023 15:09:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ca18-20020a056830611200b0066e873e4c2csm5454875otb.45.2023.01.09.15.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:09:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 9 Jan 2023 15:09:53 -0800
From:   Guenter Roeck <linux@roeck-us.net>
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
Subject: Re: [PATCH v2 1/2] hwmon: (nct6775) Directly call ASUS ACPI WMI
 method
Message-ID: <20230109230953.GA1788936@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 11:15:07PM +0200, Denis Pauk wrote:
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
>   rename each_port_arg to each_device_arg
>   rename nct6775_find_asus_acpi to nct6775_asuswmi_device_match
>   remove unrequired return -EEXIST, and iterate whole list of devices

Why ? More on that below.

>   make asus_acpi_dev static
> 
>  drivers/hwmon/Kconfig            |  2 +-
>  drivers/hwmon/nct6775-platform.c | 97 ++++++++++++++++++++++----------
>  2 files changed, 69 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 3176c33af6c6..300ce8115ce4 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1516,7 +1516,7 @@ config SENSORS_NCT6775_CORE
>  config SENSORS_NCT6775
>  	tristate "Platform driver for Nuvoton NCT6775F and compatibles"
>  	depends on !PPC
> -	depends on ACPI_WMI || ACPI_WMI=n
> +	depends on ACPI || ACPI=n
>  	select HWMON_VID
>  	select SENSORS_NCT6775_CORE
>  	help
> diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
> index bf43f73dc835..1f7885af524e 100644
> --- a/drivers/hwmon/nct6775-platform.c
> +++ b/drivers/hwmon/nct6775-platform.c
> @@ -17,7 +17,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> -#include <linux/wmi.h>
>  
>  #include "nct6775.h"
>  
> @@ -107,40 +106,44 @@ struct nct6775_sio_data {
>  	void (*sio_exit)(struct nct6775_sio_data *sio_data);
>  };
>  
> -#define ASUSWMI_MONITORING_GUID		"466747A0-70EC-11DE-8A39-0800200C9A66"
> +#define ASUSWMI_METHOD			"WMBD"
>  #define ASUSWMI_METHODID_RSIO		0x5253494F
>  #define ASUSWMI_METHODID_WSIO		0x5753494F
>  #define ASUSWMI_METHODID_RHWM		0x5248574D
>  #define ASUSWMI_METHODID_WHWM		0x5748574D
>  #define ASUSWMI_UNSUPPORTED_METHOD	0xFFFFFFFE
> +#define ASUSWMI_DEVICE_HID		"PNP0C14"
> +#define ASUSWMI_DEVICE_UID		"ASUSWMI"
> +
> +static struct acpi_device *asus_acpi_dev;
>  
>  static int nct6775_asuswmi_evaluate_method(u32 method_id, u8 bank, u8 reg, u8 val, u32 *retval)
>  {
> -#if IS_ENABLED(CONFIG_ACPI_WMI)
> +#if IS_ENABLED(CONFIG_ACPI)
> +	acpi_handle handle = acpi_device_handle(asus_acpi_dev);
>  	u32 args = bank | (reg << 8) | (val << 16);
> -	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
> -	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct acpi_object_list input;
> +	union acpi_object params[3];
> +	unsigned long long result;
>  	acpi_status status;
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
>  	if (ACPI_FAILURE(status))
>  		return -EIO;
>  
> -	obj = output.pointer;
> -	if (obj && obj->type == ACPI_TYPE_INTEGER)
> -		tmp = obj->integer.value;
> -
>  	if (retval)
> -		*retval = tmp;
> -
> -	kfree(obj);
> +		*retval = (u32)result & 0xFFFFFFFF;
>  
> -	if (tmp == ASUSWMI_UNSUPPORTED_METHOD)
> -		return -ENODEV;
>  	return 0;
>  #else
>  	return -EOPNOTSUPP;
> @@ -1099,6 +1102,50 @@ static const char * const asus_wmi_boards[] = {
>  	"TUF GAMING Z490-PLUS (WI-FI)",
>  };
>  
> +struct each_device_arg {
> +	struct acpi_device *adev;
> +	const char *match;
> +};
> +
> +/*
> + * Callback for acpi_bus_for_each_dev() to find the right device
> + * by _UID and _HID and store to each_device_arg.
> + */
> +static int nct6775_asuswmi_device_match(struct device *dev, void *data)
> +{
> +	struct acpi_device *adev = to_acpi_device(dev);
> +	const char *uid = acpi_device_uid(adev);
> +	const char *hid = acpi_device_hid(adev);
> +	struct each_device_arg *arg = data;
> +
> +	if (hid && !strcmp(hid, ASUSWMI_DEVICE_HID) &&
> +		uid && !strcmp(uid, arg->match)) {
> +		arg->adev = adev;

Why not return 1 for match here ? If there is a reason to look for
the last match instead of the first match, it needs to be explained.

> +	}
> +
> +	return 0;
> +}
> +
> +static enum sensor_access nct6775_determine_access(const char *device_uid)
> +{
> +	struct each_device_arg arg;
> +	u8 tmp;
> +
> +	arg.match = device_uid;
> +	acpi_bus_for_each_dev(nct6775_asuswmi_device_match, &arg);
> +	if (!arg.adev)
> +		return access_direct;
> +
> +	asus_acpi_dev = arg.adev;

The use of the static variable made me look into this further. Why
all that complexity with struct each_device_arg and passing the structure
and adev to/from the match function instead of just passing the 
match string as parameter and storing the matching adev directly in
asus_acpi_dev instead of passing it back and storing it here ?

Also, the use of a static variable makes me wonder: would asus_acpi_dev
be the same for both chips if there are two Super-IO chips in the system ?

Thanks,
Guenter

> +	/* if reading chip id via ACPI succeeds, use WMI "WMBD" method for access */
> +	if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp) && tmp) {
> +		pr_debug("Using Asus WMBD method of %s to access %#x chip.\n", device_uid, tmp);
> +		return access_asuswmi;
> +	}
> +
> +	return access_direct;
> +}
> +
>  static int __init sensors_nct6775_platform_init(void)
>  {
>  	int i, err;
> @@ -1109,7 +1156,6 @@ static int __init sensors_nct6775_platform_init(void)
>  	int sioaddr[2] = { 0x2e, 0x4e };
>  	enum sensor_access access = access_direct;
>  	const char *board_vendor, *board_name;
> -	u8 tmp;
>  
>  	err = platform_driver_register(&nct6775_driver);
>  	if (err)
> @@ -1122,15 +1168,8 @@ static int __init sensors_nct6775_platform_init(void)
>  	    !strcmp(board_vendor, "ASUSTeK COMPUTER INC.")) {
>  		err = match_string(asus_wmi_boards, ARRAY_SIZE(asus_wmi_boards),
>  				   board_name);
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
>  	}
>  
>  	/*
> 
> base-commit: b0587c87abc891e313d63946ff8c9f4939d1ea1a
> -- 
> 2.39.0
> 
