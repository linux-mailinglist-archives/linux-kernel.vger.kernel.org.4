Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8B2725FC3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbjFGMlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbjFGMla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:41:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586911FC7;
        Wed,  7 Jun 2023 05:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0783663875;
        Wed,  7 Jun 2023 12:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171C7C433D2;
        Wed,  7 Jun 2023 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686141614;
        bh=vjnZbE/2yE3OwFbjO2qGTa9dDTldjx2j9GsQii2RpUk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=U3ItOqlersJwiBwVH2Q1RQQUY31iUFz8QJ99setU8NuK0l48SSnc5sDgRjHeqz1d3
         ZeWRMWnZVWJjOwEBS8vTQea2IhIJR+QF6y65rKEjDeQpVnvaQPZcnfxiygURRrfJ/L
         xOxtxVxv9N/mWpNK0j9qUMZtW2pHkzWST4lR/s+MlcGIUKBGG/nWJV57yyebxGMYeE
         QOieUV85nJttpNVegcBY5pMRP6MZr5k1vjHpMDIFRDH9vTGRXl78PmWGwZITv+8aES
         owVyFtAJVoggXg335xUTr5cBrqHASIffgnoiuiAdJbR7MAvrp5K/JLZ4R3Zce9uu3g
         aqU1L64N+MZZg==
From:   Mark Brown <broonie@kernel.org>
To:     linus.walleij@linaro.org, lgirdwood@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        Esteban Blanc <eblanc@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, u-kumar1@ti.com
In-Reply-To: <20230522163115.2592883-1-eblanc@baylibre.com>
References: <20230522163115.2592883-1-eblanc@baylibre.com>
Subject: Re: (subset) [PATCH v5 0/3] TI TPS6594 PMIC support (RTC, pinctrl,
 regulators)
Message-Id: <168614161180.30174.9903723014149714624.b4-ty@kernel.org>
Date:   Wed, 07 Jun 2023 13:40:11 +0100
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

On Mon, 22 May 2023 18:31:12 +0200, Esteban Blanc wrote:
> TPS6594 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
> communicate through the I2C or SPI interfaces.
> TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.
> 
> This series adds support to TI TPS6594 PMIC and its derivatives.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[3/3] regulator: tps6594-regulator: Add driver for TI TPS6594 regulators
      commit: f17ccc5deb4d024bb52fd3433471e77ab7ae9ad8

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

