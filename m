Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C94564DF1B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiLOQ5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiLOQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:56:56 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64873D39C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:56:52 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NXz0g3Tpbz1S5C8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:56:51 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:from
        :references:to:content-language:subject:user-agent:mime-version
        :date:message-id; s=dkim; t=1671123408; x=1671987409; bh=tjNVkyH
        xOJqidYPV+BTvYS5ENh1t/1Ue/IBzdpA5tYw=; b=Kx5UdYsFpC98GCHU4ntG2Ys
        FA7ZQQx5vcwGM7ttxj55bVRUucqy1zj5mRjdLYVZG3z2GwODR2hRkIpBDmkYUi1S
        P+mRiHNQEWJothIotGeXD0/DbiR0OR1rOSCc21S7xvEO3mdeRQ/dZbl4t+cmhEWf
        S2gDfh+jGwdNG7alWv7JsdbKB2MUF8d6eC9n8xkX37qABrnAQjhQxiIqG/UEqj6w
        jet15wpYPiMpyNXGbxFzh/x74OUzBhPoMTq9Yvvb/B6kje8LKnMHweUUroYuKeOi
        p+FtXY0G8hwOEHXVHNekrS3JAc8Ml9etEeuVMo0BJoDTFOoEWRGQPMHIagmPuww=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6bljda2iFwH8 for <linux-kernel@vger.kernel.org>;
        Thu, 15 Dec 2022 11:56:48 -0500 (EST)
Received: from [192.168.4.25] (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NXz0X6DF6z1S4yj;
        Thu, 15 Dec 2022 11:56:44 -0500 (EST)
Message-ID: <0c53ff07-8cf4-3e80-97fc-67dd2f2612f9@mint.lgbt>
Date:   Thu, 15 Dec 2022 13:56:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221215161258.355962-1-they@mint.lgbt>
 <20221215161258.355962-2-they@mint.lgbt>
 <875bd0a8-fc08-1d19-2c75-65713d9d2317@linaro.org>
From:   Lux Aliaga <they@mint.lgbt>
In-Reply-To: <875bd0a8-fc08-1d19-2c75-65713d9d2317@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2022 13:18, Konrad Dybcio wrote:

> On 15.12.2022 17:12, Lux Aliaga wrote:
>> Adds a UFS host controller node and its corresponding PHY to
>> the sm6125 platform.
>>
>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>> ---
>>   arch/arm64/boot/dts/qcom/sm6125.dtsi | 66 ++++++++++++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>> index 7e25a4f85594..6d4534c7a2fe 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>> @@ -508,6 +508,72 @@ sdhc_2: mmc@4784000 {
>>   			status = "disabled";
>>   		};
>>   
>> +		ufs_mem_hc: ufs@4804000 {
>> +			compatible = "qcom,sm6125-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
>> +			reg = <0x04804000 0x3000>, <0x04810000 0x8000>;
>> +			reg-names = "std", "ice";
>> +			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
>> +			phys = <&ufs_mem_phy_lanes>;
>> +			phy-names = "ufsphy";
>> +			lanes-per-direction = <1>;
>> +			#reset-cells = <1>;
>> +			resets = <&gcc GCC_UFS_PHY_BCR>;
>> +			reset-names = "rst";
>> +
>> +			clock-names = "core_clk",
>> +				"bus_aggr_clk",
>> +				"iface_clk",
>> +				"core_clk_unipro",
>> +				"ref_clk",
>> +				"tx_lane0_sync_clk",
>> +				"rx_lane0_sync_clk",
>> +				"ice_core_clk";
>> +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
>> +				<&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>,
>> +				<&gcc GCC_UFS_PHY_AHB_CLK>,
>> +				<&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
>> +				<&rpmcc RPM_SMD_XO_CLK_SRC>,
>> +				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>> +				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>> +				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
>> +			freq-table-hz = <50000000 240000000>,
>> +				<0 0>,
>> +				<0 0>,
>> +				<37500000 150000000>,
>> +				<0 0>,
>> +				<0 0>,
>> +				<0 0>,
>> +				<75000000 300000000>;
> The indentation is wrong. Make sure your tab size is set to 8
> and all the <> entries align with the first one.
Should I do this with clocks and clock-names too?

-- 
Lux Aliaga
https://nixgoat.me/

