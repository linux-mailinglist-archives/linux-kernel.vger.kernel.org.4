Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0F26C6AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjCWO0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjCWO0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:26:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905DF1B324;
        Thu, 23 Mar 2023 07:26:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BE8262752;
        Thu, 23 Mar 2023 14:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFBEC433D2;
        Thu, 23 Mar 2023 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679581560;
        bh=M6Edg5DjVsm8prUJbJkzARqPmvj6mxfT7u619ddSojA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JYTOD1uZKNXcfY8VFb6SK7++ItlPK5up7Gzype+kcNVqumPjCgW0dSKLWGGV/iFw5
         zywQS3fyCzWEjb9eYXrq8eOtGD2bc/LRgNE8aGNd0rA8aCjbzJuPWcPmABIwYcfzby
         BIHSBw/VVx56ipCOMzzTclvfH9SuL4xlqUa0Ai0dCwuInd70Cya/EncKX/C7SmUS7/
         sME122FSz+8tADNb34utS7lF2UG5axYahPLU0lx88vI1rZoNR6wmKRpdRu/EaF8VvE
         OAJVVuRZta1kXUHdqLXVT9vUNVI8pxzwIP8hpnA8kNDV/2ac5feWGaq56iqOC/M1jh
         dUo5a6+WAgSQg==
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230323090531.67679-1-colin.i.king@gmail.com>
References: <20230323090531.67679-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: SOF: ipc4/intel: Fix spelling mistake
 "schduler" -> "scheduler"
Message-Id: <167958155761.49176.5077860409181267820.b4-ty@kernel.org>
Date:   Thu, 23 Mar 2023 14:25:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 09:05:31 +0000, Colin Ian King wrote:
> There are two spelling mistakes in dev_warn messages. Fix them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4/intel: Fix spelling mistake "schduler" -> "scheduler"
      commit: 056db840115653659d86a3931a78b3c504edb2cc

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

