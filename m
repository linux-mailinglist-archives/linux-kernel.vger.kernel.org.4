Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B7C6B68EA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCLRoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCLRoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:44:44 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995DA3646B;
        Sun, 12 Mar 2023 10:44:43 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-176b90e14a9so11535551fac.9;
        Sun, 12 Mar 2023 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678643083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKG1lI+0STMCFJtaydoqd1RU3Z9cyR3Jq7a+wFOPE4o=;
        b=K4KWVy6lbc3GDVhrSGILzEHZAE3YTv/Rtr1GNdpe4aA2ZpC3yipMyV7ZM/gPvlM1Gr
         wQiX/+dinF6I4Ijk1XnMHut/w9Cg5ZF5udEUS1NmvpA5pU0DjfzXZmLwQhuBCiF88yzT
         91zFHtQX3DKMYvsOf/IpwQwZmxrnhtdFSt008O/T5uhi2IQpCEglLX1i1WyAiMWEjpvP
         lFsqCEOdIvRDL1U5v4xzrlSq5bOxi+nUR1Cxm/8QQsqhNvw2c/BuraZ63SYMepMVW81y
         T9IMkbfCYnJiW/LIrspnNqHhnBbI6gvPrEC4f8DOGzxnbLJrH05EAO2jNg8kq60x/BmL
         a1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678643083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKG1lI+0STMCFJtaydoqd1RU3Z9cyR3Jq7a+wFOPE4o=;
        b=sF6E4JnyGQASktAdzPRxN2yE77w4TgJDX+lwkSiBqJjaqGrLZuPZLRl0VThP4ERJ+2
         xlgE3mt3X9mkmPS/ZQImGa+EBISC9mq626iwIJt6HMKYCHLmmsm8BYiYSHdN4Lu1PRYA
         4H1/8Em+JrP3E8jwBGXDCYyYi8hsF2cgRtqwlYjB2oGD1t7SQHfCNk0X+Ukhseqjcemc
         GPSZgxEXPoO0bMdpqgTIFh+GB7nddVQo0krg/lqiTauniyhpMz/VtLiSZeUiZzwh/vJQ
         +zktaMk7w2lNdMVnT6dVEEu1W33ehL0g9fnk4cYAquVLbeyGc//aVF0cYlyupeXUd8XV
         LyKA==
X-Gm-Message-State: AO0yUKVXxZOA37h5itM3sinIpCfpW9VLbjuBx2R+NAo5XGBoUfHc8m3n
        jqVKP3ecY+McV+MWMCDsgtk=
X-Google-Smtp-Source: AK7set+Y/5JDt+MN0WDjWCCFX/9iLelnILZ/WEnZ9pvrKa/IcoDk1bcmk33RN1dmFhO7RFUKAn49Iw==
X-Received: by 2002:a05:6870:414e:b0:16d:ccf9:bb4d with SMTP id r14-20020a056870414e00b0016dccf9bb4dmr18984287oad.39.1678643082970;
        Sun, 12 Mar 2023 10:44:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf17-20020a0568700a1100b0017197629658sm2212862oac.56.2023.03.12.10.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:44:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 10:44:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Leonard Anderweit <leonard.anderweit@gmail.com>
Cc:     linux-hwmon@vger.kernel.org,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] hwmon: (aquacomputer_d5next) Add infrastructure
 for Aquaero control reports
Message-ID: <210eddaf-cbd1-473e-920d-1c76c2923ee3@roeck-us.net>
References: <20230214220221.15003-1-leonard.anderweit@gmail.com>
 <20230214220221.15003-5-leonard.anderweit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214220221.15003-5-leonard.anderweit@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:02:19PM +0100, Leonard Anderweit wrote:
> Add information on the Aquacomputer Aquaero control report and disable the
> control report checksum for Aquaero. The Aquaero does not use the checksum so
> it must be disabled to avoid overwriting the last two bytes of the control
> report.
> 
> Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>

Applied. And again:

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#85:
control report checksum for Aquaero. The Aquaero does not use the checksum so

Please keep in mind that you are causing extra work for me.

Guenter

> ---
>  drivers/hwmon/aquacomputer_d5next.c | 31 ++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 535d2fc0e55c..eb185318098a 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -56,6 +56,7 @@ static const char *const aqc_device_names[] = {
>  #define SERIAL_PART_OFFSET		2
>  
>  #define CTRL_REPORT_ID			0x03
> +#define AQUAERO_CTRL_REPORT_ID		0x0b
>  
>  /* The HID report that the official software always sends
>   * after writing values, currently same for all devices
> @@ -67,6 +68,14 @@ static u8 secondary_ctrl_report[] = {
>  	0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x34, 0xC6
>  };
>  
> +/* Secondary HID report values for Aquaero */
> +#define AQUAERO_SECONDARY_CTRL_REPORT_ID	0x06
> +#define AQUAERO_SECONDARY_CTRL_REPORT_SIZE	0x07
> +
> +static u8 aquaero_secondary_ctrl_report[] = {
> +	0x06, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00
> +};
> +
>  /* Report IDs for legacy devices */
>  #define POWERADJUST3_STATUS_REPORT_ID	0x03
>  
> @@ -94,6 +103,7 @@ static u8 secondary_ctrl_report[] = {
>  #define AQUAERO_NUM_VIRTUAL_SENSORS		8
>  #define AQUAERO_NUM_CALC_VIRTUAL_SENSORS	4
>  #define AQUAERO_NUM_FLOW_SENSORS		2
> +#define AQUAERO_CTRL_REPORT_SIZE		0xa93
>  
>  /* Sensor report offsets for Aquaero fan controllers */
>  #define AQUAERO_SENSOR_START			0x65
> @@ -531,12 +541,16 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
>  	int ret;
>  	u16 checksum;
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
>  
> -	/* Place the new checksum at the end of the report */
> -	put_unaligned_be16(checksum, priv->buffer + priv->checksum_offset);
> +		/* Place the new checksum at the end of the report */
> +		put_unaligned_be16(checksum, priv->buffer + priv->checksum_offset);
> +	}
>  
>  	/* Send the patched up report back to the device */
>  	ret = hid_hw_raw_request(priv->hdev, priv->ctrl_report_id, priv->buffer, priv->buffer_size,
> @@ -1280,6 +1294,8 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->num_flow_sensors = AQUAERO_NUM_FLOW_SENSORS;
>  		priv->flow_sensors_start_offset = AQUAERO_FLOW_SENSORS_START;
>  
> +		priv->buffer_size = AQUAERO_CTRL_REPORT_SIZE;
> +
>  		priv->temp_label = label_temp_sensors;
>  		priv->virtual_temp_label = label_virtual_temp_sensors;
>  		priv->calc_virt_temp_label = label_aquaero_calc_temp_sensors;
> @@ -1443,6 +1459,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->firmware_version_offset = AQUAERO_FIRMWARE_VERSION;
>  
>  		priv->fan_structure = &aqc_aquaero_fan_structure;
> +
> +		priv->ctrl_report_id = AQUAERO_CTRL_REPORT_ID;
> +		priv->secondary_ctrl_report_id = AQUAERO_SECONDARY_CTRL_REPORT_ID;
> +		priv->secondary_ctrl_report_size = AQUAERO_SECONDARY_CTRL_REPORT_SIZE;
> +		priv->secondary_ctrl_report = aquaero_secondary_ctrl_report;
>  		break;
>  	case poweradjust3:
>  		priv->status_report_id = POWERADJUST3_STATUS_REPORT_ID;
