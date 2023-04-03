Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812066D3ECD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjDCIVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjDCIVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:21:08 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746B1CC1D;
        Mon,  3 Apr 2023 01:21:02 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3338Cknt009821;
        Mon, 3 Apr 2023 10:20:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=XfKJ4SP0q3Vew9pXOdqeZ9jxwSNU33PvIQahCWw37Ac=;
 b=bXh5/HXgXU6a69YrRERFLTo/38ln2NWs+HrkRwGEYbKMvDsgMUkgQvdoZ8fv71qFTRH3
 ++2iz8662ZgL0bJcuZAIxDcHG6xbWdUnsw21YSEkRX9gFQXvf85M6G2SqAikAytcuo0v
 txjZ6/zzkeHL3uu/7xxpmG4Aak5Szk36FEoZrQ6UcsnxQUQmucGuhtfeeFgYh152y3py
 DYZjENdmHnc18rO5uG7XUTL+7qi9MMG8oNC3lWqH3ATj10FC4Xe4+ftZB6MlUhmxJ7cO
 hN/h9O3mJugeF2O91PhJaQFL2W+eysjpGYitR/0UWHDq+tR6KKTWDtJhWQVOWXwyqOqv AQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pqu38r1w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 10:20:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DCB53100034;
        Mon,  3 Apr 2023 10:20:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D30CB212FA9;
        Mon,  3 Apr 2023 10:20:51 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 3 Apr
 2023 10:20:51 +0200
Message-ID: <fa36c2bc-c617-014e-fb11-d7621be866a0@foss.st.com>
Date:   Mon, 3 Apr 2023 10:20:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] ARM: dts: stm32: add FMC support on STM32MP13x SoC
 family
Content-Language: en-US
To:     Christophe Kerello <christophe.kerello@foss.st.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230328170711.247745-1-christophe.kerello@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230328170711.247745-1-christophe.kerello@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_05,2023-03-31_01,2023-02-09_01
X-Spam-Status: No, score=-3.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi christophe

On 3/28/23 19:07, Christophe Kerello wrote:
> Add FMC support on STM32MP13x SoC family.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> ---


Applied on stm32-next.

Thanks.
Alex

> Changes in v2:
>   - compatible, reg and ranges properties have been moved at the top of each node
> 
>   arch/arm/boot/dts/stm32mp131.dtsi | 33 +++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
> index 9ea61687f023..7ea1fe0cd070 100644
> --- a/arch/arm/boot/dts/stm32mp131.dtsi
> +++ b/arch/arm/boot/dts/stm32mp131.dtsi
> @@ -1232,6 +1232,39 @@ mdma: dma-controller@58000000 {
>   			dma-requests = <48>;
>   		};
>   
> +		fmc: memory-controller@58002000 {
> +			compatible = "st,stm32mp1-fmc2-ebi";
> +			reg = <0x58002000 0x1000>;
> +			ranges = <0 0 0x60000000 0x04000000>, /* EBI CS 1 */
> +				 <1 0 0x64000000 0x04000000>, /* EBI CS 2 */
> +				 <2 0 0x68000000 0x04000000>, /* EBI CS 3 */
> +				 <3 0 0x6c000000 0x04000000>, /* EBI CS 4 */
> +				 <4 0 0x80000000 0x10000000>; /* NAND */
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			clocks = <&rcc FMC_K>;
> +			resets = <&rcc FMC_R>;
> +			status = "disabled";
> +
> +			nand-controller@4,0 {
> +				compatible = "st,stm32mp1-fmc2-nfc";
> +				reg = <4 0x00000000 0x1000>,
> +				      <4 0x08010000 0x1000>,
> +				      <4 0x08020000 0x1000>,
> +				      <4 0x01000000 0x1000>,
> +				      <4 0x09010000 0x1000>,
> +				      <4 0x09020000 0x1000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&mdma 24 0x2 0x12000a02 0x0 0x0>,
> +				       <&mdma 24 0x2 0x12000a08 0x0 0x0>,
> +				       <&mdma 25 0x2 0x12000a0a 0x0 0x0>;
> +				dma-names = "tx", "rx", "ecc";
> +				status = "disabled";
> +			};
> +		};
> +
>   		sdmmc1: mmc@58005000 {
>   			compatible = "st,stm32-sdmmc2", "arm,pl18x", "arm,primecell";
>   			arm,primecell-periphid = <0x20253180>;


