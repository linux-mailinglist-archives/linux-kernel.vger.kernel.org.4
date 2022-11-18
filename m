Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA8A62F5B4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbiKRNQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242036AbiKRNQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:16:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0853059175
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:16:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8169EB823B1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DB8C433D6;
        Fri, 18 Nov 2022 13:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668777364;
        bh=9MMUYFRRKaYwzeCf2Np6fZLnC44Y0lXhfJrXHsvnKlQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HlDoAlfnJaE46Uk0mfb7ULFZFmHe+TcyKaIpQhvgmFbTQdDOp8ugO11tAt0k51M26
         1vHmIsSHZo2lI93MymrnGELeA03nVwa57gJWUG+L3q8yvWtbZ7vGu/+HuhKHb/oxjR
         N2go4QXrDy20QLaM0uquXSzBF0IVNJhDVAOK5W8DLL1ZCfA2YMVaVvrMscvY9HKs3+
         8QaFXwyAUidYT5PaumVF+oZXT5CFMr0jfhjunI8C0noohE8FmK8Bj5CcLJ5hZkp7ve
         cHbtfVAsIDNaM+0vAEc3vWS6rbS32avWrsfPUXQT0aHEImnMJSfh5gcfNOiz7pw/tL
         gmTGqbJA9MCzQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jyri Sarha <jyri.sarha@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20221117103223.74425-1-andriy.shevchenko@linux.intel.com>
References: <20221117103223.74425-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: SOF: probes: Check ops before memory allocation
Message-Id: <166877736036.779720.17364328796759988809.b4-ty@kernel.org>
Date:   Fri, 18 Nov 2022 13:16:00 +0000
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

On Thu, 17 Nov 2022 12:32:23 +0200, Andy Shevchenko wrote:
> We may check ops before spending resources on memory allocation.
> While at it, utilize dev_get_platdata() helper.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: probes: Check ops before memory allocation
      commit: 82b21ca1912723a53534086864ee0daceb604cb5

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
