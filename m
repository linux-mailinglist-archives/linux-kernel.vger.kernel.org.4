Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1C27508CE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjGLMyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGLMx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:53:58 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BAC19B9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:53:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so10340440e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689166433; x=1691758433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBc63gZewZL8iaZK2IOeBqCKcy2zAJOBt2Jz+c038nk=;
        b=Au4S9337dhhlibueQQOk2k+/9ELLnv1F8knGNc9Ui4OhDAcDiSCyHxIG2HUYLBxbwv
         Ok6rtJKM5nmSuz5NTjPyJ+L+MUEYZeDY982cyR9KQOtmCu61TLwn/sT3v/iCmhW68Eap
         yILluRD79+G1yjJMKF7IS5YzNbkgjWiktM1ZqGBu+83tX7/iqnF8T69Ia3JuWvxQT5R4
         RiN7g58uiaEKQ5utipqWZL/Io/+rNeod3NrUjlKDrj5B2Nlw95qPmiWpZJ0MGNq/hTjU
         LAHPW3Ayacn+O18VwCdj73BsXFX8/usTo1a4qvF7kttbJPs/jKVJQbjThKB7nAwZvsCt
         jBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689166433; x=1691758433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBc63gZewZL8iaZK2IOeBqCKcy2zAJOBt2Jz+c038nk=;
        b=DN9GR7zCSDDKa8RDzh5op29cjrZ+WLRMUoOOt3D/iHGY1IBAAWrqVJmsc3pJQPUwr2
         gQpUeqgfbT3GW19TvxxsEhCpSJs7hAjpfQHwqFxxmpxk6CExwfJqZGnt7kNu5xMmOB5C
         9PZ7fqpAQ4tKq1AOooZygOpdK2wVfKWn1ZWKG/q021FGYa3fLqPvYXTP7Qg3TjLuhmyn
         XTPfaYwLuaXb+e+OdffDFSOnMg/Zre9TPM6Vl3rB0R7vyt/KL7fnkfsoB5+XtXiY7CEx
         SQX3IUVOvbmYHapHU4jOnhIAnqq8PGWMZALcBNLiGaH8/P2N1/N+8CgOEeedZBYiVp/L
         /mAQ==
X-Gm-Message-State: ABy/qLZ3y1p2WEw3haSiMLP5I35Qouuf8umx5+maF2+XsWzLQvSws+Jd
        utLYI2ryqFJzUyKTPSZtrNP2/w==
X-Google-Smtp-Source: APBJJlEOK5nzhXK/DYiTOD2PXvlX0k83byqi39QQUlr+lNWZuEj17VECYcEc6z/ft6Wk4UO4/wVZuQ==
X-Received: by 2002:a19:3819:0:b0:4f8:631b:bf77 with SMTP id f25-20020a193819000000b004f8631bbf77mr16040627lfa.22.1689166433135;
        Wed, 12 Jul 2023 05:53:53 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id s8-20020a19ad48000000b004fba6d3eb82sm697646lfd.48.2023.07.12.05.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 05:53:52 -0700 (PDT)
Message-ID: <538c3d99-a404-6847-dd04-f77a35aa6c77@linaro.org>
Date:   Wed, 12 Jul 2023 15:53:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: ipq5332: Add tsens node
Content-Language: en-GB
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230712113539.4029941-1-quic_ipkumar@quicinc.com>
 <20230712113539.4029941-4-quic_ipkumar@quicinc.com>
 <a95dd01a-943f-e2d4-777f-a139fbc25238@linaro.org>
 <61346e56-3877-37c0-0df5-2436f97064e7@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <61346e56-3877-37c0-0df5-2436f97064e7@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 15:48, Praveenkumar I wrote:
> 
> On 7/12/2023 5:54 PM, Dmitry Baryshkov wrote:
>> On 12/07/2023 14:35, Praveenkumar I wrote:
>>> IPQ5332 has tsens v2.3.3 peripheral. This patch adds the tsense
>>> node with nvmem cells for calibration data.
>>>
>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> ---
>>> [v2]:
>>>     Included qfprom nodes only for available sensors and removed
>>>     the offset suffix.
>>>
>>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 66 +++++++++++++++++++++++++++
>>>   1 file changed, 66 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi 
>>> b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> index 8bfc2db44624..0eef77e36609 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> @@ -150,6 +150,46 @@ qfprom: efuse@a4000 {
>>>               reg = <0x000a4000 0x721>;
>>>               #address-cells = <1>;
>>>               #size-cells = <1>;
>>> +
>>> +            tsens_mode: mode@3e1 {
>>> +                reg = <0x3e1 0x1>;
>>> +                bits = <0 3>;
>>> +            };
>>> +
>>> +            tsens_base0: base0@3e1 {
>>> +                reg = <0x3e1 0x2>;
>>> +                bits = <3 10>;
>>> +            };
>>> +
>>> +            tsens_base1: base1@3e2 {
>>> +                reg = <0x3e2 0x2>;
>>> +                bits = <5 10>;
>>> +            };

Please order device nodes according to the address. So mode/base should 
come after sensors data.

>>> +
>>> +            s11: s11@3a5 {
>>> +                reg = <0x3a5 0x1>;
>>> +                bits = <4 4>;
>>> +            };
>>> +
>>> +            s12: s12@3a6 {
>>> +                reg = <0x3a6 0x1>;
>>> +                bits = <0 4>;
>>> +            };
>>> +
>>> +            s13: s13@3a6 {
>>> +                reg = <0x3a6 0x1>;
>>> +                bits = <4 4>;
>>> +            };
>>> +
>>> +            s14: s14@3ad {
>>> +                reg = <0x3ad 0x2>;
>>> +                bits = <7 4>;
>>> +            };
>>> +
>>> +            s15: s15@3ae {
>>> +                reg = <0x3ae 0x1>;
>>> +                bits = <3 4>;
>>> +            };
>>>           };
>>>             rng: rng@e3000 {
>>> @@ -159,6 +199,32 @@ rng: rng@e3000 {
>>>               clock-names = "core";
>>>           };
>>>   +        tsens: thermal-sensor@4a9000 {
>>> +            compatible = "qcom,ipq5332-tsens";
>>> +            reg = <0x4a9000 0x1000>,
>>> +                  <0x4a8000 0x1000>;
>>> +            nvmem-cells = <&tsens_mode>,
>>> +                      <&tsens_base0>,
>>> +                      <&tsens_base1>,
>>> +                      <&s11>,
>>> +                      <&s12>,
>>> +                      <&s13>,
>>> +                      <&s14>,
>>> +                      <&s15>;
>>> +            nvmem-cell-names = "mode",
>>> +                       "base0",
>>> +                       "base1",
>>> +                       "s11",
>>> +                       "s12",
>>> +                       "s13",
>>> +                       "s14",
>>> +                       "s15";
>>
>> Previously you had data for other sensors here. Are they not used at 
>> all, not wired, have no known-good placement? I think it might be 
>> better to declare all sensors here (and in the driver too) and then 
>> consider enabling only a pile of them in the thermal-zone node.
> 
> Remaining sensors are not used at all. It is not wired. Only above 
> sensors are placed in SoC.

Ack, thanks for the explanation. Then this is good.

> 
> - Praveenkumar
> 
>>
>>> +            interrupts = <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>;
>>> +            interrupt-names = "combined";
>>> +            #qcom,sensors = <5>;
>>> +            #thermal-sensor-cells = <1>;
>>> +        };
>>> +
>>>           tlmm: pinctrl@1000000 {
>>>               compatible = "qcom,ipq5332-tlmm";
>>>               reg = <0x01000000 0x300000>;
>>

-- 
With best wishes
Dmitry

