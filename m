Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1086932F7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 19:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBKSIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 13:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKSIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 13:08:32 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DB6199D1;
        Sat, 11 Feb 2023 10:08:31 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id y11-20020a05683009cb00b0068dbf908574so2536704ott.8;
        Sat, 11 Feb 2023 10:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yo9Q/zSH+BJ8u/pEoG/a2N9Q2keTYj9JnQ4wGmR0b8E=;
        b=RXmmVA+BwnOzV0B+p6FportxmT30vr/xPopd8KCaSBfN85+HXYBelIX3tqd7Lj8W6Y
         /YLP9bv5Pkf6qbohA+l+uypMccG/MN8sjrlI3a9x0EAHXd1bxw8zlYPraNrFnCFTjWde
         T5W4ArHtvsNdJ3yPL71K4FzNjO4/64ibgBKLaxstop0iA3WrbJazqa7h8DuciB7aHPbg
         ACbzZTUa4iKU9PN1na94YfdypPDYwO/bKR2+k6BCAjOD2ClTfnCgc1jF3dnN6xF9rpBB
         m1sUG6O/9r/Y5SNm4vcHoMpSea5seeRTONa3NKxNj2DLUwRLS/QIP4Geop7rM0+cCMNh
         G8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo9Q/zSH+BJ8u/pEoG/a2N9Q2keTYj9JnQ4wGmR0b8E=;
        b=ur4D5u8Sc86oZcaN7UfX8czrTKXPprWGos5sS/OBpk7zrgYfw/oW0RpJt7b9gyIEYa
         pz4SNWXsVMECpW+wbye6vGuciGWVGtexu8p09WDKvhfMJqLC5RfTtgFI4EDcqKUB9WvW
         Ms5tV6XqN33FeVxrmBIVL/Lk2eF4Qv9N0tQAB2sTkqgbYI2NWk2rEw/JDcFZGCqgTJLg
         PjtxDVLMsPfvS5YJ/CqX+mplO1/y51Bo9xsngLR7LUpc+GOvt3o/swZt3G62CTQxcSN2
         p9P6LT3SYxcddnPnB0URqtwwrp1W5bC74rbkg06NrWEtnIhrUtpimcMjKIwkanMSfrmG
         +XAg==
X-Gm-Message-State: AO0yUKW8Zlg90nm4cb8kqGqYDqhMapdgB0YHxO5SM43ccfOXZOw2DAsL
        p9lxCCi/hVPAyJ5RBqDbdL0=
X-Google-Smtp-Source: AK7set+deEVGsrefanpAl0Q2HTFhqT+Z25pgkLWnzbTjEep3HQK9wpAfBRTDdizcKPbqafF10qENRg==
X-Received: by 2002:a05:6830:68cd:b0:68b:e3da:8eff with SMTP id cw13-20020a05683068cd00b0068be3da8effmr10080130otb.17.1676138910553;
        Sat, 11 Feb 2023 10:08:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a19-20020a05683012d300b00686574e98d6sm3310856otq.72.2023.02.11.10.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 10:08:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0664b935-d201-419a-3f1d-3df4226a8db1@roeck-us.net>
Date:   Sat, 11 Feb 2023 10:08:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Leonard Anderweit <leonard.anderweit@gmail.com>,
        linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230211165923.17807-1-leonard.anderweit@gmail.com>
 <20230211165923.17807-4-leonard.anderweit@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/5] hwmon: (aquacomputer_d5next) Add temperature offset
 control for Aquaero
In-Reply-To: <20230211165923.17807-4-leonard.anderweit@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/23 08:59, Leonard Anderweit wrote:
> Support sending control reports to Aquacomputer Aquaero. This commit only
> enables control of the temperature offset as this works in the same manner as
> with already supported devices.
> Also, mention temperature offset control for Aquaero in docs.
> 
> Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
> ---
>   Documentation/hwmon/aquacomputer_d5next.rst |  4 +-
>   drivers/hwmon/aquacomputer_d5next.c         | 62 ++++++++++++++++-----
>   2 files changed, 50 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index 7d0d015b1a52..de43374940b8 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -25,7 +25,7 @@ communicate through proprietary USB HID protocols.
>   
>   The Aquaero devices expose eight physical, eight virtual and four calculated
>   virtual temperature sensors, as well as two flow sensors. The fans expose their
> -speed (in RPM), power, voltage and current.
> +speed (in RPM), power, voltage and current. The temperature offset can be controlled.
>   
>   For the D5 Next pump, available sensors are pump and fan speed, power, voltage
>   and current, as well as coolant temperature and eight virtual temp sensors. Also
> @@ -75,7 +75,7 @@ Sysfs entries
>   
>   ================ ==============================================================
>   temp[1-20]_input Physical/virtual temperature sensors (in millidegrees Celsius)
> -temp[1-4]_offset Temperature sensor correction offset (in millidegrees Celsius)
> +temp[1-8]_offset Temperature sensor correction offset (in millidegrees Celsius)
>   fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
>   fan5_pulses      Quadro flow sensor pulses
>   power[1-8]_input Pump/fan power (in micro Watts)
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 03ef9e0258d2..95461e2907e1 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -56,6 +56,7 @@ static const char *const aqc_device_names[] = {
>   #define SERIAL_PART_OFFSET		2
>   
>   #define CTRL_REPORT_ID			0x03
> +#define AQUAERO_CTRL_REPORT_ID		0x0b
>   
>   /* The HID report that the official software always sends
>    * after writing values, currently same for all devices
> @@ -67,6 +68,14 @@ static u8 secondary_ctrl_report[] = {
>   	0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x34, 0xC6
>   };
>   
> +/* Secondary HID report values for Aquaero */
> +#define AQUAERO_SECONDARY_CTRL_REPORT_ID	0x06
> +#define AQUAERO_SECONDARY_CTRL_REPORT_SIZE	0x07
> +
> +static u8 aquaero_secondary_ctrl_report[] = {
> +	0x06, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00
> +};
> +
>   /* Report IDs for legacy devices */
>   #define POWERADJUST3_STATUS_REPORT_ID	0x03
>   
> @@ -94,6 +103,7 @@ static u8 secondary_ctrl_report[] = {
>   #define AQUAERO_NUM_VIRTUAL_SENSORS		8
>   #define AQUAERO_NUM_CALC_VIRTUAL_SENSORS	4
>   #define AQUAERO_NUM_FLOW_SENSORS		2
> +#define AQUAERO_CTRL_REPORT_SIZE		0xa93
>   
>   /* Sensor report offsets for Aquaero fan controllers */
>   #define AQUAERO_SENSOR_START			0x65
> @@ -106,6 +116,9 @@ static u8 secondary_ctrl_report[] = {
>   #define AQUAERO_FAN_SPEED_OFFSET		0x00
>   static u16 aquaero_sensor_fan_offsets[] = { 0x167, 0x173, 0x17f, 0x18B };
>   
> +/* Control report offsets for the Aquaero fan controllers */
> +#define AQUAERO_TEMP_CTRL_OFFSET	0xdb
> +
>   /* Specs of the D5 Next pump */
>   #define D5NEXT_NUM_FANS			2
>   #define D5NEXT_NUM_SENSORS		1
> @@ -441,6 +454,10 @@ struct aqc_data {
>   	const char *name;
>   
>   	int status_report_id;	/* Used for legacy devices, report is stored in buffer */
> +	int ctrl_report_id;
> +	int secondary_ctrl_report_id;
> +	int secondary_ctrl_report_size;
> +	u8 *secondary_ctrl_report;
>   
>   	int buffer_size;
>   	u8 *buffer;
> @@ -513,7 +530,7 @@ static int aqc_get_ctrl_data(struct aqc_data *priv)
>   	int ret;
>   
>   	memset(priv->buffer, 0x00, priv->buffer_size);
> -	ret = hid_hw_raw_request(priv->hdev, CTRL_REPORT_ID, priv->buffer, priv->buffer_size,
> +	ret = hid_hw_raw_request(priv->hdev, priv->ctrl_report_id, priv->buffer, priv->buffer_size,
>   				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
>   	if (ret < 0)
>   		ret = -ENODATA;
> @@ -527,23 +544,27 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
>   	int ret;
>   	u16 checksum;
>   
> -	/* Init and xorout value for CRC-16/USB is 0xffff */
> -	checksum = crc16(0xffff, priv->buffer + priv->checksum_start, priv->checksum_length);
> -	checksum ^= 0xffff;
> +	/* Checksum is not needed for Aquaero */
> +	if (priv->kind != aquaero) {
> +		/* Init and xorout value for CRC-16/USB is 0xffff */
> +		checksum = crc16(0xffff, priv->buffer + priv->checksum_start,
> +				 priv->checksum_length);
> +		checksum ^= 0xffff;

aquaero is already supported, and the checksum is so far generated
and sent. Is it ignored ? Also, is it guaranteed that _all_ aquero devices
don't need it ?

If it is not needed and ignored, does it really add value to selectively drop it ?

Either case, this change is not mentioned in the commit log, and it
violates the "one logical change per patch" rule. Please split it into
a separate patch and explain why the change is needed.

Another change to separate is the introduction of ctrl_report_id
and the secondary_ctrl_report variables, which is also done silently
and not explained. That should also be a separate patch to simplify
review.

Thanks,
Guenter

>   
> -	/* Place the new checksum at the end of the report */
> -	put_unaligned_be16(checksum, priv->buffer + priv->checksum_offset);
> +		/* Place the new checksum at the end of the report */
> +		put_unaligned_be16(checksum, priv->buffer + priv->checksum_offset);
> +	}
>   
>   	/* Send the patched up report back to the device */
> -	ret = hid_hw_raw_request(priv->hdev, CTRL_REPORT_ID, priv->buffer, priv->buffer_size,
> +	ret = hid_hw_raw_request(priv->hdev, priv->ctrl_report_id, priv->buffer, priv->buffer_size,
>   				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
>   	if (ret < 0)
>   		return ret;
>   
>   	/* The official software sends this report after every change, so do it here as well */
> -	ret = hid_hw_raw_request(priv->hdev, SECONDARY_CTRL_REPORT_ID, secondary_ctrl_report,
> -				 SECONDARY_CTRL_REPORT_SIZE, HID_FEATURE_REPORT,
> -				 HID_REQ_SET_REPORT);
> +	ret = hid_hw_raw_request(priv->hdev, priv->secondary_ctrl_report_id,
> +				 priv->secondary_ctrl_report, priv->secondary_ctrl_report_size,
> +				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
>   	return ret;
>   }
>   
> @@ -969,10 +990,10 @@ static const struct hwmon_channel_info *aqc_info[] = {
>   			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
>   			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
>   			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
> -			   HWMON_T_INPUT | HWMON_T_LABEL,
> -			   HWMON_T_INPUT | HWMON_T_LABEL,
> -			   HWMON_T_INPUT | HWMON_T_LABEL,
> -			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
>   			   HWMON_T_INPUT | HWMON_T_LABEL,
>   			   HWMON_T_INPUT | HWMON_T_LABEL,
>   			   HWMON_T_INPUT | HWMON_T_LABEL,
> @@ -1275,6 +1296,9 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   		priv->num_flow_sensors = AQUAERO_NUM_FLOW_SENSORS;
>   		priv->flow_sensors_start_offset = AQUAERO_FLOW_SENSORS_START;
>   
> +		priv->buffer_size = AQUAERO_CTRL_REPORT_SIZE;
> +		priv->temp_ctrl_offset = AQUAERO_TEMP_CTRL_OFFSET;
> +
>   		priv->temp_label = label_temp_sensors;
>   		priv->virtual_temp_label = label_virtual_temp_sensors;
>   		priv->calc_virt_temp_label = label_aquaero_calc_temp_sensors;
> @@ -1438,6 +1462,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   		priv->firmware_version_offset = AQUAERO_FIRMWARE_VERSION;
>   
>   		priv->fan_structure = &aqc_aquaero_fan_structure;
> +
> +		priv->ctrl_report_id = AQUAERO_CTRL_REPORT_ID;
> +		priv->secondary_ctrl_report_id = AQUAERO_SECONDARY_CTRL_REPORT_ID;
> +		priv->secondary_ctrl_report_size = AQUAERO_SECONDARY_CTRL_REPORT_SIZE;
> +		priv->secondary_ctrl_report = aquaero_secondary_ctrl_report;
>   		break;
>   	case poweradjust3:
>   		priv->status_report_id = POWERADJUST3_STATUS_REPORT_ID;
> @@ -1446,6 +1475,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   		priv->serial_number_start_offset = AQC_SERIAL_START;
>   		priv->firmware_version_offset = AQC_FIRMWARE_VERSION;
>   
> +		priv->ctrl_report_id = CTRL_REPORT_ID;
> +		priv->secondary_ctrl_report_id = SECONDARY_CTRL_REPORT_ID;
> +		priv->secondary_ctrl_report_size = SECONDARY_CTRL_REPORT_SIZE;
> +		priv->secondary_ctrl_report = secondary_ctrl_report;
> +
>   		if (priv->kind == aquastreamult)
>   			priv->fan_structure = &aqc_aquastreamult_fan_structure;
>   		else

