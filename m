Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3B363AEE9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiK1R26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiK1R2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:28:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CAE1103;
        Mon, 28 Nov 2022 09:28:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6840F612A8;
        Mon, 28 Nov 2022 17:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B5BC433D6;
        Mon, 28 Nov 2022 17:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669656533;
        bh=gvBIJ5o3hFY/0i6NMg2Uwx9JeB/XU/zKEUgXsoB1508=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PJIX+6kJjfkAqwHy+7dvp740PGUQYy8CT2KJC0Gn5H77M23nL83BqzoLVrDwOLkkf
         9WP9R7Vt2OV+vBlMy6qhaHybiHK/bwW1ztmultQfsClYG47rjYWckFbadJmtep5myF
         vMHx3sWH+RfIYch5f9d8pchNdRIBNf/ewFVwpft14zvSn80ODmqdvdqB7K21rg2Faq
         WvWQs3s3wVcE6UkwGPLGyIYRN7pyVyfWEDhlNqQZMvLjDxAKZBUyiPITyGaTH1zzBU
         E6dXDVV/mzaMxZ76gZKVGe6dDcNn+XP2KYSVOKdPr0PzhOifJxi4u2nQQq4lUs/3T6
         J0TMgk0aJQUIg==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20221128-spi-mt65xx-v1-0-509266830665@chromium.org>
References: <20221128-spi-mt65xx-v1-0-509266830665@chromium.org>
Subject: Re: [PATCH] spi: mediatek: Enable irq when pdata is ready
Message-Id: <166965653185.677424.5326738316899525692.b4-ty@kernel.org>
Date:   Mon, 28 Nov 2022 17:28:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 12:00:01 +0100, Ricardo Ribalda wrote:
> If the device does not come straight from reset, we might receive an IRQ
> before we are ready to handle it.
> 
> Fixes:
> 
> [    0.832328] Unable to handle kernel read from unreadable memory at virtual address 0000000000000010
> [    1.040343] Call trace:
> [    1.040347]  mtk_spi_can_dma+0xc/0x40
> ...
> [    1.262265]  start_kernel+0x338/0x42c
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mediatek: Enable irq when pdata is ready
      commit: c6f7874687f7027d7c4b2f53ff6e4d22850f915d

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
