Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC6164E100
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiLOSgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiLOSfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:35:51 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B7D4A580
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:33:47 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NY18T3YJcz1S5Bt
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:33:45 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:from
        :references:to:content-language:subject:user-agent:mime-version
        :date:message-id; s=dkim; t=1671129223; x=1671993224; bh=zq0wJA+
        uw2/UuwZZAHpcTG2o9sgVhCyXWE5LQWXtoOo=; b=jIB89H4iBOhR9+qqjHCALrP
        wS7fKIe9lgLuxu6ykHqKewn5nLbZsChqa2DL9z0EFSJtzZRJQOuVGigAOanMJ5mX
        XNpszi1ldGFJM0NsezgNcNHcHNQGXQ8y/GhWbECjMxurByjQiT/KBd9UXZnFzLjm
        Lz+saeLa6+SzCPpwjy3/gZ62jtjLBFYtlMV0gBq1kMFsj9NDxhkfcMeoH2RmTcwM
        U+L1eKJEBES06d5IWEgUepatPAxccWA5Jm5+dgeGI2XlEaRh7+qoIfxAzI5oRg+a
        IxkJTT2F8sQJePvMTNSSZUrvcOv9TYaHyL8xs4Vyl0uTbD3KPbQpSPjYX9TX+ZA=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DFl81FXJFNmM for <linux-kernel@vger.kernel.org>;
        Thu, 15 Dec 2022 13:33:43 -0500 (EST)
Received: from [192.168.4.25] (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NY18M6cYyz1S4tN;
        Thu, 15 Dec 2022 13:33:39 -0500 (EST)
Message-ID: <8dcbd512-7f3b-919f-34ec-82e28b6282d3@mint.lgbt>
Date:   Thu, 15 Dec 2022 15:33:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221215182412.386064-1-they@mint.lgbt>
 <20221215182412.386064-2-they@mint.lgbt>
 <7c6dc327-9cc3-ca00-479b-25b1f6e071dc@linaro.org>
From:   Lux Aliaga <they@mint.lgbt>
In-Reply-To: <7c6dc327-9cc3-ca00-479b-25b1f6e071dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/12/2022 15:28, Konrad Dybcio wrote:
> On 15.12.2022 19:24, Lux Aliaga wrote:
>> Adds a UFS host controller node and its corresponding PHY to
>> the sm6125 platform.
>>
>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>> ---
>>   arch/arm64/boot/dts/qcom/sm6125.dtsi | 67 ++++++++++++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>> index 7e25a4f85594..22c945d5fc7a 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>> @@ -508,6 +508,73 @@ sdhc_2: mmc@4784000 {
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
>> +				      "bus_aggr_clk",
>> +				      "iface_clk",
>> +				      "core_clk_unipro",
>> +				      "ref_clk",
>> +				      "tx_lane0_sync_clk",
>> +				      "rx_lane0_sync_clk",
>> +				      "ice_core_clk";
>> +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
>> +				 <&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>,
>> +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
>> +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
>> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>,
>> +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>> +				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
>> +			freq-table-hz = <50000000 240000000>,
>> +					<0 0>,
>> +					<0 0>,
>> +					<37500000 150000000>,
>> +					<0 0>,
>> +					<0 0>,
>> +					<0 0>,
>> +					<75000000 300000000>;
>> +
>> +			non-removable;
>> +			status = "disabled";
>> +		};
>> +
>> +		ufs_mem_phy: phy@4807000 {
>> +			compatible = "qcom,sm6115-qmp-ufs-phy";
>> +			reg = <0x04807000 0x1c4>;
>> +
>> +			power-domains = <&gcc UFS_PHY_GDSC>;
>> +
>> +			clock-names = "ref", "ref_aux";
>> +			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
>> +					 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
>> +
>> +			resets = <&ufs_mem_hc 0>;
>> +			reset-names = "ufsphy";
>> +			status = "disabled";
>> +
>> +			ufs_mem_phy_lanes: lanes@4807400 {
>> +				reg = <0x4807400 0x098>,
>> +				      <0x4807600 0x130>,
>> +				      <0x4807c00 0x16c>;
>> +				#phy-cells = <0>;
>> +			};
>> +
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
> That won't compile. Properties must precede subnodes.
>
> Konrad
Wait, so should I move it above the status property?

-- 
Lux Aliaga
https://nixgoat.me/

