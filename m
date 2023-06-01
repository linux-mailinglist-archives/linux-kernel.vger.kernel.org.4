Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECC671EE83
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjFAQPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjFAQPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:15:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E15CE4;
        Thu,  1 Jun 2023 09:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEE096473C;
        Thu,  1 Jun 2023 16:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2B0C433D2;
        Thu,  1 Jun 2023 16:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685636149;
        bh=PMEPa2KhFRd/uouazKtkNE46f2CVziDF7AR1HIcQ1Yw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=raL7RKp/mNl+ONKciVZdvZYI8o2gK8w879JvMGOQ4DPwLuKgimOkrikpEcFPeZrc3
         7xXKBz+9riax35l2hog1rBzFcmqOarwrZ6bFneFqssUgRVkgIn4CfdU1PGnQQSDdys
         kszsRUiDrV0l6izyMERZl5DX9yWbqBJgn8QtWm8tWkhiJy/cWIoM9fmPA04RuGh/A1
         6Pj3+RUdJjklBGPxD04kNPGhlc5bgFw6ZGU9E7OAdHqfPi/fH6EK4Ujae6Xb52Y7la
         nfz8R5LVwoapXylClh0RTBbGeT25oMOrVrebwuyMicI5nB+SuRw8vzwMA+Y2DZ8as+
         268kxv5pm0i2g==
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230531072850.739021-1-alexander.stein@ew.tq-group.com>
References: <20230531072850.739021-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] spi: spi-fsl-lpspi: downgrade log level for pio
 mode
Message-Id: <168563614817.139315.15824942201142435374.b4-ty@kernel.org>
Date:   Thu, 01 Jun 2023 17:15:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 09:28:49 +0200, Alexander Stein wrote:
> Having no DMA is not an error. The simplest reason is not having it
> configured. SPI will still be usable, so raise a warning instead to
> get still some attention.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-lpspi: downgrade log level for pio mode
      commit: d5786c88cacbb859f465e8e93c26154585c1008d

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

