Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264E76112D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiJ1Nb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiJ1Nbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:31:32 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5451D4431;
        Fri, 28 Oct 2022 06:31:31 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SDVOV5012750;
        Fri, 28 Oct 2022 08:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666963884;
        bh=vbBf/+4TnJs87J725DwYnXl+fYl3HWX+7jwAnoxnCUM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=horsq3bNXIx2wYbndA4scsxAdayDteSI0uxXozf5mzWArfkyof0xDGEASCHkvvASb
         4dlvVI4uxIm51AgxXKggJo6psXGK8EOLHipGNoSj/RduG/mW8fdiqP06jyMpsOa/Ks
         2gvISfXohsMyxVToeYfo+zP1ne/DtcPI1XO8Tnc4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SDVOrx016228
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 08:31:24 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 08:31:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 08:31:23 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SDVN5J053573;
        Fri, 28 Oct 2022 08:31:24 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <linux-kernel@vger.kernel.org>, <afd@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <bb@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 00/10] AM62x Disable Incomplete DT Nodes
Date:   Fri, 28 Oct 2022 08:31:22 -0500
Message-ID: <166696386565.13625.17976605291962468095.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221018211533.21335-1-afd@ti.com>
References: <20221018211533.21335-1-afd@ti.com>
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

On Tue, 18 Oct 2022 16:15:23 -0500, Andrew Davis wrote:
> Same story as for AM64x[0], this time for AM62x. If there
> are no objections here then the J7x platforms are next.
> 
> Thanks,
> Andrew
> 
> [0] https://www.spinics.net/lists/arm-kernel/msg1018532.html
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[01/10] arm64: dts: ti: k3-am62: Enable UART nodes at the board level
        commit: b5877d9b409cfd5667813e667cbc27192a0fb9ea
[02/10] arm64: dts: ti: k3-am62: Enable I2C nodes at the board level
        commit: a1541a08bbf9d02f842801261d0dd4505bcd29e0
[03/10] arm64: dts: ti: k3-am62: Enable SPI nodes at the board level
        commit: 361e8b7144405b78bd37cc3e9b2d23fc2e2ed6d5
[04/10] arm64: dts: ti: k3-am62: Enable EPWM nodes at the board level
        commit: 6e5474826606a783dd969467f93b0c6a56c39780
[05/10] arm64: dts: ti: k3-am62: Enable ECAP nodes at the board level
        commit: ffd61c16fe8facf56b6fb06e29ba5bd150f01bd9
[06/10] arm64: dts: ti: k3-am62: MDIO pinmux should belong to the MDIO node
        commit: 8709e0442c79c03f7067d6e7464d669504f76527
[07/10] arm64: dts: ti: k3-am62: Enable MDIO nodes at the board level
        commit: 1f737012ce7bd92aecf7d6b1e17742dc7cae7bee
[08/10] arm64: dts: ti: k3-am62: Enable MCAN nodes at the board level
        commit: 2f6d7e18e73d3bd3752ca16d0b3c6b2926809452
[09/10] arm64: dts: ti: k3-am62: Enable SDHCI nodes at the board level
        commit: b2b10301ca685ac23f09d2e663eb4b990b871935
[10/10] arm64: dts: ti: k3-am62: Enable OSPI nodes at the board level
        commit: b0ca32e895680ba94c0ef24a5faa738e536e31cc

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

