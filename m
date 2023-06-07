Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080C6726AA5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjFGUSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjFGUSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:18:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C17213B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:17:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E62363BCC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 20:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D516C4339B;
        Wed,  7 Jun 2023 20:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686169057;
        bh=zsPzO5a6bllANxRMWQUa1/0l3GlQrD4RD45fLinGBTo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=a4vSyRdF0yIMV9kcaIJk1sRzzy+vwJvJCDbynWzBCHIiwvzTf42KIErqfc2/WxcCe
         ocLWW7HfbeAN0YKwiQVquX5vstL/iL2XIgaimWOyHN9lm5AqYpNILXCGs6oS29x5b/
         AGJT4lzrLTWOALKZpt/+OENMuO3SncP9g3qoOk1QutT3IxyRcZDBKWc9H5tGYqLVUB
         xHIOLT5WdW0z5vCyHcNxfmYFKlte/QNbUBNk1LXdyNkL3XSS2wt9HkQg2ZqG4Nj91N
         hcoJsBMMKG/oZ85jm51+zLIHEg25iJ5TcpkFZeXtqf7/1/IQid8EADnGfSAfkVAPOi
         fE3cCuYDArLVQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607171326.179527-1-krzysztof.kozlowski@linaro.org>
References: <20230607171326.179527-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wsa883x: use existing define instead of
 raw value
Message-Id: <168616905594.205102.6112069907214970415.b4-ty@kernel.org>
Date:   Wed, 07 Jun 2023 21:17:35 +0100
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

On Wed, 07 Jun 2023 19:13:26 +0200, Krzysztof Kozlowski wrote:
> Use existing define for WSA883X_GLOBAL_PA_ENABLE instead of hard-coded
> value, just like in other places in this driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa883x: use existing define instead of raw value
      commit: 99f3e7de7a100eddcf92af55a7e23000afeed35c

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

