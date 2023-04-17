Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074A56E4431
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjDQJma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjDQJmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:42:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E132E9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:41:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v21-20020a17090a459500b0024776162815so4042203pjg.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1681724434; x=1684316434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUcfly+k+twv5TfjaViZgJr1WMXFSTMq+Wmw06BPNrs=;
        b=NS5CXlhiUAguOyuMGYUowciRddHrxIdDs060zDhmUIXEVINK+W/oxAjbixPJ65gd0J
         erQBG8KUM0LSyZEl58wSqQPkrWG1oW73d61ISHmD2sJ79wg4vaMNup6+ojDS1rvMYLRh
         YjuSUkGBDLx/oSzPTUHzfITIEc4LmPIy6/kqtdlbHqbSfUFNRA3lPT3e3P9Z6b8UxlzO
         zMxvq9ziasKiqfJ1dS6xnB8xVD2IfeK5CpfGE5t9a6SUUuSr1aXYx8Gd0ZNvYQSzciHr
         +AXeOWVkLj72QGluprZy/BuFZ8nG7sjvJdHTaGKEVUdmCVr/dy7LtfFxIlHwG48yuU9G
         +Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681724434; x=1684316434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUcfly+k+twv5TfjaViZgJr1WMXFSTMq+Wmw06BPNrs=;
        b=DRiVb7xeIEjrnSHKkHnhBidLU89SzBgxkK5Qa0+UHhAqOeUCC7VrPQ83ge4wTgcpTy
         dXDBN7AQ5LKEI/HmsYXJswh4xZz6JcX+DkU8BZWVmgpUXRChJKAT2rZSwO8p7ZRKRrQV
         aiDEWhXAvQuKAgH5kdLbJ6g1eV2DP8dOnYElS36MUIG4yTnq9OKvL4CYBZ/t1ICly1O7
         0EE7LFkf/rih5uDy7AhZ7nmN1vBDMu162CNz3ipeweyS3kkTSk9c+Q9wyEW7XWrKP1DQ
         +EuZ0Ps1I5f1pC+F2o12gCLXDnGH2H2Zxj0y3ywdG7G5O3hH6KTs4YBH+92k24nLl79l
         Wy6A==
X-Gm-Message-State: AAQBX9fbvK75HNriloqin4WG1LkxyPMGbcGadeBKDSJkDkGW+UcPpv0K
        R1KaU4eS+lMWltJiOHu93GcK6g==
X-Google-Smtp-Source: AKy350arw8nWD9noplIjKGTttkk5WJxVqrqoAR5Y0o3lgIAl7LPGYXQ8vB9d99nZO+f8ESaKsHUtmw==
X-Received: by 2002:a05:6a20:160e:b0:ef:511:d6fe with SMTP id l14-20020a056a20160e00b000ef0511d6femr7572558pzj.9.1681724433924;
        Mon, 17 Apr 2023 02:40:33 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d855:461d:14be:2cce:b776? ([2405:201:d02f:d855:461d:14be:2cce:b776])
        by smtp.gmail.com with ESMTPSA id e6-20020aa78246000000b0062e024b5584sm7206126pfn.34.2023.04.17.02.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 02:40:33 -0700 (PDT)
Message-ID: <fdfb022e-db2e-b419-4cec-4f89b3aa5f28@9elements.com>
Date:   Mon, 17 Apr 2023 15:10:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] leds: max597x: Add support for max597x
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Lee Jones <lee@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20230413102624.3561299-1-Naresh.Solanki@9elements.com>
 <ZDfj5I3l4O1FkiW3@duo.ucw.cz>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <ZDfj5I3l4O1FkiW3@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 13-04-2023 04:43 pm, Pavel Machek wrote:
> Hi!
> 
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> max597x is hot swap controller with indicator LED support.
>> This driver uses DT property to configure led during boot time &
>> also provide the LED control in sysfs.
>>
>> DTS example:
>>      i2c {
>>          #address-cells = <1>;
>>          #size-cells = <0>;
>>          regulator@3a {
>>              compatible = "maxim,max5978";
>>              reg = <0x3a>;
>>              vss1-supply = <&p3v3>;
>>
>>              regulators {
>>                  sw0_ref_0: sw0 {
>>                      shunt-resistor-micro-ohms = <12000>;
>>                  };
>>              };
>>
>>              leds {
>>                  #address-cells = <1>;
>>                  #size-cells = <0>;
>>                  led@0 {
>>                      reg = <0>;
>>                      label = "led0";
>>                      default-state = "on";
>>                  };
>>                  led@1 {
>>                      reg = <1>;
>>                      label = "led1";
>>                      default-state = "on";
>>                  };
>>              };
>>          };
>>      };
>>
> 
> Yeah, well, dts bindings need to be properly documented, and example
> goes to the binding, right?
Yes.
> 
> Plus, we should have better names than led0/led1. Something like
> hdd0:green:something, based on what the LED does and what are you hot
> swapping. See/modify Documentation/leds/well-known-leds.txt .
Yeah sure.
> 
> 
>> +static int max597x_led_set_brightness(struct led_classdev *cdev,
>> +				      enum led_brightness brightness)
>> +{
>> +	struct max597x_led *ddata = ldev_to_maxled(cdev);
>> +	int ret, val;
>> +
>> +	if (!ddata->regmap)
>> +		return -ENODEV;
>> +
>> +	/* Set/Clear corresponding bit for given led index */
> 
> "/clear".
Ack.
> 
>> +	val = !brightness ? BIT(ddata->index) : 0;
>> +	ret = regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLASH, BIT(ddata->index), val);
>> +	if (ret < 0)
>> +		dev_err(cdev->dev, "failed to set brightness %d", ret);
> 
> '\n"'.
Ack
> 
>> +	ddata->cdev.brightness_set_blocking = max597x_led_set_brightness;
>> +	ddata->cdev.default_trigger = "none";
> 
> So what do these leds normally do? Should they be registered with
> common function to handle default triggers etc?
Not sure if I understand your question right. In my use case in server 
motherboards, they are use to indicate presence of power for individual 
PCIe NVME connectors. Turning the LED on/off is handled by another 
application based on some conditions.
> 
>> +	ddata->index = reg;
>> +	ddata->regmap = regmap;
>> +	ret = devm_led_classdev_register(dev, &ddata->cdev);
>> +	if (ret)
>> +		dev_err(dev, "Error initializing LED %s", ddata->cdev.name);
> 
> '\n"'.
Ack
> 
>> +module_platform_driver(max597x_led_driver);
>> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
>> +MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
> 
> "MAX5970 hot-swap"?
max5970 is primarily a hotswap controller & it also had indication led 
support.
> 
>> +MODULE_LICENSE("GPL");
>>
>> base-commit: 11e572d06c23d61683e20a98bd16f550ef17ac65
>> prerequisite-patch-id: 456044abe991b2ff3b521d337825432789d71b29
> 
> ?? Send prerequisites in the series?
Will fix in v5.
> 
> BR,
> 								Pavel
Regards,
Naresh
