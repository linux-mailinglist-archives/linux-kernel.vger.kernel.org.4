Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0359A728392
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbjFHPTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbjFHPSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:18:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818AF2D63
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:18:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE8760FAB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8907C433EF;
        Thu,  8 Jun 2023 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686237533;
        bh=pk/K8VrdCKchUB5paUdeNuT/SCeVorFznzyFJBwz8p8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VQOBPggzksGxcDdx4KDssn6TUrr6M1MgOItXztQrrJNHN8QFTPKBRpiF7Mk01wXHs
         Mde3p+xH0I1bA0D5r0kIWelmHj76C0JTiU6hTF9IUGz+jgmQW5PqhHnbrfOZluyfBo
         C1DcvX6dovAyAg8nTSpQQQ1XQoPgkgtJeiv2+0NsB13dMK9rqfBa1nKuOKQaRverGP
         vRqcK2eGjn2beNDhQBzmTeKwKCDNR65q1wtukFajPUyUUpAm75RG1405aAi1NgHhfn
         WjheAsgrnxysOFlpFbuJZLTKotXOB5YToksxzoSSBUTCJEA+nvcHazlpIumaJoiUC+
         gIeTSF8tx6ICg==
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        amergnat@baylibre.com, dan.carpenter@linaro.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
In-Reply-To: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 0/5] ASoC: mt8188-mt6359: Cleanups
Message-Id: <168623753047.1002486.1442664487202243971.b4-ty@kernel.org>
Date:   Thu, 08 Jun 2023 16:18:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2023 10:47:22 +0200, AngeloGioacchino Del Regno wrote:
> This series performs some cleanups to the mt8188-mt6359 driver,
> including usage of bitfield macros, adding definitions of register
> fields and some others for readability and consistency.
> 
> AngeloGioacchino Del Regno (4):
>   ASoC: mediatek: mt8188-mt6359: Compress of_device_id entries
>   ASoC: mediatek: mt8188-mt6359: Cleanup return 0 disguised as return
>     ret
>   ASoC: mediatek: mt8188-mt6359: Clean up log levels
>   ASoC: mediatek: mt8188-mt6359: Use bitfield macros for registers
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: mediatek: mt8188-mt6359: Compress of_device_id entries
      commit: 22628e92d76a403181916f7bac7848dd2326d750
[2/5] ASoC: mediatek: mt8188-mt6359: clean up a return in codec_init
      commit: 1148b42257e2bf30093708398db2c4570ae9fe97
[3/5] ASoC: mediatek: mt8188-mt6359: Cleanup return 0 disguised as return ret
      commit: 4882ef44f51bbb759b8a738b747fdbcbad38e51b
[4/5] ASoC: mediatek: mt8188-mt6359: Clean up log levels
      commit: acb43baf8b7e75acdb14920de29881e3f70c6819
[5/5] ASoC: mediatek: mt8188-mt6359: Use bitfield macros for registers
      commit: b0e2e4fb8a5467f4f64bcf64d1454d18cb665cc8

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

