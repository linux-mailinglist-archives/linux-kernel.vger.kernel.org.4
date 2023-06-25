Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220F073CE7B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 06:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjFYE5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 00:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFYE5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 00:57:36 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64EFE5D;
        Sat, 24 Jun 2023 21:57:34 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35P4vH4I019459;
        Sat, 24 Jun 2023 23:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687669037;
        bh=f8R3tgkj1lB6IQ8lBtLZdh5ReA80XcOWgHrdyy8mSjw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=gbmRW1jykXhifY/+UsMimcHY6RtDelSaaV/n7TaEyiJIIwz3H/iIo9W2SOqH2SFl3
         FEdtBWr21Jb8PyqQg3o0nr1EudmJVFix+OveyMEXwSKvOJ/YNccmYUIin86rw6wU13
         jDDDITuUBDg0aygO+Z1HhXymulvyIbvnwxlAKGew=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35P4vH19078089
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 24 Jun 2023 23:57:17 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Jun 2023 23:57:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Jun 2023 23:57:17 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35P4vDSU105002;
        Sat, 24 Jun 2023 23:57:14 -0500
Message-ID: <0070e00a-89c0-9b2b-8753-e1835b5aad15@ti.com>
Date:   Sun, 25 Jun 2023 10:27:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4] arm64: dts: ti: k3-j721s2: Add support for CAN
 instances 3 and 5 in main domain
To:     Bhavya Kapoor <b-kapoor@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
References: <20230622185100.12197-1-b-kapoor@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230622185100.12197-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Bhavya

On 6/23/2023 12:21 AM, Bhavya Kapoor wrote:
> CAN instances 3 and 5 in the main domain are brought on the common
> processor board through header J27 and J28. The CAN High and Low lines
> from the SoC are routed through a mux on the SoM. The select lines need
> to be set for the CAN signals to get connected to the transceivers on
> the common processor board. Threfore, add respective mux, transceiver
> dt nodes to add support for these CAN instances.
> [...]
>   
> +	mux0: mux-controller@0 {
> +		compatible = "gpio-mux";
> +		#mux-state-cells = <1>;
> +		mux-gpios = <&exp_som 1 GPIO_ACTIVE_HIGH>;
> +	};
> +


You will get more warning with @0 and @1

   DTC_CHK arch/arm64/boot/dts/ti//k3-j721s2-common-proc-board.dtb
/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dtb: /: 
mux-controller@0: 'anyOf' conditional failed, one must be fixed:
         'reg' is a required property
         'ranges' is a required property
         From schema: 
/home/udit/.local/lib/python3.10/site-packages/dtschema/schemas/root-node.yaml
/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dtb: /: 
mux-controller@1: 'anyOf' conditional failed, one must be fixed:
         'reg' is a required property
         'ranges' is a required property

> +	mux1: mux-controller@1 {
> +		compatible = "gpio-mux";
> +		#mux-state-cells = <1>;
> +		mux-gpios = <&exp_som 2 GPIO_ACTIVE_HIGH>;
> +	};
> +
>   	transceiver0: can-phy0 {
>   		/* standby pin has been grounded by default */
>   		compatible = "ti,tcan1042";
