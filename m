Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8672260DCB4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiJZICy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiJZICv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:02:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43156A52E8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:02:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o4so16764617wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YyPwO7rl+gX39UNWAmiOxo6E2JYfZJtVX93jxGyGRgU=;
        b=PuRDg6g8vE/Kmsy/HXW2aR4DBNamMoZxiJHU4GN0BUDeWEzc4IgxUwgy7Ixwjz4Ofw
         8x3MXAzIIB3n1TmHVTwoTcdDMby6OcEsRQAmxt1/qpkoouMO71atWLSLm9ox614DP4Eu
         x1lpKX834t/hf4dWr6qS8KhQgWWSxoxKQ1MUw+lJcx+pRJ6ayE7ig4zeUSub6t40aeMw
         aArsBRynHmBpxkTCqYLCHORe/tqFJmciiSPRbm/jZ8grRTY78VSpj0dMhZfsDtlDLTSS
         PIcMVWAHuqkSMu0ajNpolEaYdB/IqDFIUkZ6dM0z00AWTxdKduOtW5U8DHK9cxkw+M4z
         mfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YyPwO7rl+gX39UNWAmiOxo6E2JYfZJtVX93jxGyGRgU=;
        b=5Zp+Ndq64BTBQ3wIsbLgOJ2ROeFqNBbljWoYq09PMlMJpUbWF2qFor9+9TuOsYfSCO
         Qnwf+lIHopM75RGti8ZuzJ39oJcm8oyzmfv6bKc8YBTY6T6iza2oeMZwKGojj8rakJCe
         8hZQ+lLQfshnQmasC8Q4l104BM3bZu6biQzsUxkToegGZiBKRfuVRdlHoBwt4IFUZKp0
         3baESx2T6OxksAK6lIiX8RcDPSg/aR0aOJA/6rFK0myKCjCf1uD2yMgbSPEhGatIQVaj
         1sJSgtmydiF7YaqS2/I8JB9N8ImtRbyB0r7fI0UKVM7vVri274Zq7kaRv2yDxRms0G3r
         IL8A==
X-Gm-Message-State: ACrzQf0OgYAIeL3egdRAdxJGR32rmWF9A3aGkhrAO/HkNyTG6YXiqy5x
        szkKH6xDvFDIQNzjAZTupkCSJQ==
X-Google-Smtp-Source: AMsMyM66kvpQWFo5u0OfUq/T3nHMOYZKy3o5Z+LNI+SLBAqxTTBw+3OHccmEWCRwfakgmYIBIojMlA==
X-Received: by 2002:a5d:5f03:0:b0:22f:8ad4:bd46 with SMTP id cl3-20020a5d5f03000000b0022f8ad4bd46mr27097794wrb.120.1666771368745;
        Wed, 26 Oct 2022 01:02:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ce41:a140:b67e:6c4b? ([2a01:e0a:982:cbb0:ce41:a140:b67e:6c4b])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b003b95ed78275sm1201579wmq.20.2022.10.26.01.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 01:02:46 -0700 (PDT)
Message-ID: <5d2ffeca-b41c-20b4-454b-703c39bbb29e@linaro.org>
Date:   Wed, 26 Oct 2022 10:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCHv3] arm64: dts: meson: Enable active coling using gpio-fan
 on Odroid N2/N2+
To:     Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Dan Johansen <strit@manjaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221022084737.1028-1-linux.amoon@gmail.com>
 <CAFBinCBu_-0m9JeAr5kd-v7Z5LTi7w0WmmUYybW_kL4KJXXpOQ@mail.gmail.com>
 <CANAwSgRzdD0FWg+z6hTFs7KvpsD64bChX-k0dPXJfACXZH2zbQ@mail.gmail.com>
 <CAFBinCCNJiL-ZKRYesQAwys6bBMpYHJbUDK-Zi_VhGDVSvF7uQ@mail.gmail.com>
 <CANAwSgTLTCA9=WvWXcR-40baauN3kAk2qx9k4FQOPCa1+_O0Yw@mail.gmail.com>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <CANAwSgTLTCA9=WvWXcR-40baauN3kAk2qx9k4FQOPCa1+_O0Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/10/2022 20:06, Anand Moon wrote:
> Hi Martin,
> 
> On Sat, 22 Oct 2022 at 17:22, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>>
>> Hi Anand,
>>
>> On Sat, Oct 22, 2022 at 1:27 PM Anand Moon <linux.amoon@gmail.com> wrote:
>> [...]
>>>>> @@ -1982,7 +1982,6 @@ pwm_ao_d_10_pins: pwm-ao-d-10 {
>>>>>                                                  mux {
>>>>>                                                          groups = "pwm_ao_d_10";
>>>>>                                                          function = "pwm_ao_d";
>>>>> -                                                       bias-disable;
>>>> &pwm_ao_d_10_pins is not referenced anywhere so it seems that this
>>>> change has no impact on controlling the fan on Odroid-N2(+).
>>>> How did you test this change?
>>>>
>>> Ok I felt these changes affect the behavior of the pinctrl
>>>
>>>    * @PIN_CONFIG_BIAS_DISABLE: disable any pin bias on the pin, a
>>>   *  transition from say pull-up to pull-down implies that you disable
>>>   *  pull-up in the process, this setting disables all biasing.
>>>
>>> I mapped this is linked in pinctrl driver, pwm_ao_d_10_pins GPIOAO_10 see below
>> Yes, I understand this part.
>> My concern is: &pwm_ao_d_10_pins settings only become active when this
>> node is actively referenced. You can even see it in your output
>> below...
>>
>> [...]
>>> pin 10 (GPIOAO_10): (MUX UNCLAIMED) aobus-banks:1958
>> This shows that it's used as a GPIO. If the &pwm_ao_d_10_pins setting
>> was used then it would show "function pwm_ao_d group pwm_ao_d_10"
>> (similar to what GPIOE_1 shows in your output)
>>
>> If you want to know if a pull-up/down is enabled you can look at the output of:
>> $ cat /sys/kernel/debug/pinctrl/ff800000.sys-ctrl\:pinctrl@14-pinctrl-meson/pinconf-pins
>> (I'm sure this can also be retrieved from some userspace tools, but I
>> don't know how)
>>
> 
> I now switch using pwm-fan with the local changes I am able to link
> pwm_ao_d_10_pins
> but now the issue is fan keeps on spinning on boot-up and stays on.
> 
> I can manually turn on off by using
> $ sudo gpioset gpiochip1 10=1   // fan on
> $ sudo gpioset gpiochip1 10=0   // fan off

By doing that actually override the PWM function of the pin and set it as a GPIO.

> 
> It is not controlled by the thermal tip as expected.
> I feel some configuration is missing in pwm-meson driver.
> Any input for me?
> 
> $ sudo cat /sys/kernel/debug/pinctrl/ff800000.sys-ctrl\:pinctrl@14-pinctrl-meson/pinmux-pins
> [sudo] password for alarm:
> Pinmux settings per pin
> Format: pin (name): mux_owner gpio_owner hog?
> pin 0 (GPIOAO_0): ff803000.serial (GPIO UNCLAIMED) function uart_ao_a
> group uart_ao_a_tx
> pin 1 (GPIOAO_1): ff803000.serial (GPIO UNCLAIMED) function uart_ao_a
> group uart_ao_a_rx
> pin 2 (GPIOAO_2): (MUX UNCLAIMED) aobus-banks:1950
> pin 3 (GPIOAO_3): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 4 (GPIOAO_4): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 5 (GPIOAO_5): ff808000.ir (GPIO UNCLAIMED) function
> remote_ao_input group remote_ao_input
> pin 6 (GPIOAO_6): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 7 (GPIOAO_7): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 8 (GPIOAO_8): (MUX UNCLAIMED) aobus-banks:1956
> pin 9 (GPIOAO_9): (MUX UNCLAIMED) aobus-banks:1957
> pin 10 (GPIOAO_10): ff807000.pwm (GPIO UNCLAIMED) function pwm_ao_d
> group pwm_ao_d_10
> pin 11 (GPIOAO_11): (MUX UNCLAIMED) aobus-banks:1959
> pin 12 (GPIOE_0): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 13 (GPIOE_1): ff802000.pwm (GPIO UNCLAIMED) function pwm_ao_d
> group pwm_ao_d_e
> pin 14 (GPIOE_2): ffd1b000.pwm (GPIO UNCLAIMED) function pwm_a_e group pwm_a_e
> 
> $ sudo cat /sys/kernel/debug/pwm
> platform/ffd1b000.pwm, 2 PWM devices
>   pwm-0   (regulator-vddcpu-a  ): requested enabled period: 1250 ns
> duty: 838 ns polarity: normal
>   pwm-1   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
> 
> platform/ff807000.pwm, 2 PWM devices
>   pwm-0   (pwm-fan             ): requested period: 1250 ns duty: 0 ns
> polarity: normal
>   pwm-1   ((null)              ): period: 0 ns duty: 0 ns polarity: normal

This should be on the pwm-1, hence the "pwm_AO_cd" name, "c" and "d" and the
names of the outputs.

So you need to use 1 as first PWM phandle argument instead of 0.

> 
> platform/ff802000.pwm, 2 PWM devices
>   pwm-0   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
>   pwm-1   (regulator-vddcpu-b  ): requested enabled period: 1250 ns
> duty: 1213 ns polarity: normal
> 
> I could observe a change in duty when we have stress testing the CPU.

Can you share the complete change you did here ?

> 
> Thanks
> 
> -Anand

Neil
