Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70770623357
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiKITTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKITTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:19:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9634EA1B3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:19:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5115CB81F60
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 19:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B427DC433C1;
        Wed,  9 Nov 2022 19:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668021585;
        bh=KjkKpABDy8OeBeVkXUOWJR/+NxgUIP0eVBrO0CIT2pg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O7wiuRzJgFuqH/LSvl6UcOtawT2jlc4AtjpSI1SQ9Bbh0Wv0YDrx2B13Q1LA2Pu+h
         EsR+Jum1+/cfBQ6+cPuQiUwwv/HPN+ip+HdXlybqhnyUWm+Db3PBUg0nPlC5MdQopi
         RJ4xAZd8Cghqg8V2MdG2muGzdFzJULKnpoVo6tZp385JXrhmpGw4U36HCJdHyi1kNY
         6qzv6jXZl6TOvpJvYqZwQUNUM7lqTT/zfw2r+OvVZ1Z6V/kaLv8K4LNRGD/p9PjbWn
         naUMJU2xuQelSVtJ6wUegtPVMRlYSK6amfowqnPN03YCBoEo81ZhqBS+abpRXC2efH
         4V2wUGIdmiLHQ==
From:   Mark Brown <broonie@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
In-Reply-To: <20221109170849.273719-1-olivier.moysan@foss.st.com>
References: <20221109170849.273719-1-olivier.moysan@foss.st.com>
Subject: Re: [PATCH] ASoC: stm32: dfsdm: manage cb buffers cleanup
Message-Id: <166802158345.681172.6341903177442237519.b4-ty@kernel.org>
Date:   Wed, 09 Nov 2022 19:19:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022 18:08:49 +0100, Olivier Moysan wrote:
> Ensure that resources allocated by iio_channel_get_all_cb()
> are released on driver unbind.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: stm32: dfsdm: manage cb buffers cleanup
      commit: 7d945b046be3d2605dbb1806e73095aadd7ae129

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
