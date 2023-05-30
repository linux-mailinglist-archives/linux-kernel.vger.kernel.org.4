Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFF2716B52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjE3Rk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbjE3Rky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:40:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3552EA;
        Tue, 30 May 2023 10:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2C326313B;
        Tue, 30 May 2023 17:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF277C433EF;
        Tue, 30 May 2023 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685468451;
        bh=dfiVTuaafqT9IpeAGDpt34mUs8GjB74g7bL9p+HxIws=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HrBLIww145HVh85bcuM+ksHSkcLjl6Ia8rrl8qI39+CBIHQUTIeIJV7a4NiXfxODv
         gWKLz6y+CkV3QZmy2NwFFyODHBR03yn9jeamIffPoRKKVxA95OFloTwrVVdd3Ho1Vv
         en2IfuhxIPIL28jLb/ukrcVjMrGrXBiHXuWIAIoYQ0BfdDrxpC4e487NKKjQ1XJV3K
         vmuaOy0ooILRwOeNOqZH0SEl2FXMKIB9bKAjO9gkq3NM23pIE5Orcy1FvXk4SrVeCI
         4LDhGtzzE7WfF+PeUmMny19vCj8YRyuMAZUQ1eVcXrM/9OcMyRx9kdUceVn7Oh23D+
         ucOp2p5KT3Hfg==
From:   Mark Brown <broonie@kernel.org>
To:     Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     bstruempfel@ultratronik.de, andy.shevchenko@gmail.com,
        festevam@gmail.com, amit.kumar-mahapatra@amd.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230524091948.41779-1-boerge.struempfel@gmail.com>
References: <20230524091948.41779-1-boerge.struempfel@gmail.com>
Subject: Re: [PATCH v6 0/5] spi: add SPI_MOSI_IDLE_LOW mode bit
Message-Id: <168546844863.691057.3696427751922501531.b4-ty@kernel.org>
Date:   Tue, 30 May 2023 18:40:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 11:19:43 +0200, Boerge Struempfel wrote:
> Some spi controller switch the mosi line to high, whenever they are
> idle. This may not be desired in all use cases. For example neopixel
> leds can get confused and flicker due to misinterpreting the idle state.
> Therefore, we introduce a new spi-mode bit, with which the idle behaviour
> can be overwritten on a per device basis.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: add SPI_MOSI_IDLE_LOW mode bit
      commit: fe73245592fef75a7c41180a3fbb07c9a75f622e
[2/5] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
      commit: 6a983ff5102ff0d859df05ca3f5cf2f6a17c0fad
[3/5] spi: spidev: add two new spi mode bits
      commit: 5cc223ca4858ec40bd2b8522ebc51c0d4963e51f
[4/5] spi: spidev_test: Sorted the options into logical groups
      commit: 113f36f2dce3a5a1aacbfa700c44080ec37ee3a0
[5/5] spi: spidev_test Add three missing spi mode bits
      commit: b229a7f530ebea90c8e21b56872f3102e3d54461

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

