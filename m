Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244AB69A39B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjBQByY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjBQByW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:54:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB16C54D4E;
        Thu, 16 Feb 2023 17:54:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67629611FC;
        Fri, 17 Feb 2023 01:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEF1C433EF;
        Fri, 17 Feb 2023 01:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676598859;
        bh=agbXHVVQrZH9Lxa2v7q69ZxZbnrrIgw3R/B4Tf3ExQM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JOuHZJPY75iPidkI/ME8/EyH+M1k1S+rfzcHTdjEwlrrvUz4vrKQF9VjMKIHqkEZ8
         klwJDSdO6B8+HYXvmO79KXsVSjj+3mUog9NwfXsq74IjmTZX8LEj4JYBarqDOkqAlC
         oWXZhLT6/J2SMsiHzwwWLFCsrmSJ04iKD0FMlXrp9An7nbhFM4ii+xcJmJDkn9lpZs
         MECGw3V0iFCXd+obMw7VwXWoAS8WkecAEYnme9JivChnjshfudwOEyIXtnwG2zJW01
         rfGHueLZbg9VD3OUsqEAwLZoMCgzSRjmKP0pUq5gqKJmBZtY3sqW+UpUnPSAo8xBRq
         SBKfIzoQ1tKVA==
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20230216123014.110541-1-brgl@bgdev.pl>
References: <20230216123014.110541-1-brgl@bgdev.pl>
Subject: Re: [PATCH] spi: spidev: drop the incorrect notice from Kconfig
Message-Id: <167659885855.51558.18015897607199701976.b4-ty@kernel.org>
Date:   Fri, 17 Feb 2023 01:54:18 +0000
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

On Thu, 16 Feb 2023 13:30:14 +0100, Bartosz Golaszewski wrote:
> The spidev interface has been de-facto stable for many years. This notice
> has been unchanged since 2007 and is incorrect so remove it.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: spidev: drop the incorrect notice from Kconfig
      commit: a46ce4f884817c66d0dc303b663b53b37d2baa24

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

