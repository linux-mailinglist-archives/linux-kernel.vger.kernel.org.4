Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3ED6184E1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiKCQjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiKCQjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD461EC69
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:35:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C13861F6C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 16:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B6EC433B5;
        Thu,  3 Nov 2022 16:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667493300;
        bh=NtaRBSuTx4gEY3TFWYZ6lJZlhJEbnOaOQ4bJzzzyP+Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ESO1GdyN04Cfhk8H6tukrp5qdl5/qNbXrw2eqb+rP+pswB7OCFb8WTNDmDdyn0nJ/
         UYAVc00ZLSt5teJG4ByiEJzho3HIvxCdFGgQ894Vi3OfsvVTSYRmYcfq0dVXGGPwrg
         bHxOEFW6Rphy2AOtDKQZ2SCZWUHwHehp/Q1zO9upk026dwJm8daWabyOuD+yGjQqK6
         bw5/KVP0O0vQqa328liPezzjhpb/tiuFmu0CTA9DxCZdJbbUqaINMZBwhU7sdy0NiC
         CXP8KFsBK+4bcoaGPKgyEc/6+xFhR2y/5xan+xjTclyDh1hYebgbOlQBELyq/bvnAV
         OebWJ2JkJiE3Q==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Maarten Zanders <maarten.zanders@mind.be>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alexandre.belloni@bootlin.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221028191303.166115-1-maarten.zanders@mind.be>
References: <20221028191303.166115-1-maarten.zanders@mind.be>
Subject: Re: [PATCH] ASoC: simple-mux: add read function
Message-Id: <166749329885.480833.18370914734469838368.b4-ty@kernel.org>
Date:   Thu, 03 Nov 2022 16:34:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 21:13:01 +0200, Maarten Zanders wrote:
> During initialisation DAPM tries to read the state of the MUX
> being connected, resulting in this error log:
> input-mux: ASoC: error at soc_component_read_no_lock on input-mux: -5
> 
> Provide a read function which allows DAPM to read the state of the
> MUX.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: simple-mux: add read function
      commit: f7d97cb564a2ac5517ee7cc933de729e533d659a

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
