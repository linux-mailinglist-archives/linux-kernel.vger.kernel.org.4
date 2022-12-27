Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EAB656A25
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiL0L5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiL0L5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:57:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0452BE65
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:57:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3AD5B80F9F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2AEC433F0;
        Tue, 27 Dec 2022 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672142242;
        bh=P9cGgPldoX0pKJdwimYnFHuijiaMuAVnzGmLIPbyRKQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YyQ70LO1QSikjgMzZEofO/xeL4is9Z754c2VXq+nY1a7ouq+Upah0Ox7ZPDkwkKaC
         BB9FvDTouHJrNruQc5+FBJVMwfDtNprXTz26BhvQmQr5TEAfE3rJ3SOchY+p44ZtWj
         H9/LAKS+b5WbheMzfQptKUh7MaDJ8StxjPo60/PlkAFHhnr0VlL3S76+J7GKU19aj0
         3XCj/HvpL2wxxRQgt/UdIrjV0LIZNHQ0bvuVRDo8nTmBS74ZBlWTP3BhBITSOOAfz8
         VUUddrT2NoY5GNGfTziox40tN1ZXB07WgQGH9hBnN+zOo7x/yn63b4YHE5R1ZXg1bN
         y2mVLNuAXAr1A==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lukasz Majewski <lukma@denx.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Stephen Kitt <steve@sk2.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221216094624.3849278-1-lukma@denx.de>
References: <20221216094624.3849278-1-lukma@denx.de>
Subject: Re: [PATCH v3 1/3] ASoC: wm8940: Remove warning when no plat data present
Message-Id: <167214224036.82924.7087854643611679926.b4-ty@kernel.org>
Date:   Tue, 27 Dec 2022 11:57:20 +0000
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

On Fri, 16 Dec 2022 10:46:22 +0100, Lukasz Majewski wrote:
> The lack of platform data in the contemporary Linux
> shall not be the reason to display warnings to the
> kernel logs.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: wm8940: Remove warning when no plat data present
      commit: 5dc5e76b4c41fc8cdd9ed77653b2ce453974fb30
[2/3] ASoC: wm8940: Rewrite code to set proper clocks
      commit: 294833fc9eb4e9d6c69f8d158cd991d641e59908
[3/3] ASoC: wm8940: Read chip ID when wm8940 codec probing
      commit: a5c26ee572d94337baf9c944b7b4881a2db62d37

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
