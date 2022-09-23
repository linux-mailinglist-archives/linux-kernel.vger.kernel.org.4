Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7967F5E8057
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiIWRHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiIWRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:07:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534A214A7BE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:06:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04FACB82691
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F15C433D7;
        Fri, 23 Sep 2022 17:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663952816;
        bh=MXUJSh7a67zClSJcrIQ8uTLgyyJ6AiyBVSt6Oo0niKQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=L5ozGfX7+BnlhPf8kYmEvlTmsswimIsTUvxP0A7EOs5QLeAU7DTgyL556orPLCbSQ
         jWDSDsvBhmTH3Obu+8JS2+MwezNx17WrUScLZMuKMD+XWhecmwFmPDggjej9KMZvnX
         UWuHqm8QLARl6T/wfwagA01xQoUikW/w0GHMeRwpkbliaQn1Ch7Y/7FHDyWH/0Re1u
         BAAWQSdgKTny+VsvfMFMgNG+euMZ7dTZICI/UTRKqCw9E3up1m/hdqNDZX3Zz6SE72
         +2nPq0IsjkKHj1oSnBS4Bs7GbhOi45JXeystji3jfeCscFIE4hsbCNFzKSCiy/++ve
         RcTxQ5kODrJCw==
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     tzungbi@google.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        perex@perex.cz, tiwai@suse.com, trevor.wu@mediatek.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        matthias.bgg@gmail.com
In-Reply-To: <20220922103502.49981-1-angelogioacchino.delregno@collabora.com>
References: <20220922103502.49981-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195-mt6359: Use snd_soc_pm_ops instead of custom ops
Message-Id: <166395281428.610218.2692413378326164473.b4-ty@kernel.org>
Date:   Fri, 23 Sep 2022 18:06:54 +0100
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

On Thu, 22 Sep 2022 12:35:02 +0200, AngeloGioacchino Del Regno wrote:
> It is possible to use the standard snd_soc_pm_ops for this card:
> remove the custom mt8195_mt6359_pm_ops.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195-mt6359: Use snd_soc_pm_ops instead of custom ops
      commit: 14ed837b9740cc6ec25910980d67c22894b4ff56

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
