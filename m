Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28990750BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjGLPCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjGLPB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:01:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB39A1BC5;
        Wed, 12 Jul 2023 08:01:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40010617F7;
        Wed, 12 Jul 2023 15:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9985C433C8;
        Wed, 12 Jul 2023 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689174116;
        bh=wMZtoc3g0GfAzrfZ9V6NGMTLWE3jJBHdGaQwsDX1zRU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ipDjSCxUWZtit74tePivzZOXP/C7sRaKG8pyxFmZx6RgUH0SJbPoSCYMv0aXs5Ebl
         S/q+1+AgsT5F5MyYr9Al1CqADY+jn2zv6zV5N53HZ3Y1KnTtVEq0DHr/ndwK3BcEgf
         IhlbZh2yqugP5Jh1t+fA2jW8TZekmDEbm7jmwKbYDOqspMu2hvMPiFEOEgc7Jc5PJ2
         dtHmL5mc7xC8uTMYZHp21O4zOADoUajI9pp9ykbvwv8Zf3+OrPhBCV/22YnQ62K53X
         V0IcYxTeF/KK8v1C2MZ5SD3bOmKTT2Eve9jorLKfVtLzwNxu+5IDwPBmr5nIWgV7Cd
         y6qhpmoWXAyZg==
From:   Mark Brown <broonie@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230712064832.67091-1-frank.li@vivo.com>
References: <20230712064832.67091-1-frank.li@vivo.com>
Subject: Re: [PATCH] spi: spi-cadence: Delete unmatched comments
Message-Id: <168917411565.88164.2773848319852059399.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 16:01:55 +0100
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

On Wed, 12 Jul 2023 14:48:32 +0800, Yangtao Li wrote:
> The function no longer returns a value, synchronize the comments.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence: Delete unmatched comments
      commit: 3b38cabd5e12b8b54b9c9feab9ab0093b991f249

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

