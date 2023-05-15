Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A6F702FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbjEOOeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241849AbjEOOeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:34:00 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B0D268A;
        Mon, 15 May 2023 07:33:30 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FEWpL6026951;
        Mon, 15 May 2023 09:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684161171;
        bh=xouBqGJTe/JCoQCmMoRe3QLxsICzaUsthaIXw/SyHus=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=sHtubQSG0J4ZNrsvueP+naKaGOMIVFd25b9/OlwmsfEud4lnI+4wvBIToJty9sZjg
         2KMToqmxv1D7Rlmj+9zxraSHaYCzO4vb5bWq7QIvqsQFjDM0tfUUn1/ur+rUk4acKu
         0OtLDiUBE7jcxJGDXitwuB13aXS9mAzmLWCX+v5o=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FEWoa8057487
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 09:32:51 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 09:32:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 09:32:50 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FEWoHo007535;
        Mon, 15 May 2023 09:32:50 -0500
Date:   Mon, 15 May 2023 09:32:50 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Nitin Yadav <n-yadav@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am62-main: add sa3_secproxy in
 cbass_main
Message-ID: <20230515143250.jxwwgse24lrcqouc@grunge>
References: <20230510123216.3440019-1-n-yadav@ti.com>
 <20230510123216.3440019-3-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230510123216.3440019-3-n-yadav@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:02-20230510, Nitin Yadav wrote:
> Add sa3_secproxy node in k3-am62-main.dtsi to keep device tree
> nodes in sync with u-boot nodes.
> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index b3e4857bbbe4..7c2af5b0e022 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -42,6 +42,15 @@ gic_its: msi-controller@1820000 {
>  		};
>  	};
>  
> +	sa3_secproxy: secproxy@44880000 {
> +		compatible = "ti,am654-secure-proxy";
> +		#mbox-cells = <1>;
> +		reg-names = "rt", "scfg", "target_data";
> +		reg = <0x00 0x44880000 0x00 0x20000>,
> +		      <0x0 0x44860000 0x0 0x20000>,
> +		      <0x0 0x43600000 0x0 0x10000>;
be consistent with 0x00 instead of 0x0

You want this marked reserved and documented since it is to be used only by HSM
processors and NOT general processors.

> +	};
> +
>  	main_conf: syscon@100000 {
>  		compatible = "syscon", "simple-mfd";
>  		reg = <0x00 0x00100000 0x00 0x20000>;
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
