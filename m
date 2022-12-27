Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FF2656B64
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 14:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiL0Nn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 08:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiL0Nn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 08:43:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EE23B3;
        Tue, 27 Dec 2022 05:43:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 049AC60F46;
        Tue, 27 Dec 2022 13:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B2BC433D2;
        Tue, 27 Dec 2022 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672148605;
        bh=MWHvjZhXqCXibASs7/ji0PRKFTI00JPAvF8xc89D7D8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tIF6qIL8Y0pR593s3NX3Tr29bkjIHPsh+00HkRkm1ZOFp7ltkYgwiE7MKrXRKkA0r
         r+m8y3/xHBHqRegi7W+eHENxQxGcJbhhWqHxTTPm3nvICgCmym6e+xO9FqvE+PD8CP
         Jo0dMbESDEOTQoRaB2qanG8VqL1L36wHESRk8ph7DmPinNpIumLvZQrj1C6S8tQirA
         Q29+aq8d7SouvpPfFKQ8h85ztI66+zLhaAwbMgri3sKw7uoqPJZJvKSnCAwROdqlZn
         q5zAEtCQ8jfjmZeD/xGyowLqaBNycOi2v7voNPpM3M3Ytj8mDV6F/PYr+ygPMA3VIH
         F53An4qIZ4WQQ==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221225-mtk-spi-fixes-v1-0-bb6c14c232f8@chromium.org>
References: <20221225-mtk-spi-fixes-v1-0-bb6c14c232f8@chromium.org>
Subject: Re: [PATCH] spi: mediatek: Enable irq before the spi registration
Message-Id: <167214860344.446872.17166503994226712534.b4-ty@kernel.org>
Date:   Tue, 27 Dec 2022 13:43:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Dec 2022 09:37:12 +0100, Ricardo Ribalda wrote:
> If the irq is enabled after the spi si registered, there can be a race
> with the initialization of the devices on the spi bus.
> 
> Eg:
> mtk-spi 1100a000.spi: spi-mem transfer timeout
> spi-nor: probe of spi0.0 failed with error -110
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000010
> ...
> Call trace:
>  mtk_spi_can_dma+0x0/0x2c
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mediatek: Enable irq before the spi registration
      commit: b24cded8c065d7cef8690b2c7b82b828cce57708

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
