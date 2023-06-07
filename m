Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9D6725E9A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbjFGMRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjFGMRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:17:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3B5173A;
        Wed,  7 Jun 2023 05:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC7563E5C;
        Wed,  7 Jun 2023 12:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19DFC433EF;
        Wed,  7 Jun 2023 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686140261;
        bh=mSmfPL7w8SsMrjbIIdLfO+MVTv7SMWNXLfPVRcfcC70=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ezu3nliXVe6L3hYj35hciIetmsMGzM0Rg9gOECdn+rHYzClf03URTbDb8yqRtbIU1
         oV7G5S3/r21T0lz0R9AKXwWDgWdproe4DM9D+1SnDQ76dEW/V2BCDBHmMXk/dR1CwP
         lSqPQwIul8Fvnwmg/TCumWVADB7OZoTygCCv8/LN7x4TQNeCZGM9SFx2KrbloY/o67
         LFUJpydBBcvXRQ/Ib1/hWDXAWc9AI/TwvthYqvcNEaUiNRI+uznnfIZqM1vywYcOuJ
         OK4dr8GtFwwBd9Dv9Lwp/IdS6sEtLd5Ovy3D5ZYGUrvm3zYx/jMdsU5t6gGeeuPUTr
         m2ywWG+eVjutw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, linux-kernel@vger.kernel.org,
        Lisa Chen <minjie.chen@geekplus.com>
In-Reply-To: <20230529223402.1199503-1-vladimir.oltean@nxp.com>
References: <20230529223402.1199503-1-vladimir.oltean@nxp.com>
Subject: Re: [PATCH] spi: fsl-dspi: avoid SCK glitches with continuous
 transfers
Message-Id: <168614026036.25839.691151024424509427.b4-ty@kernel.org>
Date:   Wed, 07 Jun 2023 13:17:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 01:34:02 +0300, Vladimir Oltean wrote:
> The DSPI controller has configurable timing for
> 
> (a) tCSC: the interval between the assertion of the chip select and the
>     first clock edge
> 
> (b) tASC: the interval between the last clock edge and the deassertion
>     of the chip select
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl-dspi: avoid SCK glitches with continuous transfers
      commit: c5c31fb71f16ba75bad4ade208abbae225305b65

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

