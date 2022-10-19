Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9AB604629
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiJSNAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiJSM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:58:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE67CF000
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 010F5B8226D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F69C433C1;
        Wed, 19 Oct 2022 12:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666181110;
        bh=a+Q3SW2Du7YQqCKcu2M+v4HbHHDjTVuzUncjGaTdCTo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WKCU9deq3FM4gdIaBD9s22EbAKxA663mbS2SbG9x5hUXOzx8sB3bf8qHTx20AYwfM
         mYlHt86qJHfYh2jCedM2/7ei7Uj71FBvpKzakQutXr7M8lKXesEagWm0SMCPmw29+4
         g5xdVN8e6gwMK63HgJGGyeig2yGw0m6bOeLl8cFfaQ0eO6/FbHhM3lQHvPlhmV2NQf
         ETmVVsIa1sUzubtNJ2I7X2ZJYmHXkSJNXToj4whlbZgKSnycZUK9j1cCoODCCYtGON
         wVeA9vy+ZbBi9svnjS+Pr5V4gugBZuQZPhaigbHmCky/zX1Fn1FYsGa0vVeFOjorzE
         eah3YSI2dTB9A==
From:   Mark Brown <broonie@kernel.org>
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        ssabakar@amd.com, Vijendar.Mukunda@amd.com,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, vsujithkumar.reddy@amd.com,
        Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20221018122711.2559452-1-venkataprasad.potturu@amd.com>
References: <20221018122711.2559452-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASOC: amd: acp: Add TDM slots setting support for ACP I2S controller
Message-Id: <166618110801.80223.1404138981256305349.b4-ty@kernel.org>
Date:   Wed, 19 Oct 2022 13:05:08 +0100
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

On Tue, 18 Oct 2022 17:57:06 +0530, Venkata Prasad Potturu wrote:
> Modify set tdm slot function to set ACP I2S controller slots
> in tdm mode based on number of slots.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASOC: amd: acp: Add TDM slots setting support for ACP I2S controller
      commit: bdde278a77d3220ba7991e6ff5e992716981ae30

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
