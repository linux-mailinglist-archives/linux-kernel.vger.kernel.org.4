Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A11C6112C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJ1NaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJ1N34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:29:56 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238FB1742B;
        Fri, 28 Oct 2022 06:29:45 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SDTejI014528;
        Fri, 28 Oct 2022 08:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666963780;
        bh=O814OcMDbq0Qs3dDWLOdqya5RqPTf374x/V26mUqEso=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=TQ6urxmiuASz1rXo1GG4/JWPl0ksohQXr7hajywkXzvzIZkFhBR9c8Zl+TqJ1rICd
         lWcZ1z7XOUi/3KYV02lnjjWZelBoPvUJ7Zg9mZMmDKbNYCuc96IQNPiS2RPsBz8LUH
         JxBk0FXzkDpBRHukLA9dBsrUJDWupkDWHe7hT1+g=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SDTeAU029963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 08:29:40 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 08:29:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 08:29:40 -0500
Received: from [10.250.232.28] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SDTaWW015286;
        Fri, 28 Oct 2022 08:29:37 -0500
Message-ID: <89a96cd3-f091-f1ca-7fd9-ffcb1b62eb40@ti.com>
Date:   Fri, 28 Oct 2022 18:50:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 00/12] TI J7x Disable Incomplete DT Nodes
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221020160305.18711-1-afd@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20221020160305.18711-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/10/22 9:32 pm, Andrew Davis wrote:
> Andrew Davis (12):
>   arm64: dts: ti: k3-j721e: Enable UART nodes at the board level
>   arm64: dts: ti: k3-j721e: Enable I2C nodes at the board level
>   arm64: dts: ti: k3-j721e: Enable MCASP nodes at the board level
>   arm64: dts: ti: k3-j721e: Enable MCAN nodes at the board level
>   arm64: dts: ti: k3-j7200: Enable UART nodes at the board level
>   arm64: dts: ti: k3-j7200: Enable I2C nodes at the board level
>   arm64: dts: ti: k3-j721s2: Enable UART nodes at the board level
>   arm64: dts: ti: k3-j721e: Enable Mailbox nodes at the board level
>   arm64: dts: ti: k3-j7200: Enable Mailbox nodes at the board level
>   arm64: dts: ti: k3-j721s2: Enable Mailbox nodes at the board level
>   arm64: dts: ti: k3-j721s2: Enable MCAN nodes at the board level
>   arm64: dts: ti: k3-j721s2: Enable I2C nodes at the board level
> 
>  .../dts/ti/k3-j7200-common-proc-board.dts     |  48 ++----
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  29 ++++
>  .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |   5 +
>  arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   |  42 +----
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 141 +++-------------
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |  55 ++++++
>  .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   7 +
>  arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 158 ++----------------
>  arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   |  33 +---
>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 132 +--------------
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    |  58 +++++++
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |   7 +
>  arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  98 +----------
>  13 files changed, 231 insertions(+), 582 deletions(-)

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>

