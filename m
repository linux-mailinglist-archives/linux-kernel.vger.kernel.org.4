Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF17633F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiKVOtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiKVOtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:49:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F47663FA;
        Tue, 22 Nov 2022 06:49:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 862F06170B;
        Tue, 22 Nov 2022 14:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650C9C433D6;
        Tue, 22 Nov 2022 14:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669128563;
        bh=amq336iSJknmUhqq9B95Grn7nfD50cCH6FmElPI3irY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KPuK2qcNLXcxyi2N2jT2dny4Of5rmuhRhuGViA8WU2N8nfTW+lARzr5HYhlNnDhqd
         v6xdgiiVB2qTw/0oNozBRb5HTF58e4xXNYolA/ph5xAQCAikHTo8i3RlMzHWySkwCK
         tC4j3/u6pKUAQ93SGjPvy6pY8tR9cekrev1WR5fPBwORvegoJqq4AqMkPJToCPmB5m
         s8R5HgrX/tqzM8fzTDSlcj2x4fJFKCQqtCzbIdOecCj0l2Q/BigdVfUOlYU/thgB+y
         aiIeB3HUYZNGR0w91KAr2zI+gmOjtVhZo5xqhZmKVCZwFZRNpXzDqftbZKYlolSaK9
         rou7mBTjEUCHA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Walle <michael@walle.cc>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
In-Reply-To: <20221121150843.1562603-1-michael@walle.cc>
References: <20221121150843.1562603-1-michael@walle.cc>
Subject: Re: (subset) [PATCH 1/2] regmap: add regmap_might_sleep()
Message-Id: <166912856112.213474.2362964124352816870.b4-ty@kernel.org>
Date:   Tue, 22 Nov 2022 14:49:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 16:08:42 +0100, Michael Walle wrote:
> With the dawn of MMIO gpio-regmap users, it is desirable to let
> gpio-regmap ask the regmap if it might sleep during an access so
> it can pass that information to gpiochip. Add a new regmap_might_sleep()
> to query the regmap.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: add regmap_might_sleep()
      commit: a6d99022e56e8c1ddc4c75895ed9e3ce5da88453

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
