Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3307A606065
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJTMjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJTMjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:39:33 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5B717E0E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:39:30 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i9so13418689qvo.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZfIr1cCYntMcg38k43BwnqiTczM7YPUsQyV6bjQhYTE=;
        b=r6pXAkWN6tuBqy2WHCpX2Ylh5q4vUvyV6IgZRJl/uORfAKdVhV2Cyv2lNZpHNSwgst
         jmu5yBPSoH3m/ift8eXLd3igqXilv+xG6ilL27uG3jP4ZvZYhEw5geRXQrvJev3Ds7vY
         +8s3fAkg4RxL/U9m2By1Ghn+jH2n3S+SSjjuxEQgrobBpwlSs8cY9XE0Ae33UkO27CJu
         XBa5vMMSDjq3dIr971x5v5yr1WnPWb9JRL6j6on3YE0AnbLRN6f/35FNpWAcuxdyauPE
         bn+4yfDD5CnhZ0eL3PEeTsQ8ohiAoN4CzWvppN5wLM9mxpnHJxuJLZmhsuCkjumczFHQ
         NMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfIr1cCYntMcg38k43BwnqiTczM7YPUsQyV6bjQhYTE=;
        b=yeKXYQFBw24hmFYp2NMLD67rwXh/9fg6aQAM6YYho5Ypn2I5oQaFUYLVwFiAviCTo/
         E2IfnmWsq238pRE2DmV1LZZaGD95VCL3HL18DHE94syUvAVpNUWvhOgFDwocoVDPt8D/
         EnSVRTEQHi4JbxoEW2/DrbcpVTN09UCBXet4ENvB76/GEuwlkvtlXF3YOKMik4X6ig3/
         4NLxGjLiOw55rRKgxQ2Y6p791kSRYtll/55J/74et7KYuw0H8Jl8bOAz1hZ/6z9CiN9P
         VA7dhGbn69KQfL0Vg3duEC8HA8Gxj8t6FgGd11mxW/dD1nw+Av58nwlZOwjGc0/iNk9h
         qQGA==
X-Gm-Message-State: ACrzQf0bYy9UXubqmSWXrlXncK5e5oxygNRG1Yj1wPgkTmePyw58rBoR
        JMz3YHqhdwDoFNwGS+PzMzbISg==
X-Google-Smtp-Source: AMsMyM5NvWIvyhkngdLjT+yTVpGAEH8tXDpGUA1sQOU5Jx9NKqwwLg3kIaFQl5e+SfbTuUcFSD6gHA==
X-Received: by 2002:ad4:5d68:0:b0:4af:af07:580b with SMTP id fn8-20020ad45d68000000b004afaf07580bmr10575811qvb.14.1666269569384;
        Thu, 20 Oct 2022 05:39:29 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id x6-20020ac86b46000000b0035ba48c032asm5869363qts.25.2022.10.20.05.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 05:39:28 -0700 (PDT)
Message-ID: <1b164c8a-1ace-125a-62ac-47dd77399f74@linaro.org>
Date:   Thu, 20 Oct 2022 08:39:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221014221138.7552-1-quic_molvera@quicinc.com>
 <20221014221138.7552-4-quic_molvera@quicinc.com>
 <e94d9029-e0aa-574f-62d2-632e2c5d70d2@linaro.org>
 <65f95226-f464-2e14-1f89-930ed26e0f38@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <65f95226-f464-2e14-1f89-930ed26e0f38@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 17:16, Melody Olvera wrote:
> 
> 
> On 10/15/2022 6:29 AM, Krzysztof Kozlowski wrote:
>> On 14/10/2022 18:11, Melody Olvera wrote:
>>> Add DTs for Qualcomm IDP platforms using the QDU1000 and QRU1000
>>> SoCs.
>>>
>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/Makefile        |   2 +
>>>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 230 +++++++++++++++++++++++
>>>  arch/arm64/boot/dts/qcom/qru1000-idp.dts | 230 +++++++++++++++++++++++
>>>  3 files changed, 462 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index d7669a7cee9f..8417295adfeb 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -51,7 +51,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>> new file mode 100644
>>> index 000000000000..47a8eaf4fda2
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>> @@ -0,0 +1,230 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>> +#include "qdu1000.dtsi"
>>> +#include "pm8150.dtsi"
>>> +
>>> +/ {
>>> +	model = "Qualcomm Technologies, Inc. QDU1000 IDP";
>>> +	compatible = "qcom,qdu1000-idp", "qcom,qdu1000";
>>> +
>>> +	aliases {
>>> +		serial0 = &uart7;
>>> +	};
>>> +
>>> +	chosen {
>>> +		stdout-path = "serial0:115200n8";
>>> +	};
>>> +
>>> +	ppvar_sys: ppvar-sys-regulator {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "ppvar_sys";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +	};
>>> +
>>> +	vph_pwr: vph-pwr-regulator {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vph_pwr";
>>> +		regulator-min-microvolt = <3700000>;
>>> +		regulator-max-microvolt = <3700000>;
>>> +
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +
>>> +		vin-supply = <&ppvar_sys>;
>>> +	};
>>> +};
>>> +
>>> +&apps_rsc {
>>> +	pm8150-regulators {
>> regulators
> Just 'regulators' as the node name isn't compliant with the bindings for rpmh-rsc devices.
> Do the bindings need to be updated or should I leave this as is?

If bindings expect this, I propose to change them. Which schema is
expecting this? I already fixed SMD RPM:
https://lore.kernel.org/all/20220926092104.111449-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

