Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A147E64CB62
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbiLNNcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238300AbiLNNcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:32:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2471E25294
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:32:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5FD261843
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0F4C433F0;
        Wed, 14 Dec 2022 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671024728;
        bh=MphwCkdn5QeL6NXAHvFCBDgfGRjYo4fTYVGRBnJWEds=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cIOEbsqRHqjMOlAPyTV/Ir2Y0AEY8qo8+9DDbN37lq0TrAIjYb0GrhgS//Hn+/2fL
         bO8gIZT+JpDLcB1pT9QPRMpWyIrbDMVZEAeI5J2jfbTA9Jdg6oAcBgnGKfFfbc9B5K
         tWFDEHn7zA09v/1f4yAVdAuh1bMtNweT9F6ShleOUozzvI1MD4z4uPX0t27NsxvciB
         vgK+PyI52BJ2JwCPcBgPSyr65TNsak8L60vEq6+3WzupSVI89es1kVTzP/u0y4mTfB
         P2PLIBUfjGaPWBMqCB6F+fUug+q9Kw4wbSU1A7vvjQhEmYO4P3lY3eekb9r8l2MStC
         eEYWEou34JQTw==
From:   Mark Brown <broonie@kernel.org>
To:     YC Hung <yc.hung@mediatek.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        "Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Curtis Malainey <cujomalainey@chromium.org>,
        whalechang@google.com
In-Reply-To: <20221209031053.8444-1-yc.hung@mediatek.com>
References: <20221209031053.8444-1-yc.hung@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: add sof be ops to check audio active
Message-Id: <167102472482.27755.57467344519009874.b4-ty@kernel.org>
Date:   Wed, 14 Dec 2022 13:32:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-7e003
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Dec 2022 11:10:53 +0800, YC Hung wrote:
> In MT8195 SOF design, both DSP and audio driver would access audio
> registers. Before DSP accesses audio registers, audio power and clock
> should be enabled. DSP will hang up if DSP access audio register but
> audio power and clock are disabled. Therefore, we add audio pm runtime
> active checking before accessing audio registers in SOF BE's callback
> hw_params function to avoid this situation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: add sof be ops to check audio active
      commit: 83f1b7f39af73b01edf098fe3141404670703281

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
