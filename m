Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D825F34C5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiJCRqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJCRpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:45:39 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1C91B9C3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:45:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 10so17687748lfy.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 10:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=BJcZjBOQpJMQgVSTADZqsOnO/l6steMhAsQ4dlBAeSE=;
        b=DnkkOZKNHDxWdF31Zkdiup7xPttF3IyysDHVulbz1ZdalzxoEvQtwkfPusphseNfmP
         AjEvl6OkkRLyzu9eOr064ZburOZR1RsMO/JCSB+Stnx2LMNih34AQiqyGv13XgrSVwIh
         sNHkIQo35ZtwrWqpHGWaViRhAtA6zEejeYo8hszZ8r5q/qWLd8NqWkG18pzVrcDQXt1U
         xU5RqQ1TCpZd6KdeuwWLR9VFGIB8OiIOQuiPaBd3/+TrlgSwAw3tC7mmcc3PxP8wSP/H
         L8Aoy1HBq6H3my/nYvdsBfh52yN7IsKTQoh7cAKfmtSdNQCvWVz20a+Y4/IFO54pc/Ui
         mSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BJcZjBOQpJMQgVSTADZqsOnO/l6steMhAsQ4dlBAeSE=;
        b=j6vTLzCf0W1AlCVXsqfeF/fUngbZF/9ozLFOMZADlt2RGrH3yFnpa9kSRd6omUasZp
         hMnoCgR1U5M1yDogpv+w2VulXK4a62VSdcJ79uZZojGx3coJ66Zgx0vQTNaAi9FJmsZM
         sAEKpy1LnzfGX1iZ/KUnMMW3+toSr2v+m0K0wRgZMtd6JAygoVnKvqTN9AkZhUwmaQam
         ElwhtzRhZtcImTxozoHDJjYaG5kmciw/4qL+F2IpH4tyBzR2FHnXMhMm9bLCN3i9q1+P
         gNWmm2CZ2a38AZY2gWnZL31zYI6q26rjEA0sIg/9a36O9xk6CtJZtQZ96KyigvyWlk0N
         z+SQ==
X-Gm-Message-State: ACrzQf2whJwmUgEghKol0cIFzEeUHbfKPRmXS4V8g+8LFOEF50uloOcs
        Cq1oWbQVwKfGFuaKgBbgYI0fXA==
X-Google-Smtp-Source: AMsMyM5SjlEpVCfH7P8AmQWY91kFNxPcJPHWuCmTDmzTyAswKrJ0h/ExH2QCwadEkt8VOqJDdJLERQ==
X-Received: by 2002:a05:6512:acb:b0:4a2:500f:af73 with SMTP id n11-20020a0565120acb00b004a2500faf73mr156929lfu.524.1664819132900;
        Mon, 03 Oct 2022 10:45:32 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h13-20020a056512220d00b0049aa7a56715sm1542592lfu.267.2022.10.03.10.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 10:45:32 -0700 (PDT)
Message-ID: <985e3982-e9c6-53d0-1aa8-7c8f7726926a@linaro.org>
Date:   Mon, 3 Oct 2022 19:45:31 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=UaSAvppTqqsZzNh7x_VZ5pVPROLP4AinK2NEWMUPnoQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2022 18:14, Doug Anderson wrote:
> Hi,
> 
> On Fri, Sep 30, 2022 at 1:06 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> DT schema expects TLMM pin configuration nodes to be named with
>> '-state' suffix and their optional children with '-pins' suffix.
>>
>> The sdm854.dtsi file defined several pin configuration nodes which are
>> customized by the boards.  Therefore keep a additional "default-pins"
>> node inside so the boards can add more of configuration nodes.  Such
>> additional configuration nodes always need 'function' property now
>> (required by DT schema).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    | 344 +++++++-----------
>>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  76 ++--
>>  .../arm64/boot/dts/qcom/sdm845-lg-common.dtsi |  60 ++-
>>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts |   2 +-
>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  60 ++-
>>  .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  88 ++---
>>  .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 138 +++----
>>  .../dts/qcom/sdm845-sony-xperia-tama.dtsi     |   6 +-
>>  .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |  26 +-
>>  .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  30 +-
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 305 +++++++---------
>>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  33 +-
>>  .../boot/dts/qcom/sdm850-samsung-w737.dts     |  96 ++---
>>  13 files changed, 513 insertions(+), 751 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
>> index b5f11fbcc300..3403cdcdd49c 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
>> @@ -993,21 +993,21 @@ &wifi {
>>  /* PINCTRL - additions to nodes defined in sdm845.dtsi */
>>
>>  &qspi_cs0 {
>> -       pinconf {
>> +       default-pins {
>>                 pins = "gpio90";
>>                 bias-disable;
>>         };
>>  };
>>
>>  &qspi_clk {
>> -       pinconf {
>> +       default-pins {
>>                 pins = "gpio95";
>>                 bias-disable;
>>         };
>>  };
>>
>>  &qspi_data01 {
>> -       pinconf {
>> +       default-pins {
>>                 pins = "gpio91", "gpio92";
> 
> I haven't been fully involved in all the discussion here, but the
> above doesn't look like it matches the way that Bjorn wanted to go
> [1].  I would sorta expect it to look like this:
> 
>   /* QSPI always needs a clock and IO pins */
>   qspi_basic: {
>     qspi_clk: {
>       pins = "gpio95";
>       function = "qspi_clk";
>     };
>     qspi_data01: {
>       pins = "gpio95";
>       function = "qspi_clk";
>     };
>   }
> 
>   /* QSPI will need one or both chip selects */
>   qspi_cs0: qspi-cs0-state {
>     pins = "gpio90";
>     function = "qspi_cs";
>   };
> 
>   qspi_cs1: qspi-cs1-state {
>     pins = "gpio89";
>     function = "qspi_cs";
>   };
> 
>   /* If using all 4 data lines we need these */
>   qspi_data12: qspi-data12-state {
>     pins = "gpio93", "gpio94";
>     function = "qspi_data";
>   };
> 
> Basically grouping things together in a two-level node when it makes
> sense and then using 1-level nodes for "mixin" pins. Then you'd end up
> doing one of these things:
> 
> pinctrl-0 = <&qspi_basic &qspi_cs0>;
> pinctrl-0 = <&qspi_basic &qspi_cs1>;
> pinctrl-0 = <&qspi_basic &qspi_cs0 &qspi_data12>;


I don't get how my patch changes the existing approach? Such pattern was
already there.

Again - you end up or you ended up? We discuss here what this patch did.
So are you sure that this patch did something like that (and it wasn't
already there)?

> 
> Note that the extra tags of "qspi_clk" and "qspi_data01" are important
> since it lets the individual boards easily set pulls / drive strengths
> without needing to replicate the hierarchy of the SoC. So if a board
> wanted to set the pull of the cs0 line, just:
> 
> &qspi_cs0 {
>   bias-disable;
> };
> 
> [1] https://lore.kernel.org/lkml/CAD=FV=VUL4GmjaibAMhKNdpEso_Hg_R=XeMaqah1LSj_9-Ce4Q@mail.gmail.com/
> 
> 
>> @@ -1016,7 +1016,7 @@ pinconf {
>>  };
>>
>>  &qup_i2c3_default {
>> -       pinconf {
>> +       default-pins {
>>                 pins = "gpio41", "gpio42";
>>                 drive-strength = <2>;
> 
> I don't see any benefit to two-levels above. Why not just get rid of
> the "default-pins" and put the stuff directly under qup_i2c3_default?

For the same reason I told Konrad?

> 
> 
>>  /* PINCTRL - additions to nodes defined in sdm845.dtsi */
>>  &qup_spi2_default {
>> -       pinmux {
>> +       default-pins {
>>                 drive-strength = <16>;
>>         };
>>  };
>>
>>  &qup_uart3_default{
>> -       pinmux {
>> +       default-pins {
>>                 pins = "gpio41", "gpio42", "gpio43", "gpio44";
>>                 function = "qup3";
>>         };
>>  };
>>
>>  &qup_i2c10_default {
>> -       pinconf {
>> +       default-pins {
>>                 pins = "gpio55", "gpio56";
>>                 drive-strength = <2>;
>>                 bias-disable;
>> @@ -1144,37 +1144,37 @@ pinconf {
>>  };
>>
>>  &qup_uart6_default {
>> -       pinmux {
>> -               pins = "gpio45", "gpio46", "gpio47", "gpio48";
>> -               function = "qup6";
>> -       };
>> -
>> -       cts {
>> +       cts-pins {
>>                 pins = "gpio45";
>> +               function = "qup6";
>>                 bias-disable;
>>         };
>>
>> -       rts-tx {
>> +       rts-tx-pins {
>>                 pins = "gpio46", "gpio47";
>> +               function = "qup6";
>>                 drive-strength = <2>;
>>                 bias-disable;
>>         };
>>
>> -       rx {
>> +       rx-pins {
>>                 pins = "gpio48";
>> +               function = "qup6";
>>                 bias-pull-up;
>>         };
>>  };
> 
> I didn't check everything about this patch, but skimming through I
> believe that the uart6 handling here is wrong. You'll end up with:>
>   qup_uart6_default: qup-uart6-default-state {
>     default-pins {
>       pins = "gpio47", "gpio48";
>       function = "qup6";

This piece was removed.

>     };
> 
>     cts-pins {
>       pins = "gpio45";
>       function = "qup6";
>       bias-disable;
>     };
> 
>     rts-tx-pins {
>       pins = "gpio46", "gpio47";
>       function = "qup6";
>       drive-strength = <2>;
>       bias-disable;
>     };
> 
>     rx-pins {
>       pins = "gpio48";
>       function = "qup6";
>       bias-pull-up;
>     };
>   };
> 
> So pins 47 and 48 are each referenced in two nodes. That doesn't seem
> correct to me. IMO, better would have been:

Even though that particular piece was removed, so there is no double
reference, it would still be correct. Or rather - what is there
incorrect? Mentioning pin twice? This is ok, although not necessarily
the most readable.

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

It's not related to this patchset, but sounds good, please change the
DTS to match it. I can rebase my patch on top of it.

>   };
> 
> Also, as per latest agreement with Bjorn, we should be moving the
> default drive strength to the SoC.dtsi file, so going further:

How is it related to this patch? Sure, feel free to move drive strength
anywhere. We can discuss it. But it is not part of this patch.

> 
> In Soc.dtsi:
> 
>   qup_uart6_txrx: qup-uart6-txrx-state {
>     qup_uart6_tx {
>       pins = "gpio47";
>       function = "qup6";
>       drive-strength = <2>;
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
>     drive-strength = <2>;

These are not part of DTSI. They exist in DTS, not in DTSI. You now
introduce a change entirely different than this patchset is doing. It
makes sense on its own, but it is not related to this patchset.

>   };
> 
> In board.dts:
> 
>   &qup_uart6_cts {
>     bias-disable;
>   };
>   &qup_uart6_rts {
>     bias-disable;
>   };
>   &qup_uart6_rx {
>     bias-pull-up;
>   };
>   &qup_uart6_tx {
>     bias-disable;
>   };
> 
> In the SoC.dtsi file we could default to just a tx/rx config:
> 
> pinctrl-0 = <&qup_uart6_txrx>;
> 
> ...if a board had the flow control lines hooked up, it could do:
> 
> pinctrl-0 = <&qup_uart6_txrx &qup_uart6_cts &qup_uart6_rts>;


Best regards,
Krzysztof

