Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81E17372DF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjFTR3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjFTR3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:29:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CB71995;
        Tue, 20 Jun 2023 10:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68D4F61316;
        Tue, 20 Jun 2023 17:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40909C433C0;
        Tue, 20 Jun 2023 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687282154;
        bh=lioq7mex040QABLYI2qsir/2Ee7Vlv3H1GUQrVC7a1g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AX/ucCzosrfmmUjihrXZ3Jg0wYzmj2LxqptcCPX9l82bXdhFy6lLM7RPLJ7vUYD0W
         weIh5TYKkap/EMk/jiLL/wVvS1mlSVRXs8/5gBOw5Ou6iU28ZPwuPQd1I+0FQw9ait
         CX1dpjYuKqhtXbQKqWbZdX2k8pnLfEE1wWKDL8z4L7EWF2Yj3NlSrz/KYGgRuoDvyB
         sW9AHehm8X0F55BpKVlJVI4TCSKOYX8pFfnPJgQg21AfqOKccmMSCKxbeyivcHPW6A
         P+84JtUO7wpckJpq0adzFYcO5aLQXGthq4hAu+J5ZxHuDX2bHt6lte70lnOfcoY2Db
         mjkybMX9H1Iig==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shenghao Ding <13916275206@139.com>,
        alsa-devel@alsa-project.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230620095620.2522058-1-colin.i.king@gmail.com>
References: <20230620095620.2522058-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: tas2781: Fix spelling mistake
 "calibraiton" -> "calibration"
Message-Id: <168728215296.92979.15498830214406273531.b4-ty@kernel.org>
Date:   Tue, 20 Jun 2023 18:29:12 +0100
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

On Tue, 20 Jun 2023 10:56:20 +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it. Also fix
> grammar and add space between last word and (%d)".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Fix spelling mistake "calibraiton" -> "calibration"
      commit: 0a08778126284481c300336f1ba3d7b1906851a5

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

