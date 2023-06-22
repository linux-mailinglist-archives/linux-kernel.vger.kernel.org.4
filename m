Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A87D73AC90
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjFVWd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjFVWdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:33:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616B61BE7;
        Thu, 22 Jun 2023 15:33:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC43561924;
        Thu, 22 Jun 2023 22:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69A6C433C8;
        Thu, 22 Jun 2023 22:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687473229;
        bh=ma8yFR5QnALuCTyQbyzW/gXgi2WHYs1DAJMOAeHZ5cM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qSKzWAxVTU4YlMrv/k79Lu0IAzA7Wuogok1jqFuTUcVQTZbDinrIT/ypsWQXoPztj
         QGJfeDsP/MHMWyOvELrLXkMyUdX5/lC5PdIYronA+rNWHuZ4DKxycGqO/DXRMKfv+W
         qqAXy9hmZA34ySWMUyggPp6Y/T26LS0hOcRbALM5HtFP9agcaia5ZXHoI9sbUPjQw0
         dsIFDnYxlma7cTAIK4aQLEUWtgDoSZwLM0ufNS1q+AB4QecICkq/wB3jK//SXY7sJN
         vPoYmPztsWKGbxVo9akSbHF/zBS2dhCvc79B2drdjiEWCEqTqzeka1jkJYWbJBbu91
         tn+reAMp8lDCQ==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, thierry.reding@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        Sameer Pujar <spujar@nvidia.com>
Cc:     jonathanh@nvidia.com, mkumard@nvidia.com, sheetal@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
References: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
Subject: Re: (subset) [PATCH 0/8] Few audio fixes on Tegra platforms
Message-Id: <168747322434.318849.728081824901814342.b4-ty@kernel.org>
Date:   Thu, 22 Jun 2023 23:33:44 +0100
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

On Thu, 22 Jun 2023 17:04:08 +0530, Sameer Pujar wrote:
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

[1/8] ASoC: tegra: Fix SFC conversion for few rates
      (no commit info)
[5/8] ASoC: tegra: Use normal system sleep for ASRC
      commit: 2cc41db71a434844ca97b6e30c9a30a2464a996e
[6/8] ASoC: tegra: Remove stale comments in AHUB
      commit: f47d43283a4233528683deaaba95f0ee2cfe862d

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

