Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0171D67A866
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 02:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjAYBaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 20:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjAYBaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 20:30:02 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0B949579
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:30:00 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id v6so43784210ejg.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SaTjOuIxXBK83AxAjFBiHjZe+rvlU5L1GQ57PTy+V+k=;
        b=yP6iFUSjrUYFUjhhXgQ8jMXrNm2Pl6JUcT1uP5Qs4D9kVD9Zc7BAf756uRWCC53G32
         1ZRzezlEDYI1OYDHQHSGk5TrNQW2iZKQ/m8YKDsOq5eqL2GuZEITVdibJ7Tb7KXAZ8wm
         982in2ckWMU5bIi+V+AF9tX4+RyiODm1pg39CqR6yV1KDAdewkoGpnI2YdR1IRVWT+9B
         mOsSuWf0hmJwt39Xg6o/LX92qw5WRSmVbRpExlvD4jEe9o1HVHX2PLuv5OcoNXRr4Hcz
         gHAG7KN30cfOqje9+eCM9UkySB2ASt1mUPcme6MhqYyryuT2MS3W3NpRBxnwqX/Xpmvc
         sZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SaTjOuIxXBK83AxAjFBiHjZe+rvlU5L1GQ57PTy+V+k=;
        b=H/YhZVzEUHqiSLp2vs3foQDJssJWLc/uLyWK6VDs/SB23697y6KZuBPPOaxxwmDg6l
         qaRIi5kp/3aNgCQBU70D3psGsEgcI09UrPCj3RlpzMW1lV2eKvV5bj1LLba7ivE5Nvxv
         bLq8lvTanmDw0VXKDMMFj8pSfKLc2HGTkYQ74h8uEgK3M+cC1ri1DbCv8Lwi9x9jXUCP
         +4JcOFLcRTtXvbplRENaQEaRhcAqduSsVTrOfracpolMCSuApTZ4PxtAFIvhsbGCPBqc
         3x9dv8QGzNOugD6Y3/MAFiZ2kKSyfsmtQYPCuqBdVCT/+NU3mHHGMTcprBmvNik+Sc+N
         L1gA==
X-Gm-Message-State: AFqh2kryROMehNcfudoGC4uFFezRtSlUbAHlqQARvl0eCTRaEn6lMXBM
        4sEBKBuHDApDTuhergy8kpf49A==
X-Google-Smtp-Source: AMrXdXt0PeTUnVDTymw1fNMhzslQjfo10NEpW/gwcwWm/osV3KylhDxWrk2c8K1wpDcdiRFuxxKwig==
X-Received: by 2002:a17:906:a04d:b0:84d:4325:7f7a with SMTP id bg13-20020a170906a04d00b0084d43257f7amr28065424ejb.65.1674610197141;
        Tue, 24 Jan 2023 17:29:57 -0800 (PST)
Received: from [192.168.1.101] (abyl109.neoplus.adsl.tpnet.pl. [83.9.31.109])
        by smtp.gmail.com with ESMTPSA id ks27-20020a170906f85b00b0085fc3dec567sm1637654ejb.175.2023.01.24.17.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 17:29:56 -0800 (PST)
Message-ID: <0597e178-d563-0afc-a998-ca7c54ee56b5@linaro.org>
Date:   Wed, 25 Jan 2023 02:29:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: Add Square apq8039-t2 board
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <20230123023127.1186619-6-bryan.odonoghue@linaro.org>
 <e80b98bc-54e8-f7ab-b9a9-dd888108a0cd@linaro.org>
 <8dd1ce3c-82ea-cfc3-a84c-c022cbaec8a0@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <8dd1ce3c-82ea-cfc3-a84c-c022cbaec8a0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.01.2023 02:21, Bryan O'Donoghue wrote:
> On 23/01/2023 16:29, Krzysztof Kozlowski wrote:
>> On 23/01/2023 03:31, Bryan O'Donoghue wrote:
>>> The apq8039-t2 is an apq8039 based board paired with a wcn3680b WiFi
>>> chipset.
>>>
>>> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
>>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>>> Co-developed-by: Jun Nie <jun.nie@linaro.org>
>>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>>> Co-developed-by: Benjamin Li <benl@squareup.com>
>>> Signed-off-by: Benjamin Li <benl@squareup.com>
>>> Co-developed-by: James Willcox <jwillcox@squareup.com>
>>> Signed-off-by: James Willcox <jwillcox@squareup.com>
>>> Co-developed-by: Leo Yan <leo.yan@linaro.org>
>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>> Co-developed-by: Joseph Gates <jgates@squareup.com>
>>> Signed-off-by: Joseph Gates <jgates@squareup.com>
>>> Co-developed-by: Max Chen <mchen@squareup.com>
>>> Signed-off-by: Max Chen <mchen@squareup.com>
>>> Co-developed-by: Zac Crosby <zac@squareup.com>
>>> Signed-off-by: Zac Crosby <zac@squareup.com>
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/Makefile       |   1 +
>>>   arch/arm64/boot/dts/qcom/apq8039-t2.dts | 545 ++++++++++++++++++++++++
>>>   2 files changed, 546 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/apq8039-t2.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index b0423ca3e79fd..73ff8d3213d99 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -1,5 +1,6 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>>   dtb-$(CONFIG_ARCH_QCOM)    += apq8016-sbc.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)    += apq8039-t2.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += apq8094-sony-xperia-kitakami-karin_windy.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += apq8096-db820c.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += apq8096-ifc6640.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
>>> new file mode 100644
>>> index 0000000000000..734b4d6054132
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
>>> @@ -0,0 +1,545 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>>> + * Copyright (c) 2020-2023, Linaro Ltd.
>>> + *
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "msm8939.dtsi"
>>> +#include "msm8939-pm8916.dtsi"
>>> +#include <dt-bindings/arm/qcom,ids.h>
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>> +#include <dt-bindings/sound/apq8016-lpass.h>
>>> +
>>> +/ {
>>> +    model = "Square, Inc. T2 Devkit";
>>> +    compatible = "square,apq8039-t2", "qcom,msm8939";
>>
>> There is no square vendor prefix.
> 
> commit d3e2262cd0d1105bb3a71012693876d01e8de203
> Author: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Date:   Tue Jan 17 02:48:39 2023 +0000
> 
>     dt-bindings: arm: qcom: Document MSM8939 SoC binding
> 
> +      - items:
> +          - enum:
> +              - sony,kanuti-tulip
> +              - square,apq8039-t2
> +          - const: qcom,msm8939
> 
This is the board compatible. Krzysztof meant an entry for Square
in Documentation/devicetree/bindings/vendor-prefixes.yaml.

> 
>>> +
>>> +    qcom,board-id = <0x53 0x54>;
>>> +    qcom,msm-id = <QCOM_ID_MSM8939 0>, <QCOM_ID_MSM8939 0x30000>, <QCOM_ID_APQ8039 0x30000>;
>>> +
> 
>>> +
>>> +    lcd_avdd_reg: lcd-avdd-regulator {
>>
>> Since we try to have nodes ordered, how about naming them
>> "regulator-xxx", so whatever is added later will not spread them all over?
> 
> Point taken.
> 
> vreg_ looks like a more common prefix
> 
> arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts: vreg_edp_3p3: regulator-edp-3p3 {
> vreg_edp_bl: regulator-edp-bl {
> vreg_misc_3p3: regulator-misc-3p3 {
> vreg_nvme: regulator-nvme {
> vreg_vph_pwr: regulator-vph-pwr {
> vreg_wlan: regulator-wlan {
> vreg_wwan: regulator-wwan {
> 
>>> +    status = "okay";
>>> +
>>> +    typec: tps6598x@38 {
>>
>> Node names should be generic.
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> None of those fit really
> 
> typec_pd is upstream for the same IC, I'll reuse that.
Names, not labels.

label: name@unitaddress {

Konrad
> 
> arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> 
> ---
> bod
