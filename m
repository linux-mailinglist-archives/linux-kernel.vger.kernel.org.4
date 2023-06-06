Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78FE724923
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbjFFQaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbjFFQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:29:56 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DABD10C2;
        Tue,  6 Jun 2023 09:29:54 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356GThi3046714;
        Tue, 6 Jun 2023 11:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686068984;
        bh=xMmy6tn/ZnbYHQDsM4p6GJF+gLp6N0ez2+1xOK5ceWo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=B19e+HwpRn3OGBMk1aE329hYMpDUcBx1NgSIS2hJXjaE4M6nedCvKWf7CQpSALgAq
         oFJR7c5l+rSxmmQr8KR+bo3V6JeLDY5Cky9ceP5C27d9K7TsfhAUoCOtqldHAXLPQV
         rOPJIHT5s3LjjpleBigxKA+f3cUJ60QU0ezcH2Y0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356GThvL124198
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 11:29:43 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 11:29:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 11:29:43 -0500
Received: from [10.250.37.94] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356GThI1058724;
        Tue, 6 Jun 2023 11:29:43 -0500
Message-ID: <ef3e537e-353a-b641-bfc5-1d7b84e2f0af@ti.com>
Date:   Tue, 6 Jun 2023 11:29:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/4] arm64: dts: ti: k3-am65-main: Fix mux controller
 node name
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
References: <20230606160643.3618390-1-nm@ti.com>
 <20230606160643.3618390-2-nm@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230606160643.3618390-2-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/23 11:06 AM, Nishanth Menon wrote:
> Add unit address to form a proper node name.
> 

This is only needed when the node has a reg property, which
we have not added yet to this node. This patch instead adds a
warning:

> node has a unit name, but no reg or ranges property

Andrew

> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> No change since V1
> V1: https://lore.kernel.org/r/20230424144949.244135-3-nm@ti.com
> 
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 1adba2f2c153..f64b4e782ec3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -506,7 +506,7 @@ serdes1_clk: clock@4090 {
>   			reg = <0x00004090 0x4>;
>   		};
>   
> -		serdes_mux: mux-controller {
> +		serdes_mux: mux-controller@4080 {
>   			compatible = "mmio-mux";
>   			#mux-control-cells = <1>;
>   			mux-reg-masks = <0x4080 0x3>, /* SERDES0 lane select */
