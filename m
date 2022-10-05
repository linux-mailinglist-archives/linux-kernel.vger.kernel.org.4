Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1195F50B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJEISd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJEIS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:18:29 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A846DAD7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 01:18:27 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a12so7892586ljr.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 01:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=SbfqhVaIK7dhG2nqTGKH2SOF25RlgbBG6Jy+za8h81k=;
        b=oOZQFOg2JZnIpkohTM3yAtNDUCxzd7+Wq+98lQIVvRvG2Wa3nGwQG04Kkd7nH3EQf+
         KFMH4KCci/dqgdpWtAUQ4H+aIfsDQ4eItnAT7RzPxF+9tfuc7XsEPxjpZbNZIbgUzoZP
         TIM7OFHd52RqETkT0r8Bh15apNSWwF3zNXLXPezpNfP6Lh42F6lE2zGAk0Dy5xEhjALt
         bcsMCEenpXBuias2VdccOX1wXrVV93fu3nY6qY2f6P4IF/v4k4mXGWT2gkdXvuAAfaQv
         2uH/kIWGBYpyWhUSgrAA9qIh7VfBVt/TaXkzVOybo3zTx9Od4aDBmuK1KD0pVar56ErX
         YDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SbfqhVaIK7dhG2nqTGKH2SOF25RlgbBG6Jy+za8h81k=;
        b=5aLX7s0aKuZTlNLYCP4k93ngSiF9PkJYGNX30nfmNGXIsssdfPGbR/styZrhRf18ks
         qIe5pr077xLFe5yUjio4ols0w1pVtfdCH8P6LHl6Imo2hAqEKcnwULEMnQCix+CU70Lf
         6dwCUOt0BwxxxGnsrDnrjt76nqPxqljGBz2IHjAcBFiz4x1ZXOx8CSDpvd4r8M+M9Lc5
         oA6qesU3tnqJeaL94NW0dGc44I648Fw9mhadcNQfhu9anLscVwaRqywyrwrwnw9hEDbo
         xxdNAjurkIQ0csQJb4cJotBnvmEzujTYf2L6/E6qYhwqU0gwkyiBN1PW15dGNvNdoSar
         ie+g==
X-Gm-Message-State: ACrzQf0JS3Z8+VKOaycFmrELPOu6VzfK8Ga9KUXAcpbC1tpdLk9nH26I
        rywsybU0oBkOfE2ZrW05XVu4Hg==
X-Google-Smtp-Source: AMsMyM47EWHHplSbceSEE9OZaz5AgPfAsfk5aHV9d3zLuI8nTuMPi5RpIlJQ0y7avVzfSMNgv2VOhw==
X-Received: by 2002:a2e:ba15:0:b0:26c:1798:b178 with SMTP id p21-20020a2eba15000000b0026c1798b178mr8844465lja.19.1664957905704;
        Wed, 05 Oct 2022 01:18:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h13-20020a056512220d00b0049301e29e41sm2257878lfu.233.2022.10.05.01.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 01:18:25 -0700 (PDT)
Message-ID: <1b9dcca8-1abd-99a3-da12-a8763bf77f12@linaro.org>
Date:   Wed, 5 Oct 2022 10:18:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845: align TLMM pin
 configuration with DT schema
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20220930200529.331223-1-krzysztof.kozlowski@linaro.org>
 <20220930200529.331223-2-krzysztof.kozlowski@linaro.org>
 <CAD=FV=UaSAvppTqqsZzNh7x_VZ5pVPROLP4AinK2NEWMUPnoQw@mail.gmail.com>
 <985e3982-e9c6-53d0-1aa8-7c8f7726926a@linaro.org>
 <CAD=FV=WgZLztJUxxs0B-kTnT4cN=kKc24if+P0h7whW54S57aQ@mail.gmail.com>
 <6c20f710-e02e-1702-3985-4e995f8a7e7a@linaro.org>
 <CAD=FV=Ushwp0AUrdwKrkKLxvsoCZsbSh-tAtXRQzcTavAEk8uA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=Ushwp0AUrdwKrkKLxvsoCZsbSh-tAtXRQzcTavAEk8uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 16:55, Doug Anderson wrote:
> Hi,
> 
> On Tue, Oct 4, 2022 at 1:40 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 04/10/2022 00:59, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Mon, Oct 3, 2022 at 10:45 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 03/10/2022 18:14, Doug Anderson wrote:
>>>>> Hi,
>>>>>
>>>>> On Fri, Sep 30, 2022 at 1:06 PM Krzysztof Kozlowski
>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>
>>>>>> DT schema expects TLMM pin configuration nodes to be named with
>>>>>> '-state' suffix and their optional children with '-pins' suffix.
>>>>>>
>>>>>> The sdm854.dtsi file defined several pin configuration nodes which are
>>>>>> customized by the boards.  Therefore keep a additional "default-pins"
>>>>>> node inside so the boards can add more of configuration nodes.  Such
>>>>>> additional configuration nodes always need 'function' property now
>>>>>> (required by DT schema).
>>>>>>
>>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>> ---
>>>>>>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    | 344 +++++++-----------
>>>>>>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  76 ++--
>>>>>>  .../arm64/boot/dts/qcom/sdm845-lg-common.dtsi |  60 ++-
>>>>>>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts |   2 +-
>>>>>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  60 ++-
>>>>>>  .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  88 ++---
>>>>>>  .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 138 +++----
>>>>>>  .../dts/qcom/sdm845-sony-xperia-tama.dtsi     |   6 +-
>>>>>>  .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |  26 +-
>>>>>>  .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  30 +-
>>>>>>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 305 +++++++---------
>>>>>>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  33 +-
>>>>>>  .../boot/dts/qcom/sdm850-samsung-w737.dts     |  96 ++---
>>>>>>  13 files changed, 513 insertions(+), 751 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
>>>>>> index b5f11fbcc300..3403cdcdd49c 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
>>>>>> @@ -993,21 +993,21 @@ &wifi {
>>>>>>  /* PINCTRL - additions to nodes defined in sdm845.dtsi */
>>>>>>
>>>>>>  &qspi_cs0 {
>>>>>> -       pinconf {
>>>>>> +       default-pins {
>>>>>>                 pins = "gpio90";
>>>>>>                 bias-disable;
>>>>>>         };
>>>>>>  };
>>>>>>
>>>>>>  &qspi_clk {
>>>>>> -       pinconf {
>>>>>> +       default-pins {
>>>>>>                 pins = "gpio95";
>>>>>>                 bias-disable;
>>>>>>         };
>>>>>>  };
>>>>>>
>>>>>>  &qspi_data01 {
>>>>>> -       pinconf {
>>>>>> +       default-pins {
>>>>>>                 pins = "gpio91", "gpio92";
>>>>>
>>>>> I haven't been fully involved in all the discussion here, but the
>>>>> above doesn't look like it matches the way that Bjorn wanted to go
>>>>> [1].  I would sorta expect it to look like this:
>>>>>
>>>>>   /* QSPI always needs a clock and IO pins */
>>>>>   qspi_basic: {
>>>>>     qspi_clk: {
>>>>>       pins = "gpio95";
>>>>>       function = "qspi_clk";
>>>>>     };
>>>>>     qspi_data01: {
>>>>>       pins = "gpio95";
>>>>>       function = "qspi_clk";
>>>>>     };
>>>>>   }
>>>>>
>>>>>   /* QSPI will need one or both chip selects */
>>>>>   qspi_cs0: qspi-cs0-state {
>>>>>     pins = "gpio90";
>>>>>     function = "qspi_cs";
>>>>>   };
>>>>>
>>>>>   qspi_cs1: qspi-cs1-state {
>>>>>     pins = "gpio89";
>>>>>     function = "qspi_cs";
>>>>>   };
>>>>>
>>>>>   /* If using all 4 data lines we need these */
>>>>>   qspi_data12: qspi-data12-state {
>>>>>     pins = "gpio93", "gpio94";
>>>>>     function = "qspi_data";
>>>>>   };
>>>>>
>>>>> Basically grouping things together in a two-level node when it makes
>>>>> sense and then using 1-level nodes for "mixin" pins. Then you'd end up
>>>>> doing one of these things:
>>>>>
>>>>> pinctrl-0 = <&qspi_basic &qspi_cs0>;
>>>>> pinctrl-0 = <&qspi_basic &qspi_cs1>;
>>>>> pinctrl-0 = <&qspi_basic &qspi_cs0 &qspi_data12>;
>>>>
>>>>
>>>> I don't get how my patch changes the existing approach? Such pattern was
>>>> already there.
>>>
>>> Before your patch things were split in two nodes, the muxing and the
>>> configuration. AKA when you combined the soc.dtsi and the board.dts
>>> you'd have:
>>>
>>> qspi_cs0: qspi-cs0-state {
>>>   pinmux {
>>>     pins = "...";
>>>     ... muxing properties ...
>>>   };
>>>   pinconf {
>>>     pins = "...";
>>>     ... config properties ...
>>>   };
>>> };
>>
>> Which was also not good pattern. Muxing and configuring is basically the
>> same function of pin controller. Splitting them makes no sense at all.
> 
> Agreed, it was not a good pattern.
> 
> 
>>> Your patch combines the "pinmux" and "pinconf" nodes into one. So when
>>> you combine the soc.dtsi and the board.dts after your patch you now
>>> have:
>>>
>>> qspi_cs0: qspi-cs0-state {
>>>   default-pins {
>>>     pins = "...";
>>>     ... muxing properties ...
>>>     ... config properties ...
>>>   };
>>> };
>>>
>>>
>>> That's fine and is functionally correct. ...but IMO it sets a bad
>>> example for people to follow (though, of course, it's really up to
>>> Bjorn). The "default-pins" subnode serves no purpose. If you're
>>> touching all this stuff anyway you might as well not end up with
>>> something that's a bad example for people to follow.
>>
>> I understand, you're right. I wanted to keep minimal amount of changes
>> to the DTS layout but since I am touching almost everything, I can
>> rework it.
>>
>>
>>>> Again - you end up or you ended up? We discuss here what this patch did.
>>>> So are you sure that this patch did something like that (and it wasn't
>>>> already there)?
>>>>
>>>>>
>>>>> Note that the extra tags of "qspi_clk" and "qspi_data01" are important
>>>>> since it lets the individual boards easily set pulls / drive strengths
>>>>> without needing to replicate the hierarchy of the SoC. So if a board
>>>>> wanted to set the pull of the cs0 line, just:
>>>>>
>>>>> &qspi_cs0 {
>>>>>   bias-disable;
>>>>> };
>>>>>
>>>>> [1] https://lore.kernel.org/lkml/CAD=FV=VUL4GmjaibAMhKNdpEso_Hg_R=XeMaqah1LSj_9-Ce4Q@mail.gmail.com/
>>>>>
>>>>>
>>>>>> @@ -1016,7 +1016,7 @@ pinconf {
>>>>>>  };
>>>>>>
>>>>>>  &qup_i2c3_default {
>>>>>> -       pinconf {
>>>>>> +       default-pins {
>>>>>>                 pins = "gpio41", "gpio42";
>>>>>>                 drive-strength = <2>;
>>>>>
>>>>> I don't see any benefit to two-levels above. Why not just get rid of
>>>>> the "default-pins" and put the stuff directly under qup_i2c3_default?
>>>>
>>>> For the same reason I told Konrad?
>>>
>>> OK. I looked at what you end up with for "qup_uart9" after your
>>> patches and it's definitely not my favorite place to end up at. If
>>> nothing else you are double-specifying "function" in both
>>> "default-pins" and "tx-pins"/"rx-pins". If those disagree then what
>>> happens?
>>
>> The same happens and happened before. My patch does nothing related to
>> allowing or disallowing wrong muxing/config nodes. In the past you could
>> have conflicting setups. Now it's exactly the same.
> 
> Right that you could have had conflicting setups before, too. However,
> in the past we always avoided specifying the function for a given pin
> in more than one node.
> 
> The old way was super verbose and had a lot of repetition for sure,
> but it sorta made sense if you thought of it in words. AKA the old way
> said this after combining the soc.dtsi and the board.dts
> 
> * For pins 45, 46, 47, 48: set the function to "qup6"
> * For pin 45: set a pulldown
> * For pins 46 and 47: set the drive strength to 2 and disable pulls
> * For pin 48: set a pullup
> 
> So it repeated the "for pins" part and that was most definitely non
> ideal. However, with your new setup you are sometimes doing:
> 
> * For pins 47 and 48: set the function to "qup6"
> * For pin 45: set the function to "qup6" and set a pulldown
> * For pins 46 and 47: set the function to "qup6" and the drive
> strength to 2 and disable pulls
> * For pin 48: set the function to "qup6" and set a pullup
> 
> That repeats the 'set the function to "qup6"' more than I'd like.

Indeed, it got more duplicated/error-prone.

> 
> 
>> The double-specifying of "function" is not a result of '-state'/'-pins'
>> reorganization but aligning with common TLMM schema *which requires
>> function* for every node.
> 
> I guess now that we've talked through it, I'd say that if we have to
> specify a function for every node then we should strive for each pin
> to be in exactly one node in any given active configuration. That
> makes the schema happy and also avoids double-specifying the function.
> 
> I think in all of the examples I've given that this is true.

OK, we can rework entire DTS to follow this approach.

> 
> 
>>> In general also we end up specifying that extra level of
>>> "default-pins" in many cases for no purpose. We also end up
>>> replicating hierarchy in the board dts files (the dts files are
>>> replicating the "default-pins" nodes from the parent).
>>
>> OK, let's fix this. That will need either:
>> 1. /delete-node with copying of most of properties from default-pins
>> 2. or move the CTS/TX/RX config pins to the DTSI.
> 
> I think in my proposal the CTS/TX/RX stuff moved to the dtsi which solved it.

OK

> 
> 
>>>>>>  /* PINCTRL - additions to nodes defined in sdm845.dtsi */
>>>>>>  &qup_spi2_default {
>>>>>> -       pinmux {
>>>>>> +       default-pins {
>>>>>>                 drive-strength = <16>;
>>>>>>         };
>>>>>>  };
>>>>>>
>>>>>>  &qup_uart3_default{
>>>>>> -       pinmux {
>>>>>> +       default-pins {
>>>>>>                 pins = "gpio41", "gpio42", "gpio43", "gpio44";
>>>>>>                 function = "qup3";
>>>>>>         };
>>>>>>  };
>>>>>>
>>>>>>  &qup_i2c10_default {
>>>>>> -       pinconf {
>>>>>> +       default-pins {
>>>>>>                 pins = "gpio55", "gpio56";
>>>>>>                 drive-strength = <2>;
>>>>>>                 bias-disable;
>>>>>> @@ -1144,37 +1144,37 @@ pinconf {
>>>>>>  };
>>>>>>
>>>>>>  &qup_uart6_default {
>>>>>> -       pinmux {
>>>>>> -               pins = "gpio45", "gpio46", "gpio47", "gpio48";
>>>>>> -               function = "qup6";
>>>>>> -       };
>>>>>> -
>>>>>> -       cts {
>>>>>> +       cts-pins {
>>>>>>                 pins = "gpio45";
>>>>>> +               function = "qup6";
>>>>>>                 bias-disable;
>>>>>>         };
>>>>>>
>>>>>> -       rts-tx {
>>>>>> +       rts-tx-pins {
>>>>>>                 pins = "gpio46", "gpio47";
>>>>>> +               function = "qup6";
>>>>>>                 drive-strength = <2>;
>>>>>>                 bias-disable;
>>>>>>         };
>>>>>>
>>>>>> -       rx {
>>>>>> +       rx-pins {
>>>>>>                 pins = "gpio48";
>>>>>> +               function = "qup6";
>>>>>>                 bias-pull-up;
>>>>>>         };
>>>>>>  };
>>>>>
>>>>> I didn't check everything about this patch, but skimming through I
>>>>> believe that the uart6 handling here is wrong. You'll end up with:>
>>>>>   qup_uart6_default: qup-uart6-default-state {
>>>>>     default-pins {
>>>>>       pins = "gpio47", "gpio48";
>>>>>       function = "qup6";
>>>>
>>>> This piece was removed.
>>>
>>> It was? How/where? I tried applying your patch and I still see "qup6"
>>> under the default-pins node in sdm845.dtsi.
>>>
>>
>> Ah, you're right. The default-pins are coming from DTSI.
>>
>> So delete-node?
> 
> I would prefer the solution I proposed. Re-pasting here:
> 
> In Soc.dtsi:
> 
>   qup_uart6_txrx: qup-uart6-txrx-state {
>     qup_uart6_tx {
>       pins = "gpio47";
>       function = "qup6";
>     };
>     qup_uart6_rx {
>       pins = "gpio48";
>       function = "qup6";
>     };
>   };
>   qup_uart6_cts: qup-uart6-cts-state {
>     pins = "gpio45";
>     function = "qup6";
>   };
>   qup_uart6_rts: qup-uart6-rts-state {
>     pins = "gpio46";
>     function = "qup6";
>   };
> 
> In board.dts:
> 
>   &qup_uart6_cts {
>     bias-disable;
>   };
>   &qup_uart6_rts {
>     drive-strength = <2>;
>     bias-disable;
>   };
>   &qup_uart6_rx {
>     bias-pull-up;
>   };
>   &qup_uart6_tx {
>     drive-strength = <2>;
>     bias-disable;
>   };
> 

OK

Best regards,
Krzysztof

