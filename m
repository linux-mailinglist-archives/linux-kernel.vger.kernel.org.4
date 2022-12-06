Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CF86448D3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiLFQJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbiLFQJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:09:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49229391FB;
        Tue,  6 Dec 2022 08:04:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9560FB81AA7;
        Tue,  6 Dec 2022 16:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263CDC433C1;
        Tue,  6 Dec 2022 16:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670342665;
        bh=Szlr9bhRSHRa3/F8OFwm0BojO1dnfBM+g8JhZoyroVQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EuHdyOO7jfOqgp/M50bX1Vr0lYkcoMJ0gPiTJr33pdky/0JRMb+5J+sZBvWEU0ENI
         s264f0V25aj0eqe7VkWzwOS6m7wqx02l7A1MI+USSIqWtVOgFPwF6S1k1JLPWRgOaz
         L5PSESakgZf5/kmeSOY6ZM+JSIYiTYhs8zi2krXQwXnlJz+/bGfWEhUTgTWuQBY8rX
         8f2EZtwSdGdJS5ZOizfU6w4fUGlunL/X8/vd+vbPVB+5qMpfhszUeemCdaXdaxCTuP
         pw0EnSbeFcNeFDfRtEiY4QJo3HIAvrOjJlka1Sy6vacGHi3kbxiQySBwsVkhC9+KES
         PRzMbhZbDP2PA==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
Subject: Re: (subset) [PATCH v2 0/9] Add MediaTek MT7986 SPI NAND and ECC support
Message-Id: <167034266187.169562.7872281598428362203.b4-ty@kernel.org>
Date:   Tue, 06 Dec 2022 16:04:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-da105
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 14:57:47 +0800, Xiangsheng Hou wrote:
> This patch series add MediaTek MT7986 SPI NAND and ECC controller
> support, split ECC engine with rawnand controller in bindings and
> hange to YAML schema.
> 
> Changes since V1:
>  - Use existing sample delay property.
>  - Add restricting for optional nfi_hclk.
>  - Improve and perfect dt-bindings documentation.
>  - Change existing node name to match NAND controller DT bingings.
>  - Fix issues reported by dt_binding_check.
>  - Fix issues reported by dtbs_check.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] spi: mtk-snfi: Add snfi support for MT7986 IC
      commit: 7073888c86601389e17f3ee8ab15ab7aef148839

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
