Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FC2681A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbjA3Tdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbjA3Tdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:33:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15E611E9A;
        Mon, 30 Jan 2023 11:33:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58507B81661;
        Mon, 30 Jan 2023 19:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0FFC433EF;
        Mon, 30 Jan 2023 19:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675107220;
        bh=h94RLdZBiN3usJmqJWSlQt5FI3kHCC9pBvoqFO7eogw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ILxSqazxdzN7tbmfA5R6vvAoOq0GTxkxVIRZJwWkTmo/v6h/Den91qZUXQ5WlzJz1
         4l/QbhWmjdAZoLW7BFoitzwhbYc2Y1AyLsF/nqHsw0spFxAFqRNzRaaOdt4PFx6XJ0
         T6VFlZeXBb5qhfPuFIuzLV7T9GsW27SHesfxO8jGjqzUw3sbiuxl3iv8xguqkzGz/A
         12xaJUh02ZVyjyI/qWzFVBaMoCvoLsmK0mLlOj0JvnHkaaRJ8Ul5gU7gXL6lZo2FUO
         6yp85BjpqALBDqAR3QqOAW5DLCPYDJzSoZbnZpn7UtwEpkx9RFfG5IZTraI+5c2Ebu
         cGhnITY7hfsbg==
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230130140156.3620863-1-arnd@kernel.org>
References: <20230130140156.3620863-1-arnd@kernel.org>
Subject: Re: [PATCH] [v2] spi: dw_bt1: fix MUX_MMIO dependencies
Message-Id: <167510721842.1539806.16770192592343197907.b4-ty@kernel.org>
Date:   Mon, 30 Jan 2023 19:33:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 15:01:40 +0100, Arnd Bergmann wrote:
> Selecting a symbol with additional dependencies requires
> adding the same dependency here:
> 
> WARNING: unmet direct dependencies detected for MUX_MMIO
>   Depends on [n]: MULTIPLEXER [=y] && OF [=n]
>   Selected by [y]:
>   - SPI_DW_BT1 [=y] && SPI [=y] && SPI_MASTER [=y] && SPI_DESIGNWARE [=y] && (MIPS_BAIKAL_T1 || COMPILE_TEST [=y])
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw_bt1: fix MUX_MMIO dependencies
      commit: d4bde04318c0d33705e9a77d4c7df72f262011e0

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

