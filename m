Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44E6690D81
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjBIPrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjBIPrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:47:22 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32B25FC2;
        Thu,  9 Feb 2023 07:46:51 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 319FkdpF004770;
        Thu, 9 Feb 2023 09:46:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1675957599;
        bh=4uLEOL/7cdgOYUTQ8XvyqdOxOezuCTHfjMlJtO9i1zs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Uoe7dW+0Py5NvKnh6F6M8We91YN3U3/6ozN/MDGjUnkF2fkY84sHQCmAtRJp62lNj
         jSMs43dJ0KogOtVw/37YKQ/3X3ABcYWDignfB5UPOnRSFQ9Q1nwVzle66Kvj3GVxUH
         VXvyB6llqxDVtx512gsa8wEXn6NJ+Vh7/Lm+qbEk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 319FkdsE002058
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Feb 2023 09:46:39 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 9
 Feb 2023 09:46:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 9 Feb 2023 09:46:38 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 319Fkcp5064155;
        Thu, 9 Feb 2023 09:46:38 -0600
Date:   Thu, 9 Feb 2023 09:46:38 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Devarsh Thakkar <devarsht@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <hnagalla@ti.com>,
        <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-sk: Enable full 4GB DDR
Message-ID: <20230209154638.zktj5hxthapwbicj@accompany>
References: <20230206115240.6026-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230206115240.6026-1-devarsht@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:22-20230206, Devarsh Thakkar wrote:
> AM62A7-SK board has 4GB LPDDR4 Micron MT53E2G32D4DE-046 AUT:B memory but
> only 2GB was enabled early.
> 
> Enable full 4GB memory by updating the latter 2GB memory region
> which gets mapped to 0x0880000000 i.e. DDR16SS0_SDRAM as referred in
> Table 2-1. AM62A Common SoC Memory of AM62Ax TRM.
> 
> TRM : https://www.ti.com/lit/zip/spruj16

TRM makes no sense in this patch - it is the data sheet of the memory and part in
schematics that is relevant

Looking at the design files (link from dts): https://www.ti.com/lit/zip/sprr459
E1 version of the board has MT53E2G32D4DE-046 Vs E2 version of the board
is MT53E1G32D2FW-046

The 2GB is accurate for E1 version of the board, 4GB change implies that
E1 version of the board is no longer supported.

Is the claim that E1 version of the board no longer supported? What
happens to folks in the community who have an E1 board?

> 
> Logs:
> Link : https://gist.github.com/devarsht/e85b6af89c01ddadb3a62f3e5f196af8

Logs dont belong to the commit message. Also missing (if the patch is
claiming a "fixes") is a Fixes tag.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index 5c9012141ee2..f6a67f072dca 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -27,8 +27,9 @@
>  
>  	memory@80000000 {
>  		device_type = "memory";
> -		/* 2G RAM */
> -		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
> +		/* 4G RAM */
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
> +		      <0x00000008 0x80000000 0x00000000 0x80000000>;
>  	};
>  
>  	reserved-memory {
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
