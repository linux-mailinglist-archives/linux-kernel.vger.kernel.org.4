Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700D6742518
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjF2LnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2LnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:43:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FEE30F0;
        Thu, 29 Jun 2023 04:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DE3B61538;
        Thu, 29 Jun 2023 11:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D27C433C0;
        Thu, 29 Jun 2023 11:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688038998;
        bh=9smR4hwjfU8+YKynETyJV8YFpd23KQ+7eQokkBFjjxk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eXaFaPa2JvlA5gSM+zRwrlkmrGw4sbUzixco2eOeN+bwt5GgVDGpUToNRZZKSna8T
         IO8n7YBxIynizRXRtyfqVp62ep57cuKXsqKJpYgf5l45CyRMH6AWKeSYo3nBX2DHLU
         /7VXlbvI/zJ7te3oTWeNxbuP7qFzwNWSwh+oCAUzoxTJOzj9Ig6VA6xTZy3C7z6jrj
         wJucG9fdSNAk21U2dkwMJTCoKb7r5xsaIoh4cQ0T7IvxCx84g+8BqD+f5Vwc+xmpYP
         I1oIdpuZJhtpU8jccUoR1GI6EqG2WZ0nRlt4Bo4wSI3116+1fMYylAdcuV9zo0nqgj
         d+TK1gMFfRsBA==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, thierry.reding@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        Sameer Pujar <spujar@nvidia.com>
Cc:     jonathanh@nvidia.com, mkumard@nvidia.com, sheetal@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
References: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
Subject: Re: (subset) [PATCH v2 0/5] Few audio fixes on Tegra platforms
Message-Id: <168803899500.40884.7057697107524456502.b4-ty@kernel.org>
Date:   Thu, 29 Jun 2023 12:43:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 10:42:12 +0530, Sameer Pujar wrote:
> This series fixes some of the issues which were observed during an attempt to
> enhance automated test coverage on Jetson AGX Orin. Below is a short summary
> of the issues and fixes:
> 
>   * Sample rate coversion failures above 48kHz.
>   * AMX and ADX test cases failures due to incorrect byte mask.
>   * Atomic sleep in RT5640 codec which is present on Jetson AGX Orin.
>   * AHUB clock fixes on Tegra234 and previous chips.
>   * Minor cleanups in ASRC and AHUB driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: tegra: Fix AMX byte map
      commit: 49bd7b08149417a30aa7d92c8c85b3518de44a76
[2/5] ASoC: tegra: Fix ADX byte map
      commit: 6dfe70be0b0dec0f9297811501bec26c05fd96ad
[3/5] ASoC: rt5640: Fix sleep in atomic context
      commit: 70a6404ff610aa4889d98977da131c37f9ff9d1f

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

