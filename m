Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DF664E165
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiLOSyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiLOSyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:54:03 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FA54666A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:54:01 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 1so17122502lfz.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fWLzVy/UjP62SOghGlsb4BhhW+Tj4T8m11Npbmlrl9I=;
        b=WkdkYFD1Ufbuf8MJcf979R+l4T1zJKE+kz7eDNSr1V9FEbOatUy0v9YixpqzSfu2jw
         83mLIyH+VZNs1AdFuOlfijov2rxDYtxP+J8/hO3/OjQ+2RTdU3uOucaJWsYt1DvFLSF2
         oQl24/k4nJHRbkwooJ02qAVJUgwJWVaJrKdERWWU2mMn8Hvfhj6liEEZq89Nh69OYABd
         fqDYz8FQe/5XEqqEyq2FWoaTQlIW4m2d9VDfw16VPf1E0Rhu2Hb5sccDnl2rFWliM8qI
         Nuvx1uqOD/T7UAJFrILRKBOWtB5gcpmdan1gkwQIc7i4TxemrccQgFRmFEBQuL5QEHOT
         CmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWLzVy/UjP62SOghGlsb4BhhW+Tj4T8m11Npbmlrl9I=;
        b=OKIt0nBP9d+GCqWcJSWiVa+TORqxfcT/45iK3WHuIK/6OBOb5hfqUUk3xIEVkl2mYC
         6s1TV6FeU28263Z65FIx95CIVfqdSshlpW83UGu4vFpEIwucGABnnWMo+kZMCkQX7nfw
         /vuko7zx6bv9oS7HILJsjKiQI6HxfseWnGzBrIpnrTnK2ZzD/tHHuQE2r3Jny1Top/Ng
         1aICKtCmThQe/cr/niEveT88d1weSZZ7IqH2Ke7MnLEPRgc8OEbU8y3WFgGr0OT+UBhl
         X26qW3G6QtJQi4wXDKLNgyZZeVn9w1+FDe/ucEfzfuoby5f7uZxxjgbJDTldHuJk+7rM
         U+7A==
X-Gm-Message-State: ANoB5pnLHEGp7qBSVdvmpqn6wTMF8Pf8N1VcNz4kgxxxNMTDAWUQT8ZN
        3LS6JIrMsfp7EmevGWr6YMhRHA==
X-Google-Smtp-Source: AA0mqf7Vr8AVO/V6SDoyOHADl4vG/68vz/2MP/NJZPABzm+cJlnOzwOUuDpZJaGMvbaPDfAeAH9l5Q==
X-Received: by 2002:ac2:4215:0:b0:4b4:b5c1:77f3 with SMTP id y21-20020ac24215000000b004b4b5c177f3mr7595138lfh.16.1671130440055;
        Thu, 15 Dec 2022 10:54:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 10-20020ac25f4a000000b004bea5274fbfsm1558lfz.160.2022.12.15.10.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 10:53:59 -0800 (PST)
Message-ID: <fa818a64-4535-ba61-067c-e9f553c25726@linaro.org>
Date:   Thu, 15 Dec 2022 19:53:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221118192241.29384-1-quic_molvera@quicinc.com>
 <20221118192241.29384-3-quic_molvera@quicinc.com>
 <20221202033721.4slwz2utw5u6rv7b@builder.lan>
 <9e4e6149-bc24-b727-fff7-3fb7038fc066@quicinc.com>
 <5cd9e71c-8147-2ce1-b137-0342e271031b@linaro.org>
 <82620abd-105a-6ebc-ae58-e77fa058852b@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <82620abd-105a-6ebc-ae58-e77fa058852b@quicinc.com>
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

On 15/12/2022 18:56, Melody Olvera wrote:
> 
> 
> On 12/15/2022 12:44 AM, Krzysztof Kozlowski wrote:
>> On 14/12/2022 19:59, Melody Olvera wrote:
>>>>> +			#clock-cells = <0>;
>>>>> +		};
>>>>> +
>>>>> +		sleep_clk: sleep-clk {
>>>>> +			compatible = "fixed-clock";
>>>>> +			clock-frequency = <32000>;
>>>>> +			#clock-cells = <0>;
>>>>> +		};
>>>>> +
>>>>> +		pcie_0_pipe_clk: pcie-0-pipe-clk {
>>>> Afaict these clocks are not referenced anywhere, so please skip them.
>>> Yes, so I included them to be consistent with the bindings. They will be needed later;
>>> should I still remove?
>>>
>> If they are not referenced anywhere, how is it consistent with bindings?
>> Where do the bindings require defining such nodes?
> 
> These bindings here: https://lore.kernel.org/all/20221118181826.28269-2-quic_molvera@quicinc.com/
> I believe you commented that we either have these clocks or we don't, correct? I added them to
> the dt since these clocks exist and will be needed later when USB and PCIE nodes are added.
> As Konrad noted, these technically belong in the PHYs, but I was told to put stub fixed
> clocks instead here: https://lore.kernel.org/lkml/2c8c4642-8aee-3da3-7698-5e08b4c5894d@linaro.org/
> 
> How is this to be handled? Should I remove the clocks from the dt and the bindings and add them

This was a discussion about clock controller. You either have these
clocks as input of the clock controller or not. If you have - drop
minItems. If you do not have - trim the list to just two items.

What do you actually write in DTS is of course connected with the
bindings but separate problem. I was not referring to what should be or
should not be in DTS. We talked about clock controller and its inputs.

Best regards,
Krzysztof

