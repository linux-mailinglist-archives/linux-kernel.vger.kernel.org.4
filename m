Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493EB6B0194
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCHIeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCHIdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:33:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031D450FB1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:33:15 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id da10so62586307edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678264392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ue0NqDmKrjgpyNEx5D7GNBoWR2ZdRspc55ofKNDbaw=;
        b=C8SNgoJ/P6E60Py0cw5PYuEs80mFIR9Wf8aoG4b95aZpDnbLg69MXom/fSLfaGO2GJ
         z6KDDfgc3PRo/Zd8r/pqWQR7cpQu7b/lZiScEgULeBDUn//+7nlC3bER3y+wP9aSKoS6
         qrLQtBuJQaqk+VbSb8FCnCOTESErvHfQPpPJ/L6xC5rKjfauETnj0cywgb44mK1rCTru
         kQoJLdqP2jPYPjUtNv80uO8iv/978zHV2n0qQc+klDnO3dGW0w8GKEhUOyqGL+vvcd/7
         nWgSxeVBVtBQ2I8d4Jb6IEkFG0M88Rg1RaRqxvTV8+YixtmOgWVu70F2Sgle64iKl5gq
         D58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678264392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ue0NqDmKrjgpyNEx5D7GNBoWR2ZdRspc55ofKNDbaw=;
        b=6RNZh44Ra1o2Hm+vyNrIVb/O/x9gSHu729GU8UTfIl88wl30NY8QSDV8GKuS8sKYAI
         Jkbc25Od5VX4/9kr+AqptGNECDrpEgTDipz9bisKBoUJy0NWibZFFqlQ3KOWTW1CxzCy
         XHWLMvFND9Lb3IzCyZ4UY+HAJZtqhrb94nbC5zE9BOH5veOe3IhLYYQLkZugr8wskFzp
         VPWm3ugFDbRsjtFnkWSruXGH8mw7Url16zvJx6NENiFeQG3SBE2ZUGWlLfutslmCEwjL
         6cExJL+QGO4Hd5fATUfV1BMnl1U8WnjRp5sCFEufI5ApucH+LhAVxgJUPYXmbSaSbdAZ
         hgaQ==
X-Gm-Message-State: AO0yUKWqf0DngHgjNxsAg3zJklFyKryMdJz4ojNl1ZMlz1AdT0lWiO5l
        rG2o4w+dktTJEiajpcSMbB9MZA==
X-Google-Smtp-Source: AK7set9nTlKFw37WTDFhuyvxUVC/TCbnN4R/TKLSbNeBQ/9zLgDXA9as1YOus3xU65mYSxvowAm8iQ==
X-Received: by 2002:a05:6402:687:b0:4ac:d90e:92b with SMTP id f7-20020a056402068700b004acd90e092bmr22535880edy.10.1678264391957;
        Wed, 08 Mar 2023 00:33:11 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:bba:fbfa:8aec:a133? ([2a02:810d:15c0:828:bba:fbfa:8aec:a133])
        by smtp.gmail.com with ESMTPSA id k26-20020a508ada000000b004af6b93f00asm7761947edk.23.2023.03.08.00.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 00:33:11 -0800 (PST)
Message-ID: <0c1ad8a7-a0a7-9a92-369c-3ede2ef82e58@linaro.org>
Date:   Wed, 8 Mar 2023 09:33:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 16/19] arm64: dts: qcom: sdm845: Add "mhi" region to the
 PCIe nodes
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
 <20230306153222.157667-17-manivannan.sadhasivam@linaro.org>
 <1587de60-244a-d97f-dea0-36fe8a5be2c2@linaro.org>
 <20230308083152.GD134293@thinkpad>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308083152.GD134293@thinkpad>
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

On 08/03/2023 09:31, Manivannan Sadhasivam wrote:
> On Tue, Mar 07, 2023 at 09:20:23AM +0100, Krzysztof Kozlowski wrote:
>> On 06/03/2023 16:32, Manivannan Sadhasivam wrote:
>>> The "mhi" region contains the debug registers that could be used to monitor
>>> the PCIe link transitions.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> index 479859bd8ab3..0104e77dd8d5 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> @@ -2280,10 +2280,11 @@ opp-4 {
>>>  		pcie0: pci@1c00000 {
>>>  			compatible = "qcom,pcie-sdm845";
>>>  			reg = <0 0x01c00000 0 0x2000>,
>>> +			      <0 0x01c07000 0 0x1000>,
>>>  			      <0 0x60000000 0 0xf1d>,
>>>  			      <0 0x60000f20 0 0xa8>,
>>>  			      <0 0x60100000 0 0x100000>;
>>> -			reg-names = "parf", "dbi", "elbi", "config";
>>> +			reg-names = "parf", "mhi", "dbi", "elbi", "config";
>>
>> Indexes are fixed, thus this breaks other users of DTS.
>>
> 
> Are you suggesting to move the "mhi" to the end and do not care about sorting?

Yes, any new entry must be added at the end. What sorting do you mean?
Entries are not sorted.


Best regards,
Krzysztof

