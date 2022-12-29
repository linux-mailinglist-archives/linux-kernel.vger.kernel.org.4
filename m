Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7F665917B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiL2UY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiL2UYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:24:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0DD15F1B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:24:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 252C661908
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 20:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9475FC433D2;
        Thu, 29 Dec 2022 20:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672345492;
        bh=ETuogk7ACYxYQV9uzj4PmKQpxDQ3mxpqHb49NYgVa5U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jDjpE5mIfycRAMFRF5PXuWGu+Wm+D4yjbQRpRtMnYPV5iP75n6NeyrDgtwgXs4Xvj
         KwKuW5/TL6hk0hYJDPzkWnbkYb5A4oFEUmmjGpsyL/Ay4jVEnJUHieya8e9cF6D0F7
         BgSlvWjR0uEeisdRgvsWSjjqfgHf8qC/Ds2AoHjPEXSLMgmFtdrNHEhyT6NLUSZd8l
         QjoFB6b6UnyDSOJnDYbmUCv7ueQp4nDx+rNqr3Y9megkYbZp+Nqa4i127kPnUhOxl/
         pdgtLuW9/jygdy71PSh2O9Xczuz3z0YVo1A53D/KLob5sRVMUYvsHhxYbKW5HIaknm
         ABHqiXd2rOZzQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
In-Reply-To: <20221228115756.28014-1-allen-kh.cheng@mediatek.com>
References: <20221228115756.28014-1-allen-kh.cheng@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Add machine support for max98357a
Message-Id: <167234548928.88546.3169179138497536747.b4-ty@kernel.org>
Date:   Thu, 29 Dec 2022 20:24:49 +0000
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

On Wed, 28 Dec 2022 19:57:56 +0800, Allen-KH Cheng wrote:
> Add support for mt8186 with mt6366 and max98357a.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: Add machine support for max98357a
      commit: 8a54f666db581bbf07494cca44a0124acbced581

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
