Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AFB69E1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjBUOCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjBUOCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:02:09 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06F52A6C9;
        Tue, 21 Feb 2023 06:02:08 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31LE1uZ9076966;
        Tue, 21 Feb 2023 08:01:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1676988116;
        bh=5HIcBVXU+K8mmgkfAM3rrTSW8a4UTl8+daYL2j36OY0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=QmJoE5ymGJJN8cIxtkm+pyIh8GGn6fRU8dpHzcqkY2EJjVFMYbCNymn6NPprTliO0
         4v0AORyavJ9BNyqw4zjuapWQaRgSoTTfrsOhvfntol6g31VVSdtsQujbNpMAhjt5rt
         zOB0fUPFBglQ7ctmWmJkDxDGAtbbysjDt56gX3i0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31LE1usp077379
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Feb 2023 08:01:56 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Feb 2023 08:01:56 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Feb 2023 08:01:56 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31LE1u9p017874;
        Tue, 21 Feb 2023 08:01:56 -0600
Date:   Tue, 21 Feb 2023 08:01:56 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>
CC:     <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 3/9] arm64: dts: ti: k3-j721s2-main: Add SERDES and
 WIZ device tree node
Message-ID: <20230221140156.ml6dlhqg3a7cxvac@squishy>
References: <20230221120612.27366-1-r-gunasekaran@ti.com>
 <20230221120612.27366-4-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230221120612.27366-4-r-gunasekaran@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:36-20230221, Ravi Gunasekaran wrote:
> From: Matt Ranostay <mranostay@ti.com>
> 
> Add dt node for the single instance of WIZ (SERDES wrapper) and
> SERDES module shared by PCIe, eDP and USB.

[...]

> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index 84e5689fff9f..af6c93f0a055 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
[...]
> @@ -33,11 +44,18 @@
>  		#size-cells = <1>;
>  		ranges = <0x00 0x00 0x00104000 0x18000>;
>  
> -		usb_serdes_mux: mux-controller@0 {
> +		usb_serdes_mux: mux-controller-0 {

was'nt this just introduced in the patch just prior, if so, NAK,
do the changes where they are introduced.

>  			compatible = "mmio-mux";
>  			#mux-control-cells = <1>;
>  			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
>  		};
