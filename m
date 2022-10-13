Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49945FDCBD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJMO7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJMO7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:59:40 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D886E25E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:59:36 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r19so1382995qtx.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4GAOf0mKBsISG6wkfeAi/AqL+H6Oxq43AsFjSuuaxiA=;
        b=LfiSdNkLPHFcfpujFnb6qpOQMOMSQUF94a4kbUaUNU0ut+rhgQ9xBAv+CU5+o1zb4r
         mQ6n8lVxpO/PD2VmQSZpwMIHjSar/DUh3yWbF0WiAyTINFQisbShPGm6HkuURAWcYE4D
         zykpTd5/nwe56UOCYVBwAx8sQqNWdZvEe9JXaDEqA6OZQfBjMmMkgaeJNrxwZwGzqa0A
         Exsx7yJ5hSWkvhmuIsVCScu3hw2fT2ihYY4YlQbtdh5eBFKXUdzmmJbbb288rgWw1tU1
         cMFFfNmbt50vWIWKm/V9colambbT/CvGhIfRy+rcDa3T9jhawY5X13aWQS2msXrEzf/p
         8Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GAOf0mKBsISG6wkfeAi/AqL+H6Oxq43AsFjSuuaxiA=;
        b=RfVB/bxkafA68ryjNKslq7/blpOyef//yDAVlzuibQLLs/JTN/8V5umtZHsCTZcT9O
         iOhtNYgwcAS5sAItzhfsa8EWGHXsA7znyEhS6QOkHSieMchYUKt0enkWOxl4M6SAr2nL
         i3KcIGQppcb2SF58vvJ45DHGr8fpnBowVN24ufmpnaUmqkCmmpWy4vzUKecuE+HX3lPR
         xwMnA45Sg+tjtg4H5vdQEtu9SJvEb3DF0em5OFKv/mD06XGkFvOK/qrY3mysr8Fl0IdF
         tMeJkY4VCM+ySiwPXZnw0ttjrWBwHzZyytb+FyEqZV1x97AxIDe8Qpo1MVDn4C8n0gY9
         vLTw==
X-Gm-Message-State: ACrzQf3ZErpj5fWJGxnpUMdnsWHE44WK+ymuBKgOiajPnYg3sn0UPZQw
        gf8hwWetCWspBqrmJxrExdc7JxyPYjVZLQ==
X-Google-Smtp-Source: AMsMyM4XDjAb8RJz78eLwS3f0q5ifJFllcYu/tlqwLHbmXfsZqaOExEfb0YqZ3rw/GJt7ud6pVt9PA==
X-Received: by 2002:a05:622a:1ca:b0:394:4be9:550e with SMTP id t10-20020a05622a01ca00b003944be9550emr130555qtw.199.1665673175887;
        Thu, 13 Oct 2022 07:59:35 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id m5-20020a05620a290500b006ea7f9d8644sm9101265qkp.96.2022.10.13.07.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 07:59:34 -0700 (PDT)
Message-ID: <4aa8450f-4504-c65e-56f1-0625584fb8cd@linaro.org>
Date:   Thu, 13 Oct 2022 10:59:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7180: align TLMM pin
 configuration with DT schema
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221007145116.46554-1-krzysztof.kozlowski@linaro.org>
 <CAD=FV=UAcn=yeCZ_jum9kGgqsdKsPpya-FPumYUWO=iyp-kKYw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=UAcn=yeCZ_jum9kGgqsdKsPpya-FPumYUWO=iyp-kKYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 13:31, Doug Anderson wrote:
> Hi,
> 
> On Fri, Oct 7, 2022 at 7:51 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> DT schema expects TLMM pin configuration nodes to be named with
>> '-state' suffix and their optional children with '-pins' suffix.
>>
>> Merge subnodes named 'pinconf' and 'pinmux' into one entry, add function
>> where missing (required by bindings for GPIOs) and reorganize overriding
>> pins by boards.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Not tested on hardware.
> 
> I applied these two patches to the top of mainline today and booted up
> a sc7180-trogdor-coachz. I didn't do any stress testing, but at least
> it boots up and basic smoke tests pass.
> 
>> Doug,
>>
>> I think this implements our conclusion from SDM845 patches (alignment of
>> pinctrl with DT schema).
> 
> Yeah, it looks really great! Hopefully others agree that this scheme
> looks great and it also validates nicely with your schema changes.
> Sorry for taking a few days to get back--your email coincided with a
> few vacation days for me.
> 
> I have a few nits and there's at least one problem (the glitching of
> the SPI chip select at boot).
> 
> 
>> Cc: Doug Anderson <dianders@chromium.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sc7180-idp.dts       | 211 +++---
>>  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  36 +-
>>  .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  41 +-
>>  .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts |  16 +-
>>  .../dts/qcom/sc7180-trogdor-kingoftown.dtsi   |   8 +-
>>  .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  16 +-
>>  .../dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi |  25 +-
>>  .../boot/dts/qcom/sc7180-trogdor-mrbland.dtsi |  72 +-
>>  .../qcom/sc7180-trogdor-parade-ps8640.dtsi    |  32 +-
>>  .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi |   8 +-
>>  .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  14 +-
>>  .../qcom/sc7180-trogdor-quackingstick.dtsi    |  56 +-
>>  .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |   8 +-
>>  .../dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi |  16 +-
>>  .../qcom/sc7180-trogdor-wormdingler-rev0.dtsi |  25 +-
>>  .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  72 +-
>>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 655 +++++++-----------
>>  arch/arm64/boot/dts/qcom/sc7180.dtsi          | 410 +++++------
>>  18 files changed, 613 insertions(+), 1108 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
>> index 9dee131b1e24..3e93b13d275e 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> 
> [ ...cut... ]
> 
>> @@ -642,126 +596,131 @@ pinconf-rts {
>>                          * pulling RX low (by sending wakeup bytes).
>>                          */
>>                          pins = "gpio39";
>> +                       function = "gpio";
>>                          bias-pull-down;
> 
> optional nit: your new addition makes it obvious that the indentation of the
> surrounding lines is wrong. Maybe fix it as part of this patch?

Indeed, thanks, I'll fix it up.

> 
> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
>> index 1bd6c7dcd9e9..c66568a882b3 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
>> @@ -180,30 +180,19 @@ &wifi {
>>  /* PINCTRL - modifications to sc7180-trogdor.dtsi */
>>
>>  &en_pp3300_dx_edp {
>> -       pinmux {
>> -               pins = "gpio67";
>> -       };
>> -
>> -       pinconf {
>> -               pins = "gpio67";
>> -       };
>> +       pins = "gpio67";
>>  };
>>
>>  &sec_mi2s_active{
>> -       pinmux {
>> -               pins = "gpio49", "gpio50", "gpio51", "gpio52";
>> -               function = "mi2s_1";
>> -       };
>> +       pins = "gpio49", "gpio50", "gpio51", "gpio52";
> 
> Looks like the point of the homestar override is to add an extra pin
> (gpio52) but it forgot to update the list in the "pinconf" as well so
> gpio52 wasn't getting a drive strength and bias set. Your patch
> has the side effect of fixing this. That looks right to me (match
> GPIO51) given that the name of GPIO51 is AMP_DIN and GPIO52 AMP_DIN2.

I miss here something... There was no pinconf in
sc7180.dtsi/sc7180-trogdor-homestar.dtsi/homestar.dts

Where do you see the drive strength and bias set for the gpio49-51?

> 
> Assuming my analysis is correct, it's probably worth mentioning this
> behavior change in the commit message.
> 
> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> index eae22e6e97c1..d923ddca8b8b 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> @@ -880,17 +880,17 @@ &sdhc_2 {
>>  };
>>
>>  &spi0 {
>> -       pinctrl-0 = <&qup_spi0_cs_gpio_init_high>, <&qup_spi0_cs_gpio>;
>> +       pinctrl-0 = <&qup_spi0_cs_gpio>;
> 
> I think this is going to cause a problem. This is pretty much a direct
> revert of commit e440e30e26dd ("arm64: dts: qcom: sc7180: Avoid glitching
> SPI CS at bootup on trogdor").
> 
> I was never crazy about the solution in the patch, but I really couldn't
> find another great way to solve it. I think the problem is fairly well
> described in that commit message, at least, and I'm certainly open to
> alternate solutions. Until then, I think this prevents landing your
> patch.
> 
> [ ... cut ... ]

Ugh, thanks for noticing this. My patch  is here incorrect also because
it is not functionally equivalent - I dropped entirely the output-high
from gpio37 (the CS).

I'll fix it.

> 
>> @@ -1467,197 +1315,174 @@ pinconf-rts {
>>                          * pulling RX low (by sending wakeup bytes).
>>                          */
>>                          pins = "gpio39";
>> +                       function = "gpio";
>>                          bias-pull-down;
> 
> optional nit: your new addition makes it obvious that the indentation of the
> surrounding lines is wrong. Maybe fix it as part of this patch?

Yep

> 
> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index 58976a1ba06b..8f7845fa669c 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -1486,410 +1486,336 @@ tlmm: pinctrl@3500000 {
> 
> [ ... cut ... ]
> 
>> -                       qup_spi0_default: qup-spi0-default {
>> -                               pinmux {
>> -                                       pins = "gpio34", "gpio35",
>> -                                              "gpio36", "gpio37";
>> -                                       function = "qup00";
>> -                               };
>> +                       qup_spi0_default: qup-spi0-default-state {
>> +                               pins = "gpio34", "gpio35", "gpio36", "gpio37";
>> +                               function = "qup00";
>>                         };
>>
>> -                       qup_spi0_cs_gpio: qup-spi0-cs-gpio {
>> -                               pinmux {
>> +                       qup_spi0_cs_gpio: qup-spi0-cs-gpio-state {
>> +                               qup_spi0_spi: spi-pins {
>>                                         pins = "gpio34", "gpio35",
>>                                                "gpio36";
>>                                         function = "qup00";
>>                                 };
>>
>> -                               pinmux-cs {
>> +                               qup_spi0_cs: cs-pins {
>>                                         pins = "gpio37";
>>                                         function = "gpio";
>>                                 };
>>                         };
> 
> The way that the cs_gpio ended up after your patch series threw me for
> a loop. It's counterintutive that we have labels "qup_spi0_spi" and
> "qup_spi0_cs" and they're _not_ under "qup_spi0_default".
> 
> Here are two proposals and I'd be happy with either of them:
> 
> a) Get rid of the gpio nodes. Instead in the dtsi file do:
> 
>   qup_spi0_cs_gpio: qup-spi0-cs-gpio-state {
>     qup_spi0_spi: spi-pins {
>       pins = "gpio34", "gpio35", "gpio36";
>       function = "qup00";
>     };
> 
>     qup_spi0_cs: cs-pins {
>       pins = "gpio37";
>       function = "qup00";
>     };
>   };
> 
> In the board file just:
> 
>   &qup_spi0_cs {
>     function = "gpio";
>   };
> 
> b) Split the whole thing up. In the dtsi file pinctrl section:
> 
>   qup_spi0_spi: qup-spi0-spi-state {
>     pins = "gpio34", "gpio35", "gpio36";
>     function = "qup00";
>   };
> 
>   qup_spi0_cs: qup-spi0-cs-state {
>     pins = "gpio37";
>     function = "qup00";
>   };
> 
>   qup_spi0_cs_gpio: qup-spi0-cs-gpio-state {
>     pins = "gpio37";
>     function = "gpio";
>   };
> 
> ...in the dtsi file SPI section:
> 
>   pinctrl-0 = <&qup_spi0_spi> <&qup_spi0_cs>;
> 
> ...in the board SPI section:
> 
>   pinctrl-0 = <&qup_spi0_spi> <&qup_spi0_cs_gpio>;

OK, I'll go with the second.

> 
> [ ... cut ... ]
>> -                       qup_uart0_default: qup-uart0-default {
>> -                               pinmux {
>> -                                       pins = "gpio34", "gpio35",
>> -                                              "gpio36", "gpio37";
>> -                                       function = "qup00";
>> -                               };
>> +                       qup_uart0_default: qup-uart0-default-state {
>> +                               pins = "gpio34", "gpio35", "gpio36", "gpio37";
>> +                               function = "qup00";
>>                         };
> 
> It feels like all of the UARTs should be split up like uart3/uart8 are
> If any board actually uses these they will likely want different pulls
> and configs for the different pins.

OK

Best regards,
Krzysztof

