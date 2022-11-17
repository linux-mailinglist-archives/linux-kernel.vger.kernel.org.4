Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C3862D9CA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbiKQLs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239847AbiKQLsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:48:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CC02705;
        Thu, 17 Nov 2022 03:48:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D75EFB82004;
        Thu, 17 Nov 2022 11:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A05C433D6;
        Thu, 17 Nov 2022 11:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668685710;
        bh=YuYLP6L95ckxoWq1T7YqXJYO3vnDSPnNJH442uYE2qc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OiqaaHjpBdQGB/FDvXRk8xyvDFK7/EpHoAH9dhShasFuOFxoeKk5gclXyXvFarGVl
         pxwut3dqdiM3WoCIYLUmewIXu5KHWHNGfHCNVJYud4XVAfw+n/3TzQhQ7zTUJAgBq1
         pEPSTZ92Guu1F66NeQC3DnZLiavy/PDYaDopfYKTjCZr42oOqzeskWixXAZfn9pa2j
         GSSh+BNfzNOlJK0+uV+HWlaFrEnaJep1gNhcVHWstTI94IhokzGJaalJ0zObTIf69a
         /7TiRhKJjnZRqliEzklIXUSBcOXGOH4yhEE/g0jnEalyfzVk81TTZbSuHiJmbiheRW
         COxLwP0+6vA2A==
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-spi@vger.kernel.org
Cc:     Vladimir Oltean <olteanv@gmail.com>, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <20221111211356.545026-1-vladimir.oltean@nxp.com>
References: <20221111211356.545026-1-vladimir.oltean@nxp.com>
Subject: Re: [PATCH] spi: fsl-dspi: add cs-gpios support
Message-Id: <166868570908.694164.13311249993591941854.b4-ty@kernel.org>
Date:   Thu, 17 Nov 2022 11:48:29 +0000
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

On Fri, 11 Nov 2022 23:13:56 +0200, Vladimir Oltean wrote:
> From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
> 
> Make the driver be able to bit-bang a GPIO for the Chip Select pin of
> select peripherals.
> 
> The GPIO value is driven by the driver in that case, and none of the
> hardware Chip Select bits will be populated in the PUSHR register for
> the TX commands constructed for this peripheral.
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: fsl-dspi: add cs-gpios support
      commit: 84b60f2bce1f0416617c4dbc015b5da906b8e2ad

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
