Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B011B73061C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbjFNRgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjFNRgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:36:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA481BF0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:36:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D63C763E2E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C0FC433C0;
        Wed, 14 Jun 2023 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686764163;
        bh=AbnC8mDM/RaXBTKQvBEa7V5Bcdc8NBFEC8JEfH5l+VE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=eNGB25UHggQsfZpIKATygVauj9yBvAdupJPfruwNyZRd8ePxX5Aoh7h/Z1EuM5Trd
         h3pRq+n8eUtET+q5XtiNMF8nnIQ0/dUEMrhaZRUJTmCT3vKg0ljR8NWH/8g7kviya9
         qLrl8njd0ilfdPO20/bbfaxgGSLMFgbr8Gl+erQhg2g/5sLO4vCYIYJ30fKjXP15dp
         qh8QGJDci8b+q79RO7qOkP4x4OeiGPGggmMdK1vCDf403AgPlPThoizeKWIKVkdFCq
         lZGW11/4hp9IHpwVRTCEtShjWvNSnNNpMS/XDm6aHKfWQYAMHCcOEt9yQ9CqGylwXd
         axQixwydR0rDg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20230613-regmap-kunit-read-write-v1-0-2db337c52827@kernel.org>
References: <20230613-regmap-kunit-read-write-v1-0-2db337c52827@kernel.org>
Subject: Re: [PATCH 0/3] regmap: Add KUnit tests for read/write checking
Message-Id: <168676416227.217135.12550330638689341135.b4-ty@kernel.org>
Date:   Wed, 14 Jun 2023 18:36:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 21:17:41 +0100, Mark Brown wrote:
> Since Takashi found an issue with maple tree syncing registers it
> shouldn't do add some test cases that catch that case and some more
> potential issues, ideally we'd run through the combination of
> readability with all possible I/O calls but that's lifting for another
> day.  We did find one issue with missing readability checks which will
> be fixed separately.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/3] regmap: Add test that writes to write only registers are prevented
      commit: 180033061e203a7c5510e7c38bccd885657de517
[2/3] regmap: Add a test case for write only registers
      commit: a07bff4054c9e2b3a5c5790312a4a45aaeca7afe
[3/3] regmap: Add test to make sure we don't sync to read only registers
      commit: 357a1ebd0c012f5421252547ebf4ee619b45733d

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

