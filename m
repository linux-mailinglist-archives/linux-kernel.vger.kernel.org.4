Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7635C6BC1C0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjCOXu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCOXuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:50:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0CB1E2B4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 16:50:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id f16so21173015ljq.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 16:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678924251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p2+chdbkCkcfVI7TFnoEGlsYgaxLzqaNOF9QoTF6c+I=;
        b=kemRYaBVdzjOq+qh0tyhmGO7RqAMpnw29HNfxqCH/yddvN6lvgHi8MR/+iaQenx3Hi
         jfE/SP3tIishMHAabxa0tr8UKJZ6xP2YwqKSZ9eu9xRwYb3yHQplM3gH9fEVsB7QS9EN
         LHevtJMf+N5FvafiQs33Fb6ZnSJLXBKfTDMHOw8zUnwkv1hpfRSJV6WHJgnuyhccxHY9
         PQSx2mDeMvmk8SDURaMW/UMEvKX6b9co4A4kAf2Ono9pXcqWLlFpbcrMYTIt0vgR6yK4
         6KwV4dL87+WNUk7Ea8ejMn4GnK7z70HuBtGIDAhLfl11bgbohRHzIQpJ838EtfDTTO+4
         T70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678924251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2+chdbkCkcfVI7TFnoEGlsYgaxLzqaNOF9QoTF6c+I=;
        b=jsbUDBvJZp6WZpSTRcbGNXz4i2kO0pQCQnDHHDp5xdUsRpm4yPoc/KAqdsIfZvTJKx
         tNRXwZtrqsaicrKlfwFv/jvW+fDL2TxQJTcgGDK/tG+D5LySoSaXViP2ge4XfQwucutt
         o1vMJeVMONgfOcURaDlRCrG23sJ5W5UvCnEY9uJJhFEg0LagzLrhhxj0BMSKtFLjhFY9
         TfdomItaM2y9I6SZougR3WH4+y8RUQPudcCrEyFA9GSsN9+mTNBnOa1hbBFiyumSqhK7
         2Lgo3ihMIZjkjKK5S1M75mosmA2DGrv3foGdCDiVUwR2xbME1I838qh/gsH47nljkp8h
         FH7w==
X-Gm-Message-State: AO0yUKXZYfM+4mo85D2bpMsqd2VgZIR4d8ns3wcN5Ncd7ncxVn5sO2Kh
        JCxsTtS/lEH8iWpMk/ecUN7H2Q==
X-Google-Smtp-Source: AK7set8rrRlZyHwlnVDSAf2JsH8d351/YFfJdfIxeI2qB/sXMb0J/ZH+ILqYjiYcad3mfkriUT4T6Q==
X-Received: by 2002:a2e:740d:0:b0:294:7427:4ec4 with SMTP id p13-20020a2e740d000000b0029474274ec4mr1378919ljc.41.1678924250983;
        Wed, 15 Mar 2023 16:50:50 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id h9-20020a2e9ec9000000b0029352fc39fbsm1010140ljk.63.2023.03.15.16.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 16:50:50 -0700 (PDT)
Message-ID: <3d3117d2-b3eb-1174-7061-b899cdcdf6ce@linaro.org>
Date:   Thu, 16 Mar 2023 00:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Split out SA8155P and use correct
 RPMh power domains
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214095435.2192153-1-konrad.dybcio@linaro.org>
 <20230214095435.2192153-3-konrad.dybcio@linaro.org>
 <20230314001052.7qvgbwkl73x22oll@ripper>
 <eaf2ca0d-4d90-b68b-3b36-8bb0148cfb95@linaro.org>
 <ee1ebac4-bf18-019a-f770-5cb88703d06b@linaro.org>
 <20230315230024.wxuqthay74i5zgrq@ripper>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230315230024.wxuqthay74i5zgrq@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.03.2023 00:00, Bjorn Andersson wrote:
> On Tue, Mar 14, 2023 at 12:41:45PM +0100, Konrad Dybcio wrote:
>>
>>
>> On 14.03.2023 12:36, Konrad Dybcio wrote:
>>>
>>>
>>> On 14.03.2023 01:10, Bjorn Andersson wrote:
>>>> On Tue, Feb 14, 2023 at 10:54:35AM +0100, Konrad Dybcio wrote:
>>>>> The RPMhPD setup on SA8155P is different compared to SM8150. Correct
>>>>> it to ensure the platform will not try accessing forbidden/missing
>>>>> RPMh entries at boot, as a bad vote will hang the machine.
>>>>>
>>>>
>>>> I don't see that this will scale, as soon as someone adds a new device
>>>> in sm8150.dtsi that has the need to scale a power rail this will be
>>>> forgotten and we will have a mix of references to the SM8150 and SA8155P
>>>> value space.
>>>>
>>>> That said, I think it's reasonable to avoid duplicating the entire
>>>> sm8150.dtsi.
>>> Yeah, this problem has no obvious good solutions and even though it's
>>> not very elegant, this seems to be the less bad one..
>>>
>>>>
>>>> How about making the SA8155P_* macros match the SM8150_* macros?
>>>> That way things will fail gracefully if a device node references a
>>>> resource not defined for either platform...
>>> Okay, let's do that
>> Re-thinking it, it's good that the indices don't match, as this way the
>> board will (should) refuse to function properly if there's an oversight,
>> which may have gone unnoticed if they were matching, so this only guards
>> us against programmer error which is not great :/
>>
> 
> Right, ensuring that the resource indices never collides would be a good
> way to capture this issue, as well as copy-paste errors etc. My
> pragmatic proposal is that we make SA8155P_x == SM8150_x where a match
> exist, and for the ones that doesn't match we pick numbers that doesn't
> collide between the platforms.
> 
> The alternative is to start SA8155P_x at 11, but it's different and
> forces sa8155p.dtsi to redefine every single power-domains property...
> 
> 
> This does bring back the feeling that it was a mistake to include the
> platform name in these defines in the first place... Not sure if it's
> worth mixing generic defines into the picture at this point, given that
> we I don't see a way to use them on any existing platform.
TBF we could, think:

sm1234_rpmpds[] = {
	[CX] = &foobar1,
	[CX_AO] = &foobar1_ao,

	[...]

	/* Legacy DT bindings */
	[SM1234_CX] = &foobar1,
	[SM1234_CX_AO] = &foobar1_ao,
};

WDYT?

Konrad
> 
> Regards,
> Bjorn
> 
>> Konrad
>>>
>>> Konrad
>>>>
>>>> Regards,
>>>> Bjorn
>>>>
>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts |  2 +-
>>>>>  arch/arm64/boot/dts/qcom/sa8155p.dtsi    | 51 ++++++++++++++++++++++++
>>>>>  2 files changed, 52 insertions(+), 1 deletion(-)
>>>>>  create mode 100644 arch/arm64/boot/dts/qcom/sa8155p.dtsi
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
>>>>> index 459384ec8f23..9454e8e4e517 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
>>>>> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
>>>>> @@ -7,7 +7,7 @@
>>>>>  
>>>>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>> -#include "sm8150.dtsi"
>>>>> +#include "sa8155p.dtsi"
>>>>>  #include "pmm8155au_1.dtsi"
>>>>>  #include "pmm8155au_2.dtsi"
>>>>>  
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sa8155p.dtsi b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
>>>>> new file mode 100644
>>>>> index 000000000000..f2fd7c28764e
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
>>>>> @@ -0,0 +1,51 @@
>>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>>> +/*
>>>>> + * Copyright (c) 2023, Linaro Limited
>>>>> + *
>>>>> + * SA8155P is an automotive variant of SM8150, with some minor changes.
>>>>> + * Most notably, the RPMhPD setup differs: MMCX and LCX/LMX rails are gone.
>>>>> + */
>>>>> +
>>>>> +#include "sm8150.dtsi"
>>>>> +
>>>>> +&dispcc {
>>>>> +	power-domains = <&rpmhpd SA8155P_CX>;
>>>>> +};
>>>>> +
>>>>> +&mdss_mdp {
>>>>> +	power-domains = <&rpmhpd SA8155P_CX>;
>>>>> +};
>>>>> +
>>>>> +&mdss_dsi0 {
>>>>> +	power-domains = <&rpmhpd SA8155P_CX>;
>>>>> +};
>>>>> +
>>>>> +&mdss_dsi1 {
>>>>> +	power-domains = <&rpmhpd SA8155P_CX>;
>>>>> +};
>>>>> +
>>>>> +&remoteproc_adsp {
>>>>> +	power-domains = <&rpmhpd SA8155P_CX>;
>>>>> +};
>>>>> +
>>>>> +&remoteproc_cdsp {
>>>>> +	power-domains = <&rpmhpd SA8155P_CX>;
>>>>> +};
>>>>> +
>>>>> +&remoteproc_mpss {
>>>>> +	power-domains = <&rpmhpd SA8155P_CX>,
>>>>> +			<&rpmhpd SA8155P_MSS>;
>>>>> +};
>>>>> +
>>>>> +&remoteproc_slpi {
>>>>> +	power-domains = <&rpmhpd SA8155P_CX>,
>>>>> +			<&rpmhpd SA8155P_MX>;
>>>>> +};
>>>>> +
>>>>> +&rpmhpd {
>>>>> +	compatible = "qcom,sa8155p-rpmhpd";
>>>>> +};
>>>>> +
>>>>> +&sdhc_2 {
>>>>> +	power-domains = <&rpmhpd SA8155P_CX>;
>>>>> +};
>>>>> -- 
>>>>> 2.39.1
>>>>>
