Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B1B692C4E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjBKAyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBKAyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:54:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0904C7FEF2;
        Fri, 10 Feb 2023 16:54:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A2D5B82657;
        Sat, 11 Feb 2023 00:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A46C433D2;
        Sat, 11 Feb 2023 00:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676076858;
        bh=yt97aBQpCfcRc66XUblzdp8nwkFSLAY1fGBKH97Mnoc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LtaBBXj57r0jydp+wl1Ll7p2JyXn9qdY0l6Y6O2tmh/BigxgVAEKxMq8IwJkewQEA
         cK50Ccn85tVvJAziK0yoggLVfKpG4Cf5d6cSEx3d43a56oEVAOz8+woAOsjoIPVsZJ
         j00vJPPosyaDfPcc+QGDE950/NsSN9Uyzo3Y06r16KAcnve7a4+QRJXrC65OSZld75
         a9nlAdudiExhFAnbBO+glpJhKhY9l7jmasnsVxlgw6IOJQkpKg0u6myciQ1PQG3qKJ
         0qU3/d6tv8Ta+/UWoDqZ+xIqCOpbgZq4zXz6b4Cei/6QUR5+5V1p8Tj7P9lv0hKO2O
         z0oBQLDEJNx6A==
From:   Mark Brown <broonie@kernel.org>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>
Cc:     f.fainelli@gmail.com, dregan@mail.com, joel.peshkin@broadcom.com,
        dan.beygelman@broadcom.com, anand.gore@broadcom.com,
        kursad.oney@broadcom.com, tomer.yacoby@broadcom.com,
        jonas.gorski@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230209200246.141520-1-william.zhang@broadcom.com>
References: <20230209200246.141520-1-william.zhang@broadcom.com>
Subject: Re: (subset) [PATCH v4 00/15] spi: bcm63xx-hsspi: driver and doc
 updates
Message-Id: <167607685438.1700011.1415945825989404804.b4-ty@kernel.org>
Date:   Sat, 11 Feb 2023 00:54:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Feb 2023 12:02:31 -0800, William Zhang wrote:
> This patch series include the accumulative updates and fixes for the
> driver from Broadcom. It also added a new driver for the updated SPI
> controller found in the new BCMBCA SoC. The device tree document is
> converted to yaml format and updated accordingly.
> 
> Changes in v4:
> - Add Reviewed-by tag in patch 2
> - Update patch 8 based on latest linux spi git for-next branch code
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[08/15] spi: export spi_transfer_cs_change_delay_exec function
        commit: 6e80133abeb09721ec4601de5b1e68be67135309
[09/15] spi: bcm63xx-hsspi: Handle cs_change correctly
        commit: c00d5e93ea018786d98670fc1d0dab4c36c2217c
[10/15] spi: bcm63xx-hsspi: Fix multi-bit mode setting
        commit: 811ff802aaf878ebbbaeac0307a0164fa21e7d40
[11/15] spi: bcm63xx-hsspi: Add prepend mode support
        commit: b7a82103f7c3a9168f0077e35688d4f9ce97294e
[12/15] spi: spi-mem: Allow controller supporting mem_ops without exec_op
        commit: 76a85704cb917e3b25e00f02d5fd46e4e0a9077d
[13/15] spi: bcm63xx-hsspi: Disable spi mem dual io read op support
        commit: c6182a187b33cd00a763ac2490c0f5210b2c4742
[14/15] spi: bcmbca-hsspi: Add driver for newer HSSPI controller
        commit: a38a2233f23b568ca06ca679fb2327447d6b0224
[15/15] MAINTAINERS: Add entry for Broadcom Broadband SoC HS SPI drivers
        commit: 80323599e33f9c19287a1a3707481fb157b27052

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

