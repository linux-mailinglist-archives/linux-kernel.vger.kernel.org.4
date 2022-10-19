Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1403B604628
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiJSNAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiJSM6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:58:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DFEB4F;
        Wed, 19 Oct 2022 05:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2DBCB822CE;
        Wed, 19 Oct 2022 12:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3379FC433D7;
        Wed, 19 Oct 2022 12:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666181107;
        bh=F/vs8b7abjKQcTaqlC59wWBxEf22jzV2p9r8gJVIZGE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=E+NPxH+NYowTYhFvZA/si/KHWYqSmzmJUZSDAPHP3oaYblp6TcgreK0gD16Sb2KuV
         2yXfcvSM9i/vdsolg6CMdMSqygf3/mTElc7vXfEqyaOs6WCaPEOH+kQjATgDDbPMwI
         ydvoF66VcwKUbmzxRdoEQ1iYoiaCdYfIka0gZg1dzvIR5S/n9miXjFqW/q76rQk6GT
         JapIr8CTHoYjP8t419TzGTskGgJrRwUHXt3yM31BhZEI53aiCPe9x6iVzTTq7XkwmK
         FdkU3nlAOoCCG881txjNg4BGmBdWMSPZsFQO52Y6V7BXAgqyJLZO38F4nEmhY25n6x
         YPunp94YoomwQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221018152928.942186-1-colin.i.king@gmail.com>
References: <20221018152928.942186-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] ASoC: twl4030: make read-only array ramp_base static const
Message-Id: <166618110593.80223.11956786873062777747.b4-ty@kernel.org>
Date:   Wed, 19 Oct 2022 13:05:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 16:29:28 +0100, Colin Ian King wrote:
> Don't populate the read-only array ramp_base on the stack but
> instead make it static const. Also makes the object code a
> little smaller.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: twl4030: make read-only array ramp_base static const
      commit: 67860d2a8e0db7783f680f6f1c1600ed34ed3a97

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
