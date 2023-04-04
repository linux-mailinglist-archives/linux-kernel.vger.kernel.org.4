Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C136D671F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbjDDPVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbjDDPVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:21:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD28E468F;
        Tue,  4 Apr 2023 08:20:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A6EE635CE;
        Tue,  4 Apr 2023 15:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BA6C433EF;
        Tue,  4 Apr 2023 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680621658;
        bh=zz/zwaxro2lTFYeVOZkWlnueS/5qGSV7aFGRshKv8Jo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LiiiMMbxvfh/dSd9Hf47+Bh9ti8InYkdpMEPKm8uj3V7mzD7ZnJ9UUB/7OZSIYGz5
         ze+uSB3Jc3PY+az8ROpQyOvNh3LJ+dNNDFQDmrppsqWpVav3PYRnSolKSk9Gab6aQp
         vmo7Yx8mDpTJ0rfwPz5n4na/0pXESRgka0ubCgtZrr/kQCiYUfHVUFfj/Q1n2e2Q4U
         /3VoOvlV7Dpp7Tad1r2o42Whh8gJrrL+42QEOPUV/cwq7BcHBfd1Zb9fqjMLuGX3AA
         kZcX2rW+NiLGklBgTnm3uPYkD89yt8d3BCUW9wpZOAqiHshY/glY5bpVIHAEl1LCv7
         8361xETIzkRvw==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230328061031.70140-1-yang.lee@linux.alibaba.com>
References: <20230328061031.70140-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next 1/2] spi: tegra114: Use
 devm_platform_get_and_ioremap_resource()
Message-Id: <168062165623.53383.15473905152295240848.b4-ty@kernel.org>
Date:   Tue, 04 Apr 2023 16:20:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 14:10:30 +0800, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: tegra114: Use devm_platform_get_and_ioremap_resource()
      commit: 05c79f71e357a566de887efa55672c8a36569f60
[2/2] spi: tegra210-quad: Use devm_platform_get_and_ioremap_resource()
      commit: 69d286c5293a35cbf2de3efe3cf4a47bdd264b92

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

