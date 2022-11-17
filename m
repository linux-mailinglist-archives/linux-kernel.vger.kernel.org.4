Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E2262D528
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbiKQIjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiKQIjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:39:39 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426D3E9B;
        Thu, 17 Nov 2022 00:39:37 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH3t39G012367;
        Thu, 17 Nov 2022 09:39:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Qq3kXihqfEk1AIbvKZAImcsB1VgZAEaIMZ7JwZWPYJc=;
 b=oJ/i4ZLEOnxBgb3yKj8+Mc1Uzcw/tSTF5EjuEIuzDhtiQ7JEIsJJqoZ56aJAoYEDoIev
 ey1oaTRxGb4a4Sc1iaKmiSo8nUaMrA3aAMAjuR+vhPFRqUFWtLUzzwirQEtp3GCcLMtc
 bTAvBDX23geApSfhLH010rllAZcWOTKTtT0dVuB03G7g4d7OXTBP92dn3Pv7Wk4N25qu
 HaeW0VuDKt8LQ4W1I4eZq5g0jjch+1z5Uoa/2aE6y/wenFtTE/fAmq1F4A8RoKqQ+eL7
 7KbxwTYlAJLv0Y9F4cEuPmOK8sIpDYtSuNLztXE2wLUW3WWKJEAEHypYm2QL2Hvrveuv qQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kv9ydnc4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 09:39:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6E62F10003A;
        Thu, 17 Nov 2022 09:39:07 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 68605216ED8;
        Thu, 17 Nov 2022 09:39:07 +0100 (CET)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Thu, 17 Nov
 2022 09:39:06 +0100
Message-ID: <04c725a0-1382-10e7-8404-992aad007f78@foss.st.com>
Date:   Thu, 17 Nov 2022 09:39:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] ARM: dts: stm32: add mcp23017 IO expander on I2C1 on
 stm32mp135f-dk
Content-Language: en-US
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221024094648.145251-2-amelie.delaunay@foss.st.com>
 <20221024094648.145251-3-amelie.delaunay@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20221024094648.145251-3-amelie.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_04,2022-11-16_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie

On 10/24/22 11:46, Amelie Delaunay wrote:
> MCP23017 is an IO expander offering 16 input/output port expander with
> interrupt output.
> On stm32mp135f-dk, only INTA is routed (on PG12), but MCP23017 can mirror
> the bank B interrupts on INTA, that's why the property microchip,irq-mirror
> is used.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp135f-dk.dts | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
> index a87ab067c955..d5fc6462ba33 100644
> --- a/arch/arm/boot/dts/stm32mp135f-dk.dts
> +++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
> @@ -112,6 +112,20 @@ &i2c1 {
>   	/* spare dmas for other usage */
>   	/delete-property/dmas;
>   	/delete-property/dma-names;
> +
> +	mcp23017: pinctrl@21 {
> +		compatible = "microchip,mcp23017";
> +		reg = <0x21>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gpiog>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcp23017_pins_a>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		microchip,irq-mirror;
> +	};
>   };
>   
>   &i2c5 {

Both patches applied on stm32-next.

thanks
Alex
