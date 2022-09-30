Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6755F07CB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiI3JlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiI3JlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:41:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ECBC1131
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48079B82751
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11BFC433D6;
        Fri, 30 Sep 2022 09:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664530868;
        bh=RjJP6W5iqZsMUis7v06lqFNNd3lidWgVU5r6bWkScGo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XJaR4/QXTe0k/LjkcToimpvRRqvejcMvIMMMPMV8qJ6NztgRXekj/wVTnBRf2Qt1D
         ltEkMBROS0eAdt1Oon6/xGHzTmce5J6XnWvG+MxJ8bZlVR14E97cW/6pgsW13Njm+3
         wJiriM4esEnTfdVNqp3uR1YeS6DPSSNt0wMdnxcBC2SJhzH2vMhIup6QRbFY+sL0Al
         Z6fOEjlZ94BRoxUFRtIeAwWdBifarTHSWvc+MA1gVmfZosnxymoIEYLkw5lQ/4VSAn
         LnELky4EfEhexMfVRwUeCt3rUtqS9VMia38AIaP1cM1PnTlKSmcFZWg2qeecza7EDm
         RipSBwqI4wZPA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Ajye Huang <ajye.huang@gmail.com>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>
In-Reply-To: <20220913074906.926774-1-brent.lu@intel.com>
References: <20220913074906.926774-1-brent.lu@intel.com>
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: remove SOF_RT1015_SPEAKER_AMP_100FS flag
Message-Id: <166453086469.89101.17355339743373464176.b4-ty@kernel.org>
Date:   Fri, 30 Sep 2022 10:41:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 15:49:06 +0800, Brent Lu wrote:
> This flag could be removed since we now have API to query bclk
> fequency setting in the topology. The dai link structure itself also
> provides DAI format information instead of figuring it out with fs
> number.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_rt5682: remove SOF_RT1015_SPEAKER_AMP_100FS flag
      commit: 4157155df7d34bd91879c06a787944529f0d9a0d

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
