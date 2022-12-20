Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C9C652718
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiLTTdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiLTTdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:33:09 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5F41E3FA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:32:44 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bp15so20107378lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mdum3ASsDZJVSBVTfiI3cFyg/lFTrN1LUC9FLkDQJq8=;
        b=gysPflQ3Dudbc0ydciRVmEjBZ3UAY70FpTbtRgh8VmOOC+rWcu6nz0zw973I46Y/j0
         +1rkdHjrqAXDyZuypgPs4Ouw1QYHbW0AOWYVyi3J8xRQlhNlLiR2dgoSl0kFZFSqq2jf
         za6505KPlo54bMFncMq37I26dFpgR1uWfF6d6OTo++XCZFVTbBAVczanuTQm4mQ4CK0m
         0D6eQBcrLU+MlKxpSvb70bht8tunEr/0+rs68Q4cGnMjdwG3/QJIuqNGHQcfvg+yJ08M
         y5tI1rMU9wRyBBIvf/QQbMVCvlxn7EWhdXx9JYyFm9yEZ2k8FgMeJE5ChHRynT9kzZ05
         yRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdum3ASsDZJVSBVTfiI3cFyg/lFTrN1LUC9FLkDQJq8=;
        b=gGpkzW9OgJLpozSyg5T/KbAipEM9bZkd/oZu4jZTsiqx1IhCbhLxPsol6XdnSXelB1
         NF0EmKSOWspQrAHLq2S1xl/w9gI0vriYTf/MMU0Vkw2UCaV+yaC3x6ai9/PxG4WS7nr5
         pwCd4jJsovpgYKVri8yXLor5bxNuLbhBGSnE9kUFZdL+74325NyvoPqvIqOS22o1QRA4
         2X3D+gcagsnqhSPdA3il6WAHRndnHUmC9cPTYt53LnSoa9YVeRbOeXNpC4TY/RPVzjHG
         ETD9FbvPjY7qvdaNYrVTYHkiSwkZVb6/d4OKj83W5+0TY5GfQvtQQqRSiKURg4h/8Mby
         qrNg==
X-Gm-Message-State: ANoB5pmw9U7/xNfuRwQt7SavoE9uFLLmx3LHUyJQylqXymxP/xn8392u
        za0hKV39oKc7CpNaEi31Fsp9Dw==
X-Google-Smtp-Source: AA0mqf58yoyhTkjIdRF2KWzIBQLlNZ1jpgVI1TAyr+07fJE0lcHEM7+R1GTWivzPGEiU0gYi1dIj4w==
X-Received: by 2002:a05:6512:21ce:b0:4aa:f1f2:ad7a with SMTP id d14-20020a05651221ce00b004aaf1f2ad7amr12640886lft.49.1671564763280;
        Tue, 20 Dec 2022 11:32:43 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id u2-20020ac24c22000000b004979db5aa5bsm1568212lfq.223.2022.12.20.11.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 11:32:42 -0800 (PST)
Message-ID: <66140726-0771-a28b-4916-cc3aef569cab@linaro.org>
Date:   Tue, 20 Dec 2022 20:32:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221215190404.398788-1-they@mint.lgbt>
 <20221215190404.398788-2-they@mint.lgbt>
 <e474f99d-2375-c8db-203c-632c918d8e4d@linaro.org>
 <9c185e36-4342-0f8e-1816-494303ebd072@mint.lgbt>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <9c185e36-4342-0f8e-1816-494303ebd072@mint.lgbt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.12.2022 19:57, Lux Aliaga wrote:
> On 16/12/2022 08:24, Konrad Dybcio wrote:
> 
>>
>> On 15.12.2022 20:04, Lux Aliaga wrote:
>>> Adds a UFS host controller node and its corresponding PHY to
>>> the sm6125 platform.
>>>
>>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>>> ---
>> Please include a changelog, I don't know what you changed and
>> what you didn't. Also, you sent 4 revisions in one day, not
>> letting others review it.
>>
>>
>>>   arch/arm64/boot/dts/qcom/sm6125.dtsi | 67 ++++++++++++++++++++++++++++
>>>   1 file changed, 67 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>> index 7e25a4f85594..b64c5bc1452f 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>> @@ -508,6 +508,73 @@ sdhc_2: mmc@4784000 {
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
>>> +                      "bus_aggr_clk",
>>> +                      "iface_clk",
>>> +                      "core_clk_unipro",
>>> +                      "ref_clk",
>>> +                      "tx_lane0_sync_clk",
>>> +                      "rx_lane0_sync_clk",
>>> +                      "ice_core_clk";
>>> +            clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
>>> +                 <&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>,
>>> +                 <&gcc GCC_UFS_PHY_AHB_CLK>,
>>> +                 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
>>> +                 <&rpmcc RPM_SMD_XO_CLK_SRC>,
>>> +                 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>>> +                 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>>> +                 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
>>> +            freq-table-hz = <50000000 240000000>,
>>> +                    <0 0>,
>>> +                    <0 0>,
>>> +                    <37500000 150000000>,
>>> +                    <0 0>,
>>> +                    <0 0>,
>>> +                    <0 0>,
>>> +                    <75000000 300000000>;
>>> +
>>> +            non-removable;
>>> +            status = "disabled";
>>> +        };
>>> +
>>> +        ufs_mem_phy: phy@4807000 {
>>> +            compatible = "qcom,sm6115-qmp-ufs-phy";
>> Krzysztof asked you to add a SoC-specific compatible in v1.
> I'm working on adding a new compatible for sm6125's UFS PHY. Should I copy sm6115's tables or just reference them in the sm6125's config in drivers/phy/qualcomm/phy-qcom-qmp-ufs.c?
If they're identical, you can just do something like this:

compatible = "qcom,sm6125-qmp-ufs-phy", "qcom,sm6115-qmp-ufs-phy";

And ensure your newly added compatible is documented in bindings.
This way, the driver will fall back to the 6115 compatible that's
defined in .c, but if we ever need to adjust something specific
for 6125, we will just use the define that we added here. That's
important, as we're supposed to stay backwards-compatible with
old device trees.

Also, wrap your emails at around 80 chars or so, some people
are grumpy about that :P

Konrad
> 
