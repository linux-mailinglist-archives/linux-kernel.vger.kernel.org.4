Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F067070455B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjEPGeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjEPGd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:33:58 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFA71FD4;
        Mon, 15 May 2023 23:33:56 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34G6XhTC061465;
        Tue, 16 May 2023 01:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684218823;
        bh=kQRrE7NQZFThfXtU1mqcmhZYEzl2mdVQGQNER6/T2C0=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=Sil2Z57zIaLO+SgeLTzPZaxtl3XHObFirJgsO7Lpx0evRCQK3xO0FQ958WeRRKe8J
         myieRPQ33oWhT+d4qYPdIm4RBmByO7Xsj6++saNDI2bzJb3zvLwB/HQmGkrsz+C16y
         /QIFLsz83hRme9bc3EJ4Vl80zbnU74t8cPx+gGF4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34G6XhhE026382
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 01:33:43 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 01:33:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 01:33:42 -0500
Received: from [172.24.145.61] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34G6XdN3016858;
        Tue, 16 May 2023 01:33:39 -0500
Message-ID: <728c0165-3caa-de09-2493-e7225a78b77a@ti.com>
Date:   Tue, 16 May 2023 12:03:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: correct num-lanes requested for
 PCIe
Content-Language: en-US
To:     Achal Verma <a-verma1@ti.com>
References: <20230516062212.2635948-1-a-verma1@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230516062212.2635948-1-a-verma1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Achal,

On 16/05/23 11:52, Achal Verma wrote:
> From: Matt Ranostay <mranostay@ti.com>
> 
> J7200 has a limited 2x support for PCIe, and the properties should be
> updated as such.

According to J7200 Datasheet at [0], the SoC supports up to x4 PCIe lanes. Could
you please clarify where the lanes are documented to be 2x?

[0]: https://www.ti.com/lit/ds/symlink/dra821u-q1.pdf

> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index ef352e32f19d..5e62b431d6e8 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -729,7 +729,7 @@ pcie1_rc: pcie@2910000 {
>  		device_type = "pci";
>  		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
>  		max-link-speed = <3>;
> -		num-lanes = <4>;
> +		num-lanes = <2>;
>  		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 240 6>;
>  		clock-names = "fck";
> @@ -757,7 +757,7 @@ pcie1_ep: pcie-ep@2910000 {
>  		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
>  		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
>  		max-link-speed = <3>;
> -		num-lanes = <4>;
> +		num-lanes = <2>;
>  		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 240 6>;
>  		clock-names = "fck";

-- 
Regards,
Siddharth.
