Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3627E6722D6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjARQUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjARQUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:20:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78658291;
        Wed, 18 Jan 2023 08:15:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 871A8618BF;
        Wed, 18 Jan 2023 16:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4DEC433D2;
        Wed, 18 Jan 2023 16:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674058540;
        bh=snAInguPGhduXs4fSuUiGONd+cQGQeh1qPg6CYWz7a8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qsJvyZ2ZPED0QPElxEERjMWInHhox0jQ93URAlxnS0z49rMkaT4CB/pkBZ95FQOg1
         iEaH/LBO/qE8XwFExmfIs7xKmdY/irHghrQwML+eyR0fzxeYVSdWoj7pKdshJ4NVot
         +2O8/OpCDzM1+KD6Kfm/zBCnCWGYcE+s64/fLrqoalVQN96c6pTgmOjXLjlj0Z4gdr
         KLU9kna49quMNMRiJxEpY0QxSVlYRRZLa4bYvWDAu2SbkvD1RIhI6KM6vqA2T6372/
         olFf4omSupcarTBTzTjzoT7aICWzjC4lSwxRAxKa3e7ThFiTZZ/zGHplSzkLLnD0/D
         19JB5SJ+WwgWQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Jerome Neanne <jneanne@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20230114185736.2076-1-rdunlap@infradead.org>
References: <20230114185736.2076-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] regulator: tps65219: use IS_ERR() to detect an
 error pointer
Message-Id: <167405853919.940051.11907042713819434692.b4-ty@kernel.org>
Date:   Wed, 18 Jan 2023 16:15:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-77e06
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2023 10:57:36 -0800, Randy Dunlap wrote:
> Fix pointer comparison to integer warning from gcc & sparse:
> 
> GCC:
> ../drivers/regulator/tps65219-regulator.c:370:26: warning: ordered comparison of pointer with integer zero [-Wextra]
>   370 |                 if (rdev < 0) {
>       |                          ^
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps65219: use IS_ERR() to detect an error pointer
      commit: 2bbba115c3c9a647bcb3201b014fcc3728fe75c8

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

