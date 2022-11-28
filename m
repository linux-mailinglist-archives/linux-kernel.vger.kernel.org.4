Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1855F63A312
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiK1Ia6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiK1Iaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:30:55 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F195E17061;
        Mon, 28 Nov 2022 00:30:52 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AS22oSW017482;
        Mon, 28 Nov 2022 09:30:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=O1GD3Cc5SiRNhAGzpwqKhlM5QBrOnjwf+vXokg6eu6g=;
 b=NSdONKQLK5BTWM4IwZaI4QRbSlDg3PE0LzPEM97p7u9wl+Gd0Of6kv2gl93pnV+BG55L
 bHD83duGYOPauJXpXzSvjNhmcKeU2PSJqxCTBUYP6bAgMUgAKhAj9RS9rFIiXddi4GhT
 LFSujjEQC39jT8RwMQxJdyIvyxVen0/JrUkVh57iRf3PKa+uBBcwCAf0Sp/wuqF9XxKq
 UcQZFfOEhfieNa0Qll559TufODmPW2r0Eti16DibqVmh6Jtoj7WOfBtc0b7tev8jElQQ
 OzG63OEkuCEIm34LiKHT9z+yGlDXabhYPpDYFjtzTtGUT1MFJVaCtEIgWTto7yKAIV6h 8w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3m393rhmqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 09:30:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D86AD100034;
        Mon, 28 Nov 2022 09:30:19 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BA98F2132E2;
        Mon, 28 Nov 2022 09:30:19 +0100 (CET)
Received: from [10.211.0.247] (10.211.0.247) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 28 Nov
 2022 09:30:19 +0100
Message-ID: <9cece196-97ed-4d4b-79e0-f34adb785bf4@foss.st.com>
Date:   Mon, 28 Nov 2022 09:30:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ARM: dts: sti: align LED node names with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221125144116.476877-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20221125144116.476877-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.211.0.247]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_07,2022-11-25_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof 

On 11/25/22 15:41, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern:
> 
>   stih407-b2120.dtb: leds: 'green', 'red' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/stih410-b2260.dts  | 8 ++++----
>  arch/arm/boot/dts/stih418-b2199.dts  | 4 ++--
>  arch/arm/boot/dts/stih418-b2264.dts  | 2 +-
>  arch/arm/boot/dts/stihxxx-b2120.dtsi | 4 ++--
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index 26d93f26f6d0..240b62040000 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -27,26 +27,26 @@ aliases {
>  
>  	leds {
>  		compatible = "gpio-leds";
> -		user_green_1 {
> +		led-user-green-1 {
>  			label = "User_green_1";
>  			gpios = <&pio1 3 GPIO_ACTIVE_LOW>;
>  			linux,default-trigger = "heartbeat";
>  			default-state = "off";
>  		};
>  
> -		user_green_2 {
> +		led-user-green-2 {
>  			label = "User_green_2";
>  			gpios = <&pio4 1 GPIO_ACTIVE_LOW>;
>  			default-state = "off";
>  		};
>  
> -		user_green_3 {
> +		led-user-green-3 {
>  			label = "User_green_3";
>  			gpios = <&pio2 1 GPIO_ACTIVE_LOW>;
>  			default-state = "off";
>  		};
>  
> -		user_green_4 {
> +		led-user-green-4 {
>  			label = "User_green_4";
>  			gpios = <&pio2 5 GPIO_ACTIVE_LOW>;
>  			default-state = "off";
> diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
> index d21bcc7c1271..53ac6c2b7b7d 100644
> --- a/arch/arm/boot/dts/stih418-b2199.dts
> +++ b/arch/arm/boot/dts/stih418-b2199.dts
> @@ -26,12 +26,12 @@ aliases {
>  
>  	leds {
>  		compatible = "gpio-leds";
> -		red {
> +		led-red {
>  			label = "Front Panel LED";
>  			gpios = <&pio4 1 GPIO_ACTIVE_HIGH>;
>  			linux,default-trigger = "heartbeat";
>  		};
> -		green {
> +		led-green {
>  			gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
> diff --git a/arch/arm/boot/dts/stih418-b2264.dts b/arch/arm/boot/dts/stih418-b2264.dts
> index a99604bebf8c..34a518b037ab 100644
> --- a/arch/arm/boot/dts/stih418-b2264.dts
> +++ b/arch/arm/boot/dts/stih418-b2264.dts
> @@ -76,7 +76,7 @@ aliases {
>  	soc {
>  		leds {
>  			compatible = "gpio-leds";
> -			green {
> +			led-green {
>  				gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
>  				default-state = "off";
>  			};
> diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> index 2aa94605d3d4..920a0bad7494 100644
> --- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
> +++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> @@ -9,12 +9,12 @@
>  / {
>  	leds {
>  		compatible = "gpio-leds";
> -		red {
> +		led-red {
>  			label = "Front Panel LED";
>  			gpios = <&pio4 1 GPIO_ACTIVE_HIGH>;
>  			linux,default-trigger = "heartbeat";
>  		};
> -		green {
> +		led-green {
>  			gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
