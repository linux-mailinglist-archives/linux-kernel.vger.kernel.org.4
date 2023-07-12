Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF24750CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjGLPeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjGLPee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:34:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144131BFA;
        Wed, 12 Jul 2023 08:34:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 888BD61864;
        Wed, 12 Jul 2023 15:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ACAC433C9;
        Wed, 12 Jul 2023 15:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689176069;
        bh=YgQ7abP3N+JH1cPPrmVFk/Ktw1lSieyjGSon5H2pQo4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=vM+ig1hXHoTgkEfo0U9c11KAe3Du/5PnuEFjj6KGWe7wWyv4trKLxMvMJYu/YDupl
         EvxJlmKdTHHmeNous7jvFi3aJf78oiLCIeDRT9Fz6kxnt8m9aTVSZnF4lP4Fs94yqc
         nAplA5y+wGGFBa163j9nkAkRbXK+cn8gnRHRCIp2PplI4LSQu6FgG1Ae7/BtnPUwGK
         f6wmXmnFt9J8ttchAYdxqpga4VDnpxMOJc8rdHudpbxzyV5sosX88fZ8VMWAVjN1IH
         JYeYyl8254IgnFL3NHMW3ZoQKAdc9X0p+ywdEdlPXkjVkPxeSBZQtOqACabKxfgo3s
         wsCKNvS/3vO6A==
From:   Mark Brown <broonie@kernel.org>
To:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
In-Reply-To: <20230711082020.138165-1-jaewon02.kim@samsung.com>
References: <CGME20230711082508epcas2p3088d488035e7e2910bf087d640e9c268@epcas2p3.samsung.com>
 <20230711082020.138165-1-jaewon02.kim@samsung.com>
Subject: Re: [PATCH] spi: s3c64xx: clear loopback bit after loopback test
Message-Id: <168917606784.94105.1230521336031355958.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 16:34:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 17:20:20 +0900, Jaewon Kim wrote:
> When SPI loopback transfer is performed, S3C64XX_SPI_MODE_SELF_LOOPBACK
> bit still remained. It works as loopback even if the next transfer is
> not spi loopback mode.
> If not SPI_LOOP, needs to clear S3C64XX_SPI_MODE_SELF_LOOPBACK bit.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: clear loopback bit after loopback test
      commit: 9ec3c5517e22a12d2ff1b71e844f7913641460c6

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

