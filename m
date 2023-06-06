Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FEB724909
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbjFFQZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238506AbjFFQZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:25:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174D510FE;
        Tue,  6 Jun 2023 09:24:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A75B562862;
        Tue,  6 Jun 2023 16:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAABC433EF;
        Tue,  6 Jun 2023 16:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686068679;
        bh=W4Tp8jO+9JqisoEdQWJbb+RxEjWeGO6Ebj3B6m7pPCA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nrr/ZR5dfX1JBaKxwqI6JBfjB+mB2pSi42JI/AOhWuf9o0OsOS52k8JgXS8rdI8y6
         2vYNaoTtpW+NpBoEnH/1OmXSGKzv9ThUyzeoQXOvIP1tHfCnwKVaA6XDjPyWRg8dvY
         U3ZRT462HdmSIbet9gXFc+aKZW1SCpSUfD5eEYDCHNa7tRMF483mEyNy+w4JEJE0is
         h1/hwSTqweKkAwG8GPJOZNlO3So+SEHsyil9mK2FhoR5WQWerZri4uVgE8/HdSMWE8
         LgwLZD9x1XfJjz/TKY8SwckJINOicGboKPdh02sbc8XKkCuIj00C9gYfRRC+AFELbe
         SuWHZ2vhYhyKQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abe Kohandel <abe.kohandel@intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230606145402.474866-1-abe.kohandel@intel.com>
References: <20230606145402.474866-1-abe.kohandel@intel.com>
Subject: Re: [PATCH 0/2] spi: dw: Add compatible for Intel Mount Evans SoC
Message-Id: <168606867693.49694.16483038401822255147.b4-ty@kernel.org>
Date:   Tue, 06 Jun 2023 17:24:36 +0100
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

On Tue, 06 Jun 2023 07:54:00 -0700, Abe Kohandel wrote:
> The Intel Mount Evans SoC's Integrated Management Complex has a DW
> apb_ssi_v4.02a controller. This series adds support for this controller.
> 
> No SoC level chip select override is provided and as such no DMA
> configuration is done for the controller.
> 
> Thanks,
> Abe
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dw: Add compatible for Intel Mount Evans SoC
      commit: 0760d5d0e9f0c0e2200a0323a61d1995bb745dee
[2/2] dt-bindings: spi: snps,dw-apb-ssi: Add compatible for Intel Mount Evans SoC
      commit: 7bac98a338d63efb0b44ce4b79d53838491f00df

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

