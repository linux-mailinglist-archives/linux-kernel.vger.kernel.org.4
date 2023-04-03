Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA976D4B67
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjDCPH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjDCPHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554171825E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E923D61FDD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8940C433D2;
        Mon,  3 Apr 2023 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680534469;
        bh=ctP9KIAO52Kp15QFrAPu3MWL9C3jbTxflfhT27h9H/o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FOmuBoJ0X4jOYdtKh8CRqMwhs27px+AxE+7pLhSqT8rgHo1i1xYYFbdYNkdz/JFA2
         vKMt+++kgjj3YRmzknvo9lZOb/Q56jhn4RA3Sa1REwK+GJiFMTLoSOjTHLj35VxHaP
         fh7CH4FBJXxvsG0FqbWZpqyRwU1cbkSKMo1+7BQxEpATSYeNvdG/nbz7NQFxE0AQvT
         MovYQmQBu83eW8OPz62qop86uVe+bQsNwLH3cc5mhDuPuaswbj00MJj/W3M2+ZJ0ft
         wOOBfKvTDG3xPBLXx5NDA4ILKt43RFg93rAqzKG0atUryCJVU+pCQnOeojVDY+jbMY
         iPz2+2o6M1QLw==
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Rander Wang <rander.wang@intel.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Zheng Bin <zhengbin13@huawei.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230403071651.919027-1-Vijendar.Mukunda@amd.com>
References: <20230403071651.919027-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/6] ASoC: SOF: amd: remove unused code
Message-Id: <168053446539.47553.12390291979840159138.b4-ty@kernel.org>
Date:   Mon, 03 Apr 2023 16:07:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 12:46:41 +0530, Vijendar Mukunda wrote:
> During initial SOF driver bring up on AMD platforms, only DMIC
> support was added. As of today, we have a complete SOF solution for
> I2S endpoints along with DMIC endpoint.
> This code is no longer required.
> Remove unused code from RMB and RN platform ACP PCI driver.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: SOF: amd: remove unused code
      commit: 56e008146e5b46059c5469a8b47478ab78f5b895
[2/6] ASoC: SOF: amd: remove acp_dai_probe() function
      commit: 9eb48aeddd8dcf2defd94a837a65e052576cf42b
[3/6] ASoC: SOF: amd: remove unused variables
      commit: 2675de62de702dbda936eb0f9a20ce3d8fed5ab5
[4/6] ASoC: SOF: amd: refactor get_chip_info callback
      commit: 292b544ef4555ec5c69522e9c6eace6a90c4cd00
[5/6] ASoC: SOF: amd: refactor error checks in probe call
      commit: c7a3662f14d7e0add7b50dc2f971e77bebb333cc
[6/6] ASoC: SOF: amd: refactor dmic codec platform device creation
      commit: dd6bdd8b4d41b8f9db4b88dff2d10c0c62dbeb1d

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

