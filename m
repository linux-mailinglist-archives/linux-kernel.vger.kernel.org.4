Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A0562C140
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiKPOqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiKPOqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:46:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E351E3F05A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:46:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72BDAB81DB2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE952C433C1;
        Wed, 16 Nov 2022 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668609960;
        bh=8h23STOhuohvcppjywrWDE9rgijY1078aR3HT6vsyLw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TH566u3YDkmybi9jLXSgYBo9bevNguw9KV8wGIEhTi9puLCKWA6JcDv1LHJIl8rpV
         IE6qjPFKfi9yXCVazpvxFfKSYv2bOMtVCd7lcroDsZ7qNKa3wUxs+x/j/zUZpj2c9w
         gFgVZIKko1zYxQYoc4/xwq8nQOx96UgR5Dlk5utfHMjiYGM4SRB23DWDyNye0xt5cT
         f6/0OCyF3W8MKhtU1id4d0jblMB0w8mLLH9l09er4R9Vb7UznDLKAtPHy/mHqMCw0+
         Py5lOw/e4yznIvNDTKy2pc/y2oSgox9GbAVnrnQJ/uF+KqsuSQUxuuKlqMFWbrTVA/
         a9Fj3mdAGZtlA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
        Vijendar.Mukunda@amd.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Basavaraj.Hiregoudar@amd.com
In-Reply-To: <20221116105938.762550-1-Syed.SabaKareem@amd.com>
References: <20221116105938.762550-1-Syed.SabaKareem@amd.com>
Subject: Re: [PATCH 1/2] ASoC: amd: ps: update macros with ps platform naming convention
Message-Id: <166860995741.526370.1821465531343150450.b4-ty@kernel.org>
Date:   Wed, 16 Nov 2022 14:45:57 +0000
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

On Wed, 16 Nov 2022 16:29:22 +0530, Syed Saba Kareem wrote:
> Update macros using ps platform naming convention.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: ps: update macros with ps platform naming convention
      commit: d25ec74c6c5419f834bab506f251bc760bdfb858
[2/2] ASoC: amd: ps: Move acp63_dev_data strcture from PCI driver
      commit: 7d95977533e14738e8193c14a7efac369288aeee

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
