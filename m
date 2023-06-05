Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632ED723180
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjFEUf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjFEUf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:35:56 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC48D2;
        Mon,  5 Jun 2023 13:35:55 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 355KZl4p125076;
        Mon, 5 Jun 2023 15:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685997347;
        bh=TUS8I++rPE9XBrmZKZQUUL+5qrdpXe7L3q5KuHJRk+8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=QWIFeswkSNQycRsbpC8c2bcS0Pi0tLrX/Js9aVVQtTCYsgPoTEXe0+wcF02Z6Yxi/
         FI04ZXH+Caa3XLK8N1ZE34QW2j+c6IhRgygUe1sVWrAP3yK8clE/eksBjkEauhf9M6
         2TG9PZIxu29hM2cEAcK0PM2s/C2UOBdgMZJezEgo=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 355KZlRQ072854
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jun 2023 15:35:47 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Jun 2023 15:35:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Jun 2023 15:35:46 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 355KZkuZ095908;
        Mon, 5 Jun 2023 15:35:46 -0500
Date:   Mon, 5 Jun 2023 15:35:46 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <sabiya.d@mistralsolutions.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Dasnavis Sabiya <sabiya.d@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am69-sk: Add eMMC mmc0 support
Message-ID: <20230605203546.uq77hmu627socvis@uncaring>
References: <20230605174551.160262-1-sabiya.d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230605174551.160262-1-sabiya.d@ti.com>
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

On 23:15-20230605, sabiya.d@mistralsolutions.com wrote:
> From: Dasnavis Sabiya <sabiya.d@ti.com>
> 
> Add support for eMMC card connected to main sdhci0 instance.
> 
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am69-sk.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> index 4b7d9280d76f..ab8ec2cb396e 100644
> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> @@ -22,6 +22,7 @@ chosen {
>  
>  	aliases {
>  		serial2 = &main_uart8;
> +		mmc0 = &main_sdhci0;
>  		mmc1 = &main_sdhci1;
>  		i2c0 = &main_i2c0;
>  	};
> @@ -191,6 +192,14 @@ exp1: gpio@21 {
>  	};
>  };
>  
> +&main_sdhci0 {
> +	/* eMMC */
> +	status = "okay";
> +	non-removable;
> +	ti,driver-strength-ohm = <50>;
> +	disable-wp;
> +};
> +
>  &main_sdhci1 {
>  	/* SD card */
>  	status = "okay";
> -- 
> 2.25.1
> 

Reviewed-by: Nishanth Menon <nm@ti.com>

Though this will probably need a rebase on top of
https://lore.kernel.org/linux-arm-kernel/20230602214937.2349545-1-nm@ti.com/


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
