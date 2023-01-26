Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F48867C197
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjAZA3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjAZA3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:29:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AD762D09
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:28:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEB6DB81C67
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65302C4339B;
        Thu, 26 Jan 2023 00:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674692930;
        bh=fbBRAdPn9UFXEiL+pTgBGg0Ie4LQZr2rftDpSDQY9mQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=J2htSXXHT0yD60LqM36NP78mUMK3vdQZPm3sPfBw0ylOPx8uAF5HuQiUSYi7hbzwH
         jdDNJLFsF/ezK4qmwcuVPdd/3LAnAxsba6JHrD2EzzbwBBLCqnWdrLcsFuX4Vnkh+N
         G6BL9SaoxeHbOnOEogTRcDQncFNaXHydmJcOCXKKFOQ4sXdtC9EnTPLLhcV71Fp/V5
         mDMOuKy1OobLePtLrMuzF9nf/DC+GtAHAKSu7snlPZnodGhOCUGi4zyfvVnGuBbTHc
         SYdCe7G0uTJSXQmaXF65Ku5S1FeGg9+cZ9gxmUP+VjXReWrp2JyS6s/l/IKTak/JXe
         XecrCqRjSSGTw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
In-Reply-To: <20230124181746.19028-1-rdunlap@infradead.org>
References: <20230124181746.19028-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ASoC: Kconfig: fix spelling of "up to"
Message-Id: <167469292812.2696228.156727580350360808.b4-ty@kernel.org>
Date:   Thu, 26 Jan 2023 00:28:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023 10:17:46 -0800, Randy Dunlap wrote:
> Fix spelling in sound/soc/ Kconfig files:
> s/upto/up to/
> (reported by codespell)
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: Kconfig: fix spelling of "up to"
      commit: 636be128d659131739df62e08455bbf6678fc58b

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

