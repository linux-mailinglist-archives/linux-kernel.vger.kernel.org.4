Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509006B91BD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjCNLg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjCNLgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:36:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFF1EF9F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:36:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y15so10070962lfa.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678793781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEdKVYCW4wWuB3A77aE8lOd0heUdcbQjHdyZrhzSn44=;
        b=cQgt9aOMPcNdwPslS+LAdXqKvBbg9vqm+yaZh6EYuCP9Ts3d9FrqSNjcgJw9XQnjNc
         RzYYydo0qcvqPoeJaJcsZNGZa53ZaJ59ORhebrdu/gEzdp2RccNdIsfsTK3oePFjJlZs
         zQRVfKB5DeLYVt6oPnj+hO18epG1+2cQYNiAAEKs1Alf6+qaLMJT41m00PgJVR+4v/MB
         Q6xCD7DX7IBvXQaidBeCSGABOmARlVwElPf4mqsavF5TpntfMNLIHF+u6ItD6EdvB5Zs
         USXCxL0VQPdEUy1OfJgez05gjmZ5zHZS3BGTJYzpH2wuYxg2W7rXFyw4sIMm0J6RXLX9
         hQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678793781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEdKVYCW4wWuB3A77aE8lOd0heUdcbQjHdyZrhzSn44=;
        b=TRO4aEgJ6i9Gou6pRSHenqFwWZeJIGOuuhHsBhFRTYYwFaKA84sOA5kVdx6OkFGxWN
         Ra0xjrIWJfG4MHbmRrsNdDU4kAojCJ4/2xt/3U8JDYXg88OOBkDxPXk9LFm+H9/anSYm
         q7BDIg/Ja/B00JFUsbCTGxYnceD7s3ZeqPV0DF4GjtcGh7ATMueRT3onWUkHfBZcZw32
         bXd4EZkoThOgavwtVCoV5ikAY/QakN8qb3ptne5hZNkrkBcQtaWNo374+9W+Bh1VLNCS
         nVAdljOguZuKDkbMcvQ9B4F08jvLUKgvwvaVfXAUIPLlwyratkNxyAvQs3PxnbPHMjk4
         1v5A==
X-Gm-Message-State: AO0yUKWfzHtEpRAOl6z4dUdkw5oXCKK7ItLoWhV5KxzwOWNNip7OY0vR
        QmxQic7O26T4VPsQ8WFLGb9y3g==
X-Google-Smtp-Source: AK7set9TURs4/AAkObPILWiuPwjmkEavqIu7X0iSrkWD9PKVAwCoHaOsUTOmnpKddraLJ/VeAKL7EQ==
X-Received: by 2002:ac2:4e4d:0:b0:4e8:4a44:aabf with SMTP id f13-20020ac24e4d000000b004e84a44aabfmr675223lfr.58.1678793780717;
        Tue, 14 Mar 2023 04:36:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w16-20020ac254b0000000b004d51b590772sm368070lfk.255.2023.03.14.04.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 04:36:20 -0700 (PDT)
Message-ID: <eaf2ca0d-4d90-b68b-3b36-8bb0148cfb95@linaro.org>
Date:   Tue, 14 Mar 2023 12:36:18 +0100
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230314001052.7qvgbwkl73x22oll@ripper>
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



On 14.03.2023 01:10, Bjorn Andersson wrote:
> On Tue, Feb 14, 2023 at 10:54:35AM +0100, Konrad Dybcio wrote:
>> The RPMhPD setup on SA8155P is different compared to SM8150. Correct
>> it to ensure the platform will not try accessing forbidden/missing
>> RPMh entries at boot, as a bad vote will hang the machine.
>>
> 
> I don't see that this will scale, as soon as someone adds a new device
> in sm8150.dtsi that has the need to scale a power rail this will be
> forgotten and we will have a mix of references to the SM8150 and SA8155P
> value space.
> 
> That said, I think it's reasonable to avoid duplicating the entire
> sm8150.dtsi.
Yeah, this problem has no obvious good solutions and even though it's
not very elegant, this seems to be the less bad one..

> 
> How about making the SA8155P_* macros match the SM8150_* macros?
> That way things will fail gracefully if a device node references a
> resource not defined for either platform...
Okay, let's do that

Konrad
> 
> Regards,
> Bjorn
> 
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts |  2 +-
>>  arch/arm64/boot/dts/qcom/sa8155p.dtsi    | 51 ++++++++++++++++++++++++
>>  2 files changed, 52 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sa8155p.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
>> index 459384ec8f23..9454e8e4e517 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
>> @@ -7,7 +7,7 @@
>>  
>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>  #include <dt-bindings/gpio/gpio.h>
>> -#include "sm8150.dtsi"
>> +#include "sa8155p.dtsi"
>>  #include "pmm8155au_1.dtsi"
>>  #include "pmm8155au_2.dtsi"
>>  
>> diff --git a/arch/arm64/boot/dts/qcom/sa8155p.dtsi b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
>> new file mode 100644
>> index 000000000000..f2fd7c28764e
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
>> @@ -0,0 +1,51 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023, Linaro Limited
>> + *
>> + * SA8155P is an automotive variant of SM8150, with some minor changes.
>> + * Most notably, the RPMhPD setup differs: MMCX and LCX/LMX rails are gone.
>> + */
>> +
>> +#include "sm8150.dtsi"
>> +
>> +&dispcc {
>> +	power-domains = <&rpmhpd SA8155P_CX>;
>> +};
>> +
>> +&mdss_mdp {
>> +	power-domains = <&rpmhpd SA8155P_CX>;
>> +};
>> +
>> +&mdss_dsi0 {
>> +	power-domains = <&rpmhpd SA8155P_CX>;
>> +};
>> +
>> +&mdss_dsi1 {
>> +	power-domains = <&rpmhpd SA8155P_CX>;
>> +};
>> +
>> +&remoteproc_adsp {
>> +	power-domains = <&rpmhpd SA8155P_CX>;
>> +};
>> +
>> +&remoteproc_cdsp {
>> +	power-domains = <&rpmhpd SA8155P_CX>;
>> +};
>> +
>> +&remoteproc_mpss {
>> +	power-domains = <&rpmhpd SA8155P_CX>,
>> +			<&rpmhpd SA8155P_MSS>;
>> +};
>> +
>> +&remoteproc_slpi {
>> +	power-domains = <&rpmhpd SA8155P_CX>,
>> +			<&rpmhpd SA8155P_MX>;
>> +};
>> +
>> +&rpmhpd {
>> +	compatible = "qcom,sa8155p-rpmhpd";
>> +};
>> +
>> +&sdhc_2 {
>> +	power-domains = <&rpmhpd SA8155P_CX>;
>> +};
>> -- 
>> 2.39.1
>>
