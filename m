Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E16B6029C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJRLBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJRLBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:01:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6517FB5FDA;
        Tue, 18 Oct 2022 04:01:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2C05B81E88;
        Tue, 18 Oct 2022 11:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6487C433D6;
        Tue, 18 Oct 2022 11:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666090903;
        bh=b6Iw/I2YAN+EIBfO8nYIfadbuQNj8Oni/NifDZiVS4M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FcRJ85KV6/e4XRC/5H2J8/lx9Yx5fUr1FfdXGTtr3uMx/AZlEG4yVkAfC/Mh/iMzB
         T3Nff07yPYJQyHKLA2am+Kn4+dfN2OuNXuQICSUG3WZmRPwRv1nYCoGYob9LHX7Isb
         tPQnlJhURNxmc5e9Wxh0nNoU42ExMIrsSIOEbUbHncBassLZZgGqwQsMlOS3In5yQp
         KyFT9EMTkbeex1XMS6bQQOlhtFTIJc1HvLZQT7CHLnKgN7qqQ2cFoBrjDezDE4rmSS
         /yjFA3pIO+Sx6lyjzeq5o0CLxD1IYng69V1qkFAvflGwiUYOe+T71Qob08CEoN7oMI
         eT31xTygI6BDw==
From:   Mark Brown <broonie@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>, linux-spi@vger.kernel.org,
        agross@kernel.org, linus.walleij@linaro.org,
        konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
Cc:     luka.perkov@sartura.hr
In-Reply-To: <20221006194819.1536932-1-robert.marko@sartura.hr>
References: <20221006194819.1536932-1-robert.marko@sartura.hr>
Subject: Re: [PATCH] spi: qup: support using GPIO as chip select line
Message-Id: <166609090152.70786.17854878547413325335.b4-ty@kernel.org>
Date:   Tue, 18 Oct 2022 12:01:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022 21:48:19 +0200, Robert Marko wrote:
> Most of the device with QUP SPI adapter are actually using GPIO-s for
> chip select.
> 
> However, this stopped working after ("spi: Retire legacy GPIO handling")
> as it introduced a check on ->use_gpio_descriptors flag and since spi-qup
> driver does not set the flag it meant that all of boards using GPIO-s and
> with QUP adapter SPI devices stopped working.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: qup: support using GPIO as chip select line
      commit: b40af6183b685b0cf7870987b858de0d48db9ea0

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
