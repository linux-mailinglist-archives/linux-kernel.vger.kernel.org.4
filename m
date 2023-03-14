Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568176B9656
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjCNNdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCNNdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:33:22 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102C529E3D;
        Tue, 14 Mar 2023 06:29:50 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32EDTMQk071661;
        Tue, 14 Mar 2023 08:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678800562;
        bh=hMCvdT26ojrnD3A/uMr7Ksq6MWMWyKmsYq1BI9xHgME=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=k3W2Hw/h/Uyhg/jljvgP/6pWkeg7fjen8EhtS8NtXF6GvmZ/kSpVbQwtr5mJDocTI
         QFObSZRqboYXj1bZFO+5yoKQqhHAPYIPOrRn8D4YokTzMG/xti0a2WRiA6PbCDmVde
         KeM87ql9GES1nDGms6pXud7sK6oHGOarokLVELoY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32EDTMQQ036055
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 08:29:22 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 08:29:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 08:29:22 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32EDTMA8031352;
        Tue, 14 Mar 2023 08:29:22 -0500
Date:   Tue, 14 Mar 2023 08:29:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j784s4-mcu-wakeup: Add device id
 property for mcu_navss
Message-ID: <20230314132922.ejbutfxt7z7xhqgm@danger>
References: <20230314104055.1475054-1-s-vadapalli@ti.com>
 <20230314104055.1475054-2-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230314104055.1475054-2-s-vadapalli@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:10-20230314, Siddharth Vadapalli wrote:
> The "ti,sci-dev-id" property used to indicate the Device ID is missing
> for mcu_navss device-tree node. Add it.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> index 93952af618f6..52311da15579 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> @@ -212,6 +212,8 @@ mcu_navss: bus@28380000{
>  		dma-coherent;
>  		dma-ranges;
>  
> +		ti,sci-dev-id = <323>;
> +
>  		mcu_ringacc: ringacc@2b800000 {
>  			compatible = "ti,am654-navss-ringacc";
>  			reg = <0x00 0x2b800000 0x00 0x400000>,
> -- 
> 2.25.1
> 

Looks like
https://lore.kernel.org/all/20230313104721.407071-2-j-choudhary@ti.com/
is another part of the Fixup?

Why not squash the two as a missing ti,sci-dev-id for j784s4?


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
