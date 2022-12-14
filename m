Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02E964D1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLNVYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiLNVX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:23:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A5D36D68
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:23:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26C8FB81A28
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 21:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7BFC433EF;
        Wed, 14 Dec 2022 21:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671053032;
        bh=6i+uXOcEHXv6R+BKqJ2YEdmE4HKT/+VF1N8+Qs62I1w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=u1jzofNsDf/5KBreS3+NETXWD+t1sim9Juk0Qw5ZP2X4G2zYRDmYOUI8/MhbHdsOE
         W33/gAj1xfVeFwnARL2bNBdzIhluwFeDy5/SRWDnElaFJ9gE04AxgShT6hovFn+X33
         RJ7t5HVBwjpvpsQUUnQBfWOZpm+rAnwkQDJqJ90VSmSiB84t1Ok8ZHca7aPrZ599VR
         pNTc1IyRwhp2UfCdqkHAPpvOiWsMO8Fm3PSQJdHciG5MQuCaQiLadXyT2SO6+fvJtV
         SKC/WfjaWlC83tKp8GCeDsgiiKQjEFtkGiTH6z5qgIxzlVPev/OdZolkuEiYynWzRc
         oyeDkyWCQkqZw==
From:   Mark Brown <broonie@kernel.org>
To:     cezary.rojewski@intel.com,
        Moises Cardona <moisesmcardona@gmail.com>
Cc:     pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, oder_chiou@realtek.com,
        akihiko.odaki@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221214120830.1572474-1-moisesmcardona@gmail.com>
References: <20221214120830.1572474-1-moisesmcardona@gmail.com>
Subject: Re: [PATCH] Add HP Stream 8 to bytcr_rt5640.c
Message-Id: <167105302976.462250.4837987756943780848.b4-ty@kernel.org>
Date:   Wed, 14 Dec 2022 21:23:49 +0000
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

On Wed, 14 Dec 2022 07:08:30 -0500, Moises Cardona wrote:
> The bytcr_rt5640.c file already supports the HP Stream 7.
> 
> The HP Stream 8 is almost identical in terms of the hardware
> with the exception of it having stereo speakers, a SIM
> card slot and the obvious size difference.
> 
> Signed-off-by Moises Cardona <moisesmcardona@gmail.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Add HP Stream 8 to bytcr_rt5640.c
      commit: ff5870a76c2abda389650d3711cdddc031d12665

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
