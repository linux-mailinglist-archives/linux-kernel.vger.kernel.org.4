Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B5F5BD296
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiISQvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiISQuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:50:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7FA3DF1B;
        Mon, 19 Sep 2022 09:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3D5561E69;
        Mon, 19 Sep 2022 16:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA3FC433D7;
        Mon, 19 Sep 2022 16:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663606210;
        bh=llaez4drV8Sk9BIkIlYW0smhbZDI+kICBKljdOWOs6U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=d6CoHsHmU2diIk6I0+T1LVFoz7ywOBFA4k4oI3UmL7dyl+xniKEf6ocCVyQ0P3PkG
         2l1MVXtrQDa1gxHYXB4lMn9K5w8ePPkZmXt/Cuar+rHfRcv5IJ0IeEhVE31cEyInjj
         ev0JTN944Ln/m8jEKNcwSmngQujAvTSTuu67Dq/o6p3aYqQ+f9S7zwtGcI13fKtRVF
         GodOYlQAj3BGa6ImjBbuhfsYLFHKbUJ03EOpDpJ1xtj1TbIg93EGcD4GYZEAXYA4qS
         g6ntto/VGX0q2QnPhLn2ZDhvqXxz6+uUGWvtojM4iFP0s4+G8ymWj9EonartoIZcIt
         56TMeeD2DZ7Og==
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>, andi@etezian.org,
        krzysztof.kozlowski@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@axis.com,
        alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org
In-Reply-To: <20220916113951.228398-1-vincent.whitchurch@axis.com>
References: <20220916113951.228398-1-vincent.whitchurch@axis.com>
Subject: Re: (subset) [PATCH 0/4] spi: Fix DMA bugs in (not only) spi-s3c64xx
Message-Id: <166360620609.3110754.1774249252415131243.b4-ty@kernel.org>
Date:   Mon, 19 Sep 2022 17:50:06 +0100
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

On Fri, 16 Sep 2022 13:39:47 +0200, Vincent Whitchurch wrote:
> This series fixes some bugs I found while running spi-loopback-test with
> spi-s3c64xx.  The first problem (which I actually noticed while trying to fix
> the second problem with transfers >64KiB) seems to be a generic issue which
> affects several drivers so I fixed it in the core.
> 
> The series has been tested on ARTPEC-8, which has a version of the IP similar
> to Exynos 7 and with 64 byte FIFOs (compatible with "tesla,fsd-spi").
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/4] spi: spi-loopback-test: Add test to trigger DMA/PIO mixing
      commit: b85ad8a54e0a446b3daa7f526e4996ddb6d4373f

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
