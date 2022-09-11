Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27775B4D50
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiIKKWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiIKKWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:22:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF6B386B9;
        Sun, 11 Sep 2022 03:22:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b5so10818495wrr.5;
        Sun, 11 Sep 2022 03:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rbWss9lesRiOYZ7aAGG95N1JRHy3F6rSmH80YmQn7uM=;
        b=XqBIv16r4ZPN9olcmiGs5fkTa572AiCGLHR0MGA06wKu4bk3CX4cYcQOL07H7J8QmL
         E0HzdUQUHa7KAcd+XFp4S0ymPUd7yDvPzWhN6MzKcff+SP99IzAjO7hT1rGlp14j3TIv
         TZrUraJz1lV6z4MUgdqjMxBtqglTqmH7OKI5fc+8iWvGAdumSiNYL1PBU0yeBguKPD42
         N2dEVWHHNxoCDUZ6LzlwxA/nmLZJszoOwYV4yiy4UFxUrZ6w1szSvpgkBvZNIu0S1qL9
         qrswWtkLfl1MQfAPDOkWGepyU9OAKa1TfbqKRU3GKQ/YgYcd/VTkodOvLry8YOIrmt7x
         Qfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rbWss9lesRiOYZ7aAGG95N1JRHy3F6rSmH80YmQn7uM=;
        b=WNAAHwNsy2QE2EY2HWSJKk3qZLXFrWqKiIs0R72S2pBpMuTbO+p1WCESPCbYAg3nUB
         NJrd52+sTK5FpVxC2pAgwTxvner4O7enEM/FWuCO0Qog6vvJGk3rPdfzNpL/yTmP8XWx
         G5VrTkcpO5wwfdWZcjr6eGfeYdHvyBGa5jWxCSfwEXGenu7TeESMaO6FttF2k3MSEvnZ
         TGbmmltyktlkkXyYMWBfBe9afb9vhKBSI5RugnC/13DEmuw15UJNIDBUAHwyyIaC9fvR
         izAECocG9TUZlNNR64Oy4ahMg5KHM7S0WFPBw9i6zwMP1q5fHXJuHxKu69Xle+v9Yh3n
         llYg==
X-Gm-Message-State: ACgBeo0ChuTM5pEQ9pdi7sK7mS+Bv7lI/Dl5J6eaWDTrmUVoJn+beIX0
        sNypk9HaPSRMz/GM+jOqRDA=
X-Google-Smtp-Source: AA6agR6tTad4oBwVZNvcAqSK4PN3rz1mFjwYYTuW8a4DgaREXEnCjDfzVrF7J9ayqHHgLqPJgoK9lQ==
X-Received: by 2002:a05:6000:114b:b0:228:ab76:fa00 with SMTP id d11-20020a056000114b00b00228ab76fa00mr11880361wrx.628.1662891728308;
        Sun, 11 Sep 2022 03:22:08 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id bv7-20020a0560001f0700b0022a53fe201fsm2686529wrb.68.2022.09.11.03.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 03:22:07 -0700 (PDT)
Message-ID: <cdb756fc-6a4f-3853-9570-f02b8cb03990@gmail.com>
Date:   Sun, 11 Sep 2022 13:22:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 7/9] arm64: dts: qcom: sm6115: Add basic soc dtsi
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220910143213.477261-1-iskren.chernev@gmail.com>
 <20220910143213.477261-8-iskren.chernev@gmail.com>
 <d51b0a89-a151-dd5b-b026-4291031fe1ea@linaro.org>
 <ad940df1-6876-0c38-81c8-7d7ca97046de@gmail.com>
 <7e5eb29f-913a-7540-c618-fb6c5a493d5d@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <7e5eb29f-913a-7540-c618-fb6c5a493d5d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/22 13:07, Krzysztof Kozlowski wrote:
> On 11/09/2022 11:09, Iskren Chernev wrote:
>>
>>
>> On 9/11/22 11:40, Krzysztof Kozlowski wrote:
>>> On 10/09/2022 16:32, Iskren Chernev wrote:
>>>> Add support for Qualcomm SM6115 SoC. This includes:
>>>> - GCC
>>>> - Pinctrl
>>>> - RPM (CC+PD)
>>>> - USB
>>>> - MMC
>>>> - UFS
>>>>
>>>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>>>> ---
>>>> pending issues with dtschema:
>>>> - for some reason, using pinctrl phandles (in mmc) breaks the pinctrl
>>>>   schema (4 times)
>>>>       .output/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: pinctrl@500000: sdc1-on-state: 'oneOf' conditional failed, one must be fixed:
>>>>             'pins' is a required property
>>>>             'clk', 'cmd', 'data', 'rclk' do not match any of the regexes: 'pinctrl-[0-9]+'
>>>>             [[26]] is not of type 'object'
>>>>             From schema: /home/iskren/src/pmos/linux-postmarketos/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
>>>
>>> It's the same as 06367559766b7c9bd96d2baef8bfc5a9bb451e25. I propose to
>>> fix it the same way. I can do a biger change for all pinctrls, so here
>>> you would need to add "-pins" prefix to entries (see patch
>>> 4fcdaf4b0320f93d0ccb4d36b795ed258fb07b27).
>>
>> OK, that makes sense. One thing that is a bit odd -- the current pattern
>> "(pinconf|-pins)$" matches anything that ends in pinconf OR -pins (so it could
>> be sth-pinconf).
>
> Yeah, I am fixing it to ^(pinconf|.*-pins)$
>
>> Also, if you only have a single block, isn't the idea to just
>> list it in the -states node.  I mean we either force everybody to nest with
>> a pinconf, or we allow -pins for nested stuff and directly in -state for the
>> non-nested. Just my 2c.
>
> I didn't get this one... We allow exactly this, don't we (in PMIC GPIOs)?

Currently the schema (you linked) has:

    patternProperties:
      '-state$':
        oneOf:
          - $ref: "#/$defs/qcom-pmic-gpio-state" // 1st case
          - patternProperties:                   // 2nd case
              "(pinconf|-pins)$":
                $ref: "#/$defs/qcom-pmic-gpio-state"
            additionalProperties: false

The idea being that you can have

    pinctrl@xxx {
        basic-state { // this matches the first state in oneOf
            pins: "gpio1";
            funciton: "normal";
        };

        nested-state {
            some-pins { // this matches the second state in oneOf
                pins: "gpio1";
                funciton: "normal";
            };
            other-pins {
                pins: "gpio2"
                funciton: "normal";
            };
        }

        // but also, matching second state in oneOf
        nested-basic-state {
            pinconf {
                pins: "gpio1";
                funciton: "normal";
            };
        };
    };

So I'm saying, we should either choose basic-state and nested-state, in which
case we don't need the "^pinconf$" variant, or we can have nested-state and
nested-basic-state, in which case we don't need the 1st case of the oneOf.

Otherwise people have to choose between basic-state and nested-basic-state,
which are equivalent in semantics.

On a tangent -- why specifying the .* regex of pinctrl subnodes has effect on
pinctrl references in other nodes. I.e I don't understand why this fix fixes
the issue (but it does).

> Best regards,
> Krzysztof
