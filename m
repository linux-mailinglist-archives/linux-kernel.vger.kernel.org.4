Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F4B724A05
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbjFFRTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbjFFRSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:18:51 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BA210F0;
        Tue,  6 Jun 2023 10:18:50 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356HIfpj031547;
        Tue, 6 Jun 2023 12:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686071921;
        bh=rOMVYREIYcTY5QVHtGg5rm/dGOdQDWqSaarwfoS2GME=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GmpxcAOO+lwy/aHXvt3uDYAT1AzVoj1hF6DHaLsAj+mwEJVN55MAKTLJPT90FOkER
         vWXONL6TONyclKTf13Bc0Xo+pFrOifivFskp5A/75X/fkrvPBl3esEoay3p6s+VqG5
         vVov0wnIpP1CAvdalABr3JEOxm0p64DFr352NoTQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356HIfEH044960
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 12:18:41 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 12:18:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 12:18:40 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356HIbYm040556;
        Tue, 6 Jun 2023 12:18:38 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH V2 0/5] arm64: dts: ti: Drop bootargs
Date:   Tue, 6 Jun 2023 22:48:22 +0530
Message-ID: <168607161907.2072651.9268020209509725261.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230419141222.383567-1-nm@ti.com>
References: <20230419141222.383567-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth Menon,

On Wed, 19 Apr 2023 09:12:17 -0500, Nishanth Menon wrote:
> The bootargs atm contains (generally) two information: console and
> earlycon - console is already covered by stdout-path and earlycon is
> really meant to be used when debug is needed and not something of a
> default to spin out to all users.
> 
> This has come up multiple times, so cleaning it all up.
> See [1] for context. AM64 is covered in [2]. There are quite a few other
> instances of the same in mailing list[3].
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: k3-am62x-sk-common: Drop bootargs
      commit: d525ef9c7f077bfa8202b4b47ca9242ab936a1dc
[2/5] arm64: dts: ti: k3-am65*: Drop bootargs
      commit: da4159a776593f802ee211ad4823f3aed31e5375
[3/5] arm64: dts: ti: k3-j721e-*: Drop bootargs
      commit: af2cda7df7769d3353170b6a72d73bc4ea703480
[4/5] arm64: dts: ti: k3-j7200-common-proc-board: Drop bootargs
      commit: f920c49f1e46a99c410e2aaf486ffb7ce3d12270
[5/5] arm64: dts: ti: k3-j721s2-common-proc-board: Drop bootargs
      commit: cf82a026f54f54c241903add9b9bdbeb2a449db0

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

