Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E483870C1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjEVPDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjEVPDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:03:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2B0E73;
        Mon, 22 May 2023 08:02:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8618623BB;
        Mon, 22 May 2023 15:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AFFC433D2;
        Mon, 22 May 2023 15:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684767715;
        bh=Cb7wYsL4GyXP/HGoxz6KSl4qGY9mIiX9Yg7CdwhMpu4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fROP6QjYw1cwPrTFMPPa52tHByCRAnAEYRJKYY/vLIZKUtsKCM8abpK46pBkHFgJu
         V19r5mGgnv288GhjqNer5i+YZVov8RrPjn4Uj8HIS+c9cHE/PRTbCzZEz1AFLJXUPI
         gy4i0ddWfVyErmnVB1L8Vgx7P3qJY4N/SV9TJ5c7eiF37I6WHHwBEtYHOBV3lVGQ1v
         WiI9AItD9+w5zZpV0yVSNzVbWx+NwIAyJCyfwnp+r/zMlPNPgIQv77tJFUltMjZBJa
         lWh4dwXhkC7qVpEy1Bf4rNYoW60hPhehkP5Y0GT/SJE5APF5VCWlARCJx3+pPG6Jfm
         p2hfVEskU2NKw==
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <f7987f18dadf77bfa09969fd4c82d5a0f4e4e3b7.1684594838.git.christophe.jaillet@wanadoo.fr>
References: <f7987f18dadf77bfa09969fd4c82d5a0f4e4e3b7.1684594838.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: stm32: sai: Use the devm_clk_get_optional()
 helper
Message-Id: <168476771240.849172.17021857411511988497.b4-ty@kernel.org>
Date:   Mon, 22 May 2023 16:01:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2023 17:00:50 +0200, Christophe JAILLET wrote:
> Use devm_clk_get_optional() instead of hand writing it.
> This saves some LoC and improves the semantic.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: stm32: sai: Use the devm_clk_get_optional() helper
      commit: 374628fb668e50b42fe81f2a63af616182415bcd

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

