Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7E6628F8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjAIOst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbjAIOsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:48:13 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C40C3FA39;
        Mon,  9 Jan 2023 06:45:50 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309CbxGK004467;
        Mon, 9 Jan 2023 15:45:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Ft+FrNhwgVL8bCzUNIUTmBwjxzeRiMl5KNxEZOw/h40=;
 b=qRPjGQFRny/bUNrDXQZ6OSYC0l6i8h0MJhjzrJt7GA4KOyUxup8swXl+eGKOOiOe/be9
 1rwYTc6kk7xNTKMHEOmi7/j3Z+jMnvGVR2Ja1xlM3xoOYiwg25skWrpJJru75vuVqI39
 WOj44qflYW7ujthorkwB2yWGSnY5fxrJJRejcokdXCqvzDSefYGP3YWCrDFctgqTCIv7
 +aMA4ZYzbP/zGeaKhk1mirGcpJprddaEF5/4v8aOa+mfPiiHiKchbyLyS6uqJ2fYIAAt
 gO51/e9Nfp8/smhy15/jNABir1zNnBL/bToac8c7GJdIe+VOyNwzBG98BdtgsJlMYhq3 qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3my0y6tvfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 15:45:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E8CAB10002A;
        Mon,  9 Jan 2023 15:45:12 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D8A5E220C50;
        Mon,  9 Jan 2023 15:45:12 +0100 (CET)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 9 Jan
 2023 15:45:11 +0100
Message-ID: <b2a88e83-2eac-7b58-4803-b020c0336e34@foss.st.com>
Date:   Mon, 9 Jan 2023 15:45:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RESEND RFC PATCH v5 3/5] ARM: dts: stm32: add CAN support on
 stm32f429
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, <michael@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230108162554.8375-1-dario.binacchi@amarulasolutions.com>
 <20230108162554.8375-4-dario.binacchi@amarulasolutions.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230108162554.8375-4-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_08,2023-01-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/23 17:25, Dario Binacchi wrote:
> Add support for bxcan (Basic eXtended CAN controller) to STM32F429. The
> chip contains two CAN peripherals, CAN1 the master and CAN2 the slave,
> that share some of the required logic like clock and filters. This means
> that the slave CAN can't be used without the master CAN.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> (no changes since v4)
> 
> Changes in v4:
> - Replace the node can@40006400 (compatible "st,stm32f4-bxcan-core")
>    with the gcan@40006600 node ("sysnode" compatible). The gcan node
>    contains clocks and memory addresses shared by the two can nodes
>    of which it's no longer the parent.
> - Add to can nodes the "st,gcan" property (global can memory) which
>    references the gcan@40006600 node ("sysnode compatibble).
> 
> Changes in v3:
> - Remove 'Dario Binacchi <dariobin@libero.it>' SOB.
> - Add "clocks" to can@0 node.
> 
>   arch/arm/boot/dts/stm32f429.dtsi | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index c31ceb821231..ce08872109b8 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -362,6 +362,35 @@ i2c3: i2c@40005c00 {
>   			status = "disabled";
>   		};
>   
> +		gcan: gcan@40006600 {
> +			compatible = "st,stm32f4-gcan", "syscon";
> +			reg = <0x40006600 0x200>;
> +			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN1)>;
> +		};
> +
> +		can1: can@40006400 {
> +			compatible = "st,stm32f4-bxcan";
> +			reg = <0x40006400 0x200>;
> +			interrupts = <19>, <20>, <21>, <22>;
> +			interrupt-names = "tx", "rx0", "rx1", "sce";
> +			resets = <&rcc STM32F4_APB1_RESET(CAN1)>;
> +			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN1)>;
> +			st,can-master;
> +			st,gcan = <&gcan>;
> +			status = "disabled";
> +		};

We try to keep ordering by address. Can you move can1 before gcan ?
Otherwise, it is ok for me.

> +
> +		can2: can@40006800 {
> +			compatible = "st,stm32f4-bxcan";
> +			reg = <0x40006800 0x200>;
> +			interrupts = <63>, <64>, <65>, <66>;
> +			interrupt-names = "tx", "rx0", "rx1", "sce";
> +			resets = <&rcc STM32F4_APB1_RESET(CAN2)>;
> +			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN2)>;
> +			st,gcan = <&gcan>;
> +			status = "disabled";
> +		};
> +
>   		dac: dac@40007400 {
>   			compatible = "st,stm32f4-dac-core";
>   			reg = <0x40007400 0x400>;

