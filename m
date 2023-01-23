Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26F56786AE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjAWTpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjAWTpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:45:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F5F26589;
        Mon, 23 Jan 2023 11:45:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7404361016;
        Mon, 23 Jan 2023 19:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EB7C433D2;
        Mon, 23 Jan 2023 19:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674503132;
        bh=7xpsjjOksJa+D80Mz4jpcUdj/h3s0z9lgcJOeeAT3rM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=KVcVGTo3O3yUE1plqscCldZDjkRC4WO4qMCIj5GPiYHD1ELTPkNADNS67djjPrnPv
         n9QooRm7MjEmWT17YjH4mLU9yCMd2VAGRhTdWvrliELhAqUjFY5jqfmHKxd49sv2cB
         7Ks1ypNGpIKRgvuvpexfGfl8CmtOwebqYSQr0nxaDXOZII4zL5SvI2AwtItlqNzLQ+
         asLpBCgRk2KO7XuTjlnbQE6wr54xa6w/jXnFKCQ+nCbzCaJPVeig9MOqwljaNWoP1t
         JOWzzRlrAGLzB7guWhMdzKFyTPYDY5wPuaG2W+yBxZ+gXzAtG/UsVsExehpj5INUZN
         zVL1Pm5lcoAjA==
Message-ID: <a20b8bd0-b1c9-d2ec-155f-d8e78cd76b1a@kernel.org>
Date:   Mon, 23 Jan 2023 13:45:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ARM: dts: socfpga: align UART node name with bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230123151521.369188-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230123151521.369188-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/23 09:15, Krzysztof Kozlowski wrote:
> Bindings expect UART/serial node names to be "serial".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm/boot/dts/socfpga.dtsi         | 4 ++--
>   arch/arm/boot/dts/socfpga_arria10.dtsi | 4 ++--
>   arch/arm/boot/dts/socfpga_vt.dts       | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 3fee80bbae21..4c1d140f40f8 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -905,7 +905,7 @@ timer3: timer3@ffd01000 {
>   			reset-names = "timer";
>   		};
>   
> -		uart0: serial0@ffc02000 {
> +		uart0: serial@ffc02000 {
>   			compatible = "snps,dw-apb-uart";
>   			reg = <0xffc02000 0x1000>;
>   			interrupts = <0 162 4>;
> @@ -918,7 +918,7 @@ uart0: serial0@ffc02000 {
>   			resets = <&rst UART0_RESET>;
>   		};
>   
> -		uart1: serial1@ffc03000 {
> +		uart1: serial@ffc03000 {
>   			compatible = "snps,dw-apb-uart";
>   			reg = <0xffc03000 0x1000>;
>   			interrupts = <0 163 4>;
> diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
> index 3b2a2c9c6547..72c55e5187ca 100644
> --- a/arch/arm/boot/dts/socfpga_arria10.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
> @@ -845,7 +845,7 @@ timer3: timer3@ffd00100 {
>   			reset-names = "timer";
>   		};
>   
> -		uart0: serial0@ffc02000 {
> +		uart0: serial@ffc02000 {
>   			compatible = "snps,dw-apb-uart";
>   			reg = <0xffc02000 0x100>;
>   			interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
> @@ -856,7 +856,7 @@ uart0: serial0@ffc02000 {
>   			status = "disabled";
>   		};
>   
> -		uart1: serial1@ffc02100 {
> +		uart1: serial@ffc02100 {
>   			compatible = "snps,dw-apb-uart";
>   			reg = <0xffc02100 0x100>;
>   			interrupts = <0 111 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
> index 3d0d806888b7..845ab2cc5ce6 100644
> --- a/arch/arm/boot/dts/socfpga_vt.dts
> +++ b/arch/arm/boot/dts/socfpga_vt.dts
> @@ -57,11 +57,11 @@ timer3@ffd01000 {
>   			clock-frequency = <7000000>;
>   		};
>   
> -		serial0@ffc02000 {
> +		serial@ffc02000 {
>   			clock-frequency = <7372800>;
>   		};
>   
> -		serial1@ffc03000 {
> +		serial@ffc03000 {
>   			clock-frequency = <7372800>;
>   		};
>   

Applied!

Thanks,
Dinh
