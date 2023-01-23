Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A112D677FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjAWPfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjAWPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:34:51 -0500
Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730551421A;
        Mon, 23 Jan 2023 07:34:50 -0800 (PST)
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 9A3D1440E7B;
        Mon, 23 Jan 2023 17:30:59 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1674487859;
        bh=C+BAPobvJK/ihHNeayLt3PctTI5hdAQxmOczAdCQCgk=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=g2N0q4fZcFYbzCBh3MpjVo7v/oizJ8IzsGUCthk2Lp/QjgEofGUF7WrXEJrgV/FMg
         kae59LwYJLwiYX2gcOEYiIr4v9d3I3eKseAZR5CeJmMhaHH/HKv/60oxFX9MBUT2Rw
         /le5jKfD8xoB1gRdCd7DbkRtS1/zB4b2hbMHB3XyHe4cuoUw24Zblob8/L/BmzPnzz
         j4+7dem6bsDCQqzImqiaSbgoxy7zd22ppVwylf3/M2VOD944fqZGSIOcjndrcaMWI4
         Q4OgnP4yXcKLHw0b/K0Kz6JJCbQTHqMfiWZXGRTzvZoYqaXtXbEi+RyCPQO6jZxLBd
         /tVh+w5386icw==
References: <20230123151527.369285-1-krzysztof.kozlowski@linaro.org>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Baruch Siach <baruch@tkos.co.il>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: cx92755: align UART node name with bindings
Date:   Mon, 23 Jan 2023 17:34:04 +0200
In-reply-to: <20230123151527.369285-1-krzysztof.kozlowski@linaro.org>
Message-ID: <87k01d8dt4.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Jan 23 2023, Krzysztof Kozlowski wrote:
> Bindings expect UART/serial node names to be "serial".
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
>  arch/arm/boot/dts/cx92755.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/cx92755.dtsi b/arch/arm/boot/dts/cx92755.dtsi
> index d2e8f36f8c60..227675fbe820 100644
> --- a/arch/arm/boot/dts/cx92755.dtsi
> +++ b/arch/arm/boot/dts/cx92755.dtsi
> @@ -107,7 +107,7 @@ uc_regs: syscon@f00003a0 {
>  		reg = <0xf00003a0 0x10>;
>  	};
>  
> -	uart0: uart@f0000740 {
> +	uart0: serial@f0000740 {
>  		compatible = "cnxt,cx92755-usart";
>  		reg = <0xf0000740 0x20>;
>  		clocks = <&main_clk>;
> @@ -115,7 +115,7 @@ uart0: uart@f0000740 {
>  		status = "disabled";
>  	};
>  
> -	uart1: uart@f0000760 {
> +	uart1: serial@f0000760 {
>  		compatible = "cnxt,cx92755-usart";
>  		reg = <0xf0000760 0x20>;
>  		clocks = <&main_clk>;
> @@ -123,7 +123,7 @@ uart1: uart@f0000760 {
>  		status = "disabled";
>  	};
>  
> -	uart2: uart@f0000780 {
> +	uart2: serial@f0000780 {
>  		compatible = "cnxt,cx92755-usart";
>  		reg = <0xf0000780 0x20>;
>  		clocks = <&main_clk>;


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
