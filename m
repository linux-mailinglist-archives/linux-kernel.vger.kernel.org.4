Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1626526B6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiLTS62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbiLTS6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:58:12 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A53D1B78A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:58:03 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4Nc5S83KJxz1S5DD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 13:58:00 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:from
        :content-language:references:to:subject:user-agent:mime-version
        :date:message-id; s=dkim; t=1671562677; x=1672426678; bh=R2+Pnx7
        lc2xnheWr0dOtMgrXKsF57mIB5k5Bxij3rTw=; b=ycpPuxrjE6AyKvfLS/R+9t5
        Rx4NyRCRXhdXnF1kZLoYuIbMfRDIh5PnB+fBm3oJ/nGH2c0cGQ8woVIq0fGTMAch
        QZWyraXD9abTe0TADn7fXNH2O9FkAsS0/FX7sYM7rQp2t/nk6W2ugFp151aFKVEL
        jRrbaivJIgSBxmcHhlW3lnp+o6wKwvcnhh5wN3eNdEje4XcCebsM3BbWjPhj/fST
        q4AN2G4+12mV/sBD4RWitA/uhqI5ziWI+zP6fY9kD07aWoo0THnjDYXqYsl4t7VZ
        +7BVBYMw2NWphwLK5jXo5D8gkaLp/+5gsU6RysqBJrvwFVAmABlCvuXu43/e4nA=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6WipfFVxppjm for <linux-kernel@vger.kernel.org>;
        Tue, 20 Dec 2022 13:57:57 -0500 (EST)
Received: from [192.168.4.25] (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4Nc5S26pr6z1S51M;
        Tue, 20 Dec 2022 13:57:54 -0500 (EST)
Message-ID: <9c185e36-4342-0f8e-1816-494303ebd072@mint.lgbt>
Date:   Tue, 20 Dec 2022 15:57:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221215190404.398788-1-they@mint.lgbt>
 <20221215190404.398788-2-they@mint.lgbt>
 <e474f99d-2375-c8db-203c-632c918d8e4d@linaro.org>
Content-Language: en-US
From:   Lux Aliaga <they@mint.lgbt>
In-Reply-To: <e474f99d-2375-c8db-203c-632c918d8e4d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 08:24, Konrad Dybcio wrote:

>
> On 15.12.2022 20:04, Lux Aliaga wrote:
>> Adds a UFS host controller node and its corresponding PHY to
>> the sm6125 platform.
>>
>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>> ---
> Please include a changelog, I don't know what you changed and
> what you didn't. Also, you sent 4 revisions in one day, not
> letting others review it.
>
>
>>   arch/arm64/boot/dts/qcom/sm6125.dtsi | 67 ++++++++++++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>> index 7e25a4f85594..b64c5bc1452f 100644
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
> Krzysztof asked you to add a SoC-specific compatible in v1.
I'm working on adding a new compatible for sm6125's UFS PHY. Should I 
copy sm6115's tables or just reference them in the sm6125's config in 
drivers/phy/qualcomm/phy-qcom-qmp-ufs.c?

-- 
Lux Aliaga
https://nixgoat.me/

