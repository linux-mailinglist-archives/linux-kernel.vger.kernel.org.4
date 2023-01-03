Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8948565C6DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjACTAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjACTAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:00:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08C713DF6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:00:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C04961499
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 19:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E434C433D2;
        Tue,  3 Jan 2023 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672772436;
        bh=rHCesJ+cl5D0m6koH1aTaI1S1JP4QlOBXoCX2LsSXr4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cTnXHpSyIEdGcRaodXG6vuQlwK3BlDoYkOCL5PJ7r+AEH6Q0vwEHT9gryvePz0b6W
         ndlum+j8MaFUZzyTsyjTfupr8k+C1eXaJxOfpGWqIF/s9evyoh8/a8Y4ansZQ9ak9d
         zq93zRzzTEtj+ZWL7d8mii3sQIDN2AakkxqmGaJ8yBhJz094Je+jznLVShktIUgwvN
         CrN7n2nQkgVKb8ST8se1YZRroEJYcvFwVIDoPkbt5Xxqz+gnZSRwKSSAuFIF5nndIs
         gi1e7eGxa2nv4ASv9HKBukSZ7BxNLGmx4nny7xedxpqxE8m4/wJeav5PSl98fxSjBQ
         ZJ/X8NiL5W1gw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230103073704.722027-1-brent.lu@intel.com>
References: <20230103073704.722027-1-brent.lu@intel.com>
Subject: Re: [PATCH] ASoC: Intel: sof_ssp_amp: remove unused variable
Message-Id: <167277243396.325583.15307745179196438624.b4-ty@kernel.org>
Date:   Tue, 03 Jan 2023 19:00:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jan 2023 15:37:04 +0800, Brent Lu wrote:
> The variable becomes useless since we moved the snd_soc_jack
> structure from a static array to sof_hdmi_pcm structure.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_ssp_amp: remove unused variable
      commit: 03178b4f7e2c59ead102e5ab5acb82ce1eaefe46

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
