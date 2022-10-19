Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C68604C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJSPyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiJSPxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:53:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47165153E37
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:51:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E27E8CE228E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFBAC433D6;
        Wed, 19 Oct 2022 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666194623;
        bh=oMxztditmQbZR7+DrctklPnyl2cHfutQghmyLJRjwCQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=juhzztDPhSvnkTsGVI0KuTg9czWwFcxaBCk6Be6q69WSasQQcNsKWND43EUif1OQh
         I0CjGRRGUysZP9Kzc80OOse3wvOM/oQ0H1d0PwCXmdal7C6QGgeM5Xq6jEXUSZDBlh
         k+KDVlNm9FQH/EPllNLLKvd/2eA00fCnG3Q5J61fZHxjhEHMqAQKW0KgBgKqIjx/Ui
         2RCgmUsCtDkLelZOXJZzWHM9uk1RjVi2u0cWbiLMjG9gG9xDg4hNjppPDhaVflRFs2
         pnTimfgXPMnWEAZSeQcpusoWTWxgV/rCEIOqtH9mZPNcs93PXNEDLSwpdIj6qErC6e
         O87zSXsWkx3Xg==
From:   Mark Brown <broonie@kernel.org>
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com, Jaroslav Kysela <perex@perex.cz>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>,
        vsujithkumar.reddy@amd.com, Vijendar.Mukunda@amd.com,
        ssabakar@amd.com, Basavaraj.Hiregoudar@amd.com,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220921090750.3833256-1-venkataprasad.potturu@amd.com>
References: <20220921090750.3833256-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: Add setbias level for rt5682s codec in machine driver
Message-Id: <166619462028.884966.16711536183815156169.b4-ty@kernel.org>
Date:   Wed, 19 Oct 2022 16:50:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 14:37:44 +0530, Venkata Prasad Potturu wrote:
> Add set_bais_level function for rt5682s codec to enable bclk and lrclk
> before codec widgets power on and disable bclk and lrclk after widgets
> power down, to avoid pop noise
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Add setbias level for rt5682s codec in machine driver
      commit: 9e693e81745f03845788ef409f03a39e92f8dd48

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
