Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2182C69F52C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjBVNQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBVNQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:16:21 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C502739BB4;
        Wed, 22 Feb 2023 05:16:17 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31MDFxnp113410;
        Wed, 22 Feb 2023 07:15:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677071759;
        bh=hD52NgGyIxcH+/PIi7CS0t2PfjHjhrKYf0n1At3rXj4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=A6kApQgYAguYcRVJXgjC/uQ5wT3p1B8YFodt7GXl1iUHprmZPlNa49YnCapg7FOmX
         sEGvO+g3rgVvY4LGmHcXK72AUZBH3q1X9VAHZp5/sS1QPz9Q5oLOf22YMT7fh0la1s
         HhbNFECRMa7kmY3sePI17pRDlrLJhkr5mLGaVJ/k=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31MDFx3T083692
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Feb 2023 07:15:59 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 22
 Feb 2023 07:15:59 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 22 Feb 2023 07:15:59 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31MDFxVx104054;
        Wed, 22 Feb 2023 07:15:59 -0600
Date:   Wed, 22 Feb 2023 07:15:59 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>
CC:     <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 2/9] arm64: dts: ti: k3-j721s2-main: Add support for
 USB
Message-ID: <20230222131559.day4frfvjuje25i4@suffrage>
References: <20230221120612.27366-1-r-gunasekaran@ti.com>
 <20230221120612.27366-3-r-gunasekaran@ti.com>
 <20230221135852.n3yukx55q7jmqbgk@chowder>
 <a74bf007-40b5-3d92-ba30-c50a2bf4a3c0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a74bf007-40b5-3d92-ba30-c50a2bf4a3c0@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:21-20230222, Ravi Gunasekaran wrote:
[...]
> >> +	usbss0: cdns-usb@4104000 {
> >> +		compatible = "ti,j721e-usb";
> >> +		reg = <0x00 0x04104000 0x00 0x100>;
> >> +		clocks = <&k3_clks 360 16>, <&k3_clks 360 15>;
> >> +		clock-names = "ref", "lpm";
> >> +		assigned-clocks = <&k3_clks 360 16>; /* USB2_REFCLK */
> >> +		assigned-clock-parents = <&k3_clks 360 17>;
> >> +		power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
> >> +		#address-cells = <2>;
> >> +		#size-cells = <2>;
> >> +		ranges;
> >> +		dma-coherent;
> >> +
> >> +		status = "disabled";
> > 
> > Why disabled by default?
> 
> One of the comment received in the v9 series was to disable the node in
> the include file and then enable it in the board specific DTS file.
> Changes in this series addressed that comment.

Document in the node why it is disabled by default. Also do make sure
All K3 SoCs dtsi nodes follow the same argument.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
