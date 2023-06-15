Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0115A7319E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241196AbjFON1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241287AbjFON12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:27:28 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4622735;
        Thu, 15 Jun 2023 06:27:26 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FDRH3O014003;
        Thu, 15 Jun 2023 08:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686835637;
        bh=e2JqayMgeVvA/IBzTOt4qE8zDQV6l+OTweSpwewCVeg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=w9PIZR+pt/FbrvtfYPGzQKcKnBGsdQBB4hM0b0PKUZAEnGAFVqssIf9jZb4+majKv
         +QZgcJIQcl61iCDqTTamp9ghtGD04P2HtNVKtQpLvyM6KF+veAm9l9KiC79upqQU+X
         hBWfgPZOMD5xUApJX+HAC0MmiFyidFCzU3e2/MrM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FDRHPk055324
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 08:27:17 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 08:27:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 08:27:17 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FDREFd090523;
        Thu, 15 Jun 2023 08:27:14 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH V2 00/14] arm64: dts: ti: Fix up references to phandles
Date:   Thu, 15 Jun 2023 18:57:12 +0530
Message-ID: <168681817160.2098323.17959511532204360182.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606182220.3661956-1-nm@ti.com>
References: <20230606182220.3661956-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth Menon,

On Tue, 06 Jun 2023 13:22:06 -0500, Nishanth Menon wrote:
> When referring to array of phandles, using <> to separate the array
> entries is better notation as it makes potential errors with phandle and
> cell arguments easier to catch. Fix the outliers to be consistent with
> the rest of the usage.
> 
> This set was caught by using: git grep '\s&' arch/arm64/boot/dts/ti/
> and manually going through the list.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[01/14] arm64: dts: ti: k3-j721e-sk: Fixup reference to phandles array
        commit: 12bf41da5c3a02a9a6f8059404ba97c39a8f1852
[02/14] arm64: dts: ti: k3-j721e-som-p0/common-proc-board: Fixup reference to phandles array
        commit: 7335c987de3e4741908a032914bd3f2979898375
[03/14] arm64: dts: ti: k3-j721e-beagleboneai64: Move camera gpio pinctrl to gpio node
        commit: d528c29fa7526adf7074fb166b99df7d5fd90670
[04/14] arm64: dts: ti: k3-j721e-beagleboneai64: Move eeprom WP gpio pinctrl to eeprom node
        commit: 88875d4c70cabcb509e9836086fdf2064ef89468
[05/14] arm64: dts: ti: k3-j721e-beagleboneai64: Fixup reference to phandles array
        commit: 4a701c01e7ff96966fcf2cf9df0d3dd851197317
[06/14] arm64: dts: ti: k3-am642-phyboard-electra-rdk: Fixup reference to phandles array
        commit: 56ccd4b1eb52e153d557c7c7ae19f849e5d5c2e1
[07/14] arm64: dts: ti: k3-j7200-som/common-proc-board: Fixup reference to phandles array
        commit: a6550e2547acbcd7b01ea26d447a437140df7c43
[08/14] arm64: dts: ti: k3-j721s2-common-proc-board: Fixup reference to phandles array
        commit: 6a2baa853500d1bbe986f29aacce4a0c859bf017
[09/14] arm64: dts: ti: k3-am625-sk: Fixup reference to phandles array
        commit: 875aad10d219494bb0ef0880b1b4a33f99c98a13
[10/14] arm64: dts: ti: k3-am64-evm: Fixup reference to phandles array
        commit: bb867df51d3b7f305222405c4e01373efc8866c7
[11/14] arm64: dts: ti: k3-am64-sk: Fixup reference to phandles array
        commit: 0e97d245633bffc0ae348c95f98a2af5b973811c
[12/14] arm64: dts: ti: k3-am65-iot*: Fixup reference to phandles array
        commit: f722090aeb70ca67b5f5a37a39a26fca29664dce
[13/14] arm64: dts: ti: k3-am654-base-board: Fixup reference to phandles array
        commit: 9da060be7491cc67323b8f4386ebc4524eba5970
[14/14] arm64: dts: ti: k3-am68-sk-base-board: Fixup reference to phandles array
        commit: 918ef215db22b18b75292b6e5bcb763ce27e0483

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

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh

