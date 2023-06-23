Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4530F73BB0D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjFWPH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjFWPH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:07:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1641FDF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DA8D61A87
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2349C433CA;
        Fri, 23 Jun 2023 15:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687532872;
        bh=zEV2RKDHizUuqsg/GKSamDV5J/oB9i1p+vG1rVTtzt8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IchY5XGxI/2DQEDIkFjGD5WpWJK1obsXG6/iTyEfyBLwuuKkEQeeGfdfb8wnj5bmL
         SAn0fRhmzBpXa7qMK8oUX44vM05Xai2FKeI5e9eW36qR4aXG6Nh0iWyYsTc9kIMolf
         4ffVLS4VMFwlgQJK46uEhpTLTt1KimvOhbUMTLWPdmgEqr3NakWZlAs3XDF4mLfp4L
         zh7n0zozS2UdBDp8YwYL7pZRhwExrDjJkbBIEOJbmdyadK07kPSGjpBXdx1DjYqSTE
         eCohysBtUFbOi4yrqWd0LpySMMUL/wjkbRzIR7mRyCi/mcqP7R3BcninozTcvN0fYo
         JFCGdVTkVO+/g==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Arun Gopal Kondaveeti <arungopal.kondaveeti@amd.com>
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        sunil-kumar.dommati@amd.com, venkataprasad.potturu@amd.com,
        syed.sabakareem@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230623214150.4058721-1-arungopal.kondaveeti@amd.com>
References: <20230623214150.4058721-1-arungopal.kondaveeti@amd.com>
Subject: Re: [PATCH v2] ASoC: amd: update pm_runtime enable sequence
Message-Id: <168753286853.678414.15580009562650782179.b4-ty@kernel.org>
Date:   Fri, 23 Jun 2023 16:07:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2023 03:11:40 +0530, Arun Gopal Kondaveeti wrote:
> pm_runtime_allow() is not needed for ACP child platform devices.
> Replace pm_runtime_allow() with pm_runtime_mark_last_busy()
> & pm_runtime_set_active() in pm_runtime enable sequence for
> ACP child platform drivers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: update pm_runtime enable sequence
      commit: 154756319cc6f8b8b86241da02da6a8fcc6abd1f

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

