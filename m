Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D40750D10
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjGLPuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjGLPuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:50:02 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591E41BD4;
        Wed, 12 Jul 2023 08:50:01 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b8baa836a5so52614685ad.1;
        Wed, 12 Jul 2023 08:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689177001; x=1691769001;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3Bv4WWgOD1Bt+pV7AhI2nSno+WdRlPknAzmwF2PhRc=;
        b=XnOfrBa40zR0KJV4r3rmnocEZqE2vUaWguWIA0CoyXEi8fTgh8HYiRsL2XPGe4+RWt
         dQaN4tpT2wnsw1aFoBSvdEXil/78glUm33GSWNzlaNcXs/V1hXqHjmYW4NLEkIq7u00N
         vhjSLA5Jt5o3/hJPWsMaosp8dclqh6ePbsvuJ0iVNm4v5JOux2IArMV3LpPeFiDF0NNW
         feWpn0gDQy4MhvV2kZPAXdy1VJ0MwVTz9TqHhgIzjx08XCov8ASAP7jSvClTvVLZOTih
         RWX0uJrSZDKXa+O458BJ69Ue27rmxhSkhnOG6a7USWExPTPL7XAR+qEbVFh7Sv9SFSrH
         uXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689177001; x=1691769001;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3Bv4WWgOD1Bt+pV7AhI2nSno+WdRlPknAzmwF2PhRc=;
        b=JOQsX3TxUJ61vlZt4f07nbWeSi3j3inean7dDh/63iHpzXBQKs0ibVJug4+7LL3JHN
         hoO6d/7TWMOHP5EGIO/5xKbY1HeYA24jrxM6YZOCbH7Q7oJMPZBp+V02PQ9TpQroLg7Z
         dEUTxgFPI9e5/R1LmpFXu1umdt2/x1eAU3RyyWm9E3owE/WQnVm62SPLU3mkeZGnKxSg
         ITBkzNC+rS8QkAfXGAZIzdryyNArxqCGSufG685ZubmVAso65dl2nK2zqkh+n9+9sb+W
         +Q+Kezrggo9bPLYY3JNgh5Bh3/6ztvbjZXwukHQVt+u60wmw80MGu04FvW2MDagAMCg0
         F6Rw==
X-Gm-Message-State: ABy/qLaVufkk6JW7oyMKifMRaS2jNeMCOoKGhK8N0k1F81TEPh0eJUCZ
        7YkC/02yqye+uFYtJJIJDTx2LAI2GjI=
X-Google-Smtp-Source: APBJJlFUqA7+VhxO8G+C7QCn4NTvLOE62ar817CjKpMo55XGqK6+sVTuOsoJklHOU0BgJGwY5VrKjA==
X-Received: by 2002:a17:902:d2d1:b0:1b8:c972:606c with SMTP id n17-20020a170902d2d100b001b8c972606cmr23230796plc.57.1689177000628;
        Wed, 12 Jul 2023 08:50:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i19-20020a170902eb5300b001b7f9963febsm4132495pli.175.2023.07.12.08.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 08:50:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <38157958-9723-73bc-f79a-1ac8c80c512e@roeck-us.net>
Date:   Wed, 12 Jul 2023 08:49:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
 <20230712114754.500477-4-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4/8] hwmon: (pmbus/mp2975) Simplify VOUT code
In-Reply-To: <20230712114754.500477-4-Naresh.Solanki@9elements.com>
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

On 7/12/23 04:47, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> In order to upstream MP2973/MP2971 simplify the code by removing support
> for various VOUT formats. The MP2973 and MP2971 supports all PMBUS
> supported formats for VOUT, while the MP2975 only support DIRECT and
> VID for VOUT.
> 
> In DIRECT mode all chips report the voltage in 1mV/LSB.
> 
> Configure the chip to use DIRECT format for VOUT and drop the code
> conversion code for other formats. The to be added chips MP2973/MP2971
> will be configured to also report VOUT in DIRECT format.
> 
> The maximum voltage that can be reported in DIRECT format is 32768mV.
> This is sufficient as the maximum output voltage for VR12/VR13 is
> 3040 mV.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>   drivers/hwmon/pmbus/mp2975.c | 54 ++++++------------------------------
>   1 file changed, 8 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
> index 04778f2dcbdb..ebc9a84b8ad3 100644
> --- a/drivers/hwmon/pmbus/mp2975.c
> +++ b/drivers/hwmon/pmbus/mp2975.c
> @@ -70,7 +70,6 @@ struct mp2975_data {
>   	int vref_off[MP2975_PAGE_NUM];
>   	int vout_max[MP2975_PAGE_NUM];
>   	int vout_ov_fixed[MP2975_PAGE_NUM];
> -	int vout_format[MP2975_PAGE_NUM];
>   	int curr_sense_gain[MP2975_PAGE_NUM];
>   };
>   
> @@ -83,22 +82,6 @@ MODULE_DEVICE_TABLE(i2c, mp2975_id);
>   
>   #define to_mp2975_data(x)  container_of(x, struct mp2975_data, info)
>   
> -static int mp2975_read_byte_data(struct i2c_client *client, int page, int reg)
> -{
> -	switch (reg) {
> -	case PMBUS_VOUT_MODE:
> -		/*
> -		 * Enforce VOUT direct format, since device allows to set the
> -		 * different formats for the different rails. Conversion from
> -		 * VID to direct provided by driver internally, in case it is
> -		 * necessary.
> -		 */
> -		return PB_VOUT_MODE_DIRECT;
> -	default:
> -		return -ENODATA;
> -	}
> -}
> -
>   static int
>   mp2975_read_word_helper(struct i2c_client *client, int page, int phase, u8 reg,
>   			u16 mask)
> @@ -273,24 +256,6 @@ static int mp2975_read_word_data(struct i2c_client *client, int page,
>   		ret = DIV_ROUND_CLOSEST(data->vref[page] * 10 - 50 *
>   					(ret + 1) * data->vout_scale, 10);
>   		break;
> -	case PMBUS_READ_VOUT:
> -		ret = mp2975_read_word_helper(client, page, phase, reg,
> -					      GENMASK(11, 0));
> -		if (ret < 0)
> -			return ret;
> -
> -		/*
> -		 * READ_VOUT can be provided in VID or direct format. The
> -		 * format type is specified by bit 15 of the register
> -		 * MP2975_MFR_DC_LOOP_CTRL. The driver enforces VOUT direct
> -		 * format, since device allows to set the different formats for
> -		 * the different rails and also all VOUT limits registers are
> -		 * provided in a direct format. In case format is VID - convert
> -		 * to direct.
> -		 */
> -		if (data->vout_format[page] == vid)
> -			ret = mp2975_vid2direct(info->vrm_version[page], ret);
> -		break;
>   	case PMBUS_VIRT_READ_POUT_MAX:
>   		ret = mp2975_read_word_helper(client, page, phase,
>   					      MP2975_MFR_READ_POUT_PK,
> @@ -578,20 +543,18 @@ mp2975_vout_max_get(struct i2c_client *client, struct mp2975_data *data,
>   }
>   
>   static int
> -mp2975_identify_vout_format(struct i2c_client *client,
> -			    struct mp2975_data *data, int page)
> +mp2975_set_vout_format(struct i2c_client *client,
> +		       struct mp2975_data *data, int page)
>   {
>   	int ret;
>   
>   	ret = i2c_smbus_read_word_data(client, MP2975_MFR_DC_LOOP_CTRL);
>   	if (ret < 0)
>   		return ret;
> -
> -	if (ret & MP2975_VOUT_FORMAT)
> -		data->vout_format[page] = vid;
> -	else
> -		data->vout_format[page] = direct;
> -	return 0;
> +	/* Enable DIRECT VOUT format 1mV/LSB */
> +	ret &= ~MP2975_VOUT_FORMAT;
> +	ret = i2c_smbus_write_word_data(client, MP2975_MFR_DC_LOOP_CTRL, ret);

Writing this back is only needed if MP2975_VOUT_FORMAT was not already cleared.

> +	return ret;
>   }
>   
>   static int
> @@ -650,11 +613,11 @@ mp2975_vout_per_rail_config_get(struct i2c_client *client,
>   			return ret;
>   
>   		/*
> -		 * Get VOUT format for READ_VOUT command : VID or direct.
> +		 * Set VOUT format for READ_VOUT command : direct.
>   		 * Pages on same device can be configured with different
>   		 * formats.

Not sure if this comment still makes sense.

>   		 */
> -		ret = mp2975_identify_vout_format(client, data, i);
> +		ret = mp2975_set_vout_format(client, data, i);
>   		if (ret < 0)
>   			return ret;
>   
> @@ -689,7 +652,6 @@ static struct pmbus_driver_info mp2975_info = {
>   		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
>   		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
>   		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT | PMBUS_PHASE_VIRTUAL,
> -	.read_byte_data = mp2975_read_byte_data,
>   	.read_word_data = mp2975_read_word_data,
>   };
>   

