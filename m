Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F0471A2E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjFAPog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjFAPoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:44:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370F5E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:44:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB91F645C3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 15:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6FAC433EF;
        Thu,  1 Jun 2023 15:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685634268;
        bh=6wfuvEex59Ok6T5gRrkfMoK/HR47V0aNeFPlA0QEhM8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZqvvUnO/0qfrMMhnw3xdHydTy+Y8BJRfv87V1KJ9TvwRrbOBm1vH4kx+bc/BXg0S4
         eR9mepejozTdE7nmqzwznxeTOrt32CR96/BljyQbeZlkZ7aEwBcxmcJ6ZN92DtCBXH
         GcVer9bs2bPDkAYjZsn6weI9nRIkxj2kAS0cZU8Mrmi8kNfPZz9mWnjL/0WsZTQBnS
         cGNKH0v+cCrodvUzd5XAiMLz4XBDCDta6EmixY2D4MsR8U+jysWux25USD2YV37sN+
         E/Pvpq4mNP9RoEVjJJmiT6jVUTETmwrcKGFrfXOX+Jsgum6Juz8ibk3AN/PiftsDtx
         H1ZIZuRUAxaQA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     dianders@chromium.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230601033318.10408-1-trevor.wu@mediatek.com>
References: <20230601033318.10408-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH v2 0/2] ASoC: mediatek: fix use-after-free in driver
 remove path
Message-Id: <168563426581.132600.16426299018571667864.b4-ty@kernel.org>
Date:   Thu, 01 Jun 2023 16:44:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 11:33:16 +0800, Trevor Wu wrote:
> These patches concern modifications made in mt8186[1]. The clock
> unregistration mechanism used in mt8188 and mt8195 is similar with
> mt8186, resulting in the same problem existing within the driver.
> Therefore, the solution has also been applied to these two platforms.
> 
> [1] https://lore.kernel.org/all/20230511092437.1.I31cceffc8c45bb1af16eb613e197b3df92cdc19e@changeid/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt8188: fix use-after-free in driver remove path
      commit: fd67a7a1a22ce47fcbc094c4b6e164c34c652cbe
[2/2] ASoC: mediatek: mt8195: fix use-after-free in driver remove path
      commit: dc93f0dcb436dfd24a06c5b3c0f4c5cd9296e8e5

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

