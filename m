Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760616CD032
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjC2CkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjC2CkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:40:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551252D52;
        Tue, 28 Mar 2023 19:39:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so14699650pjt.5;
        Tue, 28 Mar 2023 19:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680057581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBqGLlQWBzgLNM35bMIlMtkWU8jTVbK7kCFdEUE+Qfo=;
        b=Vjan1Kr+TFn/CY5K5IF4pP6hej+Aa9g5aPDT19X76pFs9ZNlxDp1kp4XtkUhIgRdTz
         cGD/i0fyo5QIEu7nTFQV/F+hR1sdbctMxVmc3FVrnUzW/ZSvQNqbKDGLJoSWAQKtGKvm
         P1a2nF0kavJa12oiead6ZuFma6iLroT1kP4gK5zeOfz+me5QV8tT2qKnLE599hTiJs4F
         JI7y0SxBvzxqGqvHLYZOIK7XnzbUnkCiVptVdOLiB+EY6G2RTEfNKOPGA7o5yPSGGnYW
         Wmowhcv0QoYYcw2zDC9Mv56l6xqtWYlN8+70i9uoAwjLtPAVg8DiMV2WdtN6eCeEGSdR
         RdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680057581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBqGLlQWBzgLNM35bMIlMtkWU8jTVbK7kCFdEUE+Qfo=;
        b=eYQkqlcEgb7K/yqLF7wvKbpllXVgYm66jU7XP8RZlVanx6UZAR2OSTl9N37p1Ctt8v
         ICBU+pat/+miyyKJGG1Y4jCO9/vXozRBPTZyMFs5PVGInmGJphXo+3NL9b0pcj2u+AY+
         frkxC3KcL403VFEO+yTi0kYQwJetUPwONDW9H3U4yxC9WHDTRTvcMg/MtnlVU8MLd+gD
         yptIDWNK5lwmBit06pIydKyb/AMU9e5gHGLvgayLEEGYcuY0oSp3yDDSqFRRqZYzJGAo
         0jOispm2ezU36f3mzdQeGUpI+c3oUsOWFT84eaT6fYXhDqimqIS7vtGut3M+2qTtvsAJ
         bUvw==
X-Gm-Message-State: AAQBX9eO5n4mqaSxmSi0huXpMIOkpjoSCMnfMkRlXucIK7HzK+a39bmw
        ZgPQXLYNMpSiNRmCr8AYUYM=
X-Google-Smtp-Source: AKy350YWk1xnpVihNB+oV1sB+z3d2We64JMKsJiLUKkDM/cPOwkg+LyuPDnNTktEBZ+3siz68xOGog==
X-Received: by 2002:a17:90b:1d09:b0:240:5397:bd91 with SMTP id on9-20020a17090b1d0900b002405397bd91mr18805633pjb.4.1680057580703;
        Tue, 28 Mar 2023 19:39:40 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id w11-20020a63474b000000b005134fc049d7sm4907262pgk.31.2023.03.28.19.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 19:39:40 -0700 (PDT)
Message-ID: <129cf4b6-b3b5-2a12-5911-37e70a624812@gmail.com>
Date:   Wed, 29 Mar 2023 10:39:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 08/12] arm64: dts: nuvoton: Add initial ma35d1 device
 tree
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-9-ychuang570808@gmail.com>
 <ab4e0bc8834b7e618e9a88ea6a1c30cc.sboyd@kernel.org>
 <b7977069-4f82-76a1-10c1-b6400862c2c4@gmail.com>
 <c37e1f3a40c404acd81c2c9d5b28b340.sboyd@kernel.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <c37e1f3a40c404acd81c2c9d5b28b340.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Stephen,


On 2023/3/29 上午 10:19, Stephen Boyd wrote:
> Quoting Jacky Huang (2023-03-28 19:03:24)
>> On 2023/3/29 上午 01:57, Stephen Boyd wrote:
>>> Quoting Jacky Huang (2023-03-27 19:19:08)
>>>> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>>>> new file mode 100644
>>>> index 000000000000..0740b0b218a7
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>>>> @@ -0,0 +1,231 @@
> [...]
>>>> +
>>>> +               L2_0: l2-cache0 {
>>> Just l2-cache for the node name. Doesn't it go under the cpu0 node as
>>> well?
>> This describes the level-2 cache which is external to and shared by cpu0
>> & cpu1.
>> And only level-1 cache is inside of CPU core.
>> L2_0 is must, because both cpu0 and cpu1 has a next-level-cache =
>> <&L2_0> property.
> Ok. The name should just be l2-cache then, not l2-cache0.

OK, I will fix it.

>> Many identical example of l2-cache node can be found in arm64 dts, such
>> as k3-arm642.dtsi,
>> rk3328.dtsi, mt8195.dtsi, etc. Here is just a copy of similar arm64
>> multi-core SoCs.
>>
>> So we would like to keep this unchanged. Is it OK for you? Thanks.
>>
> Mostly ok, yes.

Thank you for the agreement.

>
>>>> +
>>>> +       sys: system-management@40460000 {
>>>> +               compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
>>>> +               reg = <0x0 0x40460000 0x0 0x200>;
>>>> +
>>>> +               reset: reset-controller {
>>>> +                       compatible = "nuvoton,ma35d1-reset";
>>>> +                       #reset-cells = <1>;
>>>> +               };
>>>> +       };
>>>> +
>>>> +       clk: clock-controller@40460200 {
>>>> +               compatible = "nuvoton,ma35d1-clk", "syscon";
>>>> +               reg = <0x00000000 0x40460200 0x0 0x100>;
>>>> +               #clock-cells = <1>;
>>>> +               clocks = <&clk_hxt>;
>>>> +               nuvoton,sys = <&sys>;
>>>> +       };
>>> It looks like the device at 40460000 is a reset and clock controller.
>>> Just make it one node and register the clk or reset device as an
>>> auxiliary device.
>> 40460000 is for system control registers, including power contrl,
>> multifunction pin control,
>> usb phy control, IP reset control, power-on setting information, and
>> many other miscellaneous controls.
>> The registers of reset controller is only a subset of system control
>> registers.
>>
>> 40460200 is for clock controller which is independent of the system
>> control integration
>> The register base of clock controller is very close to system
>> controller, but in fact the two are independent.
> What do you use the syscon for then? The clock driver must want to use
> the syscon for something, implying that they are the same device.

The register lock mechanism is applied to protect many critical 
registers from false written.
The register lock control register is one register in system controller.
Some registers of the clock controller are lock protected. Not only 
clock controller, but other
IP such as RTC, PWM, ADC, etc, also have lock protected registers. All 
these IP requires
syscon to access the lock/unlock control register in the system controller.
That's why we add a <&sys> to the clock controller.

Should we implement a ma35d1-sysctl driver to protect register_lock() 
and register_unlock()
and export to those drivers?  If yes, we can remove the <&sys> from 
clock controller.


Best regards,
Jacky Huang








