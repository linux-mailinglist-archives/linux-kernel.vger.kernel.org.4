Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181906C103F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCTLGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjCTLGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:06:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E4C2697
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:01:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t11so14369877lfr.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679310094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KV3kkcZfdeiVUi9v9t89pEf4D/a17ZWSTdxw83QbO4w=;
        b=x2wH4rX8OQawmcsvI25abb6SUD3Ez/ROJb7xcQ0KSWKQNMBKkBBxL9xYqw4WGJtRFr
         5zt8LL7y8o2hcgLZgkbnMyk9tjEpBJlsMVpgHZUshCqwWAHhC4RXaYe1beFN460bpRSv
         6C42OCeQeRGL93W4mroZmtmFT5CUaI4VTd38BgMjjbt6Z9S/Gllx3ZiPQsdBub6zBuKe
         uyTttcchDGuo+263vaA8vr7zxP0rKPxUMLJhWpSiC3r7VFw56cDlWRwD/Djo06e/4aeb
         g6ywhB9sUF476sLwro3szKIOiNr/ce/zeTABsw99BdqGgVKl9kDqslK2DosBuwab6liv
         7BCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679310094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KV3kkcZfdeiVUi9v9t89pEf4D/a17ZWSTdxw83QbO4w=;
        b=D2+6+F+FAusbAK1bFcwMtiCyIYUFRtBg3scjjMvvprNoNcCps8JRZz73327ZM/I0L8
         Hr6iKh7zxO7TiX//wZ+IKVR+Se4IbNEh0zmL/1Gcc/pcAX2o+Nvd7/N70bUjtE8XmKwu
         QF+Ed3uDv8rfJoriXIQ9uJ1UzNZfVVVOPJCe/cPiQFfs/3ZxEG+5dTbTM8yRM5IaHn6N
         uwqBdSTmruFZidIcl8dWGKzP6r21tvMlO62E1A+muN9aoxgt/V/F/Vp7AaUhJnjaj/qm
         A6C6OeWXJnf4SR2kdjuTbBlSltlop+fh8h6oADogEs5kpi65gpItZS/QHpp3WVLRd9k5
         7aKw==
X-Gm-Message-State: AO0yUKVjcpFUCuwRsMrVDAzSQ8IeNpUT54CWk/61ZOWtYSdCkTsh6ab0
        qByfWUt99GQ4hkxfuHOQxhjZfg==
X-Google-Smtp-Source: AK7set9bIwd0efybryR+Sa+q7avGV4AtAky6AdRGrX0WmP9KUmOK/yXt6JEyMlQLo7vek6dyh/lHDQ==
X-Received: by 2002:a19:ac08:0:b0:4ea:4793:facf with SMTP id g8-20020a19ac08000000b004ea4793facfmr553439lfc.13.1679310094482;
        Mon, 20 Mar 2023 04:01:34 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id n7-20020ac24907000000b004e85f7ec749sm1648310lfi.117.2023.03.20.04.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 04:01:34 -0700 (PDT)
Message-ID: <babfc91c-9c11-3dbd-d58d-55de22326656@linaro.org>
Date:   Mon, 20 Mar 2023 12:01:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 08/14] arm64: dts: qcom: sa8775p: pmic: add the power key
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230314183043.619997-1-brgl@bgdev.pl>
 <20230314183043.619997-9-brgl@bgdev.pl>
 <8ed14d64-f75b-b129-ad7b-0d3290de7738@linaro.org>
 <CAMRc=McGbZVWnp6Vcp2PzNjRpkfF9RJDWU89nvC+uso+mPK2PA@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAMRc=McGbZVWnp6Vcp2PzNjRpkfF9RJDWU89nvC+uso+mPK2PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.03.2023 11:52, Bartosz Golaszewski wrote:
> On Tue, Mar 14, 2023 at 9:26 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 14.03.2023 19:30, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Add the power key node under the PON node for PMIC #0 on sa8775p.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
>>> index 5d73212fbd16..874460d087db 100644
>>> --- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
>>> @@ -18,6 +18,13 @@ pmk8775_0_pon: pon@1200 {
>>>                       reg = <0x1200>, <0x800>;
>>>                       mode-recovery = <0x1>;
>>>                       mode-bootloader = <0x2>;
>>> +
>>> +                     pmk8775_0_pon_pwrkey: pwrkey {
>>> +                             compatible = "qcom,pmk8350-pwrkey";
>>> +                             interrupts-extended = <&spmi_bus 0x0 0x12 0x7 IRQ_TYPE_EDGE_BOTH>;
>>> +                             linux,code = <KEY_POWER>;
>>> +                             status = "disabled";
>> Does it make any sense to disable the power button?
>>
> 
> Since this is an automotive platform, I'd say yes - you wouldn't
> normally have physical access to the board or even be sure for it to
> have a power button?
On Qualcomm platforms there's little different ways to turn on the
device short of giving it DC power (though that may also be config
dependent), so I'd expect *something* would be connected to PON_PWR..

>But if you prefer it the other way, I won't be
> dying on this hill.
Yeah if you could, please leave it on (unless somebody has strong
arguments against that)

Konrad
> 
> Bart
> 
>> Konrad
>>> +                     };
>>>               };
>>>       };
>>>
