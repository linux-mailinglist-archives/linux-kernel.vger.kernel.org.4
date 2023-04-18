Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529676E6946
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjDRQVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjDRQVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:21:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E389773
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:21:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B69416367C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 16:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A19C4339B;
        Tue, 18 Apr 2023 16:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681834889;
        bh=sEurxhubJV3nON51IQZqLGOw26j1V6FgvthN0k69le8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=jfBEGMl5amAy07pYzf66+W/0cbQfqJp+8j9IGzcAsovNiuHUmS7UZV4kZ1U6UHVPS
         qrhYixAKvS93OHrIjNL+Bykm2oytk0oCezCJNMxKw8BOT6sEq0JFblpYtAoNQQz82q
         fTWJ5gYVG3BAHnBgR2slYPgYkrcwNLbYWFGwIFXyOt4ReXUD7s2lDTdjh32L/CPOJb
         B/W+QIVxu1DA54PMzXHCoyAphlCpx+pd7cwMukS2z6y80iu+Hto/7+nsmXzONuKurT
         SNKJ3cKo52auL1Jzj+0c9Ki7dn79r2Qn2Avc7VzIlm9d9OwWzgq1BPLCmYBqKDyt9H
         LD8FRoAMqHnYQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
References: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/4] ASoC: codecs: wcd9335: Simplify with
 dev_err_probe
Message-Id: <168183488717.87933.2105607240342604934.b4-ty@kernel.org>
Date:   Tue, 18 Apr 2023 17:21:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 16:14:50 +0200, Krzysztof Kozlowski wrote:
> Code can be a bit simpler with dev_err_probe().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: codecs: wcd9335: Simplify with dev_err_probe
      commit: 67380533d450000699848e292d20ec18d0321f0e

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

