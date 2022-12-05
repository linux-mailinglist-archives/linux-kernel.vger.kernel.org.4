Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9032D642490
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiLEI22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiLEI2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:28:22 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9DFEE38;
        Mon,  5 Dec 2022 00:28:20 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B58MTF7027238;
        Mon, 5 Dec 2022 09:28:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=CiJ573Jp5ZruqWdA3n8fdyNoDx4JIQSN35zKVUrzezE=;
 b=LngdjuU7iSC5beEZPTaRTNdx0XUAqI8nNGHJVgK8taGrdGHLEZ0OSPmNyGAO3vmMvXqz
 L1Q8Or2w5xFWiuz6+Ugl1wDgiJ72cc4ZGFh6dklO7ik93cYYmQoajvGiOCdTygvO/8ro
 vRl6Q5QgUk9QcP3TdY5zwUfIkTo3jo/HlOMLvUiN6i1AIoGucFyuJLjMTtgijUSnZMjQ
 bMPYGPFImwoiatRqhJj380PEU6LmkuboH1sxOqN1tuMEbyCGPNw1A8RjM57s/MbEEIb/
 8v6ysPKkuMWYS4w1tCDeV5KcAdZ7fNrsDKRucqUxooOlH8aqk+jtBNjTo8f1KyiPT0ql gQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3m7x7pgjyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 09:28:00 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 02DA010003B;
        Mon,  5 Dec 2022 09:27:55 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E0C082138CA;
        Mon,  5 Dec 2022 09:27:55 +0100 (CET)
Received: from [10.201.20.130] (10.201.20.130) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 5 Dec
 2022 09:27:55 +0100
Message-ID: <0a14f171-003b-01c4-6ed1-80f9e21120ce@foss.st.com>
Date:   Mon, 5 Dec 2022 09:27:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ARM: dts: stih410: align HDMI CEC node names with
 dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221204183353.140002-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20221204183353.140002-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.130]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On 12/4/22 19:33, Krzysztof Kozlowski wrote:
> The bindings expect "cec" for HDMI CEC node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> See also:
> https://lore.kernel.org/all/20221204182908.138910-3-krzysztof.kozlowski@linaro.org/
> ---
>  arch/arm/boot/dts/stih410.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
> index a39dd5f7bcae..29e95e9d3229 100644
> --- a/arch/arm/boot/dts/stih410.dtsi
> +++ b/arch/arm/boot/dts/stih410.dtsi
> @@ -272,7 +272,7 @@ thermal@91a0000 {
>  			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
> -		sti-cec@94a087c {
> +		cec@94a087c {
>  			compatible = "st,stih-cec";
>  			reg = <0x94a087c 0x64>;
>  			clocks = <&clk_sysin>;

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
