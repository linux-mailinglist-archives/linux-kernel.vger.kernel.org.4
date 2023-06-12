Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D95672CC82
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbjFLR1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbjFLR1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14499170A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5B4B62C1D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 17:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B54EC433EF;
        Mon, 12 Jun 2023 17:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686590815;
        bh=uOab3yRuil+00P2CAkfmCzTH6J2kw0s08EsYP6TTYAk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uc6TOR1ZOtF/eV7k3z5Dz7S3LRRP6M71bjAOf/jvu9QnHwTu3ChJiD1zK5rr42j0I
         qrP2x6chV4GO8+vtF513icXxVAQX6KNtCXrPFW6SoNHlF2TqSIyi9q+dbdIipqOwp7
         Qgsg7rQ5S4Qkgm6EwvoaTG9tJRaw0oxOgzpDxnGEcmm8efIkSzp1Fcz3nuIbC+86sw
         BFnBAJI1jxzyny2Ojju7yxIf/TweyBqTQKuGyZN3cYZJG4l+Y+wxkBlj4RBF+3tcOr
         5yeFZrWRkavgnMxhDgiNfscvB8FsHp9RGX0uvMTLkMt+2IDZxG8EnP9cgtENUTGk2b
         hl+TP+KjpP95w==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ricardo Ribalda Delgado <ribalda@chromium.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Dan Carpenter <dan.carpenter@linaro.org>, stable@kernel.org
In-Reply-To: <20230612-mt8173-fixup-v2-0-432aa99ce24d@chromium.org>
References: <20230612-mt8173-fixup-v2-0-432aa99ce24d@chromium.org>
Subject: Re: [PATCH v2 0/2] ASoC: mediatek: mt8173: Fix error paths
Message-Id: <168659081228.87413.14975958802523841979.b4-ty@kernel.org>
Date:   Mon, 12 Jun 2023 18:26:52 +0100
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

On Mon, 12 Jun 2023 11:05:30 +0200, Ricardo Ribalda Delgado wrote:
> ASoC: mediatek: mt8173, presented a couple of error paths errors, lets
> fix them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt8173: Fix snd_soc_component_initialize error path
      commit: a46d37012a5be1737393b8f82fd35665e4556eee
[2/2] ASoC: mediatek: mt8173: Fix irq error path
      commit: f9c058d14f4fe23ef523a7ff73734d51c151683c

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

