Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF140606B20
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJTWRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJTWRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:17:11 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395D321551B;
        Thu, 20 Oct 2022 15:17:08 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29KMGmK2058047;
        Thu, 20 Oct 2022 17:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666304208;
        bh=zQnSES82ipiGqNM7gc4jpefdaGHRyDoGL9iPjKpkoyU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ACL3SPCxxjsb/0PTbeY5uC7GHrhOjlfRLnKNpXCA7rO06iDVj/mYogHdYX2kXOBrZ
         BdX0oIU65+djzlM5b0d4D1tjipgdyEPj0FBtqvmO0PV6ilLuzmRQSCCLrCIQdT8Ztg
         UyLVv8pFXxo3HTYVM93PKG8FSsyJMO1zKCTQRU/g=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29KMGmLF009684
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Oct 2022 17:16:48 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 20
 Oct 2022 17:16:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 20 Oct 2022 17:16:47 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29KMGlJK014120;
        Thu, 20 Oct 2022 17:16:47 -0500
Date:   Thu, 20 Oct 2022 17:16:47 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/12] TI J7x Disable Incomplete DT Nodes
Message-ID: <20221020221647.d6pifdm2jtjpt4yk@bryanbrattlof.com>
References: <20221020160305.18711-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20221020160305.18711-1-afd@ti.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 20, 2022 thus sayeth Andrew Davis:
> Hello all,
> 
> Same story as for AM64x[0] and AM62x[1], this time for J7x.
> 
> This one was a little more involved that the last 2 rounds as some IP
> (like UART) are pinned out using the default pinmux. Perhaps we should be
> explicit here and have pinmux nodes that simply restate the defaults. I
> can go solve that in a follow up series if we think that is what we
> want to do.
> 
> I have the last round for AM65x ready to post, but that involves a few
> boards that I do not have (Simatic IOT2050) but would like to do some
> additional re-work with, so holding off until after I get that sorted.
> 
> Thanks,
> Andrew
> 
> [0] https://www.spinics.net/lists/arm-kernel/msg1018532.html
> [1] https://www.spinics.net/lists/arm-kernel/msg1018864.html
> 
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
> 

*whew* these Jacinto boards have a lot of stuff on them :) but it LGTM

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
