Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D0E6EAEAC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjDUQGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjDUQGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:06:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28EC146D3;
        Fri, 21 Apr 2023 09:06:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ED5B612AB;
        Fri, 21 Apr 2023 16:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C53C433EF;
        Fri, 21 Apr 2023 16:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682093203;
        bh=Ycs5/wDsSkeoMdncpw3AYUuAjBNxE0d1fYTJRvpcH2w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=g3/qOxduXopxn52YNmjrQq+LCK82iTgPzLyNo0Q2Yl3Eq4rrA5BwznTiXCVICFr18
         u5T4ioNyjzmGcqZkfmpvPDTIn0YTTcD7Wav5PiPrTrnpAG2uSuD3Ji+wtzlNbFgGMs
         xGZ4/8VBoRi4jLfQtTQmsly3PaOYOS2GgVHThqme3Fx5vGI4OirysZCD0CsJFphRTR
         hn2Fwf0ZFx1zUBajYXQqxPW34mcelD2dwrpi0wo42gP/Uk8B/3vAdHFjC02DVGrgp6
         GPGmCUaMtFoP01rBJRrRsCwek04cNG5xLnxOyz5WK1PItgMrBMQ1VyoK6JsMCyb+mc
         46Vl9u844XB0Q==
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Vaishnav Achath <vaishnav.a@ti.com>, Vignesh <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
In-Reply-To: <20230420121615.967487-1-d-gole@ti.com>
References: <20230420121615.967487-1-d-gole@ti.com>
Subject: Re: [PATCH] spi: bcm63xx: remove PM_SLEEP based conditional
 compilation
Message-Id: <168209320180.108697.6146441595079629834.b4-ty@kernel.org>
Date:   Fri, 21 Apr 2023 17:06:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00e42
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 17:46:15 +0530, Dhruva Gole wrote:
> Get rid of conditional compilation based on CONFIG_PM_SLEEP because
> it may introduce build issues with certain configs where it maybe disabled
> This is because if above config is not enabled the suspend-resume
> functions are never part of the code but the bcm63xx_spi_pm_ops struct
> still inits them to non-existent suspend-resume functions.
> 
> Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm63xx: remove PM_SLEEP based conditional compilation
      commit: 25f0617109496e1aff49594fbae5644286447a0f

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

