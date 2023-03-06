Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50FB6AC133
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjCFNdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjCFNc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:32:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617382F78C;
        Mon,  6 Mar 2023 05:32:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 169EDCE127A;
        Mon,  6 Mar 2023 13:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD95C433A1;
        Mon,  6 Mar 2023 13:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678109546;
        bh=r2YevUTaEioy0IiiN4oIORAATS724rvNMW2/rHghHCQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=T25nklooE0ahT7WUzKCeUE4BraSm+vDbPKMRF2OXSEFIP+4lRgO7Wshph58T3JAt3
         jniU6sOuca3s247kwAySQQkJH//HS4IeA7hnjgcyObifJnRGe2VxXSk4uuHzklwXFP
         /YUGrbi3SYG2cNwJtRH4DESQD48Yemx5ZkxuYPsjJD+A9qvQtvKQlc/CeX+6XGgKSf
         ieeoU/3jHTvqm9V3K5lHQYKINzJ2vMrroqmO+XPvZfLkb52ZHTIwFnZwL/Wsw3zTWp
         YEaJqY6KYe1uutES9F7wKJ4CSW4D0w9bF75y1vd13a95U1JEtBM5yKmPEKYTaI14oP
         79dlnmO/CpwlQ==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Qiu <william.qiu@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ziv Xu <ziv.xu@starfivetech.com>
In-Reply-To: <20230302105221.197421-1-william.qiu@starfivetech.com>
References: <20230302105221.197421-1-william.qiu@starfivetech.com>
Subject: Re: [PATCH v1 0/2] Add Quad SPI driver for StarFive JH7110 SoC
Message-Id: <167810954467.76172.7217821282766106312.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 13:32:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Mar 2023 18:52:19 +0800, William Qiu wrote:
> This patchset adds initial rudimentary support for the StarFive
> Quad SPI controller driver. And this driver will be used in
> StarFive's VisionFive 2 board.The first patch constrain
> minItems/maxItems of resets for JH7110 QSPI and Patch 2 adds
> support for StarFive JH7110 QSPI.
> 
> The patch series is based on v6.2.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: qspi: cdns,qspi-nor: constrain minItems/maxItems of resets
      commit: 13f1033e07588b7d1151d22d7ee3ca8f16181de7
[2/2] spi: cadence-quadspi: Add support for StarFive JH7110 QSPI
      commit: 47fef94afeae2a125607b6b45145594713471320

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

