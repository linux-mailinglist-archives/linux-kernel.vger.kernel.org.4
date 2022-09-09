Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0505B3E1E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiIIRnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiIIRnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:43:47 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50E3B9FA3;
        Fri,  9 Sep 2022 10:43:44 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y136so2335465pfb.3;
        Fri, 09 Sep 2022 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date;
        bh=LRneblQEh19hJEGNPBGoCScjU1yIefedI8Ztk/H4XpI=;
        b=ZyVYfIQhHxbP2RIGijgGRHxVOYG1qVsMPjeAY+0oRQqvpeMcYUcOvUhwwChDq7U+QY
         T268rh1P17qPTRwdT0nRTO3sLd05SB3u9ORvc4RLhXSAZyXRWPPv2zXD38FDm2qkK/Wf
         6DRQFNGV+QPySp0BERNAZx9NCG9IJXs5Ou3+2LaL0lkZBS+9NQppoShJNnxPLfhZLFv+
         MLrdzp0HCsjzZuaxRwhBn7zguVmnA0Oe//vwYIKm1+CAZBVmEqIjGIZVBhXJiXImjxWP
         b2wePYHlAfeXmXQcGMKhWM/zmUUxqHV+OFrOlgRym4/Xx/pfj1LgYI16y3sKLAgAMjdT
         0mJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LRneblQEh19hJEGNPBGoCScjU1yIefedI8Ztk/H4XpI=;
        b=LQTk1Vc6w9f7yMpRDrd09BL79Lz3++5QFOyJC1f8VyUaw9H8ciRXC36Bk0u5YvCF9S
         neYiCNNx9emg6PIYWz4lSGK/BMuv6P0EK6NI7dp3PR/lbKk26FIOaQfDC26R5/35ZdFg
         2o13tPMqs8bG1iqkR68YI2+WgEYxTAsgeS8I1smMAiGPQD3VG2QKOXmxjZYNbpbf5REt
         HpaVFSqu98yG/dzpVeiE9PHAh27MAvY+ZEE+d+VdxrhD5OfK2eKlzqatM15CPjkLXCST
         9e4M2POgGX4Cb3EFbrAdDwLthYBxcJDSeyqdrOFaksdcPY+Q5mXmIRlyN0ta4fY5VotC
         epZw==
X-Gm-Message-State: ACgBeo1V5JH3Tj1IDS1gr3hYzBNFjaVuNkFpoey2dDZ3mXdFiAR0qPOo
        uUYpiWSE20UVwJtBDOGhLM8=
X-Google-Smtp-Source: AA6agR5wvJM2nrbRK+TYJzP0jh/Ed4N7B502wnYuPZ0ddAef+8gWcPCMCv9pxRjEyeOQT3p/8E7O9g==
X-Received: by 2002:a05:6a00:2395:b0:52f:723c:363 with SMTP id f21-20020a056a00239500b0052f723c0363mr15292989pfc.21.1662745422445;
        Fri, 09 Sep 2022 10:43:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902ce8400b0016dc6279ab7sm754007plg.149.2022.09.09.10.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 10:43:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fd0b0c53-192e-7205-91a8-fdb8953e9026@roeck-us.net>
Date:   Fri, 9 Sep 2022 10:43:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>
References: <20220909133718.388213-1-Ibrahim.Tilki@analog.com>
 <20220909133718.388213-2-Ibrahim.Tilki@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v8 1/4] drivers: hwmon: Add max31760 fan speed controller
 driver
In-Reply-To: <20220909133718.388213-2-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 06:37, Ibrahim Tilki wrote:
> MAX31760 is a precision fan speed controller with nonvolatile lookup table.
> Device has one internal and one external temperature sensor support.
> Controls two fans and measures their speeds. Generates hardware alerts when
> programmable max and critical temperatures are exceeded.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> Reviewed-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>

Since you'll have to resend this anyway to address the devicetree
failures:

[ ... ]

> +
> +static int max31760_write(struct device *dev, enum hwmon_sensor_types type,
> +			  u32 attr, int channel, long val)
> +{
> +	struct max31760_state *state = dev_get_drvdata(dev);
> +	unsigned int pwm_index;
> +	unsigned int reg_temp;
> +	int temp;
> +	u8 reg_val[2];
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_max:
> +			reg_temp = REG_TEMP_MAX(channel);
> +			break;
> +		case hwmon_temp_crit:
> +			reg_temp = REG_TEMP_CRIT(channel);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +		temp = TEMP11_TO_REG(val);
> +		reg_val[0] = temp >> 8;
> +		reg_val[1] = temp & 0xFF;
> +
> +		return regmap_bulk_write(state->regmap, reg_temp, reg_val, 2);
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_enable:
> +			if (val == 0)
> +				return regmap_clear_bits(state->regmap, REG_CR3, BIT(channel));
> +
> +			if (val == 1)
> +				return regmap_set_bits(state->regmap, REG_CR3, BIT(channel));
> +
> +			return -EOPNOTSUPP;

This should return -EINVAL.

> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			if (val < 0 || val > 255)
> +				return -EINVAL;
> +
> +			return regmap_write(state->regmap, REG_PWMR, val);
> +		case hwmon_pwm_enable:
> +			if (val == 1)
> +				return regmap_set_bits(state->regmap, REG_CR2, CR2_DFC);
> +
> +			if (val == 2)
> +				return regmap_clear_bits(state->regmap, REG_CR2, CR2_DFC);
> +
> +			return -EOPNOTSUPP;

This should return -EINVAL (the _operation_ is supported, after all,
but the written value is invalid).

Thanks,
Guenter
