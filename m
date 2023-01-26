Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A34467C19F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbjAZA3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbjAZA3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:29:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661F262D00
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:29:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7C55616F7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52879C43446;
        Thu, 26 Jan 2023 00:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674692944;
        bh=3Gl7E6jxTJB4ZcRekvn84sIy4EUd9X3kKt/L9R5RoHY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=l3+9Yz5WREv4TJsO3Ykp8x5ZEKcEgVPsZ6z4HVH1Z1xwLRJU51Ljq8kwLPYZP7+fE
         aYqBkKye3roMOfsPQg7ktKddWjIjgXFlPIOdDMxzg2YDAlbUyuv3ihE5ZeP+Xvyw5E
         TgdzkK27hi7If8h6WADZ5otACPoWlE1K0UJz+RY6lO9dwLios7V6gE0amfj8zbCgOL
         FFaNhzbrRAMw82iKEk1WHtQbiZ6AgpaQ5CWCZbEVJEYJ4s0n83U/qabDi/+qAiJT/g
         wtOXGhOHzech6qkjaZ/nDxTHD2nL81kRnoDwYcCoC1RsxbaH7zDdtwnwB5zFd71kse
         SFyb/aGoMtpqg==
From:   Mark Brown <broonie@kernel.org>
To:     srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        lgirdwood@gmail.com, Judy Hsiao <judyhsiao@chromium.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org,
        Banajit Goswami <bgoswami@quicinc.com>,
        Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20221208084200.2136311-1-judyhsiao@chromium.org>
References: <20221208084200.2136311-1-judyhsiao@chromium.org>
Subject: Re: [PATCH v1] ASoC: qcom: lpass-platform: Use
 SNDRV_DMA_TYPE_NONCOHERENT page allocation
Message-Id: <167469294198.2696228.16654878670798627815.b4-ty@kernel.org>
Date:   Thu, 26 Jan 2023 00:29:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Dec 2022 08:42:00 +0000, Judy Hsiao wrote:
> Replace SNDRV_DMA_TYPE_DEV by SNDRV_DMA_TYPE_NONCOHERENT for pcm
> buffer allocation. We measured about 18x performance improvement
> when accessing the snd_pcm_mmap() buffer from userspace.
> 
> Eg: aarch64 with internal speaker
> ==
> SNDRV_DMA_TYPE_DEV
>     frames_per_second=66.4557M/s
>     max_time_per_4096_frames=106.094u
>     time_per_4096_frames=61.6351us
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-platform: Use SNDRV_DMA_TYPE_NONCOHERENT page allocation
      commit: 01270f905eea786f418cbc2040f7a52b969ef377

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

