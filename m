Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872C3663603
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbjAJAEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbjAJAEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:04:49 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7430FDFCC;
        Mon,  9 Jan 2023 16:04:48 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-15085b8a2f7so10569509fac.2;
        Mon, 09 Jan 2023 16:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tU7xqlxoqQYzxNUd2tV9T0j18fTCGh8gQdqsrjiDR18=;
        b=VCvgFgIO+G4qIlz2s3+FUcKmJ9xolwbkKBDVQd7C8z/HK6P7+HYIW/LRENO5wZ8JZT
         K1CKRg8n5VeQK9EHzkksIIWSGUsVBG0i2tbsQwwVcBNlUDYW8ZIA+Q9aetlKBtxFRJVZ
         eWZdh8MXnaYEl4CMDUOj00bjgg7WIGRnvrWjIa6udbhxGJfVXl8JMPF6ZbBEpjp9cWmf
         91DjHvMfWCVFl5PFBU+6dU/fKi1IYlKEnnJi491aXEBDQEWOXYt0bf20IPpUidzzg+EQ
         JGPegHDTVzpfuxhPYkzDqn6h9+bUgO3lTkXx2/xR2t7Q7glKfchpW8kg/mIPduwxZhKU
         40mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tU7xqlxoqQYzxNUd2tV9T0j18fTCGh8gQdqsrjiDR18=;
        b=F90B24k45x6L4NZiWj1N4OrdRaIn+VOySKBDCamgiWzDopWBc3djLk4E3+pnG1MJOf
         hmLzA7P7kbsw1GkmotD4y/UBWBWzPAH0djetMjQjMacMHV0y2DRfOiLoCP/gFfFT1tvz
         q6/g6R0eVPn1vCAh32ZJpvtrcRBAcGpoMfMyjyLOv+SCkDj2ebZBCvZKG5hVV9sovUV3
         QeNXcTZi2DBN2mVWoNKoXJ2w/CYKj+6AvvVY1fmcM50g2aCY4zeX3Nfoh4CqhRRV97h5
         j31EngvnIQ/wvbIQ7pRwWztbaMQsO5vmaJbz3zmYLGnx1esS6Hkm8Uk+ws/DWvd2P8oq
         6HCw==
X-Gm-Message-State: AFqh2kpIdHxWr3h6ks952bFwJm/U6va3H933KrfaRXp7wvP98WchsT4B
        kPQWS4TWGnoheC5tgZeSmmc7Mwigji4=
X-Google-Smtp-Source: AMrXdXsb8On+uzw3FWK3vK1VkZcaAObj4m6y3i+HKyTpeKJI6+GyvLelZK+5q8EBpined4AKIx9aVA==
X-Received: by 2002:a05:6870:c1c2:b0:14f:9e41:7dbe with SMTP id i2-20020a056870c1c200b0014f9e417dbemr38258957oad.10.1673309087755;
        Mon, 09 Jan 2023 16:04:47 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p22-20020a056870831600b0014813cc4a51sm4985686oae.29.2023.01.09.16.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 16:04:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d49d4b4c-e7ee-e0a1-56e6-7f193e0d1340@roeck-us.net>
Date:   Mon, 9 Jan 2023 16:04:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 3/5] hwmon: ltc2945: Handle error case in
 ltc2945_value_store
Content-Language: en-US
To:     Jonathan Cormier <jcormier@criticallink.com>,
        linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
References: <20221214220727.1350784-3-jcormier@criticallink.com>
 <20230109233534.1932370-1-jcormier@criticallink.com>
 <20230109233534.1932370-4-jcormier@criticallink.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230109233534.1932370-4-jcormier@criticallink.com>
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

On 1/9/23 15:35, Jonathan Cormier wrote:
> ltc2945_val_to_reg errors were not being handled
> which would have resulted in register being set to
> 0 (clamped) instead of being left alone.
> 
> Change reg_to_val and val_to_reg to return values
> via parameters to make it more obvious when an
> error case isn't handled. Also to allow
> the regval type to be the correct sign in prep for
> next commits.
> 

Sorry, I don't see that as reason or argument for such invasive changes.
As far as I can see, a two-liner to check the return value of val_to_reg()
should have been sufficient. Most of the rest, such as splitting
the return value into two elements, is POV and just adds additional code
and complexity for zero gain.

Guenter

> Fixes: 6700ce035f83 ("hwmon: Driver for Linear Technologies LTC2945")
> 
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> ---
>   drivers/hwmon/ltc2945.c | 30 ++++++++++++++++++------------
>   1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> index 9af3e3821152..c66acf8d2124 100644
> --- a/drivers/hwmon/ltc2945.c
> +++ b/drivers/hwmon/ltc2945.c
> @@ -70,12 +70,12 @@ static inline bool is_power_reg(u8 reg)
>   }
>   
>   /* Return the value from the given register in uW, mV, or mA */
> -static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> +static int ltc2945_reg_to_val(struct device *dev, u8 reg, u64 *regval)
>   {
>   	struct regmap *regmap = dev_get_drvdata(dev);
>   	unsigned int control;
>   	u8 buf[3];
> -	long long val;
> +	u64 val;
>   	int ret;
>   
>   	ret = regmap_bulk_read(regmap, reg, buf,
> @@ -148,11 +148,12 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>   	default:
>   		return -EINVAL;
>   	}
> -	return val;
> +	*regval = val;
> +	return 0;
>   }
>   
>   static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> -			      unsigned long val)
> +			      unsigned long val, unsigned long *regval)
>   {
>   	struct regmap *regmap = dev_get_drvdata(dev);
>   	unsigned int control;
> @@ -220,19 +221,21 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>   	default:
>   		return -EINVAL;
>   	}
> -	return val;
> +	*regval = val;
> +	return 0;
>   }
>   
>   static ssize_t ltc2945_value_show(struct device *dev,
>   				  struct device_attribute *da, char *buf)
>   {
>   	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> -	long long value;
> +	int ret;
> +	u64 value;
>   
> -	value = ltc2945_reg_to_val(dev, attr->index);
> -	if (value < 0)
> -		return value;
> -	return sysfs_emit(buf, "%lld\n", value);
> +	ret = ltc2945_reg_to_val(dev, attr->index, &value);
> +	if (ret < 0)
> +		return ret;
> +	return sysfs_emit(buf, "%llu\n", value);
>   }
>   
>   static ssize_t ltc2945_value_store(struct device *dev,
> @@ -245,7 +248,7 @@ static ssize_t ltc2945_value_store(struct device *dev,
>   	unsigned long val;
>   	u8 regbuf[3];
>   	int num_regs;
> -	int regval;
> +	unsigned long regval;
>   	int ret;
>   
>   	ret = kstrtoul(buf, 10, &val);
> @@ -253,7 +256,10 @@ static ssize_t ltc2945_value_store(struct device *dev,
>   		return ret;
>   
>   	/* convert to register value, then clamp and write result */
> -	regval = ltc2945_val_to_reg(dev, reg, val);
> +	ret = ltc2945_val_to_reg(dev, reg, val, &regval);
> +	if (ret < 0)
> +		return ret;
> +
>   	if (is_power_reg(reg)) {
>   		regval = clamp_val(regval, 0, 0xffffff);
>   		regbuf[0] = regval >> 16;

