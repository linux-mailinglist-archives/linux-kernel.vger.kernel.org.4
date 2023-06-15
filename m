Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB4F731A50
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344452AbjFONmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344451AbjFONmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:42:18 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D864C2D4B;
        Thu, 15 Jun 2023 06:41:39 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FDfPBh017065;
        Thu, 15 Jun 2023 08:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686836485;
        bh=7Jg/lJHMvQJ7MX1B2FUaeJ+bIZCApwe5zycq3lyBS8I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aPvii9De6iaEY7lQWDBqaOr8/hMRtdyimohRV1lGEFiU/ZusR5j2RankGthZvktR8
         +KWneRBVMeqEjUZhWoeN/cM+UqYJgXuYgBFNtUVB4Bv/LzvP5NaLlitxydDtrRxQN/
         MyAjqQ+WQAlaSRTttlXaBnTaC8F0SaUifouWKELI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FDfPpQ014323
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 08:41:25 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 08:41:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 08:41:25 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FDfMIL079470;
        Thu, 15 Jun 2023 08:41:22 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] Add Toradex Verdin AM62
Date:   Thu, 15 Jun 2023 19:11:20 +0530
Message-ID: <168683646819.2367452.1758333747967197723.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615095058.33890-1-francesco@dolcini.it>
References: <20230615095058.33890-1-francesco@dolcini.it>
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

Hi Francesco Dolcini,

On Thu, 15 Jun 2023 11:50:53 +0200, Francesco Dolcini wrote:
> This series adds support for the Toradex Verdin AM62 SoM which can be used on
> different carrier boards (Verdin Development Board, Dahlia and Yavia).
> 
> The module consists of an TI AM62 family SoC (either AM623 or AM625), a
> TPS65219 PMIC, a Gigabit Ethernet PHY, 512MB to 2GB of LPDDR4 RAM, an eMMC, a
> TLA2024 ADC, an I2C EEPROM, an RX8130 RTC, and optional Parallel RGB to MIPI
> DSI bridge plus an optional Bluetooth/Wi-Fi module.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] dt-bindings: arm: ti: add toradex,verdin-am62 et al.
      commit: d93dc2c99868334660bc474e35d2714102942382
[2/5] arm64: defconfig: enable drivers for Verdin AM62
      (no commit info)
[3/5] arm64: dts: ti: add verdin am62
      commit: 0e2486a5ebf4865862902a489151fb717bd09b2d
[4/5] arm64: dts: ti: add verdin am62 dahlia
      commit: 3a81b82997094d6119882ae72c3a4fddd88726fa
[5/5] arm64: dts: ti: add verdin am62 yavia
      commit: ad7c1ada8b851ff390bde7a959492fa13e0cfccc

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

