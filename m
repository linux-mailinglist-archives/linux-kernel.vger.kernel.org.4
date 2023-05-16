Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC83D704FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjEPNwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjEPNvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:51:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D041FCC;
        Tue, 16 May 2023 06:51:47 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34GDpb9K026071;
        Tue, 16 May 2023 08:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684245097;
        bh=U2m0ShCmYC5zfXOGkHLuxLc+rB6GpSgduVVZuSLFpEg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=wlOKkXAIUmTjaBKD9AlWWRjNUyjEJM9/iEDWEIVMXHhH/ycMkOPWAopSD4tYbTTz3
         8J+UWRaTyD73lPrt9Lc1SOguRCib6lz0u8idHyPMNBuZ0UDsqZYARdObwQMe7c12HV
         1Srcw+FQdjWk9mJCVINa3IMMjMHQyrK/b+1HE6Q0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34GDpb3V049576
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 08:51:37 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 08:51:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 08:51:37 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34GDpbAN017579;
        Tue, 16 May 2023 08:51:37 -0500
Date:   Tue, 16 May 2023 08:51:37 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] arm64: dts: ti: k3-j721e-beagleboneai64: Fix mailbox
 node status
Message-ID: <20230516135137.y2akvgeghe6xg446@earful>
References: <20230515172137.474626-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230515172137.474626-1-afd@ti.com>
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

On 12:21-20230515, Andrew Davis wrote:
> Mailbox nodes are now disabled by default. The BeagleBoard AI64 DT
> addition went in at around the same time and must have missed that
> change so the mailboxes are not re-enabled. Do that here.

Uggh. thanks.

> 
> Fixes: fae14a1cb8dd ("arm64: dts: ti: Add k3-j721e-beagleboneai64")
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> index 37c24b077b6a..8a62ac263b89 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> @@ -936,6 +936,7 @@ &ufs_wrapper {
>  };
>  
>  &mailbox0_cluster0 {
> +	status = "okay";
>  	interrupts = <436>;
>  
>  	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
> @@ -950,6 +951,7 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
>  };
>  
>  &mailbox0_cluster1 {
> +	status = "okay";
>  	interrupts = <432>;
>  
>  	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
> @@ -964,6 +966,7 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
>  };
>  
>  &mailbox0_cluster2 {
> +	status = "okay";
>  	interrupts = <428>;
>  
>  	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
> @@ -978,6 +981,7 @@ mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
>  };
>  
>  &mailbox0_cluster3 {
> +	status = "okay";
>  	interrupts = <424>;
>  
>  	mbox_c66_0: mbox-c66-0 {
> @@ -992,6 +996,7 @@ mbox_c66_1: mbox-c66-1 {
>  };
>  
>  &mailbox0_cluster4 {
> +	status = "okay";
>  	interrupts = <420>;
>  
>  	mbox_c71_0: mbox-c71-0 {
> -- 
> 2.39.2
> 
Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
