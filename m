Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFAF6E4A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjDQNm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjDQNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:42:54 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6EC6A75;
        Mon, 17 Apr 2023 06:42:49 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33HDgfwc115750;
        Mon, 17 Apr 2023 08:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681738961;
        bh=seuPS1iQRiZOPAIOrJ+23K+sqk6ZAZc/FbVBz513qsc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=R93LsQ1ayRBbbfHxo4p/s1leBiFctxhlan8YGvrBmFV7ibChrTQJJ8bnlQwDWse2h
         6fImBjl9iyuPTrfPk2D9uZ9tlNIPw7BfNlQ+avPLez/njE7G7ZVc3t7cUemt8Lb32A
         uHhYT87X6K7Gj239ojNoUNtWQQJBgQU5TkQ8PM+g=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33HDgfMo098059
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Apr 2023 08:42:41 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 17
 Apr 2023 08:42:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 17 Apr 2023 08:42:41 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33HDgfsu079671;
        Mon, 17 Apr 2023 08:42:41 -0500
Date:   Mon, 17 Apr 2023 08:42:41 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <kamlesh@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-main: Remove power-domains from
 crypto node
Message-ID: <20230417134241.oj5cmrqjeoxj2sb2@power>
References: <20230417133308.1990057-1-kamlesh@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230417133308.1990057-1-kamlesh@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:03-20230417, kamlesh@ti.com wrote:
> From: Kamlesh Gurudasani <kamlesh@ti.com>
> 
> With latest firmware update, we can no longer control power of SA3UL from
> main domain.

How is this backward compatible?

> 
> Remove power-domains property from the crypto node.
> 
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index b3e4857bbbe4..18a6e9ffaf58 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -174,7 +174,6 @@ k3_reset: reset-controller {
>  	crypto: crypto@40900000 {
>  		compatible = "ti,am62-sa3ul";
>  		reg = <0x00 0x40900000 0x00 0x1200>;
> -		power-domains = <&k3_pds 70 TI_SCI_PD_SHARED>;
>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
