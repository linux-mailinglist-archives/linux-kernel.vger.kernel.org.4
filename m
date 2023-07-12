Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AD375068E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjGLLrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjGLLrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE211BD3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:46:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9E876179B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE21C433CD;
        Wed, 12 Jul 2023 11:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162411;
        bh=JXAMcZrpRoE91F6XTSvxZwcYhk6D31xbdpQ1w4SM5Ns=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Ug77po3JMwPWMfa4AgH0aTo577IWr7JHKnVhLNkT7MaYL7jRKqyYx9n7qmXYFms1F
         voLs+23dPqdWNMKTdRUW9Lti7Ynb2Te3lqf+1WarjmTBFRD+actcKwAE3Ht/QjArKi
         Jwa0dPaTXTU4WLNowXxlbesUOiY1YGQdey9ZNtdhQsQCVOEaOkV79J9bC+C3U1LitF
         1vlUyevOEuItBBWnt9mwXwolZG9ucqQfWvdxMIv5mxEIc4K37NtC0Q7vi3N9qrJUX3
         ZfwIsHV7tl3wm103IrqoN57DbjNBT+kTdH4MFQImTByu6QCJ8TBg5Hobmf43jgO3Gb
         sdufjRjTIFVgw==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20230625065412.651870-1-chancel.liu@nxp.com>
References: <20230625065412.651870-1-chancel.liu@nxp.com>
Subject: Re: [PATCH] ASoC: imx-pcm-rpmsg: Set PCM hardware parameters
 separately
Message-Id: <168916240829.46574.4591447025609181967.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 12:46:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2023 14:54:12 +0800, Chancel Liu wrote:
> Different PCM devices may have different PCM hardware parameters. It
> requires PCM hardware parameters set separately if there is more than
> one rpmsg sound card.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-pcm-rpmsg: Set PCM hardware parameters separately
      commit: 82770b76abae2ff9d70f354a61983b921e63bae1

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

