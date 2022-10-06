Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4334C5F62C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiJFIel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiJFIeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:34:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FBA95ADF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:34:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id x40so1371154ljq.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GzfT1UT0gTS4zyhoLR6feGjWpD8QE6QL/n6TzHcJTf8=;
        b=ok/+z3AU0eAV/B/T0mPPzKNo/A0muOVVf5j3pP1Jiq1vXSVOu2o9wAhRKxNB/xniC1
         fepJ1Qzz3O0PfpQiDLL6V+GjVCrXoPS6VW4M4niFjQ9BKN4nuFTJP/qs3Xie2+DF0m17
         CCwKfIwpQHcWlEAdOKqCBHr1hBcDDBgjH0QskaZr4QJsWjelFfM1fvNlCIdkhQQNjyEY
         U06B411pUnwYqIeW87lBOzh/sF1ZO9JQjWwWMyEU3rnuK5liwyn3DDRiCpUdpnK7PEwP
         qHvDW9E01rnLIYvbV3tMr5+zyM5Q6zmMkzYRHX6VuA9XAvXFrjVE/RHjbjwXAgUqJNzt
         p3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GzfT1UT0gTS4zyhoLR6feGjWpD8QE6QL/n6TzHcJTf8=;
        b=Wd2X7GbaN1LHJ0NLG5YKRaGs5kp5KPcSsXYyB7PkTyz0E1brdb/sdg6okXFuuze4kv
         Qii3FDT01PlGTFAs2srNC+0jN9h46tmEl/nFwSVUZ/HvWtNswn0+mD/BTN3tJuiDIJCC
         8UbY0htz2cppTMsyBjpf6MHpEwb6TrSosu077bJ3eqtXsabYgk10yibuT0xU5DO17fLe
         nx1LSS4bvDYrD+mKwMK/GjptUXKz9GRbH5MhVn3eeTFf3+yYI/UKi51ous8sbigKgzuW
         Ba+pzOmJGWF6cmOa28RvbozM1nDa+tIFIdxzNq/0AsMCXXrJO34cDYX34wkXuXksj3H0
         kNbA==
X-Gm-Message-State: ACrzQf2TcpMJMuRNxxWWW0hAHhtmuSZZalWkPywCB4qanYAS7GvQjBri
        kUkWyRlzvjlUE1vevzLZ9oXDig==
X-Google-Smtp-Source: AMsMyM5nrmXNwzgd8LgZLC8M6boRSeCMaCIpT1O1Z2xDnaBPB1QYMS8iSriYVnSAr8kWso/rFTZUCA==
X-Received: by 2002:a05:651c:2103:b0:25d:6478:2a57 with SMTP id a3-20020a05651c210300b0025d64782a57mr1304197ljq.496.1665045250038;
        Thu, 06 Oct 2022 01:34:10 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q3-20020a0565123a8300b004a05c425cb7sm2626537lfu.184.2022.10.06.01.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 01:34:09 -0700 (PDT)
Message-ID: <323457c6-7f7e-e127-82f4-b86f3bad243f@linaro.org>
Date:   Thu, 6 Oct 2022 10:34:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFCv2 PATCH 3/4] dt-bindings: gpio: add Wiegand GPIO driver dt
 documentation
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?Q?Martin_Za=c5=a5ovi=c4=8d?= <m.zatovic1@gmail.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        gregkh@linuxfoundation.org, jeffrey.l.hugo@gmail.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, saravanak@google.com,
        mani@kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20221005145746.172138-1-m.zatovic1@gmail.com>
 <20221005145746.172138-3-m.zatovic1@gmail.com>
 <959a45b0-b4bb-98df-20be-707aa0d26700@linaro.org>
In-Reply-To: <959a45b0-b4bb-98df-20be-707aa0d26700@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 10:23, Krzysztof Kozlowski wrote:
> On 05/10/2022 16:57, Martin Zaťovič wrote:
>> The Wiegand GPIO driver uses two GPIO lines to transmit data -
>> data-hi and data-lo. These lines need to be defined in the
>> devicetree, otherwise the driver will not probe successfully.
>>
>> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
>> ---
>>  .../bindings/gpio/gpio-wiegand.yaml           | 53 +++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-wiegand.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-wiegand.yaml b/Documentation/devicetree/bindings/gpio/gpio-wiegand.yaml
>> new file mode 100644
>> index 000000000000..3b235667ae17
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-wiegand.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/gpio/gpio-wiegand.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Wiegand GPIO controller
>> +
>> +description: |
>> +  Wiegand GPIO controller running under Wiegand bus.
> 
> GPIO controllers need "gpio-controller" property, so this seems to be
> something else.
> 
>> +
>> +maintainers:
>> +  - Martin Zaťovič <m.zatovic1@gmail.com>
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^wiegand-gpio@[0-9a-f]+$"
> 
> No need to enforce node name, unless this is for a class of devices. But
> then why "gpio" not just "wiegand"?
> 
>> +
>> +  compatible:
>> +    const: wiegand,wiegand-gpio
>> +
>> +  data-hi-gpios:
>> +    description: GPIO spec for data-hi line to use
>> +    maxItems: 1
>> +
>> +  data-lo-gpios:
>> +    description: GPIO spec for data-lo line to use
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - data-hi-gpios
>> +  - data-lo-gpios
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    wiegand {
>> +        compatible = "wiegand";
>> +
>> +        wiegand-gpio {
> 
> I have troubles understanding this. The "wiegand" node is the bus,
> right? Then what is "wiegand-gpio"? GPIO controller? Then why it is not
> marked as GPIO controller? What GPIOs does it control?
> 
>> +            compatible = "wiegand,wiegand-gpio";
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&pinctrl_uart2_wiegand>;
>> +            data-hi-gpios = <&gpio2 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
>> +            data-lo-gpios = <&gpio2 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> 
> Aren't these properties of the bus, not the device?

So this looks like specific implementation of Wiegand bus - a Wiegand
bus controller. If it is correct, it should not be represented as child
of a bus... because this is a bus. IOW, just like SPI or I2C controllers
(why is this one different?), the bus is defined by SPI controller:

wiegand {
	compatible = "wiegand,wiegand-gpio";
	data-hi-gpios = <&gpio2 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
	data-lo-gpios = <&gpio2 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;

	child-device, e.g. some-card {
		compatible = "foo,bar";
		// more properties of the device
	};
};

Best regards,
Krzysztof

