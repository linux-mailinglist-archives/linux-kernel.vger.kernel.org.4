Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC486D252B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjCaQR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjCaQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:17:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A27822E8D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:11:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2BA52CE302C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3E7C4339C;
        Fri, 31 Mar 2023 16:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680279087;
        bh=a2nn9ApAiXxUS2mngL+N4oLVV5lpgnnKpfezBGQqbm8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=u2Yu73OAupWN1suEk4eTeMrxuAkZDqqZsFgxSS+4YitoPlNT19RpYdG5nm0tSZg6p
         9TdORG/B/J0sWsnC9HTTPxRSl9ShpHK3Lp/xaTh+jZeinHcOOJZ9C1nM2CvxtZ/ld3
         qQvnNc07SBLH3Sp6lxa8+JWC/YzGTkz+08QoQb5y5VhDppu1TYS+nfE8CopBy+gBf0
         Qy4ceclXugFmcaGyISOcWfivjxvD3KBFLL18FeLO6ZeJZVlUto9nPp9cJKcnOpFpDS
         g/F1wNBoHYEHp9FWemka24InNcacV0YOwhvXQKOuHL9oZOBoLGNCb5dqazhwy5zMuJ
         Z9VKCpZZ66HXg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230331052102.2211115-1-Syed.SabaKareem@amd.com>
References: <20230331052102.2211115-1-Syed.SabaKareem@amd.com>
Subject: Re: [PATCH] ASoC: amd: ps: update the acp clock source.
Message-Id: <168027908456.3377192.5594266753523930126.b4-ty@kernel.org>
Date:   Fri, 31 Mar 2023 17:11:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 10:50:23 +0530, Syed Saba Kareem wrote:
> Updating the clock source from ACLK to default clock
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: ps: update the acp clock source.
      commit: a4d432e9132c0b29d857b09ca2ec4c1f455b5948

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

