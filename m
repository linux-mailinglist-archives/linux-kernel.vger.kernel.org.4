Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946666BB460
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjCONTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjCONTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:19:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51521F5EB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4420D61D5F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55B2C4339B;
        Wed, 15 Mar 2023 13:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678886368;
        bh=3djw40rUw+nNpWOAp6TWK8VOxJM0awfRn9QjEkHNKHU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=p4mBqVpmQqEMVYVJfpmuIorD57kG3lYxffPv8FymWpo+oa1igyr9QmzShnpRkmQjr
         vUcbNL2SrLmsLfttD/qAkP83LbDvzTLCP+ZgFJ+vlpDkpj+ayiv9IyqhVi+PXTeD9R
         p5Rb6yfIoyAhcubaB6aPioQT17mW921CqMT0mF5INNZqY4xNVM6A0ckFvuECsO6P1N
         AupXtcFddWgsJzkScqnIio8WCUMa3CsufmGXHG9F/1DeTjngoc881sED5Ns3bE8sbL
         9Lku4MJXOK5zUofRkbF7LF9BE38dCCHJjHqSjeEi2Llwli+U4o4oCylraGLzAozTYE
         lIUBVexzbta2g==
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20230313212908.2282961-1-nfraprado@collabora.com>
References: <20230313212908.2282961-1-nfraprado@collabora.com>
Subject: Re: [PATCH 0/2] ASoC: mt8192: Address spammy log messages
Message-Id: <167888636565.25434.17339984677925115588.b4-ty@kernel.org>
Date:   Wed, 15 Mar 2023 13:19:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 17:29:05 -0400, Nícolas F. R. A. Prado wrote:
> A couple commits to make the mt8192 sound driver not spam the console.
> 
> 
> Nícolas F. R. A. Prado (2):
>   ASoC: mt8192: Remove function name log messages
>   ASoC: mt8192: Move spammy messages to debug level
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mt8192: Remove function name log messages
      commit: f147ca85d6ecaf65106d1650f3c2e8afacbc833f
[2/2] ASoC: mt8192: Move spammy messages to debug level
      commit: 5f2a53c0687b151c2ecad19995108b40df76ba86

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

