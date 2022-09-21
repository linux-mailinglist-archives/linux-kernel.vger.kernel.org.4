Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8897B5BFACB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiIUJYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIUJYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:24:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10DBE038
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:24:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AAF0622F2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CE8C433D6;
        Wed, 21 Sep 2022 09:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663752256;
        bh=rAuxqPx42mAjtQZnFlh+Q21reaXO0ms/6WnRLYM8jx4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CO+suIzp78LCtUdlS9/h0qLZANnIwmpqOIhrGyY1xjGbVaPnpK5obtLvV8LPyXCnm
         0O/YDXg3iR/F98DSJxUIu2ZHw5gnXL+DB+doWZhDL4G1fv1WweQ3JkWaUA04PCMGns
         SbQ9HYvPBxKR+gVp9i6dYACVrWuODDz9ywWFpyRVYmozVEV5SODcr1NHqVsel8mFpN
         vb/X55uy0TSphCVe61HnrGWm0Pr6/lXwiuCmb4cYp/UIDbXFYPyR+jzNh0/Gxum53b
         RbivIgoQyZGcb/DCu3gX9d2iPBc16uCwZKDCBKCJYbk6btJbqHB0VIdERhYQZfpPUr
         fbYJqxvQgE1+Q==
From:   Mark Brown <broonie@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, Sebastian S <iam@decentr.al>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        Travis Glenn Hansen <travisghansen@yahoo.com>
In-Reply-To: <20220920171320.7776-1-mario.limonciello@amd.com>
References: <20220920171320.7776-1-mario.limonciello@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add Lenovo Yoga Slim 7 Pro X to quirks table
Message-Id: <166375219306.526450.5755084616429501425.b4-ty@kernel.org>
Date:   Wed, 21 Sep 2022 10:23:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 12:13:20 -0500, Mario Limonciello wrote:
> Lenovo Yoga Slim 7 Pro X has an ACP DMIC that isn't specified in the
> ASL or existing quirk list.  Add it to the quirk table to let DMIC
> work on these systems.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add Lenovo Yoga Slim 7 Pro X to quirks table
      commit: 2232b2dd8cd4f1e6d554b2c3f6899ce36f791b67

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
