Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B47C718814
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjEaRIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjEaRH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:07:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ADA18B;
        Wed, 31 May 2023 10:07:53 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34VH7hpT043694;
        Wed, 31 May 2023 12:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685552863;
        bh=tQX/X9ADA125sR0RTWyJnMsQq2TMFr67uEYkSDqfkEg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Q9vXISPZM7JqonSwGUVxvvZuiNWvt4FThlvk1gUyDmTnEb475DrBhfuL5xZKBNwwK
         ZLBFagHrhtFZTmnXnoHiJ0WbYIcapWAb03dZUOdnpJ/kt7TOKVH3YY1zaXTs7Yj/hl
         ONPLHYyWg6PyYj9XeRQN6dzwRgwKtCV0wZGIWuzI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34VH7hhl091496
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 May 2023 12:07:43 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 May 2023 12:07:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 May 2023 12:07:43 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34VH7c7J009279;
        Wed, 31 May 2023 12:07:39 -0500
Message-ID: <e25936b9-d85c-dfe8-0eb1-07b51fdfff1e@ti.com>
Date:   Wed, 31 May 2023 22:37:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/7] arm64: dts: ti: k3-j7200-mcu: Add mcu_secproxy
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nitin Yadav <n-yadav@ti.com>, Andrew Davis <afd@ti.com>
References: <20230530165900.47502-1-nm@ti.com>
 <20230530165900.47502-5-nm@ti.com>
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230530165900.47502-5-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth

On 5/30/2023 10:28 PM, Nishanth Menon wrote:
> MCU domain has it's own secure proxy for communicating with ROM and
> for R5 micro controller firmware operations. This is in addition to
> the one in the main domain NAVSS subsystem that is used for general
> purpose communication.
>
> Describe the node for use with bootloaders and firmware that require
> this communication path which uses interrupts to corresponding micro
> controller interrupt controller. Mark the node as disabled since this
> instance does not have interrupts routed to the main processor by
> default for a complete description of the node.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> New patch
>
>   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 674e695ef844..dff23b258240 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -209,6 +209,21 @@ mcu_udmap: dma-controller@285c0000 {
>   		};
>   	};
>   
> +	secure_proxy_mcu: mailbox@2a480000 {
I think, we should start name as  mailbox@2a380000
> +		compatible = "ti,am654-secure-proxy";
> +		#mbox-cells = <1>;
> +		reg-names = "target_data", "rt", "scfg";
> +		reg = <0x0 0x2a480000 0x0 0x80000>,
> +		      <0x0 0x2a380000 0x0 0x80000>,
> +		      <0x0 0x2a400000 0x0 0x80000>;

I think, we should have increasing order for reg. Unless there is some 
strong reason to keep in this way.

> +		/*
> +		 * Marked Disabled:
> +		 * Node is incomplete as it is meant for bootloaders and
> +		 * firmware on non-MPU processors
> +		 */
> +		status = "disabled";
> +	};
> +
>   	mcu_cpsw: ethernet@46000000 {
>   		compatible = "ti,j721e-cpsw-nuss";
>   		#address-cells = <2>;
