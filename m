Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4475730DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbjFOEBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFOEBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:01:46 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31624E3;
        Wed, 14 Jun 2023 21:01:44 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35F41GpV102556;
        Wed, 14 Jun 2023 23:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686801676;
        bh=B3tVnaHBrTh1EakG8xwEt9gRtjsiN9xvLXdYvAk6tUI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=vlIk37hSRtrm+zTsFMgaC6bf0J/VXRPyKHdDdH5X8VUNhxeDG7dRgvK49jI1/osC8
         EsFso6ZQw0u+s63TguDOygb18HM/qxA56DzHoMXdfi5GBEaJE6iFItaTwzWSnLXIbn
         TtV4YhgpOPp4pBlFyfusMcZcYpUvQ7biEgFT3GXw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35F41Gk2056219
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Jun 2023 23:01:16 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Jun 2023 23:01:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Jun 2023 23:01:16 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35F41CBS001429;
        Wed, 14 Jun 2023 23:01:13 -0500
Message-ID: <76f14228-2ccf-bcd5-153a-20c4dd365bad@ti.com>
Date:   Thu, 15 Jun 2023 09:31:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62-main: Remove power-domains
 from crypto node
Content-Language: en-US
To:     Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230614-sa3ul-v2-1-3a832b82339c@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230614-sa3ul-v2-1-3a832b82339c@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/06/23 15:16, Kamlesh Gurudasani wrote:
> Only SYSFW has control of SA3UL power.
> From SYSFW 08.04.00.002, for security reasons, device ID for power
> management of SA3UL has been removed.
> 
> "power-domains" property in crypto node tries to access
> the SA3UL, for which it gets NACK and hence, SA3UL driver doesn't
> probe properly.
> 
> Fixes: 8af893654c02 ("arm64: dts: ti: k3-am62-main: Enable crypto accelerator")
> 
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
> v2 changes:
> -make commit message clearer
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


Per Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml this is a
required property. This would need binding update to make power-domains
optional for certain compatibles.

>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
> 
> ---
> base-commit: 53ab6975c12d1ad86c599a8927e8c698b144d669
> change-id: 20230614-sa3ul-cb4bd1bb4d08
> 
> Best regards,

-- 
Regards
Vignesh
