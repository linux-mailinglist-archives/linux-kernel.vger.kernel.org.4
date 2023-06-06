Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A8F724A26
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbjFFRZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjFFRZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:25:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F35E42;
        Tue,  6 Jun 2023 10:25:20 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356HPBsT032729;
        Tue, 6 Jun 2023 12:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686072311;
        bh=WtY6LblahE/joq91g99eyQWj4duOr1M1WEmEUEPrxIw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rQLvCliDEAh3b8HOfSZIkM7zDIjGlUDCcGr4qSVLwdn8kKU2ZEYZKNRgTTBI184Kc
         nHT3eVnoVoY7niRBrvMVdF2iLiGgt1SjrSIjeWkLTCij9eHPG8Qb/wWFvMq/DJFxsI
         3N0Op/KFsg2yiSfxh2z5woxc3+Wcv+2shyaHpAyE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356HPBGM049268
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 12:25:11 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 12:25:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 12:25:10 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356HP7eU108772;
        Tue, 6 Jun 2023 12:25:08 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 0/7] arm64: dts: ti: k3-am65: Cleanups and minor additions
Date:   Tue, 6 Jun 2023 22:55:01 +0530
Message-ID: <168607229292.2083722.2030065242930574931.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230419225913.663448-1-nm@ti.com>
References: <20230419225913.663448-1-nm@ti.com>
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

On Wed, 19 Apr 2023 17:59:06 -0500, Nishanth Menon wrote:
> This is a result of looking to cleanup u-boot and realizing there are
> pieces missing in kernel that need to be pushed out.
> 
> So, minor cleanups and adding a few missing pieces.
> 
> Bootlog: https://gist.github.com/nmenon/f4dc43aef616dfcb3d38701cc074ff6d
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/7] arm64: dts: ti: k3-am654-base-board: Add missing pinmux wkup_uart, mcu_uart and mcu_i2c
      commit: 3ae28642a110485f71091f0a631492e78b396b2b
[2/7] arm64: dts: ti: k3-am654-base-board: Rename regulator node name
      commit: ec1b54824f022a7e65d858abbe74f5d7effc9817
[3/7] arm64: dts: ti: k3-am654-base-board: Add VTT GPIO regulator for DDR
      commit: 5292f504827c56406975b463eda1270d144cf06f
[4/7] arm64: dts: ti: k3-am654-base-board: Add missing PMIC
      commit: 282621ed6e790ccf7288c4c0aadbb34f1fe25c11
[5/7] arm64: dts: ti: k3-am654-base-board: Add board detect eeprom
      commit: 895e2f4f9852e54c0e6d16ddea9882b9b2065eae
[6/7] arm64: dts: ti: k3-am654-base-board: Add aliases
      commit: 692e8888a84357232574caba74f60ceea7364016
[7/7] arm64: dts: ti: k3-am65: Drop aliases
      commit: ffc449e016e269ce4d19e648bae584f8e5afd59f

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

