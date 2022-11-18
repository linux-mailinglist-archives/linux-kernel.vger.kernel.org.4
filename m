Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A8F62F6C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbiKROEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiKROEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:04:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4285DBBB;
        Fri, 18 Nov 2022 06:04:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD105B823FF;
        Fri, 18 Nov 2022 14:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DD3C433C1;
        Fri, 18 Nov 2022 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668780279;
        bh=9yheBu0E5q+IcHeJfS1FhBxw8JfmFK6j4Pq/GK5sFX4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BPEidOVDG18TFLDhuwwd01okKzwhGRscdNNGrtf4z3du1qE173znNmKrsPjSsxOO+
         2Rl7v2p+7bIp5mQatV6JfknBBGO3vjIMW69Zp3JN+ThrMo/Lv3qmsPx5CeEIfQSlOH
         GGC8WB3PdVP+o/zEwfqgWMxapTbOlgsA2dPGQPHmoWRNrmg0FXiL/qCjRwnK4JgPaR
         IsmSX00Tv/jdbbYKNje9janKTI/Tm7bPFa/gi2CppWO8jrjYzjgqTuzsNMOLr12n8H
         RSsMXEIl+KAIhchiKHwAIRvGMbAaH/+IbV7dqIjDfGQ1sbb/a2PR4Xr9Lk3xi4nXjc
         tWJBxu56OQvxQ==
From:   Mark Brown <broonie@kernel.org>
To:     alexandre.belloni@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        nicolas.ferre@microchip.com, robh+dt@kernel.org,
        claudiu.beznea@microchip.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
In-Reply-To: <20221117105249.115649-1-tudor.ambarus@microchip.com>
References: <20221117105249.115649-1-tudor.ambarus@microchip.com>
Subject: Re: (subset) [PATCH 0/8] spi: Introduce spi-cs-setup-ns dt property
Message-Id: <166878027633.872789.16689184742126026549.b4-ty@kernel.org>
Date:   Fri, 18 Nov 2022 14:04:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 12:52:41 +0200, Tudor Ambarus wrote:
> SPI NOR flashes have specific cs-setup time requirements without which
> they can't work at frequencies close to their maximum supported frequency,
> as they miss the first bits of the instruction command. Unrecognized
> commands are ignored, thus the flash will be unresponsive. Introduce the
> spi-cs-setup-ns property to allow spi devices to specify their cs setup
> time.
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/8] spi: dt-bindings: Introduce spi-cs-setup-ns property
      commit: f6c911f3308c1cfb97ae1da6654080d7104e2df2
[2/8] spi: Introduce spi-cs-setup-ns property
      commit: 33a2fde5f77bd744b8bd0c694bc173cc968e55a5
[3/8] spi: Reintroduce spi_set_cs_timing()
      commit: 684a47847ae639689e7b823251975348a8e5434f
[4/8] spi: atmel-quadspi: Add support for configuring CS timing
      commit: f732646d0ccd22f42ed7de5e59c0abb7a848e034

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
