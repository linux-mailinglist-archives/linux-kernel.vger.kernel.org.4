Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC0D619C14
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiKDPtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiKDPth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:49:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD803205D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11217B82E10
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 15:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09C1C433C1;
        Fri,  4 Nov 2022 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667576973;
        bh=Lf8JCJgjgUQ53WHCpkUyzYaK8iGnPpryq97fFhrWBQw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IWqcHhUCaJST3EpTW+B9ZO+VXxkf4XUFtPwQ9+1lSLJIUehn7JeDn4emOPcRtMkM7
         GnM6BrtBvYIscE4zZUYPBxWhgkgNHEsXC/pg3POWotODXnJwMf0Sp+L6BadS/8ndNm
         r6rvLsAHiJ07f+WFPtclFlFspOO4x54XrozeF3/EGZafFsUgSVbatE8T2PQv/A2sJC
         m8Ddqcg2+Qvt0UfNyVqUJklyye28agBYqDfMt72wCGzPmwsJ3QXBSTpg8jxMc1CWjM
         gMDa0aeSbx8meh6e9Eq0dwks5hNCfduipctu7XHalgIxVDCgE7f9iS38QxLEJCRBLs
         nOjOqYvcJPR+Q==
From:   Mark Brown <broonie@kernel.org>
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        alsa-devel@alsa-project.org
Cc:     syed saba kareem <syed.sabakareem@amd.com>,
        Basavaraj.Hiregoudar@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Vijendar.Mukunda@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        mario.limonciello@amd.com, Sunil-kumar.Dommati@amd.com,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20221104121001.207992-1-Syed.SabaKareem@amd.com>
References: <20221104121001.207992-1-Syed.SabaKareem@amd.com>
Subject: Re: [PATCH] ASoC: amd: fix ACP version typo mistake
Message-Id: <166757697041.399796.7667715854379542495.b4-ty@kernel.org>
Date:   Fri, 04 Nov 2022 15:49:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 17:39:07 +0530, Syed Saba Kareem wrote:
> From: syed saba kareem <syed.sabakareem@amd.com>
> 
> Pink Sardine is based on ACP6.3 architecture.
> This patch fixes the typo mistake acp6.2 -> acp6.3
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: fix ACP version typo mistake
      commit: 4b19211435950a78af032c26ad64a5268e6012be

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
