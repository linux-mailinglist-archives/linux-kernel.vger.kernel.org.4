Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E836BB676
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjCOOsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjCOOsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:48:33 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D8A2714;
        Wed, 15 Mar 2023 07:48:31 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32FEmLKv005313;
        Wed, 15 Mar 2023 09:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678891701;
        bh=7+9A8QTOsGfnCng+WGV2/97G5RjeXWiEdM1CDDOAook=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=TOk6msmgMRvARbBJqFzb5nZHmyhnE7YDod37FtB5Nf1u3ib+qZTz8ijBbEsqxrwyu
         d7JWt0vvMNtev6lAENS4Vg9WSkXmFyyFrVVSHNoe+nnXOD6QkvxQ3hpeiPnrO3CR13
         YS96OKd1cVoNRZOX+/SQ11nDypAXq2HMnDpK7X7w=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32FEmLBJ031641
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Mar 2023 09:48:21 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 15
 Mar 2023 09:48:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 15 Mar 2023 09:48:21 -0500
Received: from [10.249.34.133] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32FEmK9q028391;
        Wed, 15 Mar 2023 09:48:20 -0500
Message-ID: <1563e38e-e561-280f-bcf3-997d3be3d256@ti.com>
Date:   Wed, 15 Mar 2023 09:48:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 0/4] Add DT support for J721E CPSW9G and J7200 CPSW5G
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20230315062307.1612220-1-s-vadapalli@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230315062307.1612220-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

On 3/15/23 1:23 AM, Siddharth Vadapalli wrote:
> Hello,
> 
> This series adds the device-tree nodes for the CPSW9G instance of CPSW
> Ethernet Switch on TI's J721E SoC and the CPSW5G instance of CPSW
> Ethernet Switch on TI's J7200 SoC. Additionally, overlays are also added
> to individually enable CPSW9G on J721E SoC and CPSW5G on J7200 SoC in
> QSGMII mode with the Add-On J7 QUAD Port Ethernet expansion QSGMII
> daughtercard.
> 
> This series combines the v2 series for J721E CPSW9G at:
> https://lore.kernel.org/r/20230310103504.731845-1-s-vadapalli@ti.com/
> and the v1 series for J7200 CPSW5G at:
> https://lore.kernel.org/r/20230310101407.722334-1-s-vadapalli@ti.com/
> 
> The suggestions for the v2 series for J721E are implemented for the J7200
> series as well in this patch series.
> 

Looks much better, thanks for the changes,

Reviewed-by: Andrew Davis <afd@ti.com>

> ---
> Changes from v2 for J721E CPSW9G series:
> 1. Rename the overlay k3-j721e-quad-port-eth-exp.dtso as
>     k3-j721e-evm-quad-port-eth-exp.dtso.
> 2. Update arch/arm64/boot/dts/ti/Makefile to build k3-j721e-evm.dtb as the
>     result of applying k3-j721e-evm-quad-port-eth-exp.dtbo to
>     k3-j721e-common-proc-board.dtb.
> 3. Use the newer "&{/} {" style instead of the "fragments" style in
>     k3-j721e-evm-quad-port-eth-exp.dtso.
> 4. Move the "mdio0_pins_default" pinctrl from cpsw0 node into the
>     "cpsw9g_mdio" node.
> 5. Disable individual "cpsw0_port" nodes in the main.dtsi file, enabling
>     only the required nodes in the overlay.
> 6. Disable the "cpsw9g_mdio" node in the main.dtsi file.
> 
> Changes from v1 for J721E CPSW9G series:
> 1. Rename node name "mdio_pins_default" to "mdio0-pins-default", since
>     node names shouldn't contain underscores.
> 2. Change node label "mdio_pins_default" to "mdio0_pins_default".
> 
> Changes from v1 for J7200 CPSW5G series:
> 1. Rename the overlay k3-j7200-quad-port-eth-exp.dtso as
>     k3-j7200-evm-quad-port-eth-exp.dtso.
> 2. Update arch/arm64/boot/dts/ti/Makefile to build k3-j7200-evm.dtb as the
>     result of applying k3-j7200-evm-quad-port-eth-exp.dtbo to
>     k3-j7200-common-proc-board.dtb.
> 3. Use the newer "&{/} {" style instead of the "fragments" style in
>     k3-j7200-evm-quad-port-eth-exp.dtso.
> 4. Move the "mdio0_pins_default" pinctrl from cpsw0 node into the
>     "cpsw5g_mdio" node.
> 5. Disable individual "cpsw0_port" nodes in the main.dtsi file, enabling
>     only the required nodes in the overlay.
> 6. Disable the "cpsw5g_mdio" node in the main.dtsi file.
> 
> J721E CPSW9G v2 series:
> https://lore.kernel.org/r/20230310103504.731845-1-s-vadapalli@ti.com/
> J721E CPSW9G v1 series:
> https://lore.kernel.org/r/20230310092804.692303-1-s-vadapalli@ti.com/
> J7200 CPSW5G v1 series:
> https://lore.kernel.org/r/20230310101407.722334-1-s-vadapalli@ti.com/
> 
> Siddharth Vadapalli (4):
>    arm64: dts: ti: k3-j721e: Add CPSW9G nodes
>    arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G ports in QSGMII
>      mode
>    arm64: dts: ti: j7200-main: Add CPSW5G nodes
>    arm64: dts: ti: k3-j7200: Add overlay to enable CPSW5G ports in QSGMII
>      mode
> 
>   arch/arm64/boot/dts/ti/Makefile               |   6 +-
>   .../ti/k3-j7200-evm-quad-port-eth-exp.dtso    | 100 +++++++++++++
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  88 ++++++++++++
>   .../ti/k3-j721e-evm-quad-port-eth-exp.dtso    | 132 ++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 116 +++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   1 +
>   6 files changed, 441 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso
> 
