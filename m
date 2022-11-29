Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BB663C34D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiK2PGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiK2PGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:06:10 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8943FBA4;
        Tue, 29 Nov 2022 07:06:08 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-142faa7a207so17281760fac.13;
        Tue, 29 Nov 2022 07:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kDwNcelrs2eUV+lrqFjarpCKpHkKCs1VhcZri8buYKI=;
        b=AoZfmFeYKOl4l2lIHPCkTbcdpAwJpSta0pfkYwaOkFHCISQw8IoGt3aERVL2/nqOkC
         a6BHyldoXF8TPzDrKg0hHQ+iLMySV9kk5duA9ppJwI3nVnZkecI7mqXVjTzxjc1tPf1s
         Hlx15iEgHrOjRYo0NFhhTx1q/VYw5qA3kSnG/L/75Bylsq7133s9dlcs8Qr30wwEV7OG
         fNFek9RS1KKxHLxzZ/tujDKRHxDGuDqt7+cMME8GxWqaraogMMeyD/FP/SgXOdZq/OZw
         5MI31UGRbttIb/R9Kk+rkdl4d+hqpbnXIkdE9XBkr6wnotATQzBzfuZTkWlopIn4Ubmp
         l5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDwNcelrs2eUV+lrqFjarpCKpHkKCs1VhcZri8buYKI=;
        b=8KgAi9UJw2PaccUuK3Dotv2811EMQ5V/IvQravvE+tF9mACDZ4MB238HbctXyrrDCk
         thxg1r9uUk8hewiKQ2uYop1kxi5p0n+/I68z0RObAkFRHm/8jQAw2zBYpi0uZrBUh/MJ
         d3/ELl7AHrWse/u1xSg2RhD77wlOPkDOXbE+xCVpvhpth5ymFDfUBFopU+uiAQII1Wgy
         EWr5RefFXOUrcwE4VA3OVa8YcJjOvixkU92TPr8Xw6cqopyuHHtUiKAACWJAWL/ml9Gi
         nIFztwNHQMshzIT1Eiew0FOxTpLsCzmeraq4w2mVirXZdi+tS/D95sDrd4J/enoyDmH0
         5RrQ==
X-Gm-Message-State: ANoB5pm2OwqfbBgH5kVMscQqYo/jEhR3H868CIvr9TmplQjgGM51KEAh
        vxMZL3hyZwY2mZusv4Tedmw=
X-Google-Smtp-Source: AA0mqf5oDydb9EGtYPiKSPOiYCPpv8fl65qEocklfg33+p3F9hythil2GZwIwm+FvmCbwsKu6AnaMQ==
X-Received: by 2002:a05:6870:54d2:b0:131:e200:1492 with SMTP id g18-20020a05687054d200b00131e2001492mr21190025oan.44.1669734367149;
        Tue, 29 Nov 2022 07:06:07 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h9-20020a4ad009000000b0049be9c3c15dsm5517327oor.33.2022.11.29.07.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 07:06:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a0b48e60-59ce-0033-b09f-2f92983753b7@roeck-us.net>
Date:   Tue, 29 Nov 2022 07:06:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [v4 5/5] hwmon: Add Aspeed ast2600 TACH support
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee@kernel.org" <lee@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc:     kernel test robot <lkp@intel.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-6-billy_tsai@aspeedtech.com>
 <bf851fa1-af62-5cdc-8cb4-bcf29b73731a@roeck-us.net>
 <D5F454FE-9C4B-4B7E-8817-637D5FCC047A@aspeedtech.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <D5F454FE-9C4B-4B7E-8817-637D5FCC047A@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 23:08, Billy Tsai wrote:
> On 2022/11/23, 11:45 PM, "Guenter Roeck" <groeck7@gmail.com on behalf of linux@roeck-us.net> wrote:
> 
>      On 11/22/22 22:16, Billy Tsai wrote:
>      > > +The driver provides the following sensor accesses in sysfs:
>      > > +=============== ======= =====================================================
>      > > +fanX_input	ro	provide current fan rotation value in RPM as reported
>      > > +			by the fan to the device.
>      > > +fanX_div	rw	Fan divisor: Supported value are power of 4 (1, 4, 16
>      > > +                        64, ... 4194304)
> 
>      > The code doesn't support 1.
> 
> The code can support 1.
> 
Sorry, leftover from when I misread the code and thought it didn't.
> 
>      > The existence of a status register makes me wonder what is in there.
>      > Does the controller report any errors ? If so, it might be worthwile
>      > adding attribute(s) for it.
> 
>      > > +	if (ret)
>      > > +		return ret;
>      > > +
>      > > +	if (!(val & TACH_ASPEED_FULL_MEASUREMENT))
>      > > +		return 0;
>      > > +	rpm = aspeed_tach_val_to_rpm(priv, fan_tach_ch,
>      > > +				     val & TACH_ASPEED_VALUE_MASK);
>      > > +
>      > > +	return rpm;
> 
> The status register is the TACH_ASPEED_FULL_MEASUREMENT which is used to indicate that
> the controller doesn't detect the change in tach pin for a long time.
> 
>      > > +static void aspeed_create_fan_tach_channel(struct aspeed_tach_data *priv,
>      > > +					   u32 tach_ch)
>      > > +{
>      > > +	priv->tach_present[tach_ch] = true;
>      > > +	priv->tach_channel[tach_ch].limited_inverse = 0;
>      > > +	regmap_write_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
>      > > +			  TACH_ASPEED_INVERS_LIMIT,
>      > > +			  priv->tach_channel[tach_ch].limited_inverse ?
>      > > +				  TACH_ASPEED_INVERS_LIMIT :
>      > > +				  0);
>      > > +
>      > What is the purpose of the above code ? limited_inverse is always 0.
> 
>      > > +	priv->tach_channel[tach_ch].tach_debounce = DEBOUNCE_3_CLK;
>      > > +	regmap_write_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
>      > > +			  TACH_ASPEED_DEBOUNCE_MASK,
>      > > +			  priv->tach_channel[tach_ch].tach_debounce
>      > > +				  << TACH_ASPEED_DEBOUNCE_BIT);
>      > > +
>      > > +	priv->tach_channel[tach_ch].tach_edge = F2F_EDGES;
>      > > +	regmap_write_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
>      > > +			  TACH_ASPEED_IO_EDGE_MASK,
>      > > +			  priv->tach_channel[tach_ch].tach_edge
>      > > +				  << TACH_ASPEED_IO_EDGE_BIT);
>      > > +
> 
>      > limited_inverse, tach_debounce, and tach_edge are constants.
>      > There is no need to keep constants as per-channel variables.
> 
>      > > +	priv->tach_channel[tach_ch].divisor = DEFAULT_TACH_DIV;
>      > > +	regmap_write_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
>      > > +			  TACH_ASPEED_CLK_DIV_T_MASK,
>      > > +			  DIV_TO_REG(priv->tach_channel[tach_ch].divisor)
>      > > +				  << TACH_ASPEED_CLK_DIV_BIT);
>      > > +
>      > > +	priv->tach_channel[tach_ch].threshold = 0;
>      > > +	regmap_write_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
>      > > +			  TACH_ASPEED_THRESHOLD_MASK,
>      > > +			  priv->tach_channel[tach_ch].threshold);
>      > > +
> 
>      > The above applies to threshold as well.
> 
> The above code is used to retain the adjustable feature of the controller.
> I will remove them until I add the dts property to support them.
> 
>      > > +	}
>      > > +
>      > > +	hwmon = devm_hwmon_device_register_with_info(dev, "aspeed_tach", priv,
>      > > +						     &aspeed_tach_chip_info, NULL);
>      > > +	ret = PTR_ERR_OR_ZERO(hwmon);
>      > > +	if (ret)
>      > > +		return dev_err_probe(dev, ret,
>      > > +				     "Failed to register hwmon device\n");
>      > > +	return 0;
> 
>      > Why not return the error ? Either it is an error or it isn't. If it is
>      > not an error, dev_err_probe() is not appropriate. If it is, the error
>      > should be returned. Either case, if this is on purpose, it needs an
>      > explanation.
> 
> I have return the return value of the dev_err_probe. Did I miss someting?
> 
No, me not having enough coffee when reviewing the code. Sorry for the noise.

Thanks,
Guenter

