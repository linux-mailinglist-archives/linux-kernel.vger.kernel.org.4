Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC59969A398
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjBQByN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjBQByL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:54:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848F354D35
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 17:54:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C745D6121C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B961FC4339B;
        Fri, 17 Feb 2023 01:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676598849;
        bh=Gw5LE3twoGw4eDFOyNeOTFFuzAZaxlBPT44ZcdXStuk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pMYaEO+nM4HYKGFOGrCC2gJ8NTppz1XUFbx7S2o42CcorIXnk5RaTfbxb9X3YstTs
         NoBC09X09lo6E8Wp1rYMY33QQ5+NjHLYMMvKHUqAhSHpntxnTerAY4yK7Xdn0VdyI5
         lCsunmp/8USEwUfWiySLAzgkgYonRJmxMxmuzfrfmimlc0a975onIagYfxp26/Egyr
         tDwiUZDmYYhI0nAvO+hzjacM39/rania2WmrBI2KGYMNml3l/ui3Vd6hQWw2K7yv+B
         x90xrZX0C3jQf0IQ/DmiTSgrJ2XFTHO1Jbq+VGybP8ixpawXN11ZPnUK5Te+KOoouf
         GbDq4v3MHcwdw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Joseph Hunkeler <jhunkeler@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230216155007.26143-1-jhunkeler@gmail.com>
References: <20230216155007.26143-1-jhunkeler@gmail.com>
Subject: Re: [PATCH] soc:amd:yp:Add OMEN by HP Gaming Laptop 16z-n000 to
 quirks
Message-Id: <167659884738.51394.3064624449308276945.b4-ty@kernel.org>
Date:   Fri, 17 Feb 2023 01:54:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 10:50:07 -0500, Joseph Hunkeler wrote:
> Enables display microphone on the HP OMEN 16z-n000 (8A42) laptop
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] soc:amd:yp:Add OMEN by HP Gaming Laptop 16z-n000 to quirks
      commit: 22ce6843abec19270bf69b176d7ee0a4ef781da5

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

