Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA75722AAA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjFEPPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbjFEPPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:15:32 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75487C5;
        Mon,  5 Jun 2023 08:14:35 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 355FDxFK100220;
        Mon, 5 Jun 2023 10:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685978039;
        bh=1LbyU7mjt/+cgQHUAABS5foB5XVJY69pidPaNxd2SYg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=W/kmXQyUeeL5Le/uBK/GL5qBmj6mVYF0Mm6pAjIuGxkiKrwN58cLVvKKY8aTOG54I
         C/vK+aR0abI4q/A7BZHFBCmFP/kHzbriebJOEgTYp9f6V6RNGxtw09MIFherGXyzbY
         V6NfA+efGREulfpqyWwxvCpdgeUqxt9X8iH0PJZk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 355FDx0w030721
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jun 2023 10:13:59 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Jun 2023 10:13:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Jun 2023 10:13:59 -0500
Received: from [10.249.142.56] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 355FDunv022614;
        Mon, 5 Jun 2023 10:13:56 -0500
Message-ID: <4b4f4eef-398b-843b-37f8-fdf97c1b6b8d@ti.com>
Date:   Mon, 5 Jun 2023 20:43:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j721e-mcu-wakeup: Switch to
 "ti,j721e-system-controller" compatible
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>
References: <20230424154841.353631-1-nm@ti.com>
 <20230424154841.353631-2-nm@ti.com>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <20230424154841.353631-2-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 4/24/2023 9:18 PM, Nishanth Menon wrote:
> Switch to "ti,j721e-system-controller" compatible to be more specific.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index 24e8125db8c4..71b8b04a7789 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -35,7 +35,7 @@ k3_reset: reset-controller {
>  	};
>  
>  	mcu_conf: syscon@40f00000 {
> -		compatible = "syscon", "simple-mfd";
> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
>  		reg = <0x0 0x40f00000 0x0 0x20000>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;

As Andrew suggested at [0], lets work on getting rid of unneeded
"syscon" here and move to simple-bus instead 

[0] https://lore.kernel.org/all/76da0b98-3274-b047-db11-ecabc117ae11@ti.com/

Regards
Vignesh
