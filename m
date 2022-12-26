Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F78656609
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 00:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiLZXd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 18:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLZXd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 18:33:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0216530D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 15:33:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EFD660ECE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9623EC433EF;
        Mon, 26 Dec 2022 23:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672097634;
        bh=7DsybbBBAfTaw/MyZaW8yFKygVp4C3sX9HBvOmr/AQA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TJ+UpzFEDwFLbxscII1eoB1vN56nUV4f50QVIrLfxfIGy1TgNdofvm/WE0BV9Lvqc
         V5SRlFyEasnroQlJ6MeslSpE91Z1bJWIqCbDeZppdKEoo1HEmBVdKBa4kBDKcBp+/Q
         8llM+rzO9OjBzxA16aAuYBGrHp0824GJ7Jr3AxyNNSveArcpa2IR3DKUmUUo9vg8Fs
         R9vncwZFKL77rbliQqprVR+CXCsRvT4QHQ2phwCU3ARrExANQRzmc47t8DF/3h+6/9
         FdK7v2WUFC/AkEs5Z3/CCsVRzZ7rzKK9vVtzS+i/QCgVvYxcrmyw8gefh+/8XT+6bu
         sl6CuwhsOT+sg==
From:   Mark Brown <broonie@kernel.org>
To:     Wim Van Boven <wimvanboven@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        syed sabakareem <Syed.SabaKareem@amd.com>,
        Leohearts <leohearts@leohearts.com>,
        Brent Mendelsohn <mendiebm@gmail.com>,
        Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        linkt <xazrael@hotmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221216081828.12382-1-wimvanboven@gmail.com>
References: <20221216081828.12382-1-wimvanboven@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add Razer Blade 14 2022 into DMI table
Message-Id: <167209763231.330820.17564668361422560655.b4-ty@kernel.org>
Date:   Mon, 26 Dec 2022 23:33:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2022 09:18:27 +0100, Wim Van Boven wrote:
> Razer Blade 14 (2022) - RZ09-0427 needs the quirk to enable the built in microphone
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add Razer Blade 14 2022 into DMI table
      commit: 68506a173dd700c2bd794dcc3489edcdb8ee35c6

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
