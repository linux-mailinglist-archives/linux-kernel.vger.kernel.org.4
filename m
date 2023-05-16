Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1F4704C77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjEPLhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjEPLha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:37:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2C83AB1;
        Tue, 16 May 2023 04:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 625706376B;
        Tue, 16 May 2023 11:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF35CC433D2;
        Tue, 16 May 2023 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684237047;
        bh=gZcEDGXhjDqN9IAFo0tEwKJca3qdlvooZ9An+4lAqlk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=R3WGojs3Uhj/l3b1ED2OxJK068vrPFdiJ7Ws6xPNgcNWBQr2XqhRLl9i60luCTAwL
         BEY+GNDryWqaRMfRx2QqCQxP/imYt29nGm+H0+9UjVussgqGUSo6MvOCSHSqETaIRa
         Tf8YjcOfgeIW2D8AFooFso3kVNy5xzAHfXF836olfb2I/ZPZbPznMrLjvo0/ClT08E
         1irRd1ANt2F9JeKfnCXaHBwuZeRel67c3gR0SD8qvuoWmCqXLN0oKXXCiqKj/vUZJQ
         bgr8HzGhXZDPSiQhKjdmoauje0iJ1+FJyO35OENlN17Fj5vrOezIBqfZ275NmCkeY7
         tRWhfcy4Cx/WA==
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     blarson@amd.com, git@amd.com, fancer.lancer@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitrkcian2002@gmail.com
In-Reply-To: <20230515130343.63770-1-amit.kumar-mahapatra@amd.com>
References: <20230515130343.63770-1-amit.kumar-mahapatra@amd.com>
Subject: Re: [PATCH] spi: dw: Replace spi->chip_select references with
 function calls
Message-Id: <168423704524.428452.18231434046939667560.b4-ty@kernel.org>
Date:   Tue, 16 May 2023 20:37:25 +0900
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

On Mon, 15 May 2023 18:33:43 +0530, Amit Kumar Mahapatra wrote:
> New set/get APIs for accessing spi->chip_select were introduced by
> 'commit 9e264f3f85a5 ("spi: Replace all spi->chip_select and spi->cs_gpiod
> references with function call")', but the 'commit 2c8606040a80 ("spi: dw:
> Add support for AMD Pensando Elba SoC")' uses the old interface by directly
> accessing spi->chip_select. So, replace all spi->chip_select references
> in the driver with new get/set APIs.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw: Replace spi->chip_select references with function calls
      commit: 445164e8c136f1445caf735d6d268c948e71caf1

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

