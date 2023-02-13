Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D466945BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBMMYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjBMMYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:24:30 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16DF18B08
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:24:24 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n13so8565012wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akDdfWgAom4+Qw6oyiFy0XwcGM2sFwhM88l4NhMh8Yk=;
        b=p5YYZG3Z9ppDNThNZy/tz6Yuou5EdPxXopV4/5yFaI40miPBZ9IX5TD0nTKMATIHd7
         Euz8gCYfGkWXLDX13F77p5qks7C0y/cpQmvYJuV7BvbvcjZUvPDrfifFb2T0K0Hciixc
         LpPcTl7JwCGHS/R22K1yqzriCwyuXX/vT+8OG5nEjtvsfpyQHegk84g0GJzP0Th1MdTF
         OZLIKfbiIoe5GB3jMpBuBuV6qcgH96a7mr+oWGnEqMHTIg+R7yx56JN+m+UbTRe5aLdj
         WIGkRNRsIfDkns0GN7e1dSi421tRQB3krkrT/CNq1K2wJfe+FJYEidc/qXp78CY2aaTG
         GgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akDdfWgAom4+Qw6oyiFy0XwcGM2sFwhM88l4NhMh8Yk=;
        b=fFdh5NlGfx+WfU7T+pN7IWcxffC7JFyn9/6VxMBmHhgqw+MzcpwY29A96mlZC9Ru4i
         RrxzRYjLn/nrEMXrx9jdCmZp10KGN5vc9sp8N8YXqtt6IJChk4FKqQYOKkBdwEYD5gaR
         +72Xty6CK5G4daKv+V+rhzXPv+IU1XwfoGJz0JeCkSCqj2ms3uJvJ0pmTwryS9z1mlNr
         s6oi83sCgjKnoB1kACYSN4qNtCZaxRoWSjSww77ddhMDe86tZW6684tNfQGxVdduxvx/
         by5w3tFT5YIUKpAKEcl/HQmOea6+upndKylOkm16diSNgfuQyyR9SAQHPGu8DxHSHej0
         me0g==
X-Gm-Message-State: AO0yUKVrKDApUMyDr8BVKXusGc0Hq+opOHIJHd7T+Zk5901PpVeMm/FZ
        XPP1tyaEctIlh7MXELN813kHIw==
X-Google-Smtp-Source: AK7set8CA6HBWgQFi1iHVyKXED3E3GqaxxXZI6kp4jnxJeL/OCD+KZp0i7N94qkf4k+kxjVAMAq4Sg==
X-Received: by 2002:a05:600c:a295:b0:3da:1e35:dfec with SMTP id hu21-20020a05600ca29500b003da1e35dfecmr18942967wmb.4.1676291063435;
        Mon, 13 Feb 2023 04:24:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003daf7721bb3sm18199812wms.12.2023.02.13.04.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 04:24:23 -0800 (PST)
Message-ID: <5739cfb2-ec6a-410f-9d2f-6e9bfc115cdd@linaro.org>
Date:   Mon, 13 Feb 2023 13:24:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] rtc: pcf85363: add support for the
 quartz-load-femtofarads property
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20230213095018.2255225-1-javier.carrasco@wolfvision.net>
 <12dc51e4-622e-4a26-8bde-2795d77ce36e.e0c24246-04d4-485f-8d5f-1cc8fbefd095.f44d6731-6fc0-4ea1-bc6d-c08581fb532e@emailsignatures365.codetwo.com>
 <20230213095018.2255225-2-javier.carrasco@wolfvision.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213095018.2255225-2-javier.carrasco@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 10:50, Javier Carrasco wrote:
> The quartz oscillator load capacitance of the PCF85263 and PCF85363 can
> be adjusted to 6 pF, 7 pF (default) and 12.5 pF with the CL[1:0] bits in
> the oscillator control register (address 25h).
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  drivers/rtc/rtc-pcf85363.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index c05b722f0060..941f9264cf0a 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
> @@ -101,6 +101,10 @@
>  #define PIN_IO_INTA_OUT	2
>  #define PIN_IO_INTA_HIZ	3
>  
> +#define OSC_CAP_SEL	GENMASK(1, 0)
> +#define OSC_CAP_6000	0x01
> +#define OSC_CAP_12500	0x02
> +
>  #define STOP_EN_STOP	BIT(0)
>  
>  #define RESET_CPR	0xa4
> @@ -117,6 +121,32 @@ struct pcf85x63_config {
>  	unsigned int num_nvram;
>  };
>  
> +static int pcf85363_load_capacitance(struct pcf85363 *pcf85363, struct device_node *node)
> +{
> +	u32 load = 7000;
> +	u8 value = 0;
> +
> +	of_property_read_u32(node, "quartz-load-femtofarads", &load);
> +
> +	switch (load) {
> +	default:
> +		dev_warn(&pcf85363->rtc->dev, "Unknown quartz-load-femtofarads value: %d. Assuming 7000",
> +			 load);
> +		fallthrough;
> +	case 7000:
> +		break;
> +	case 6000:
> +		value |= OSC_CAP_6000;
> +		break;
> +	case 12500:
> +		value |= OSC_CAP_12500;
> +		break;
> +	}
> +
> +	return regmap_update_bits(pcf85363->regmap, CTRL_OSCILLATOR,
> +				  OSC_CAP_SEL, value);
> +}
> +
>  static int pcf85363_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
> @@ -372,7 +402,7 @@ static int pcf85363_probe(struct i2c_client *client)
>  			.reg_write = pcf85363_nvram_write,
>  		},
>  	};
> -	int ret, i;
> +	int ret, i, err;
>  
>  	if (data)
>  		config = data;
> @@ -394,6 +424,11 @@ static int pcf85363_probe(struct i2c_client *client)
>  	if (IS_ERR(pcf85363->rtc))
>  		return PTR_ERR(pcf85363->rtc);
>  
> +	err = pcf85363_load_capacitance(pcf85363, client->dev.of_node);

Aren't you updating it for all variants? But the property is marked as
not valid for them.

Best regards,
Krzysztof

