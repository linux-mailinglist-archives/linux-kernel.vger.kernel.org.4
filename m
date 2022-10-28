Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368D66112CC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiJ1Nb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiJ1NbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:31:05 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBEAA3B50;
        Fri, 28 Oct 2022 06:31:00 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SDUsHZ014769;
        Fri, 28 Oct 2022 08:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666963854;
        bh=YNmEL+4el6A4/n1wHclSSQcRxCbdsl7QUONYIy+L2Ps=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IJLYwdGcq1alUDnJ+h255/zN/eQujh1jEPN7pP+YYpYmIuWcQ8uKH3GkmFfdPtQQ/
         5lLrqP0KQxqvOnC5h+MeBN8+Fqidnv/jERlWupuk1chQxMCw6ttaz6fMt/Z+aU1TyQ
         FsAwI9a2FqVkiRO6uXIW7HtV72UgYXxWDTG4AUU0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SDUs8d031963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 08:30:54 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 08:30:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 08:30:54 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SDUseQ052554;
        Fri, 28 Oct 2022 08:30:54 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <afd@ti.com>
CC:     Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 00/10] AM64x Disable Incomplete DT Nodes
Date:   Fri, 28 Oct 2022 08:30:52 -0500
Message-ID: <166696382813.13332.11282110313952274375.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221017192532.23825-1-afd@ti.com>
References: <20221017192532.23825-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew Davis,

On Mon, 17 Oct 2022 14:25:22 -0500, Andrew Davis wrote:
> This series goes through the AM64x dtsi and disables the set of nodes
> that are not functional without additional board level information.
> This is usually pinmux data, but can also be inernal device resources.
> 
> Only when the node is completed in the board file should the node be
> enabled. This helps prevents nodes that represent IP that are not
> pinned-out on a given board from being left enabled.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[01/10] arm64: dts: ti: k3-am64: Enable UART nodes at the board level
        commit: dacf4705cee54eef4406a886a0a50a6f445969f8
[02/10] arm64: dts: ti: k3-am64: Enable I2C nodes at the board level
        commit: b80f75d8f68cad4efa250e4a3152932f59c756cc
[03/10] arm64: dts: ti: k3-am64: Enable SPI nodes at the board level
        commit: 79d4aa623f6c9d47aa29b6b4a3fa46c09f74bfae
[04/10] arm64: dts: ti: k3-am64: Enable EPWM nodes at the board level
        commit: ebc0ed718da346d651b356cb71dddfb747c934fa
[05/10] arm64: dts: ti: k3-am64: Enable ECAP nodes at the board level
        commit: dcac8eaaa90fe2c84761cf55a3e989ca5774d2f5
[06/10] arm64: dts: ti: k3-am64: Enable PCIe nodes at the board level
        commit: 3e21ec289c76dbc88dc306802122214b6b053a99
[07/10] arm64: dts: ti: k3-am64: MDIO pinmux should belong to the MDIO node
        commit: aa62d661247f180d0fc534e880cb6bc7fb50b4a1
[08/10] arm64: dts: ti: k3-am64: Enable MDIO nodes at the board level
        commit: f572888b3c10bf12436423e854f6ee6e3872c570
[09/10] arm64: dts: ti: k3-am64: Enable MCAN nodes at the board level
        commit: 4a57988707d7c7502842de07d6c8649da5a844fc
[10/10] arm64: dts: ti: k3-am64: Enable GPMC and ELM nodes at the board level
        commit: 4eb7aa3befa33c05a03d11fd3b4bb8b74d3c68c0

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

