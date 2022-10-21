Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B1E6079FB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJUOz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJUOzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:55:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D1F1ABA07
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E41861EE8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE27C433C1;
        Fri, 21 Oct 2022 14:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666364153;
        bh=ezvjYc+rhZy26pQ0cAF1QNG1TcfOw/mpocoE4BSrq2s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UjguJfdw1jBgJ0iv8x+X6JQdKK/eQt8zS1JnqRQ5eST14Hz+A5oQJtq8+s5KVU+dZ
         R3Tp21qD0hS3SUoHTE9K2EJKGHjoOYfJ+aiB19VsTjrjVrMC7oPhDolj6MmHCWibqt
         DtCa/+eDT4AU7yPdKcjXIAKn/XwJsB9FgsQsDOhKttxIUFZ6ojo1s+Wkb5yfeIIclr
         +NrYV2LLOAy01PI39xoZWJWqj7jg7N77ekJw2BdGUQv3UlEEzCrMN2ibF+2oQQ/09x
         KURMXtEAhd7ZKjI0epDDp8qoVDzSaZ4BOurE8mMAfVb4UYiVG/7jsQ3YyLp5lxJ/GG
         xgBswygW4VVrw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Leohearts <leohearts@leohearts.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <26B141B486BEF706+313d1732-e00c-ea41-3123-0d048d40ebb6@leohearts.com>
References: <26B141B486BEF706+313d1732-e00c-ea41-3123-0d048d40ebb6@leohearts.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add Lenovo Thinkbook 14+ 2022 21D0 to quirks table
Message-Id: <166636415149.251337.3450241153034990472.b4-ty@kernel.org>
Date:   Fri, 21 Oct 2022 15:55:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 14:34:32 +0800, Leohearts wrote:
> Lenovo Thinkbook 14+ 2022 (ThinkBook 14 G4+ ARA) uses Ryzen
> 6000 processor, and has the same microphone problem as other
> ThinkPads with AMD Ryzen 6000 series CPUs, which has been
> listed in https://bugzilla.kernel.org/show_bug.cgi?id=216267.
> 
> Adding 21D0 to quirks table solves this microphone problem
> for ThinkBook 14 G4+ ARA.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add Lenovo Thinkbook 14+ 2022 21D0 to quirks table
      commit: a75481fa00cc06a8763e1795b93140407948c03a

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
