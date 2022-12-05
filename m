Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5D46435A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiLEU2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiLEU2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:28:22 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48FE27DF8;
        Mon,  5 Dec 2022 12:28:20 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id td2so1302600ejc.5;
        Mon, 05 Dec 2022 12:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOm4Ju1oY7JNly88Z9jr4bM+kyrgfVTIA8UOp54ZnS8=;
        b=VoAZ9iRnD7OWa2NtOuGYMpK0lhHrmoL0kGMEa9eNe+kBBDUPRiwG2SEXWZ3HZhymRZ
         TmuVE3fZ0G9roCSFUCFHlfFzZm0eBhGZTL3kG/kJ0cLhfMHQHshEcCQN986OxRMps/ir
         CaMTyuUMgat2EzwzsuAGs8KpRZYr4/Dzk5eqqwg9pNy2vkOLTA8mKwjzQ0suSc/xOAhX
         Ca8HU7nBwtb7YtUcX4aXCp4EE11D4itlLwoSMM8BwiJcTOvQp7j5GSl9cUI8k6nP711p
         9LP4gJA71MTAedmrBGuELhy4njVE2ol354w/xa6GqnZM/vZ+seorNynJJ5suFCK8nnRT
         31EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOm4Ju1oY7JNly88Z9jr4bM+kyrgfVTIA8UOp54ZnS8=;
        b=Gp63bIV7pb5OfzfmF3qd+La4E9RhP58FODFLfZr+KhzEa8o1naqRnJr3LPasnDHkx8
         OIpG1CPBU0ypGP58whi5YI1KKYzh9Cu9pMl00xYbuOR/pgLnLzTqj0gSmCFiF3Fe9Vm/
         bHKPEPMoEFq3NQWnXhZHTTGOiMzbJQKEa9XrWyU2LOLIjA/nwBjDTUFVlp/88X4rHwwy
         H8GwHzklFtr81e/J6oTTQGuX4rZroU6rmj0dOBfEHKqHjB87VoOS7X2N26+BChQTX8d9
         X+AnKXpLbfVkacNd4n9gpp4U3sTeuKXgXdR1XA5sCTkdDmAk+NZv6rMkwsU35DN/bQqD
         d8Pw==
X-Gm-Message-State: ANoB5plVkfXbAWF4gw8WV86NyOM54PmEFKh4p+xRjM/wHHMT4GXEr5Zq
        vALB98ZH1c88ch5V6KTmGp4ugsMJ7Mo=
X-Google-Smtp-Source: AA0mqf4t87c1wxtRGXDTt0NYKzSKRwqAVQGWw+m0qslWVZxokhkcz3N3ZAONdmH1WEZ/+JxjRNNaWA==
X-Received: by 2002:a17:906:9f10:b0:7ad:86f9:1d70 with SMTP id fy16-20020a1709069f1000b007ad86f91d70mr49313297ejc.179.1670272099322;
        Mon, 05 Dec 2022 12:28:19 -0800 (PST)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id gh22-20020a170906e09600b007bd7178d311sm6592437ejb.51.2022.12.05.12.28.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 12:28:18 -0800 (PST)
Subject: Re: [PATCH 3/3] power: supply: cpcap_battery: Read battery parameters
 from nvram
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, philipp@uvos.xyz
References: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1667647544-12945-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <6d5e2890-a86b-1b9b-bb8f-474838d9bd86@gmail.com>
Date:   Mon, 5 Dec 2022 22:28:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1667647544-12945-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On 5.11.22 г. 13:25 ч., Ivaylo Dimitrov wrote:
> Formulas were taken from android blob
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>   drivers/power/supply/cpcap-battery.c | 88 ++++++++++++++++++++----------------
>   1 file changed, 48 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
> index ca6ee2b..92aa66c 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -74,9 +74,6 @@
>   
>   #define CPCAP_BATTERY_CC_SAMPLE_PERIOD_MS	250
>   
> -#define CPCAP_BATTERY_EB41_HW4X_ID 0x9E
> -#define CPCAP_BATTERY_BW8X_ID 0x98
> -
>   enum {
>   	CPCAP_BATTERY_IIO_BATTDET,
>   	CPCAP_BATTERY_IIO_VOLTAGE,
> @@ -388,22 +385,9 @@ static int cpcap_battery_cc_to_ua(struct cpcap_battery_ddata *ddata,
>    * kernel on droid 4, full is 4351000 and software initiates shutdown
>    * at 3078000. The device will die around 2743000.
>    */
> -static const struct cpcap_battery_config cpcap_battery_eb41_data = {
> -	.cd_factor = 0x3cc,
> -	.info.technology = POWER_SUPPLY_TECHNOLOGY_LION,
> -	.info.voltage_max_design = 4351000,
> -	.info.voltage_min_design = 3100000,
> -	.info.charge_full_design = 1740000,
> -	.bat.constant_charge_voltage_max_uv = 4200000,
> -};
> -
> -/* Values for the extended Droid Bionic battery bw8x. */
> -static const struct cpcap_battery_config cpcap_battery_bw8x_data = {
> +static struct cpcap_battery_config cpcap_battery_mot_data = {
>   	.cd_factor = 0x3cc,
>   	.info.technology = POWER_SUPPLY_TECHNOLOGY_LION,
> -	.info.voltage_max_design = 4200000,
> -	.info.voltage_min_design = 3200000,
> -	.info.charge_full_design = 2760000,
>   	.bat.constant_charge_voltage_max_uv = 4200000,
>   };
>   
> @@ -431,39 +415,63 @@ static int cpcap_battery_match_nvmem(struct device *dev, const void *data)
>   static void cpcap_battery_detect_battery_type(struct cpcap_battery_ddata *ddata)
>   {
>   	struct nvmem_device *nvmem;
> -	u8 battery_id = 0;
> +	char buf[24];
> +	u8 capacity;
> +	u8 mul_idx;
> +	u8 charge_voltage;
> +	u32 v;
> +	static const u32 multipliers[] = {20, 10, 10, 10, 10, 40, 10, 20, 40};
>   
>   	ddata->check_nvmem = false;
>   
>   	nvmem = nvmem_device_find(NULL, &cpcap_battery_match_nvmem);
>   	if (IS_ERR_OR_NULL(nvmem)) {
> -		ddata->check_nvmem = true;
>   		dev_info_once(ddata->dev, "Can not find battery nvmem device. Assuming generic lipo battery\n");
> -	} else {
> -		char buf[24];
> -
> -		if (nvmem_device_read(nvmem, 96, 4, buf) < 0 ||
> -		    strncmp(buf, "COPR", 4) != 0 ||
> -		    nvmem_device_read(nvmem, 104, 24, buf) < 0 ||
> -		    strncmp(buf, "MOTOROLA E.P CHARGE ONLY", 24) != 0 ||
> -		    nvmem_device_read(nvmem, 2, 1, &battery_id) < 0) {
> -			battery_id = 0;
> -			ddata->check_nvmem = true;
> -			dev_warn(ddata->dev, "Can not read battery nvmem device. Assuming generic lipo battery\n");
> -		}
> +		goto unknown;
> +	}
>   
> +	if (nvmem_device_read(nvmem, 96, 4, buf) < 0 ||
> +	    strncmp(buf, "COPR", 4) != 0 ||
> +	    nvmem_device_read(nvmem, 104, 24, buf) < 0 ||
> +	    strncmp(buf, "MOTOROLA E.P CHARGE ONLY", 24) != 0) {
> +		dev_warn(ddata->dev, "Unknown battery nvmem device. Assuming generic lipo battery\n");
> +		goto unknown;
>   	}
>   
> -	switch (battery_id) {
> -	case CPCAP_BATTERY_EB41_HW4X_ID:
> -		ddata->config = cpcap_battery_eb41_data;
> -		break;
> -	case CPCAP_BATTERY_BW8X_ID:
> -		ddata->config = cpcap_battery_bw8x_data;
> -		break;
> -	default:
> -		ddata->config = cpcap_battery_unkown_data;
> +	if (nvmem_device_read(nvmem, 49, 1, &mul_idx) < 0 ||
> +	    nvmem_device_read(nvmem, 34, 1, &capacity) < 0 ||
> +	    nvmem_device_read(nvmem, 65, 1, &charge_voltage) < 0) {
> +		dev_warn(ddata->dev, "Can not read battery nvmem device. Assuming generic lipo battery\n");
> +		goto unknown;
>   	}
> +
> +	/* design capacity */
> +	mul_idx -= 2;
> +
> +	if (mul_idx < ARRAY_SIZE(multipliers))
> +		v = multipliers[mul_idx];
> +	else
> +		v = 10;
> +
> +	cpcap_battery_mot_data.info.charge_full_design = 1000 * v * capacity;
> +
> +	/* design max voltage */
> +	v = 1000 * ((16702 * charge_voltage) / 1000 + 1260);
> +	cpcap_battery_mot_data.info.voltage_max_design = v;
> +
> +	/* design min voltage */
> +	if (v > 4200000)
> +		cpcap_battery_mot_data.info.voltage_min_design = 3100000;
> +	else
> +		cpcap_battery_mot_data.info.voltage_min_design = 3200000;
> +
> +	ddata->config = cpcap_battery_mot_data;
> +
> +	return;
> +
> +unknown:
> +	ddata->check_nvmem = true;
> +	ddata->config = cpcap_battery_unkown_data;
>   }
>   
>   /**
> 
