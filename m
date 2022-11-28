Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB20563ADEF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiK1Qj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiK1QjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:39:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084B624F12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:39:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 982ED6126C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 16:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021B3C433D6;
        Mon, 28 Nov 2022 16:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669653559;
        bh=r7oK9gKTFrfT25jnJNs0I4GAPDbwydVvp8oH1NS7/G4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LLrQcXhSmwf5XH5KI87pXrmViqXZrgeXvw6i7nmvqUOPfnF5PRW1sPwIPL7bqxGM8
         ChLW3hfrwNzXFhyb0lD2Hm7p/WX18RhRYDf7RiSfa2x2D/IWipnLopsla+blaEkoub
         NjlOYpoBhOhVxpiiIxRcxBeJ4Zfei8f/7tnBRkSdhes1lO0cRxvaoYa2/K31pGpp6E
         4WLdvUR57lBqJ11pkwAl8qWY5Nh7tqFZRjlpVnPgpWVGUmkbzbkx0BzVPi6DzaXncw
         wrG7WGPgmB8exdQp1Dv+KjxLYJw4xZQfVbEFPmHGPw25Nyidl6qSF94V9LOXoBHrA1
         4DsDa+RlB681w==
From:   Mark Brown <broonie@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.de>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20221127193441.0b54484d@endymion.delvare>
References: <20221127193441.0b54484d@endymion.delvare>
Subject: Re: [PATCH] ASoC: rsnd: Drop obsolete dependency on COMPILE_TEST
Message-Id: <166965355773.629583.13607764552879782158.b4-ty@kernel.org>
Date:   Mon, 28 Nov 2022 16:39:17 +0000
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

On Sun, 27 Nov 2022 19:34:41 +0100, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rsnd: Drop obsolete dependency on COMPILE_TEST
      commit: d695d089e35e28f3f0ed4595a242922cc28f9b20

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
