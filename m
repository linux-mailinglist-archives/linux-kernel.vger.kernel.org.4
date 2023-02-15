Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A9F6982B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjBORvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjBORvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:51:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA15A34F75;
        Wed, 15 Feb 2023 09:51:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D425B82322;
        Wed, 15 Feb 2023 17:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE6FC433D2;
        Wed, 15 Feb 2023 17:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676483477;
        bh=AEZxxUbcfqFLmNGLt+x9zQDOxw7fXxXJeNPUMFpz8i8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YJUIFMyXS9DTDajJzDoq582aqatXX2g7eywxeQr/rR7rrDnW5RVPo707+urkrSJsC
         UCHIf6kmqed1XvUclRf2v1f59jq2eYHFPO101BpbzpgfjDhfu5+EiA+Z3kCt9GPMkv
         xd1HFxMf4CBmpCvbZoNzKNZgKcAmWEH6c8rEHaBtND9BPhctFQ3ZH6/mLWHWn48tHZ
         sL9zWEytX/aDsqaF77Iq48yoKZtO85LV7QnUK/ia2cdYiBlBYroidtg6KXXZ61r5tQ
         4dgYB1ZhSZ8u3PWBe/5MdwrmaDuguAvsw6Uv157rOuMM6HOGfz9d2AkevvmesQhdJM
         Po8x6/KuuNb1g==
From:   Mark Brown <broonie@kernel.org>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <c2040bf3cfa201fd8890cfab14fa5a701ffeca14.1676466072.git.christophe.jaillet@wanadoo.fr>
References: <c2040bf3cfa201fd8890cfab14fa5a701ffeca14.1676466072.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: synquacer: Fix timeout handling in
 synquacer_spi_transfer_one()
Message-Id: <167648347509.3558777.10506015723406529671.b4-ty@kernel.org>
Date:   Wed, 15 Feb 2023 17:51:15 +0000
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

On Wed, 15 Feb 2023 14:01:28 +0100, Christophe JAILLET wrote:
> wait_for_completion_timeout() never returns a <0 value. It returns either
> on timeout or a positive value (at least 1, or number of jiffies left
> till timeout)
> 
> So, fix the error handling path and return -ETIMEDOUT should a timeout
> occur.
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: synquacer: Fix timeout handling in synquacer_spi_transfer_one()
      commit: e6a0b671880207566e1ece983bf989dde60bc1d7

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

