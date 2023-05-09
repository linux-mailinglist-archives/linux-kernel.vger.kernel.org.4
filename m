Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5956FC2E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbjEIJfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbjEIJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72B211567
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2912262D49
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDACC433EF;
        Tue,  9 May 2023 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683624777;
        bh=YkP+9nzJf7FuXgkUkk5HPDzH/zBWnTOgyTpPE8pO4lE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Uiiun6tjTocEOD3UZ+N6NlWAsbsJVSQzEYquYHC9uTm+n5UZa8Rmmq2Cch9VEf1YH
         VVaMgZDhzRM+WhF/LzowhK4b64QLO5yIiUXLlu3pJsoNDuP7EaS/NWiFFJBt12wqli
         arN/Wq+9tQEBERrJ4SGclVUhh5w0nJd14plnig1GHpsnR5waJCDhdqzSzTbEppgqGX
         qvUrMPGYRZdeHW9TSQxhFjt5QrqS11XgT6x/5Q5MM1RHuAr9QEPK8GC48/yVY/qNxe
         Av7DJ5zzTW/3kA4hmbUWvTvlWX1poGm7TJW/3zwN7WOgOmRjpbRtwW1zhmS3CO8j01
         zMq3dnTzcsaLA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
        ssabakar@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Paul Olaru <paul.olaru@nxp.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230508070510.6100-1-Vsujithkumar.Reddy@amd.com>
References: <20230508070510.6100-1-Vsujithkumar.Reddy@amd.com>
Subject: Re: [PATCH] ASoC: SOF: amd: Fix NULL pointer crash in
 acp_sof_ipc_msg_data function
Message-Id: <168362477289.305930.16081039230793204822.b4-ty@kernel.org>
Date:   Tue, 09 May 2023 18:32:52 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 May 2023 12:35:08 +0530, V sujith kumar Reddy wrote:
> Check substream and runtime variables before assigning.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: amd: Fix NULL pointer crash in acp_sof_ipc_msg_data function
      commit: 051d71e073614a72ad423d6dacba37a7eeff274d

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

