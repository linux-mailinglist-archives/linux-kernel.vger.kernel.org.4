Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DC96AC2BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCFONN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjCFOMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:12:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A234C2F;
        Mon,  6 Mar 2023 06:10:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41016B80E01;
        Mon,  6 Mar 2023 14:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC7DC4339C;
        Mon,  6 Mar 2023 14:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678111755;
        bh=RJ0FmJU9WMs2qNpdCgNq0asdNDVRtui4RpZgSXxGb0Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MtOHUhgLvqykjjSuSz1g6u0gnl6uMCa0C9flvSZlNBSObuMBt8NTBXOkiuKa8BXl8
         rySLu2uHugli5+ACcRxeRRNEaWnfqQSGUEcUIK3/5aF9amiA+fQ16obGyYDz4ct74O
         6W8Tjub2cKzrQue/7BtDR9GMrAjNcGkOKaKlnbj07EHqGeUlbf3xU8RLmpkFAVGVcE
         vDAF/S6smwFhLg587C7jF/z3Lg/2vzJt6et/B+Zu1Ei72MuBLixcVYyohZ5UbhxE/P
         arfqijpwUEv32Imkim1wE0n4+JCla+APUi2gPKBnn/q5ZzrGZzUWudbnjFni/RpTma
         F6xh3YIJxCRdw==
From:   Mark Brown <broonie@kernel.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <cover.1677515341.git.william.gray@linaro.org>
References: <cover.1677515341.git.william.gray@linaro.org>
Subject: Re: (subset) [PATCH v2 0/6] Migrate IDIO-16 GPIO drivers to regmap
 API
Message-Id: <167811175334.98202.15503041463855908266.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 14:09:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 11:45:21 -0500, William Breathitt Gray wrote:
> Changes in v2:
>  - Utilize memset32() to set status_buf for no_status case
>  - Utilize GENMASK() to generate status_buf mask
>  - Move no_status kernel doc line under runtime_pm line
>  - Add comma to end of idio_16_names initialization list
>  - Set io_port to true in idio_16_regmap_config
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/6] regmap-irq: Add no_status support
      commit: 4d60cac951fd2dfbf261b83abb805748abc8b995

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

