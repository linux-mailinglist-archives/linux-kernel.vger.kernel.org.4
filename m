Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD01F675644
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjATOBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjATOBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:01:17 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0C9C13F6;
        Fri, 20 Jan 2023 06:01:15 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b4so6954562edf.0;
        Fri, 20 Jan 2023 06:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHuW96WNQklJ2L3ptc1sz641lCSFrmjBzlYLr54HVK4=;
        b=HrPmLtIdXcc5JmqAUWHz4ki1UmYTgxHCc6lVIA2OtB2UMMNdp3zZu3Q0BbNMrcpE8J
         MfKGlzrDNaFpS6hU9lPgxglU+XuPOhPkjQ9jw8yIMxjO7Jy7jqcJ1fceqKZTwFpaoEKX
         CeHRmeClRRnm6+U7lQetM65uqM+AUojGNmDa6UxAaEVGx5lgG0MqDLeaOzWhWW0l3nSP
         HXPjerzT30taGYVtTJAFbtL2RedUwPpcxVXsrTPORqD6Cl35e6YmFEL/ji9l1a3pcC2F
         CXW216cddBhxR42nig945xVyL/0KrVjszIMcI1ebN3jZU5gyWo3Nx175GtzgzxgtA77Q
         SBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHuW96WNQklJ2L3ptc1sz641lCSFrmjBzlYLr54HVK4=;
        b=MWFaiUTFKXrFocgR3NLbmrgFmG5lBaFdFjrHbW0/3ma0PgWJzFlmGohUgAls2XV0sv
         9VDEZjm8U5TTdj7wPKZ+5VvRHrqM9e/oRd1CRdTncJ8TrejjiR5j88BlMhmZtJ2bcqh3
         ameUb5n6l2KQ0BeesUwBN2Wgv+Ycob4zbEsMpJZgvgIJXY3twZ9Yz/NMM4l22ulrmhl8
         L3brXWYMJgTedj1LbbkwPr7AuVovS7tzwN8PV+5v0zTq+ymvtVcHlygV6DlAH4LasxQI
         6/+PNEFpJScukylTjUibOvbEJ1+4dn9rkQgH2j1zGyDNzvV0XH7BXmPyt1Wsb1msiVGp
         yoFg==
X-Gm-Message-State: AFqh2kpSc92GqMak7w3wQ1pO1zYS9WJkjskuPMPzCxUuHm9cj0WWiqB7
        8j31AWMd0gMeHZQ6OmjEllY=
X-Google-Smtp-Source: AMrXdXu8A2cERT/DoRz1yGUvXEerrWaTOtN8rOJYoVL0udtUFA5T2UWfDwN8kXDjhrMZaMaAUJULMA==
X-Received: by 2002:a05:6402:602:b0:49d:f448:878c with SMTP id n2-20020a056402060200b0049df448878cmr23663299edv.2.1674223274134;
        Fri, 20 Jan 2023 06:01:14 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7dc1a000000b00499c3ca6a0dsm13153712edu.10.2023.01.20.06.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 06:01:13 -0800 (PST)
Message-ID: <e0bbfc9b-9db4-9443-a205-62f91c15e207@gmail.com>
Date:   Fri, 20 Jan 2023 16:01:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, en-GB
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Alistair Francis <alistair@alistair23.me>,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        s.hauer@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, linux@armlinux.org.uk, jernej.skrabec@gmail.com,
        kernel@pengutronix.de, festevam@gmail.com
References: <20221220112927.440506-1-alistair@alistair23.me>
 <20221220112927.440506-4-alistair@alistair23.me>
 <20221220131715.femjybikqcnm4lyg@pengutronix.de>
 <CAKmqyKO-Qw3AihUnF7np7_6kr6-ODnXU3aBwph-_9=xSbXRx-Q@mail.gmail.com>
 <CANhJrGOtZZEG0mdVeQTQ=HDB3bUT2kkGbMxbqcvZc_gb_aNETA@mail.gmail.com>
 <CAKmqyKMvSYr6WiVrvQWCWeiYF3R-VJmfuwxXczyE9j4QnYB_KA@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: imx7d-remarkable2: Enable the
 rohm,bd71815
In-Reply-To: <CAKmqyKMvSYr6WiVrvQWCWeiYF3R-VJmfuwxXczyE9j4QnYB_KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 11:17, Alistair Francis wrote:
> On Tue, Jan 10, 2023 at 5:13 AM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>>
>> ma 9. tammik. 2023 klo 14.32 Alistair Francis (alistair23@gmail.com) kirjoitti:
>>>
>>> On Tue, Dec 20, 2022 at 11:17 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
>>>>
>>>> Hi Alistair,
>>>>
>>>> thanks for your patch, please see below.
>>>>
>>>> On 22-12-20, Alistair Francis wrote:
>>>>> Add support for the rohm,bd71815 power controller controller for the
>>>>> reMarkable 2.
>>>>>
>>>>> Signed-off-by: Alistair Francis <alistair@alistair23.me>
>>>>> ---
>>>>>   arch/arm/boot/dts/imx7d-remarkable2.dts | 159 ++++++++++++++++++++++++
>>>>>   1 file changed, 159 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
>>>>> index a138b292ec6a..4387d30d6180 100644
>>>>> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
>>>>> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
>>>>> @@ -92,6 +92,10 @@ wifi_pwrseq: wifi_pwrseq {
>>>>>        };
>>>>>   };
>>>>>
>>>>> +&cpu0 {
>>>>> +     cpu-supply = <&buck1_reg>;
>>>>> +};
>>>>> +
>>>>>   &clks {
>>>>>        assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
>>>>>                          <&clks IMX7D_CLKO2_ROOT_DIV>;
>>>>> @@ -119,6 +123,148 @@ wacom_digitizer: digitizer@9 {
>>>>>        };
>>>>>   };
>>>>>
>>>>> +&i2c2 {
>>>>> +     clock-frequency = <100000>;
>>>>
>>>> We can set this now to 400kHz since the driver can handle quirks now
>>>> internal.
>>>
>>> After a discussion on the first patch I'm going to leave this as is.
>>> Let me know if you do want me to change it.
>>>
>>>>
>>>>> +     pinctrl-names = "default", "sleep";
>>>>> +     pinctrl-0 = <&pinctrl_i2c2>;
>>>>> +     pinctrl-1 = <&pinctrl_i2c2>;
>>>>
>>>> Do we need a "sleep" config here since this will be the same
>>>> configuration as the "default" one.
>>>
>>> Nope, dropped.
>>>
>>>>
>>>>> +     status = "okay";
>>>>> +
>>>>> +     bd71815: pmic@4b {
>>>>> +             compatible = "rohm,bd71815";
>>>>> +             reg = <0x4b>;
>>>>> +             pinctrl-names = "default";
>>>>> +             pinctrl-0 = <&pinctrl_bd71815>;
>>>>> +             interrupt-parent = <&gpio6>; /* PMIC_INT_B GPIO6_IO16 */
>>>>> +             interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
>>>>> +             gpio-controller;
>>>>> +             clocks = <&clks IMX7D_CLKO2_ROOT_SRC>;
>>>>> +             clock-output-names = "bd71815-32k-out";
>>>>> +             #clock-cells = <0>;
>>>>> +             #gpio-cells = <1>;
>>>>> +
>>>>> +             regulators {
>>>>> +                     #address-cells = <1>;
>>>>> +                     #size-cells = <0>;
>>>>> +
>>>>> +                     buck1_reg: regulator@0 {
>>>>> +                             reg = <0>;
>>>>> +                             regulator-compatible = "buck1";
>>>>> +                             regulator-min-microvolt = <800000>;
>>>>> +                             regulator-max-microvolt = <2000000>;
>>>>> +                             regulator-boot-on;
>>>>> +                             regulator-always-on;
>>>>> +                             regulator-ramp-delay = <1250>;
>>>>> +                     };
>>>>> +
>>>>> +                     buck2_reg: regulator@1 {
>>>>> +                             reg = <1>;
>>>>> +                             regulator-compatible = "buck2";
>>>>> +                             regulator-min-microvolt = <800000>;
>>>>> +                             regulator-max-microvolt = <2000000>;
>>>>> +                             regulator-boot-on;
>>>>> +                             regulator-always-on;
>>>>> +                             regulator-ramp-delay = <1250>;
>>>>> +                     };
>>>>> +
>>>>> +                     buck3_reg: regulator@2 {
>>>>> +                             reg = <2>;
>>>>> +                             regulator-compatible = "buck3";
>>>>> +                             regulator-min-microvolt = <1200000>;
>>>>> +                             regulator-max-microvolt = <2700000>;
>>>>> +                             regulator-boot-on;
>>>>> +                             regulator-always-on;
>>>>> +                     };
>>>>> +
>>>>> +                     buck4_reg: regulator@3 {
>>>>> +                             reg = <3>;
>>>>> +                             regulator-compatible = "buck4";
>>>>> +                             regulator-min-microvolt = <1100000>;
>>>>> +                             regulator-max-microvolt = <1850000>;
>>>>> +                             regulator-boot-on;
>>>>> +                             regulator-always-on;
>>>>> +                     };
>>>>> +
>>>>> +                     buck5_reg: regulator@4 {
>>>>> +                             reg = <4>;
>>>>> +                             regulator-compatible = "buck5";
>>>>> +                             regulator-min-microvolt = <1800000>;
>>>>> +                             regulator-max-microvolt = <3300000>;
>>>>> +                             regulator-boot-on;
>>>>> +                             regulator-always-on;
>>>>> +                     };
>>>>> +
>>>>> +                     ldo1_reg: regulator@5 {
>>>>> +                             reg = <5>;
>>>>> +                             regulator-compatible = "ldo1";
>>>>> +                             regulator-min-microvolt = <800000>;
>>>>> +                             regulator-max-microvolt = <3300000>;
>>>>> +                             regulator-boot-on;
>>>>> +                             regulator-always-on;
>>>>> +                     };
>>>>> +
>>>>> +                     ldo2_reg: regulator@6 {
>>>>> +                             reg = <6>;
>>>>> +                             regulator-compatible = "ldo2";
>>>>> +                             regulator-min-microvolt = <800000>;
>>>>> +                             regulator-max-microvolt = <3300000>;
>>>>> +                             regulator-boot-on;
>>>>> +                             regulator-always-on;
>>>>> +                     };
>>>>> +
>>>>> +                     ldo3_reg: regulator@7 {
>>>>> +                             reg = <7>;
>>>>> +                             regulator-compatible = "ldo3";
>>>>> +                             regulator-min-microvolt = <800000>;
>>>>> +                             regulator-max-microvolt = <3300000>;
>>>>> +                             regulator-boot-on;
>>>>> +                             regulator-always-on;
>>>>> +                     };
>>>>> +
>>>>> +                     ldo4_reg: regulator@8 {
>>>>> +                             reg = <8>;
>>>>> +                             regulator-compatible = "ldo4";
>>>>> +                             regulator-min-microvolt = <800000>;
>>>>> +                             regulator-max-microvolt = <3300000>;
>>>>> +                             regulator-boot-on;
>>>>> +                             regulator-always-on;
>>>>> +                     };
>>>>> +
>>>>> +                     ldo5_reg: regulator@9 {
>>>>> +                             reg = <9>;
>>>>> +                             regulator-compatible = "ldo5";
>>>>> +                             regulator-min-microvolt = <800000>;
>>>>> +                             regulator-max-microvolt = <3300000>;
>>>>> +                             regulator-boot-on;
>>>>> +                             regulator-always-on;
>>>>> +                     };
>>>>> +
>>>>> +                     dvref_reg: regulator@a {
>>>>> +                             reg = <0xa>;
>>>>> +                             regulator-compatible = "dvref";
>>>>> +                             regulator-boot-on;
>>>>> +                             regulator-always-on;
>>>>> +                     };
>>>>> +
>>>>> +                     lpsr_reg: regulator@b {
>>>>> +                             reg = <0xb>;
>>>>> +                             regulator-compatible = "lpsr";
>>>>> +                             regulator-boot-on;
>>>>> +                             regulator-always-on;
>>>>> +                     };
>>>>> +
>>>>> +                     wled_reg: regulator@c {
>>>>> +                             reg = <0xc>;
>>>>> +                             regulator-compatible = "wled";
>>>>> +                             regulator-min-microamp = <10>;
>>>>> +                             regulator-max-microamp = <25000>;
>>>>> +                             regulator-boot-on;
>>>>> +                             regulator-always-on;
>>>>> +                     };
>>>>
>>>> Note: You have marked all regulators as always on, this is rather
>>>> suboptimal due to power consumption.
>>>
>>> Good point. The power consumption is already pretty bad, as mainline
>>> doesn't support the i.MX deep sleep. As I know this works I'd like to
>>> keep it as is. I'll test to see if removing them doesn't break
>>> anything and then send a follow up patch.
>>
>> I'd like to suggest also seeing what removing the "regulator-boot-on"
>> causes. As far as I understand, the "regulator-boot-on" mainly (only?)
>> intended to be used in situations where the regulator state can not be
>> reliably read from the hardware at the boot-up. AFAIR, unlike the
>> BD71837 and BD71847,
>> the BD71815 does not have this limitation. (This is just my
>> understanding - which is based on some age-old discussions with Mark
>> Brown - hence this comment is just a suggestion to try this while
>> testing, not a comment intended to be demanding for a change)
> 
> I have tried removing both "regulator-boot-on" and "regulator-always-on".
> 
> After one boot to userspace (where the display didn't work correctly)
> the device now seems to not power up at all. Even u-boot is failing to
> start. I'm not sure if the regulators are now in some strange state or
> if something is fried.

Ouch. This does not sound good at all. Sorry for a bad advice. :(

I can only assume the "power dependencies" are not modelled correctly - 
Eg. some required power-rails are not marked to be used by devices that 
actually need them. This is probably being worked around using the 
regulator-boot-on / regulator-always-on - which will cause the Linux to 
turn on these rails when the driver is load. My understanding is that 
this is not the intended use-case for the regulator-boot-on flag though. 
Also, as was said - the side-effect of always-on is that there will be 
no power-saving options - which is still better for an user than a fried 
device would be :|

> 
> I'm currently waiting for the battery to discharge to see if that helps.
> 

/me keeps fingers crossed. You wouldn't guess how hard it was to type this!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

