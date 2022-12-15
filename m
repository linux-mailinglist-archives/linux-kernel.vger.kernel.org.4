Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AFC64E02A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiLOSCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiLOSCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:02:35 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F83E45EC1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:02:34 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id z26so16889040lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpKy2M+1xTceyI06vSLlckoJe7LD35YbU+PTPi0rKDM=;
        b=YjH5xlGT3cTRpULF/LGszL0dl2Cw4WpBjvowxr58+hoevF3Wvac6hRkNwnbI86v103
         c5aYwS/yIWSV9i3iYSr4zprpgEcV1mPtAoo649RBsoYK8EvlL6XOBtJ1j19k9F6EWUzB
         F7fHMuD3qmbtiX2irY445IMjEajhjZ5AS4werdMOJdXtNeT2viE8rlTilJbdImBP3sS+
         kz6YtbLTRvrqFATRm4KI7K1D3OvLRgtKdayqAEphXTBvxQxwSQW6lNRRMqmEb6KT7xK/
         /YZVNF1pU2OuIn2COPd94tzC0bKR4x2VUcFvJMc59MR0nB6N2ijDtUKFKPLwzhUKVknE
         bSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpKy2M+1xTceyI06vSLlckoJe7LD35YbU+PTPi0rKDM=;
        b=BSKYSUrirLY+hHsO46llnH4jJpJ87+dhPHk+wtjoKSMAmuZKPIx00AlfH4LkQQiypj
         7okucWyRCdvkntRTVepa97fEM5ZA8hQFfsS+lnmDQ38O81vFgMqbfKlNzPUvjdq9l0tP
         Dpam1pFS29B5CTsjtYLgCkGWTrYyYUvg0afUenCkUKqwOvCc32+i1cgRYRx0g8pfZ/3c
         UItq3+e81AzrW0zlVepfHVaVrpUDMlwq1jkj8bEUh1fEqF72/jHaUXh3Vxj4GoolQPga
         oydn4MC1jsS/5q99bLtpNLrY82h+8p291vmeuglno62NB7NXdVnvTQn/feJHApfbZ0hj
         hK6w==
X-Gm-Message-State: ANoB5pmrRTDNl3myzIeYGKT2PtJj8r3DqMiAx3+sjwZDnsIIRcmbD5ZY
        jaf3+DeVcMwAFLlaHmBincwD8KkZ2pRs4373
X-Google-Smtp-Source: AA0mqf7n5rAlsQjQNz3aAcI4rjK0IqOpQADETQT00LwtKjvbTYtLF3Grp2vDJKTL/L4qJajpkFwwpA==
X-Received: by 2002:ac2:4474:0:b0:4b5:9365:cd4f with SMTP id y20-20020ac24474000000b004b59365cd4fmr7640127lfl.42.1671127352250;
        Thu, 15 Dec 2022 10:02:32 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id g7-20020a19e047000000b004b58fadba35sm1221068lfj.296.2022.12.15.10.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 10:02:31 -0800 (PST)
Message-ID: <ab5d99c0-d5a8-d144-6153-27116e20442c@linaro.org>
Date:   Thu, 15 Dec 2022 19:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221215161258.355962-1-they@mint.lgbt>
 <20221215161258.355962-2-they@mint.lgbt>
 <875bd0a8-fc08-1d19-2c75-65713d9d2317@linaro.org>
 <0c53ff07-8cf4-3e80-97fc-67dd2f2612f9@mint.lgbt>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <0c53ff07-8cf4-3e80-97fc-67dd2f2612f9@mint.lgbt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.12.2022 17:56, Lux Aliaga wrote:
> On 15/12/2022 13:18, Konrad Dybcio wrote:
> 
>> On 15.12.2022 17:12, Lux Aliaga wrote:
>>> Adds a UFS host controller node and its corresponding PHY to
>>> the sm6125 platform.
>>>
>>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm6125.dtsi | 66 ++++++++++++++++++++++++++++
>>>   1 file changed, 66 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>> index 7e25a4f85594..6d4534c7a2fe 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>> @@ -508,6 +508,72 @@ sdhc_2: mmc@4784000 {
>>>               status = "disabled";
>>>           };
>>>   +        ufs_mem_hc: ufs@4804000 {
>>> +            compatible = "qcom,sm6125-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
>>> +            reg = <0x04804000 0x3000>, <0x04810000 0x8000>;
>>> +            reg-names = "std", "ice";
>>> +            interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
>>> +            phys = <&ufs_mem_phy_lanes>;
>>> +            phy-names = "ufsphy";
>>> +            lanes-per-direction = <1>;
>>> +            #reset-cells = <1>;
>>> +            resets = <&gcc GCC_UFS_PHY_BCR>;
>>> +            reset-names = "rst";
>>> +
>>> +            clock-names = "core_clk",
>>> +                "bus_aggr_clk",
>>> +                "iface_clk",
>>> +                "core_clk_unipro",
>>> +                "ref_clk",
>>> +                "tx_lane0_sync_clk",
>>> +                "rx_lane0_sync_clk",
>>> +                "ice_core_clk";
>>> +            clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
>>> +                <&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>,
>>> +                <&gcc GCC_UFS_PHY_AHB_CLK>,
>>> +                <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
>>> +                <&rpmcc RPM_SMD_XO_CLK_SRC>,
>>> +                <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>>> +                <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>>> +                <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
>>> +            freq-table-hz = <50000000 240000000>,
>>> +                <0 0>,
>>> +                <0 0>,
>>> +                <37500000 150000000>,
>>> +                <0 0>,
>>> +                <0 0>,
>>> +                <0 0>,
>>> +                <75000000 300000000>;
>> The indentation is wrong. Make sure your tab size is set to 8
>> and all the <> entries align with the first one.
> Should I do this with clocks and clock-names too?
Yes, every "vertical list" (for a lack of a better name)
should be aligned. Add as many tabs as you can and fill
the rest with spaces.

Konrad
> 
