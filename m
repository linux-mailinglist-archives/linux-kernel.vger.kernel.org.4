Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035CA6ED482
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjDXSe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjDXSel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:34:41 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0EE61A4;
        Mon, 24 Apr 2023 11:34:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OIYYb2050572;
        Mon, 24 Apr 2023 13:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682361274;
        bh=Ruxvs7JkPbDEBPwKjbBWvKoqskn5NMCZpQRZRuF4lcA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=lHuJrgpWTrF0Xqajix4MGaTO70EWgfYEbz2CZE743RVb6gVKNKhDZL8xDen9uN/kQ
         myC2RV23KfVIWCMmqD9+BpoHdoB2lPIbKWYCQEZXGZ/RbO7NLbcpoRce57rYVcK+oS
         aPE90jGW3l4MZOXJfsA0XzBeWIMASiRly1jP17K8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OIYYSV038836
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 13:34:34 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 13:34:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 13:34:33 -0500
Received: from [10.249.130.34] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OIYSlW011264;
        Mon, 24 Apr 2023 13:34:29 -0500
Message-ID: <78a7884b-2955-2006-9083-19306074a486@ti.com>
Date:   Tue, 25 Apr 2023 00:04:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j7200-mcu-wakeup: Split fss node
 up
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <vaishnav.a@ti.com>,
        <afd@ti.com>, <u-kumar1@ti.com>
References: <20230424173623.477577-1-nm@ti.com>
 <20230424173623.477577-4-nm@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230424173623.477577-4-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 4/24/2023 11:06 PM, Nishanth Menon wrote:
> fss node claims to be entirely a syscon node, but it is really two
> parts of it - one a syscon that controls the hbmc mux and a simple bus
> where ospi, hbmc peripherals are located. So model it accordingly by
> splitting the node up and using ti,j721e-system-controller to describe
> the syscon
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 21 +++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index b58a31371bf3..7653cb191be1 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -338,18 +338,27 @@ mcu_spi2: spi@40320000 {
>   		status = "disabled";
>   	};
>   
> -	fss: syscon@47000000 {
> -		compatible = "syscon", "simple-mfd";
> +	hbmc_syscon: syscon@47000000 {
> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
>   		reg = <0x00 0x47000000 0x00 0x100>;

Description is given upto 0x78 register in TRM (Section 12.3.1.6 FSS 
Registers)

Should we limit length to 0x78 ?

> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x00 0x00 0x47000000 0x100>;
>   
> -		hbmc_mux: hbmc-mux {
> +		hbmc_mux: mux-controller@4 {
>   			compatible = "mmio-mux";
> +			reg = <0x4 0x2>;
>   			#mux-control-cells = <1>;
>   			mux-reg-masks = <0x4 0x2>; /* HBMC select */
>   		};
> +	};
> +
> +	fss: bus@47030000 {
> +		compatible = "simple-bus";
> +		reg = <0x0 0x47030000 0x0 0x100>;

Only registers upto address  0x47030008 has valid description in TRM

Section, 13.3.3.6.3 HyperBus Subsystem Registers

Please see, if we need to limit length to 8 instead of 256

> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
>   
>   		hbmc: hyperbus@47034000 {
>   			compatible = "ti,am654-hbmc";
