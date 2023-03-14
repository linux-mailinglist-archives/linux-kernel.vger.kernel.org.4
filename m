Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D066B98B1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjCNPNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjCNPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:13:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC769AF2B3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27D49B819CD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFA0C433EF;
        Tue, 14 Mar 2023 15:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678806750;
        bh=sxY6IxxMJjTgL2d12zQJvjYKpWV410MnU3SAB376tMs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BIkvb1tkqgaqoJ2kMN88PmRGoAVh+8P8pG/6JwKfvl9aQzynROahhfTno2HHd5E59
         ZZyHCB7vWo0V9z37KrGHmWuCIZneJf9AeOShmqJTcBhM8qrwwONZPN9slIHfs7EipP
         sExPbIOu0+9OFrzY7Ks28xOnbPeJIjASYGbZUdxXQOz+ZlsAX0KGPBrNlxsrkJeEMe
         YgRh0vvcG4UgYKS+ecq1Jjrq5ovc+XHB/Gmq3QMwS1u2CTkxyMBSe/JqXje6JGyqlr
         dsRlBc3ZjGiksH4muW1leqd1SbYAgVt+NbCVC8QED3Fv+yS7F4Jzw9GXhbapjs6T+2
         6cGkltsWV09xg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>, dharageswari.r@intel.com,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        alsa-devel@alsa-project.org, Mac Chiang <mac.chiang@intel.com>
In-Reply-To: <20230310184201.1302232-1-ajye_huang@compal.corp-partner.google.com>
References: <20230310184201.1302232-1-ajye_huang@compal.corp-partner.google.com>
Subject: Re: [PATCH v1] ASoC: Intel: sof_rt5682: Enable Bluetooth offload
 on adl_rt1019_rt5682
Message-Id: <167880674689.43040.10505944947157085015.b4-ty@kernel.org>
Date:   Tue, 14 Mar 2023 15:12:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 02:42:01 +0800, Ajye Huang wrote:
> Enable Bluetooth audio offload for drv_name "adl_rt1019_rt5682" with
> following board configuration specifically:
> 
> SSP0 - rt5682 Headset
> SSP1 - alc1019p speaker amp
> SSP2 - Bluetooth audio
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_rt5682: Enable Bluetooth offload on adl_rt1019_rt5682
      commit: 12e3b2848bfa8197062b7989eefb7c081d372fb8

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

