Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EA46F63EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 06:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjEDEK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 00:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEDEKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 00:10:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9EC19A8
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 21:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A97663178
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 04:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912A1C4339B;
        Thu,  4 May 2023 04:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683173453;
        bh=b54NE5I89A3lhMM6mWdX+VclYU5RjljTIR3b1SP852c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=j4/qpF9QvFt/ftaRBpo7fKmiW8ABOcsTWxVZdzmcI4IgcXlmW46wWp+xtsuCIqZlM
         uVbAXd/kF2n5ZRURAsrIPZ3ys5vP+P79kInBFjWO/iAhz6EwSixDK8jTmaqmno6tgS
         EFQAq+vaSGwOeu7nEX5UUNScAMW7dkitLLfH4xtNwzpUPpr2rnGr2SlNvPIj10GEP7
         XWHALs6wHqYPhqPOOHym02kinLX+TuUQBQs59T9SFkjuDngf2fyMgPd2ewIv7XSzlD
         7siwikcrM662/fCNOxEQzcdoooo00wY3P3g4+nXa6yaY7Z7adGMHvBs2nm4erDUcXN
         hQLWuVbg/88/g==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Andrey Rakhmatullin <wrar@wrar.name>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230501185134.34591-1-wrar@wrar.name>
References: <20230501185134.34591-1-wrar@wrar.name>
Subject: Re: [PATCH] ASoC: amd: yc: Add Asus VivoBook Pro 14 OLED M6400RC
 to the quirks list for acp6x
Message-Id: <168317345231.155442.10736020348986933324.b4-ty@kernel.org>
Date:   Thu, 04 May 2023 13:10:52 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 May 2023 22:51:34 +0400, Andrey Rakhmatullin wrote:
> This is needed (and enough) to get the internal mic visible and working.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add Asus VivoBook Pro 14 OLED M6400RC to the quirks list for acp6x
      commit: 4a1b5bc73e9ce8373d50fdb8f74badd2b4bf324e

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

