Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51297709EBA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjESSEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjESSET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:04:19 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2261E107;
        Fri, 19 May 2023 11:04:18 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34JI41K9123753;
        Fri, 19 May 2023 13:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684519441;
        bh=pxyRvlFpeqDhcPQM1uiU4LwtUvwW6oBAb1Z/Y2aKWnI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=M6NcYj20vRMklofcChadDLNy3CKli7JRlwfgsDVme8iM73W8qMs++Plkceatuslot
         8GV5WlFq6k9A1w5cx5zFa3jVZhhS/kAZDqQ7J0aXTLK44P6Px7na1yds78c1mTRSlb
         7BVzs000qmLnYeuUcZUXAZRxOkotXeCyEZilnsHo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34JI41sA019183
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 May 2023 13:04:01 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 May 2023 13:04:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 May 2023 13:04:01 -0500
Received: from [10.250.33.177] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34JI40ni127628;
        Fri, 19 May 2023 13:04:00 -0500
Message-ID: <8133a637-2295-6b1d-569a-381de692e330@ti.com>
Date:   Fri, 19 May 2023 13:04:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am62-main: add sa3_secproxy in
 cbass_main
Content-Language: en-US
To:     Nitin Yadav <n-yadav@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230519113434.1024206-1-n-yadav@ti.com>
 <20230519113434.1024206-3-n-yadav@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230519113434.1024206-3-n-yadav@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/23 6:34 AM, Nitin Yadav wrote:
> Add sa3_secproxy node in k3-am62-main.dtsi to keep device tree
> nodes in sync with u-boot nodes.

That is not a good reason, nodes should be added because the device
exists and should be described. Simply say that here.

> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index b3e4857bbbe4..7c2af5b0e022 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -42,6 +42,15 @@ gic_its: msi-controller@1820000 {
>   		};
>   	};
>   
> +	sa3_secproxy: secproxy@44880000 {
> +		compatible = "ti,am654-secure-proxy";

The "ti,am654-secure-proxy" binding has interrupts as a required
property, so this will cause new binding check warnings.

We also already have a Secure Proxy instance in this DT, why
do we need this other one? Is this the instance that was added
for for the R5 use? I guess that would explain why there are no
interrupts to the big ARM core.. Can we actually use this
node in Linux then? If not mark it disabled/reserved.

Andrew

> +		#mbox-cells = <1>;
> +		reg-names = "rt", "scfg", "target_data";
> +		reg = <0x00 0x44880000 0x00 0x20000>,
> +		      <0x0 0x44860000 0x0 0x20000>,
> +		      <0x0 0x43600000 0x0 0x10000>;
> +	};
> +
>   	main_conf: syscon@100000 {
>   		compatible = "syscon", "simple-mfd";
>   		reg = <0x00 0x00100000 0x00 0x20000>;
