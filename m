Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1696592A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 23:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiL2Wum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 17:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiL2WuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:50:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542C35F42;
        Thu, 29 Dec 2022 14:50:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE6B6B81A7C;
        Thu, 29 Dec 2022 22:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8331C433D2;
        Thu, 29 Dec 2022 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672354220;
        bh=I93/1mRsdn1k7zesrQeJJdmqUVW8X7j/6JylnPTDMak=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=A3zMnWxQ2QRSKe/ukjH1wIb2KGk644x0HuxTVfQL213iMNb5bCyXlVpClZkFU7Jol
         w93hBVwJb7wwY8isey1tapUOsZ87dy/eXYlr3mjOgLVcKn3SWCHJuy/QOqPe09bx+d
         D9ikBGbeCQPbHNdAk2NpZkM95LVy3tGt9yaKzDPR82ECnBiZlJxWowZFhsquIHSwrG
         hHzYcCwAsl0B9EUaHh1A4wAlYv6Ts9J7ItcUGdUh1O70b/qIm7nvMnTondcYznu5b4
         +XXDR1BcyOohQEWXUrpczci6xMWcgUAgWcgURtWSSUPRMLVXsArKHyCehzdgAWw/+b
         F2RP8XVneaqSA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        perex@perex.cz, tiwai@suse.com,
        angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
        jiaxin.yu@mediatek.com, chunxu.li@mediatek.com,
        ajye_huang@compal.corp-partner.google.com,
        tongjian <tongjian@huaqin.corp-partner.google.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221228122230.3818533-1-tongjian@huaqin.corp-partner.google.com>
References: <20221228122230.3818533-1-tongjian@huaqin.corp-partner.google.com>
Subject: Re: [PATCH 0/2] Add new AMP MAX98360A for RT5682S
Message-Id: <167235421493.130379.3520267907504978837.b4-ty@kernel.org>
Date:   Thu, 29 Dec 2022 22:50:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-69c4d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 20:22:28 +0800, tongjian wrote:
> Add MAX98360A for RT5682S, MAX98360A works same as rt1019. So, it can
> be supported.
> 
> tongjian (2):
>   ASoC: mediatek: mt8186: support rt5682s_max98360
>   ASoC: dt-bindings: mt8186-mt6366: add new compatible for max98360a
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt8186: support rt5682s_max98360
      commit: 6e1dbf694d7cd1737ee14866e9e05016ccc9ac40
[2/2] ASoC: dt-bindings: mt8186-mt6366: add new compatible for max98360a
      commit: 2d3dd559751ce19ba84f9690c6c7c5a4b39129df

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
