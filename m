Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC0164E10A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiLOShT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiLOSgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:36:45 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989254A5B1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:35:03 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id cf42so17041458lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJWfZA9lb6SueW3DXeKSzLEsUDmmTJCRV+wmNHW5G+U=;
        b=pEtuWDXdRArr5c+XNWAICkBVcAvET7Xs8sxEpuSppouXY0ZuoJltHg9nkUS4K4S503
         752k+xKl53pB9UDDwr3vYiqV/WGfVbWqi/v9vRmWTldArfbeTzrZ77060VBpOjkh6KEW
         rkA6rSA1cDxeyPP8wlgt5GP7bBqM7v6DcWQiPACNXopkAKod5BsN2rtj9p2Y6eKsmCZP
         0frgsTjGNUGJ8GXRgtN4cvkEh8Ww07NMQceVmJnEMfiTR3TC80sicCDXq9t7ry9L1HPT
         XfgNdSS5T8JHZhR+Qg1oCLPftjVsG3cZxC9YLp/77XI9XWrYqj3/BhUmDtXyaaBWm4H0
         DUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJWfZA9lb6SueW3DXeKSzLEsUDmmTJCRV+wmNHW5G+U=;
        b=K0WEtRqRvfXxPgaZUm7CuFeI/IpKSAkQFXQwpMAT9xXdpC1v9qpldj5hrujVFDjP6Q
         GQh3Cr5QrzrSSO6tWWPinDtmWwqN+jK73iBtfNXuRr7Kdw9okkSCakNGNlZfuvsc8d6+
         3RVkdZrL6qOD3GD7myoBcstxLEyCRFR7aF4WDT8G7BBPh9furN0sfQGHgGSzTZzzlkT9
         w0G+XInTgsU0WaBmxI32ce7kYTRAgcE6PKCWnB/Pp3aaqds+C12c/fIgQhOhliEMAPGc
         slhwpglc+aplZwHZRs1Qxt/+e8eOH5MJfWsuBf9EVBPYdD/DvEr9nRRLeLRIMot+RIoA
         bqDw==
X-Gm-Message-State: ANoB5pnFh4RypAJaIA5w9CzoQtXFvnD7W1VVwwZ98Oau/DLnzRQ+Do9e
        X/UkdzGSOWmn3+fuldzKrgrPJA==
X-Google-Smtp-Source: AA0mqf6X7yI3BJ7QJ1ceRqBxVWmBUaKE0UClqb9c/OeJxiMbSt8YocWwwaRUjGqMzVcswKV1ZyZcGw==
X-Received: by 2002:ac2:52b1:0:b0:4b5:7859:349f with SMTP id r17-20020ac252b1000000b004b57859349fmr8137842lfm.48.1671129302028;
        Thu, 15 Dec 2022 10:35:02 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id g12-20020ac24d8c000000b004b0b2212315sm1231966lfe.121.2022.12.15.10.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 10:35:01 -0800 (PST)
Message-ID: <d387f52b-5c3e-9e3f-c5b9-4201a622abaf@linaro.org>
Date:   Thu, 15 Dec 2022 19:34:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221215182412.386064-1-they@mint.lgbt>
 <20221215182412.386064-2-they@mint.lgbt>
 <7c6dc327-9cc3-ca00-479b-25b1f6e071dc@linaro.org>
 <8dcbd512-7f3b-919f-34ec-82e28b6282d3@mint.lgbt>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <8dcbd512-7f3b-919f-34ec-82e28b6282d3@mint.lgbt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.12.2022 19:33, Lux Aliaga wrote:
> 
> On 15/12/2022 15:28, Konrad Dybcio wrote:
>> On 15.12.2022 19:24, Lux Aliaga wrote:
>>> Adds a UFS host controller node and its corresponding PHY to
>>> the sm6125 platform.
>>>
>>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm6125.dtsi | 67 ++++++++++++++++++++++++++++
>>>   1 file changed, 67 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>> index 7e25a4f85594..22c945d5fc7a 100644
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
>>> +            reg = <0x04807000 0x1c4>;
>>> +
>>> +            power-domains = <&gcc UFS_PHY_GDSC>;
>>> +
>>> +            clock-names = "ref", "ref_aux";
>>> +            clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
>>> +                     <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
>>> +
>>> +            resets = <&ufs_mem_hc 0>;
>>> +            reset-names = "ufsphy";
>>> +            status = "disabled";
>>> +
>>> +            ufs_mem_phy_lanes: lanes@4807400 {
>>> +                reg = <0x4807400 0x098>,
>>> +                      <0x4807600 0x130>,
>>> +                      <0x4807c00 0x16c>;
>>> +                #phy-cells = <0>;
>>> +            };
>>> +
>>> +            #address-cells = <1>;
>>> +            #size-cells = <1>;
>>> +            ranges;
>> That won't compile. Properties must precede subnodes.
>>
>> Konrad
> Wait, so should I move it above the status property?
Status should be the last *property*.

If I'm not mistaken, this will not even compile as-is..

Konrad
> 
