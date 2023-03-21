Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4872F6C3200
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjCUMqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCUMqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:46:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51427460BE;
        Tue, 21 Mar 2023 05:46:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2464B81665;
        Tue, 21 Mar 2023 12:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BF7C433D2;
        Tue, 21 Mar 2023 12:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679402784;
        bh=NK7Qa4/kmnTtDIuShrMbbctCm/ZSCmINfV6f2ojz/kY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eUphMwq+Y1iiFAmpinx4VQbhWdgjf4hPT4v/XzR2fbGs8jdXQYtftiVcArvK/1F4H
         s/lAIzEzxGXY4Agf1HzZ8Mh82B0dK5LiPiPisTqjsDGBV7vC99KgTEy4xkyogmQlN3
         l3TcSKUeoBEvO7164xC+MPFOiho+o6vzFII2oeylo71PWPfpeHCLUWqcqMqBVnxl8C
         I/gbU7WL9tNQx85G0PuDjNcKRgt5gGOvvBjk9q6ml7VcdfkwC/iWOsDr0JsfvQ/hyi
         KPfmxCnyVYcXhal5IAgqdaQKYsTO0bgL0STyMVO507EmSLCWwD6daFUj+Kq4hZKtCd
         YqCyu98JGBDWw==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jianhua Lu <lujianhua000@gmail.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
In-Reply-To: <20230318141440.29023-1-lujianhua000@gmail.com>
References: <20230318141440.29023-1-lujianhua000@gmail.com>
Subject: Re: [PATCH] ASoC: cs35l41: Add 12288000 clk freq to cs35l41_fs_mon
 clk config
Message-Id: <167940278163.26969.15643936747688736434.b4-ty@kernel.org>
Date:   Tue, 21 Mar 2023 12:46:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Mar 2023 22:14:39 +0800, Jianhua Lu wrote:
> There are 8 cs35l41 speaker amplifier connected to TDM
> in my Xiaomi Mi Pad 5 Pro tablet. In this case, it's necessary
> to set 12288000 (48000 * 32 * 8) clk freq for it.
> 
> rate=48000, slot_width=32, slots=8.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l41: Add 12288000 clk freq to cs35l41_fs_mon clk config
      commit: 00a7ef3242f42c38c9ffdf14ab2d729fd9754391

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

