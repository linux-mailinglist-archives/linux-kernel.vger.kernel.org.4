Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9CC6B3CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCJKyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCJKx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:53:56 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0935F8E79;
        Fri, 10 Mar 2023 02:53:47 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32AArfvJ115600;
        Fri, 10 Mar 2023 04:53:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678445621;
        bh=41Zx3qFHWjyM5PIkEb3swc2qxePmA2Y3iWGeDIR/8QM=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=f7SCpOhU8BE1x5DxNfcZC4ECm8htRbIbRN3JBSDwKTijaefEORIMu6Q7ri6Quyfqi
         EIqnoT8XnSO1QiIAfNfvuYWo1aKxS5dP9tRUM9wdH1QX/Qq9ndzhGCdzgdgDdPJPhY
         3NNoLIww6qVX9w+kddXpCgRvtcPUVMx7WgkTvxro=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32AArfK8085794
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Mar 2023 04:53:41 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 10
 Mar 2023 04:53:41 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 10 Mar 2023 04:53:41 -0600
Received: from [172.24.145.61] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32AArbn0028520;
        Fri, 10 Mar 2023 04:53:38 -0600
Message-ID: <a0136dee-7ee3-6681-81f1-fb646136b5e7@ti.com>
Date:   Fri, 10 Mar 2023 16:23:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH 0/2] Add device-tree support for CPSW5G on J7200 SoC
Content-Language: en-US
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
References: <20230310101407.722334-1-s-vadapalli@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230310101407.722334-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series depends on the series at:
https://lore.kernel.org/r/20230310103504.731845-1-s-vadapalli@ti.com
and will cause merge conflict if merged before it.

Regards,
Siddharth.

On 10/03/23 15:44, Siddharth Vadapalli wrote:
> Hello,
> 
> This series adds the device-tree nodes for CPSW5G instance of CPSW
> Ethernet Switch on TI's J7200 SoC. Additionally, an overlay file is also
> added to enable CPSW5G nodes in QSGMII mode with the Add-On J7 QUAD Port
> Ethernet expansion QSGMII daughtercard.
> 
> Siddharth Vadapalli (2):
>   arm64: dts: ti: j7200-main: Add CPSW5G nodes
>   arm64: dts: ti: k3-j7200: Add overlay to enable CPSW5G ports in QSGMII
>     mode
> 
>  arch/arm64/boot/dts/ti/Makefile               |   2 +
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  83 +++++++++++++++
>  .../dts/ti/k3-j7200-quad-port-eth-exp.dtso    | 100 ++++++++++++++++++
>  3 files changed, 185 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-quad-port-eth-exp.dtso
> 
