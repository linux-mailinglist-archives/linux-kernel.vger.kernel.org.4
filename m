Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8E473C4B1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjFWXKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjFWXKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826BDEA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F1F361232
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D69C433C8;
        Fri, 23 Jun 2023 23:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687561816;
        bh=Mhd166EPkeVELtxz3wOL++HbLzHAs9D0tqBr4aCUI4A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fFm65H5c1qSSW+fLp1P/xOXOUCNI3jK6nxEndmhpdXCd5joIDM60s1jJe0XAp/qYf
         UkCSa0T5yMzsA03yiZbPkm1mN4CJNGdkNvFF/3zPSfMYbIi2Rc5VEbD6BPF0J4yVng
         3FNBsE97EC8c6MkwipV7sB+GFPDRTujEmWC4ijgBiY3zPB/8vbmqTt6HYY15/wh866
         qDIS6YBEM8Gy/nVbkeMrefji2FTHxG2WTGscoTSGlKMdxNomGgxCq/iE6ca1+k4XXF
         wL2c4hH0VcbG7/Du1eR3ODOWa1shiStJH/DD/F2EwxIPN1djkWVD2ijSQ3JUqxotpH
         PuPy8MMgxh8Ow==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230623-asoc-fix-meson-probe-v1-1-82b2c2ec5ca4@kernel.org>
References: <20230623-asoc-fix-meson-probe-v1-1-82b2c2ec5ca4@kernel.org>
Subject: Re: [PATCH] ASoC: core: Always store of_node when getting DAI link
 component
Message-Id: <168756181441.1144026.11961364462852265443.b4-ty@kernel.org>
Date:   Sat, 24 Jun 2023 00:10:14 +0100
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

On Fri, 23 Jun 2023 22:04:39 +0100, Mark Brown wrote:
> The generic snd_soc_dai_get_dlc() contains a default translation function
> for DAI names which has factored out common code in a number of card
> drivers, resolving the dai_name and of_node either using a driver provided
> translation function or with a generic implementation. Unfortunately the
> of_node can't be set by the translation function since it currently doesn't
> have an interface to do that but snd_soc_dai_get_dlc() only initialises the
> of_node in the case where there is no translation function.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: core: Always store of_node when getting DAI link component
      commit: 2d0cad0473bd1ffbc5842be0b9f2546265acb011

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

