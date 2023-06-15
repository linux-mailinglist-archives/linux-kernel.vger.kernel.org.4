Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1202B7319F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343644AbjFON3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344137AbjFON2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:28:45 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85552272A;
        Thu, 15 Jun 2023 06:28:44 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FDScrn033292;
        Thu, 15 Jun 2023 08:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686835718;
        bh=sS1L684dTZiD+iT9IxSE0z1OIF0CJl4nb9xUZEsV2jQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EzMaIDe2n0hgf/a0JGMVCjfAhcftPSte9nEat0BN0AtxwNFdswVCy0Hs+A+QTVTY6
         Jy1kS4TxYSEHFJZzHvY0hqsNSZ+T9ewjBmgAEpFeUoKOnkror0YEZ4ywmQ33fllOya
         CUxzg8EOV+gZVVUW6iqqpLDAVrWtpkEcCxs+SRDI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FDScFG006476
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 08:28:38 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 08:28:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 08:28:38 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FDSXwp091382;
        Thu, 15 Jun 2023 08:28:34 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Udit Kumar <u-kumar1@ti.com>, Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>,
        Thejasvi Konduru <t-konduru@ti.com>,
        Dasnavis Sabiya <sabiya.d@ti.com>
Subject: Re: [PATCH 0/8] arm64: dts: ti: k3-j784s4/am69: Add uart, i2c, eeprom, misc
Date:   Thu, 15 Jun 2023 18:58:31 +0530
Message-ID: <168682622738.2286657.11314390186712296144.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602214937.2349545-1-nm@ti.com>
References: <20230602214937.2349545-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth Menon,

On Fri, 02 Jun 2023 16:49:29 -0500, Nishanth Menon wrote:
> This series picks up from where [1] left off. After fixing the mux
> regions, introduce the basic i2c, uarts, ethernet, and a few alias
> fixups sprinkled along with it.
> 
> This series also takes over [2] and rebased on top of [1] and my series.
> 
> Test log:
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/8] arm64: dts: ti: k3-j784s4-evm: Fix main_i2c0 alias
      commit: c10a9df30e3401bd5a5ee43f1afd6c2b2ca75ad7
[2/8] arm64: dts: ti: k3-j784s4-evm: Add mcu and wakeup uarts
      commit: 6fa5d37a2f34476613012789d4618c3dc6c68b35
[3/8] arm64: dts: ti: k3-j784s4-evm: Enable wakeup_i2c0 and eeprom
      commit: 5dfbd1debc8ce5123310265cd44b5d99d272b1fe
[4/8] arm64: dts: ti: k3-am69-sk: Fix main_i2c0 alias
      commit: b38c6ced4ec5b3f6260ff6cc2b71e8a3d8c897d7
[5/8] arm64: dts: ti: k3-am69-sk: Enable mcu network port
      commit: 7b72bd25508de6a5eee2cb1679b9d4b8bc25de5a
[6/8] arm64: dts: ti: k3-am69-sk: Add mcu and wakeup uarts
      commit: 45299dd1991b496ddab5ab4a86d7ae601e0e4c7f
[7/8] arm64: dts: ti: k3-am69-sk: Enable wakeup_i2c0 and eeprom
      commit: 08ae12b637507cd22fbcdb82521b8b8a5ae96222
[8/8] arm64: dts: ti: k3-am69-sk: Add pinmux for RPi Header
      commit: 0ec1a48d99ddd11c265f7f1b2573fb2c8e0db0ab

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

