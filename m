Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160F974FA96
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjGKWES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjGKWEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:04:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40AB170C;
        Tue, 11 Jul 2023 15:04:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8897E6162C;
        Tue, 11 Jul 2023 22:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF5FC433CC;
        Tue, 11 Jul 2023 22:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689113049;
        bh=1qUIYTa5qH+71pJpjqPgB4HJsLDFKxPRZi5HFjGOMLs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oOEPJja8myKtu19uf9CQ22ifaq3vPiL2ri5Z2xQ2P/8FEMrI+Wt5t3BMttW+5e8ou
         VclyQXWp77ziXpg6foLd9+45yaV4m7qByHvMf9Q8VyG0SFYLgVu3h17u9rYSLzukGx
         9CzwkBdcJl6WHekct/4Mtj46BZIUkzpPHRE1z9DaAdlIYJIpQGaM76D4EQbdkokyJ5
         cDeIXQjItFmtOo6M0MzYsiDUmWwOwgA0GncP9pnNTGrm2Eu70zMz7VXip1FLLKwJvH
         u4KHioJPeJEjJmoGa8bz42SHinZoDFyx6Yku+vcpkIAnm3eqJSC6kh69vUoU0TKchz
         FRZtXi2ZOAVEQ==
From:   Mark Brown <broonie@kernel.org>
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230706081342.468090-1-valentin.caron@foss.st.com>
References: <20230706081342.468090-1-valentin.caron@foss.st.com>
Subject: Re: [PATCH v3] spi: stm32: disable device mode with st,stm32f4-spi
 compatible
Message-Id: <168911304710.642798.3178025159634647364.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 23:04:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2023 10:13:42 +0200, Valentin Caron wrote:
> STM32 SPI driver is not capable to handle device mode with stm32f4 soc.
> Stop probing if this case happens.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: disable device mode with st,stm32f4-spi compatible
      commit: fee681646fc831b154619ac0261afedcc7e671e7

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

