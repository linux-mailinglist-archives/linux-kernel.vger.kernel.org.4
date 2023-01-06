Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26AE660226
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjAFOaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbjAFO3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:29:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13A08110E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 06:29:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94201B81D3A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 14:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3C4C433EF;
        Fri,  6 Jan 2023 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673015357;
        bh=Qvr7MD8G9FmZl4anXDch3jsk6CbjpCfuPfm12VW5+Ic=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=a4JlKq64k/lKtjCzWB0pqlmdoXg5kMPeZuuS+tg3MGZXfTuCOiKH0E3+pB+cdResy
         km6mczt+G0UGYU9+VyLVLSwhcuIu5N8/AWbq0apNP0FtFCzspBiPKUjTCInxj55fR8
         1Fb/WGapS/6rHYUlGXZn1U1SC7K30Xu1QLFm6jX0PczPu+o1KH3CWOkdfbX0ttfnQi
         44lUxyYR38vGevkv8hyc5MuX3Q5WipfEFkxHkOHHQIZGN4+NTsRNXdjNBv4JWjn0pG
         UIOB03YvQyKFdsjpFjJRZqwHmAvxvI3bqnwSN5zKMj9UzgTGF9Zff7Mn1XYy8xouBy
         Qq87MKLzNJKjA==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20230104025754.3019235-1-chancel.liu@nxp.com>
References: <20230104025754.3019235-1-chancel.liu@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: Correct the number of steps on SX controls
Message-Id: <167301535488.46037.15431956554804644558.b4-ty@kernel.org>
Date:   Fri, 06 Jan 2023 14:29:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-214b3
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jan 2023 10:57:54 +0800, Chancel Liu wrote:
> The parameter "max" of SOC_SINGLE_SX_TLV() means the number of steps
> rather than maximum value. This patch corrects the minimum value to -8
> and the number of steps to 15.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_micfil: Correct the number of steps on SX controls
      commit: cdfa92eb90f5770b26a79824ef213ebdbbd988b1

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
