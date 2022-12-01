Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513FA63F187
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiLANYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiLANY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:24:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E80A2832
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:24:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9565B81F1D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B53C433D6;
        Thu,  1 Dec 2022 13:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669901061;
        bh=amVP+1P0dNrlbJaDPRNEsD4wfnCL+4/BW2bhTC4Kicg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UU/En7RogwdtofVGswPptV6smospR4VEfq2JflWcFFeeL+nFISH8/5wc+2h5nmczU
         lcmuJGPyW7MFSi9jE1csIdlpYgy9T0wZuFG4Ee63qCBtRTXXvNvcQQznP9MHznFX0+
         qjsGvCQLSk5Tth35g++TM6W/9VEBTJas3r3kjfQkoyNoNyDwAk9MBb8GJxGeLcu/8C
         zQbwzE11vEU7K6l7VhywLLPpRlujstLmrsOAj+gS75xlZFzBeebHQbRwfYCG8y6i1G
         brb0q4O6vNlDEC7xXt12DM+mAEi3OknNtYB+CGAMru8esNc8i7SQaWI3yNlgT5Srs6
         n/i4Kxl0SYgjQ==
From:   Mark Brown <broonie@kernel.org>
To:     David Rau <we730128@gmail.com>, perex@perex.cz
Cc:     tiwai@suse.com, support.opensource@diasemi.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, David Rau <david.rau.zg@renesas.com>
In-Reply-To: <20221121050744.2278-1-david.rau.zg@renesas.com>
References: <20221121050744.2278-1-david.rau.zg@renesas.com>
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP headsets when playing music
Message-Id: <166990105936.78632.9195345334708461451.b4-ty@kernel.org>
Date:   Thu, 01 Dec 2022 13:24:19 +0000
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

On Mon, 21 Nov 2022 05:07:44 +0000, David Rau wrote:
> The OMTP pin define headsets can be mis-detected as line out
> instead of OMTP, causing obvious issues with audio quality.
> This patch is to put increased resistances within
> the device at a suitable point.
> 
> To solve this issue better, the new mechanism setup
> ground switches with conditional delay control
> and these allow for more stabile detection process
> to operate as intended. This conditional delay control
> will not impact the hardware process
> but use extra system resource.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7219: Fix pole orientation detection on OMTP headsets when playing music
      commit: 969357ec94e670571d6593f2a93aba25e4577d4f

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
