Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C2A6B815F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCMTHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCMTHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:07:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB625AB4A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8C7C61469
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98ABC433D2;
        Mon, 13 Mar 2023 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678734461;
        bh=NSgcGMlvHaZdY1J2Us1HiQZa412OdeIu/4FLhrIhJVY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Hke5SM/mxLaeP5gd2fw1qU77XLIYsy+ZXz0S7dsUv8LMn1YYsIlQ6sXh+uiX1zMho
         wMadRJNLkrsf+GDOtvxXZ7rhhtkafdpZp1pXKaGOJp9aWdzK+9CKn/67GFQ1EWF6A2
         c4s27L+XyF3z4d18AuPa8c/tist0WAr6kC1SvAacWEA/KYWex07XzZw2tDWVJO85ID
         44i1KbUg9ph5zxCOfrcQxri2+1o25dXnLu2gRnZYcZkWxCTkWGOhQImXGWGa7BUmto
         UQl8KN52L6Qz4CjVdj743JQ1EDE66kiT6ixeUJwJlUxpWl0gKjHrbJMH88r+oIaSfc
         W/tGN9jJcNGEQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     jiaxin.yu@mediatek.com, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230307040938.7484-1-trevor.wu@mediatek.com>
References: <20230307040938.7484-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH 0/4] ASoC: mediatek: fix coverity problems
Message-Id: <167873445867.106067.16026073006550113761.b4-ty@kernel.org>
Date:   Mon, 13 Mar 2023 19:07:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023 12:09:34 +0800, Trevor Wu wrote:
> Coverity reports some UNINIT and CERT STR31-C problems, so we add
> initialization and dai id check to resolve problems.
> 
> Trevor Wu (4):
>   ASoC: mediatek: mt8195: add dai id check before accessing array
>   ASoC: mediatek: mt9195-mt6359: fix UNINIT problem
>   ASoC: mediatek: mt6358: fix UNINIT problem
>   ASoC: mediatek: mt6359: fix UNINIT problem
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: mediatek: mt8195: add dai id check before accessing array
      commit: ff728899065922534d80170685fb807194d6487b
[2/4] ASoC: mediatek: mt9195-mt6359: fix UNINIT problem
      commit: 1a3f0116b74ba2f9477c28fcf9d66ac7126455fd
[3/4] ASoC: mediatek: mt6358: fix UNINIT problem
      commit: 9760e01b3851dc51d1901876668168328d34a647
[4/4] ASoC: mediatek: mt6359: fix UNINIT problem
      commit: 3a60fa4c063dacc5eb66660aa23107f3cb8a477e

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

