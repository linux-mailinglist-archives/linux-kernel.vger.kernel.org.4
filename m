Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFF671FA9D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbjFBHFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbjFBHEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:04:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3595B10E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:04:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96fdc081cb3so239653866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 00:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685689469; x=1688281469;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnQX0y9CucftjRft49d3HMPlBdEUnz94TDnE0qcYiJ8=;
        b=s6EvqgVxtO4TBZu0WwHgiMFZml20ChuVeE8PMA7UyEmuVlbEbmdnB/ols1Qg0V/bsm
         U7qvcR76k7KNGdEnpat3QPD9gQbN4ntl1E8F+4/F7otHawL/Qrw8dLep0BlYRpUowZv1
         JwBEalTrdoq4fSOXIderQuHNI0NUOfNXT/SU6qhOIWKZ/wMif3iqYPVgIOh3FM5mf3UQ
         P6KXMb304exvpzMwUd9bXbpQC1dpYVxSW6ppRwmLX1JXk4Wl7NT3r6oY8VLftXaDOdrm
         /4TxZdlJ5IEUbLr8xquB1aOjKn9gACXDhvPl4/vmTomZMDEMf0EKYB8XZFxJjL69vwjI
         hQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685689469; x=1688281469;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnQX0y9CucftjRft49d3HMPlBdEUnz94TDnE0qcYiJ8=;
        b=DYDB7XNn4VxO75UiMJf2shnhPNrC7zIr1rDG+wLodP6coSOBthr53IU3JT8LdiepKD
         zWFPE/bfRmebRg+ORkJiw+V5YPXYZxdX6f15TYPJeDIsMN/qp/8GDMlYk6tQ/AA/aV5q
         WIlA9Ms3jT0lclkgZec1xgt8gAi/QG4pVi+33kSz8t+xPnC4TxPGxgnOJPM553PuKnog
         UraqhWUpPZOuq8lNpVOV3I7dp3qFB+1exhhEoxfSJZm/A9acFIIwi76NxULaxWBicSrd
         6mxQbcK8t8mv0B1zj3bOrTKtJy3pfiWPK9BO6NVz+Av+Yf0m6sG/zUQc/RxEji9jUhKp
         C8Xg==
X-Gm-Message-State: AC+VfDzlPG5LM1hWv+r3xNoeAICTBtU6OKNqpdNpyRDcgUOSPDqnBUkT
        sJq9trCIuYqE7DbdUDTjKN08Tw==
X-Google-Smtp-Source: ACHHUZ5uGlEwXV94UmdP/Z9fWCmXFFhewyP4sS3Cx877kjsyOBbrr1YU/wJs7N49Oe5p5ZtfMuPs3g==
X-Received: by 2002:a17:907:3e9d:b0:96f:f451:1874 with SMTP id hs29-20020a1709073e9d00b0096ff4511874mr11116346ejc.59.1685689469543;
        Fri, 02 Jun 2023 00:04:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id z13-20020a170906240d00b0094e597f0e4dsm386722eja.121.2023.06.02.00.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 00:04:29 -0700 (PDT)
Message-ID: <201cb02b-b7b0-eecc-a9d5-3a7535c91d8d@linaro.org>
Date:   Fri, 2 Jun 2023 09:04:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RESEND 4/4] arm64: dts: qcom: ipq5332: add support for the
 RDP474 variant
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230601042054.29075-1-quic_kathirav@quicinc.com>
 <20230601042054.29075-5-quic_kathirav@quicinc.com>
 <91c63634-eb39-fdca-2c76-6f8182c2d47c@linaro.org>
 <2dd8e5be-c5b5-02e7-32d0-587a40cb70cc@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2dd8e5be-c5b5-02e7-32d0-587a40cb70cc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2023 06:05, Kathiravan T wrote:
> 
> On 6/1/2023 10:59 PM, Krzysztof Kozlowski wrote:
>> On 01/06/2023 06:20, Kathiravan T wrote:
>>> Add the initial device tree support for the Reference Design
>>> Platform(RDP) 474 based on IPQ5332 family of SoC. This patch carries
>>> the support for Console UART, eMMC, I2C and GPIO based buttons.
>>>
>>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/Makefile           |   1 +
>>>   arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts | 112 ++++++++++++++++++++
>>>   2 files changed, 113 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index 4f9e81253e18..0f8c763a9bd9 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-mi01.2.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp442.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp474.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
>>> new file mode 100644
>>> index 000000000000..085729a0fdf1
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
>>> @@ -0,0 +1,112 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * IPQ5332 RDP474 board device tree source
>>> + *
>>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/input/input.h>
>>> +#include "ipq5332.dtsi"
>>> +
>>> +/ {
>>> +	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.9";
>>> +	compatible = "qcom,ipq5332-ap-mi01.9", "qcom,ipq5332";
>>> +
>>> +	aliases {
>>> +		serial0 = &blsp1_uart0;
>>> +	};
>>> +
>>> +	chosen {
>>> +		stdout-path = "serial0";
>>> +	};
>>> +
>>> +	gpio_keys {
>> No, srsly, so not only ignored the tags but also feedback?
> 
> 
> Please correct me if I am wrong here..
> 
> This is RESEND of V1 patches (only minor correction in the subject line

I sent you three emails and I assumed you got my feedback, thus it
should not have been resend...


> in cover letter). Also I don't see review comments as such in original 
> V1 as well 
> https://lore.kernel.org/linux-arm-msm/20230531135048.19164-1-quic_kathirav@quicinc.com/
> 
> Can you help to point out your review comments, I couldn't able to find out.

... but I don't see them on lore. So apparently you also did not get them.

I apologize in such case. Mails are nicely sent in my outbox but
apparently went to /dev/null.

Original feedback:

Same problems as with most of recent patches. No underscores in node names.

Best regards,
Krzysztof

