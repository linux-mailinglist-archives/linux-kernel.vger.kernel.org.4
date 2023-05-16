Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBC7704EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjEPNN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjEPNNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:13:50 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BB43C26;
        Tue, 16 May 2023 06:13:36 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34GDDOCF017141;
        Tue, 16 May 2023 08:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684242804;
        bh=1UhcqkQcKuAtC+uK46qMD3fkFPLBcWpgWbgvZQeitDY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Nevh9aswYeLYLzre+6ApflVHI9yrqgZFDN9SZvjK3+J+sAXRlH3IiSVtSI2PDUBDl
         LX/KpjsRY6qXxeyS3B+WoWIqkxbAX9Szk87VNxyU7OREMTSjZfXHVRFIKbTncKy7e8
         wW4eTwY2kU93xK9ZPoqkAi1QJoJG92DWDk/kuWXQ=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34GDDOaQ001395
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 08:13:24 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 08:13:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 08:13:23 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34GDDN8x070960;
        Tue, 16 May 2023 08:13:23 -0500
Date:   Tue, 16 May 2023 08:13:23 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Achal Verma <a-verma1@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: correct num-lanes requested
 for PCIe
Message-ID: <20230516131323.3empqp5btdzfarjx@curliness>
References: <20230516062212.2635948-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230516062212.2635948-1-a-verma1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:52-20230516, Achal Verma wrote:
> From: Matt Ranostay <mranostay@ti.com>
> 
> J7200 has a limited 2x support for PCIe, and the properties should be
> updated as such.
> 

What commit does this fix?

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
> -- 
> 2.25.1
> 


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
