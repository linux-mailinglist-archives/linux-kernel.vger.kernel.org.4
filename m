Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C326D4075
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjDCJXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjDCJXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:23:48 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E936A44BE;
        Mon,  3 Apr 2023 02:23:28 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3338pK5d019557;
        Mon, 3 Apr 2023 11:23:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=YjNvltbkqwv0GajfCzB3caqZQqY82G0xYqYSg7vFACs=;
 b=RlIIgGiDacMsSyG2Gyy5QT6mHHaCKkUMyzJapbg641ACmQQQFDHc5ssGcxW1jM14dG0Q
 4gMZ5C2mDaXBW1KGS5Lz68NG17bgrjRag0nxFOHcIlotw4z9YO+vr+eadH5rbL5y7g+k
 wXKMGC+OHqr0WH36sRXgOvrbfftQKre4bcr5+LAtDbQgV+yXZQWsezXaw2ZDv9DcoYbQ
 b+9oSQS59LF1CACM3dHvT3SRD8iVZ9BNifTfqXE1Q2DbxKlmjbffcRpDZQaTWd3EiY5t
 J8dn4qEfgyLm8iDM8kUQeWHfuvcmUazwea8ciFOomEyxFSrfl1+aINvXZX38y6aT0RqH Mg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pqunhg8j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 11:23:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 099E310002A;
        Mon,  3 Apr 2023 11:23:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 300802138D4;
        Mon,  3 Apr 2023 11:23:17 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 3 Apr
 2023 11:23:16 +0200
Message-ID: <f4721c8a-d4f0-d391-b9c9-d1a8cf5538b4@foss.st.com>
Date:   Mon, 3 Apr 2023 11:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ARM: dts: stm32: Add QSPI support on STM32MP13x SoC
 family
To:     <patrice.chotard@foss.st.com>, <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230331071907.4127388-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230331071907.4127388-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_06,2023-03-31_01,2023-02-09_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Patrice

On 3/31/23 09:19, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Add QSPI support on STM32MP13x SoC family
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp131.dtsi | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
> index 5949473cbbfd..544c755b6e67 100644
> --- a/arch/arm/boot/dts/stm32mp131.dtsi
> +++ b/arch/arm/boot/dts/stm32mp131.dtsi
> @@ -1137,6 +1137,21 @@ mdma: dma-controller@58000000 {
>   			dma-requests = <48>;
>   		};
>   
> +		qspi: spi@58003000 {
> +			compatible = "st,stm32f469-qspi";
> +			reg = <0x58003000 0x1000>, <0x70000000 0x10000000>;
> +			reg-names = "qspi", "qspi_mm";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&mdma 26 0x2 0x10100002 0x0 0x0>,
> +			       <&mdma 26 0x2 0x10100008 0x0 0x0>;
> +			dma-names = "tx", "rx";
> +			clocks = <&rcc QSPI_K>;
> +			resets = <&rcc QSPI_R>;
> +			status = "disabled";
> +		};
> +
>   		sdmmc1: mmc@58005000 {
>   			compatible = "st,stm32-sdmmc2", "arm,pl18x", "arm,primecell";
>   			arm,primecell-periphid = <0x20253180>;
Applied on stm32-next.

Thanks.
Alex
