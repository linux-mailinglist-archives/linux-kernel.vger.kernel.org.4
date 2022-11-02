Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B876168D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiKBQaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiKBQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:29:37 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EACE63A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:25:29 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id g10so5531560qkl.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8fIxNkEk762/Vheq+PXA4qt7Mvqj/WdcSUj0Kue8hA=;
        b=XEfS8BNTxPXiLGKyRtLBrUbXvgzZq6y+qmEGcmpKTJ6Rf6iwxijtYyCBH6XQFjp0vU
         6P6koymPWHPrwafaeDWpd6g/rAh2p9+RW7mzqJVEHElCIZbfSMSbj9WpDnehMsy4O5dS
         yPYjqPcCFCB4BM0M1lpG8r8Oxo7Lvow8vZO6nCjMjjNQsDz1NMBCZzcWQOrCndapYzIv
         AlOLtdLYx7BULb6oGUx4OKnnkiahP6kebvJBBqhR1ScmMw9EkIscY932mTaLvcPGUBOi
         VmPqniTSPndFjT5ZrTpXcPdDHiymRcm8uAP7rfKbBsRYf511i7Gc1NkgCYNcs3Odz1c2
         BCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8fIxNkEk762/Vheq+PXA4qt7Mvqj/WdcSUj0Kue8hA=;
        b=vhNxU2rkhQXVdzXnKlOMllI3vOksCzBEdVJvMACzoClMYn6zjfWdRoX0m3RGbDtUMU
         cjEPnbYMQ1mCHNJeCiOImvTCucnixja70SWUmB5xbhNF4vj4z/4dEXN3DUjR+rBB0awH
         ygp5JHfvWMG6ZQGpB8NfFp3Qcm75icJxdCwZtwovE1qs4HlbDVhvhJ5oNfKN5AttfAP0
         wtdEJ1CM//t/xzIePD7V3xrJttGORRrrlKCkLNBY7TC5KtAdJYklAHdChlg4sXWBx3Wo
         5A27o+HniYqgANGxtayFXqL5tGYu0TriT6lGco7lYgOMlnL13x8O/vqTpxW8IM4tfAlE
         gfog==
X-Gm-Message-State: ACrzQf3Y3ih99S4e/uGdFBbsIgl8aF2i0Ys+Cxj2QYVg2oQUza51aKjB
        1Rlau7TKweYeyMK5OBiu5rk5RA==
X-Google-Smtp-Source: AMsMyM5vwuJnEcgb+oJjdrutqKPUgnMnkL7oV0EsF7Id3Eo1xB7ssbTpF0sR0T/QyEeSoyQYY6aufA==
X-Received: by 2002:a05:620a:2627:b0:6b8:c8c3:78f9 with SMTP id z39-20020a05620a262700b006b8c8c378f9mr17894253qko.641.1667406328091;
        Wed, 02 Nov 2022 09:25:28 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a0bca00b006ce580c2663sm8862515qki.35.2022.11.02.09.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 09:25:27 -0700 (PDT)
Message-ID: <7aebd7a1-e9c7-d545-eb5b-dab622dce599@linaro.org>
Date:   Wed, 2 Nov 2022 12:25:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221026200429.162212-1-quic_molvera@quicinc.com>
 <20221026200429.162212-4-quic_molvera@quicinc.com>
 <ae4b2333-d243-17ee-1ebd-6b1c89eef9f3@linaro.org>
 <d109cbdf-1b0e-ff67-879c-d0955da4898e@quicinc.com>
 <5314f33d-dba0-ad86-0db8-9c1d16faec41@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5314f33d-dba0-ad86-0db8-9c1d16faec41@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2022 19:25, Melody Olvera wrote:
> 
> 
> On 10/31/2022 2:49 PM, Melody Olvera wrote:
>>
>> On 10/27/2022 8:21 AM, Krzysztof Kozlowski wrote:
>>> On 26/10/2022 16:04, Melody Olvera wrote:
>>>> Add the base DTSI files for QDU1000 and QRU1000 SoCs, including base
>>>> descriptions of CPUs, GCC, RPMHCC, QUP, TLMM, and interrupt-controller
>>>> to boot to shell with console on these SoCs.
>>>>
>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 1406 +++++++++++++++++++++++++
>>> Please use scripts/get_maintainers.pl to get a list of necessary people
>>> and lists to CC.  It might happen, that command when run on an older
>>> kernel, gives you outdated entries.  Therefore please be sure you base
>>> your patches on recent Linux kernel.
>> Sure thing; we talked about this on a different patch.
>>>>  arch/arm64/boot/dts/qcom/qru1000.dtsi |   27 +
>>>>  2 files changed, 1433 insertions(+)
>>>>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>>>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>>> new file mode 100644
>>>> index 000000000000..76474106e931
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>>> @@ -0,0 +1,1406 @@
>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>> +/*
>>>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + */
>>> (...)
>>>
>>>> +
>>>> +	soc: soc@0 {
>>>> +		#address-cells = <2>;
>>>> +		#size-cells = <2>;
>>>> +		ranges = <0 0 0 0 0x10 0>;
>>>> +		dma-ranges = <0 0 0 0 0x10 0>;
>>>> +		compatible = "simple-bus";
>>>> +
>>>> +		gcc: clock-controller@80000 {
>>>> +			compatible = "qcom,gcc-qdu1000", "syscon";
>>>> +			reg = <0x0 0x80000 0x0 0x1f4200>;
>>>> +			#clock-cells = <1>;
>>>> +			#reset-cells = <1>;
>>>> +			#power-domain-cells = <1>;
>>>> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
>>>> +			clock-names = "bi_tcxo", "sleep_clk";
>>>> +		};
>>>> +
>>>> +		gpi_dma0: dma-controller@900000  {
>>>> +			compatible = "qcom,sm6350-gpi-dma";
>>> You should add here a specific compatible as well. Same in other places.
>>> All places. I had impression we talked about this few times, so I don't
>>> know what is missing on your side.
>>>
>>> This must be:
>>> "qcom,qdu1000-gpi-dma", "qcom,sm6350-gpi-dma"
>> Got it. I talked to Stephan and he said either your suggestion or just using
>> preexisting compatibles would be ok. I thought it might be cleaner to not
>> have the qdu compats, but I'm fine either way.
> Coming back to this, it looks like this will fail dtb_check since compatible field is too long.
> Is there an adjustment to the binding which needs to be made here?

Every compatible must be documented, so yes, bindings needs changes.

Best regards,
Krzysztof

