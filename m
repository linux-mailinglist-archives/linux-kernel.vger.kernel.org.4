Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D752964CCB2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbiLNOx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238720AbiLNOxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:53:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C9326A9E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:53:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 694E8B818E4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54770C433EF;
        Wed, 14 Dec 2022 14:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671029632;
        bh=w5xhvVMm8HcONvBFdH0GaBJz/7H0mrmGXMjWGZuBv8Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Nl26XP32SxbpeOA3E7n4KLxmMIyuxGZPgbGDEYUueETTuCIhMhZz1JUnrIC/ufWYP
         8eetISDpNIk5bH/qt3D8VjaKqGpE5y0dmyOrKWFqQwCm0nbH9ug1SYHO8ZOGcT5+u3
         RgII5HQxOL9HrcZK0ndL1oL+FWTfyd3eddZQwlgwjkP0bQFBOo2Jacz/0bdh1YfskP
         ft7jQhHjFtklBVqVd/3x2oMu/YT60dGF7vSL7pxRYfguRXIpRQUbvY3vtJ8ST4tiJY
         B9YsN3HSFf6rs3juaYnTCTB0TM2ZItJ0FTBGIB0XvT4yvXUzHoZ4Bi8Yg5frCjljIC
         7JS8QxUyvDb5Q==
From:   Mark Brown <broonie@kernel.org>
To:     YC Hung <yc.hung@mediatek.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chao Song <chao.song@intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        chunxu.li@mediatek.com, Trevor Wu <trevor.wu@mediatek.com>,
        Curtis Malainey <cujomalainey@chromium.org>
In-Reply-To: <20221213115617.25086-1-yc.hung@mediatek.com>
References: <20221213115617.25086-1-yc.hung@mediatek.com>
Subject: Re: [PATCH] ASoC: SOF: mediatek: initialize panic_info to zero
Message-Id: <167102962807.215050.16757916120691616071.b4-ty@kernel.org>
Date:   Wed, 14 Dec 2022 14:53:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-7e003
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 19:56:17 +0800, YC Hung wrote:
> Coverity spotted that panic_info is not initialized to zero in
> mtk_adsp_dump. Using uninitialized value panic_info.linenum when
> calling snd_sof_get_status. Fix this coverity by initializing
> panic_info struct as zero.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: initialize panic_info to zero
      commit: 7bd220f2ba9014b78f0304178103393554b8c4fe

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
