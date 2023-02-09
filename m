Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6536D69105E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjBISgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBISga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:36:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D81763136;
        Thu,  9 Feb 2023 10:36:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2656861B80;
        Thu,  9 Feb 2023 18:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE69BC4339B;
        Thu,  9 Feb 2023 18:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675967788;
        bh=m3VjIjkXjpczEE/UKggPWCZa7ltciaHAVYcIm/gP1Mw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=n2kUP7FO4eMwJ3xUqLKBncdTLjfyZEf/gQC4otqY7i/XBwWsByQW/Xd4pL2W4BirR
         OcYEelgbeJ9Wx1UL8/MnHFFJjXSFu0YblgXQcDlpgulw1To93dG2kloxEc4hvqvvoD
         lvbzO6Gmue47PyqPkA5zPOw5WEOKE0hJsR57LfBvjMTv+AQDBzG7U/pnnM/jTo8CHs
         TIAKzs0Mq5op+OfP76353a3u9r4rTSuFdlqSd5+fvk9TFnBgikQSk9qbPV4TTv9GJr
         nSrO04ax3DKmArkf7AFz5rLo1nrNH434BjzoReYzAqCDguW256rsI51QIqgthS5IOJ
         96RgDokh+ayWQ==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        oder_chiou@realtek.com, Sameer Pujar <spujar@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <1675953417-8686-1-git-send-email-spujar@nvidia.com>
References: <1675953417-8686-1-git-send-email-spujar@nvidia.com>
Subject: Re: (subset) [PATCH 0/2] Codec support on Jetson AGX Orin
Message-Id: <167596778569.879652.2944492731365735456.b4-ty@kernel.org>
Date:   Thu, 09 Feb 2023 18:36:25 +0000
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

On Thu, 09 Feb 2023 20:06:55 +0530, Sameer Pujar wrote:
> Jetson AGX Orin has onboard RT5640 audio codec and uses I2S1 interface.
> Add DT bindings to enable codec support. Series also contains a clock
> fix in the codec driver.
> 
> Sameer Pujar (2):
>   ASoC: rt5640: Update MCLK rate in set_sysclk()
>   arm64: tegra: Audio codec support on Jetson AGX Orin
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: rt5640: Update MCLK rate in set_sysclk()
      commit: 9f138bb2eaf661788df459dfcaf38feb080af41f

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

