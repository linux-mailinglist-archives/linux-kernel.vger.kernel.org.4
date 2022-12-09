Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49B8648837
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiLISLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLISLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:11:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECAB9B7B2;
        Fri,  9 Dec 2022 10:11:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7634A622F8;
        Fri,  9 Dec 2022 18:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D4BC433D2;
        Fri,  9 Dec 2022 18:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670609489;
        bh=epx/3n6EwqEj5rJc+f7YxdkKGXlAtgNwhwzCjKBq+B8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=q0fqputXafLstYl7s0bbqBLoARECT4s7udCu2lxwMr8acbXZx0lwkn41Ah5tYa6/m
         Dw5GPNYVmG7/KMGJyL9dNgkzPdj1b9gzLW7x7XdFXZq6T/53w9aRpTBAHy1NV4gZQQ
         cUjf/jbzo3V3qQnEUDrSWeS+lfxhDlf9ifvGJ0C1/ONiRUMWlXGPJgVVHqZLjn1A5U
         heKpQRMS58dIB1xlUlW4/ckFhzwzj5aBBqJmhJVr/hxG6nswwtuTHWbgkAWl0ytECl
         bYCXaHPvTTGJkVUZzzIWgsh7qSZRM8a9dU/h9H6GYx3y+mnu4YH3FvcXMKIfLhbI9O
         jg05ybqRsE7EA==
From:   Mark Brown <broonie@kernel.org>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221209171644.3351787-1-robh@kernel.org>
References: <20221209171644.3351787-1-robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: Convert Synquacer SPI to DT schema
Message-Id: <167060948678.166802.5232484726492968107.b4-ty@kernel.org>
Date:   Fri, 09 Dec 2022 18:11:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-64ef0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Dec 2022 11:16:43 -0600, Rob Herring wrote:
> Convert the Socionext Synquacer SPI binding to DT format.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: Convert Synquacer SPI to DT schema
      commit: 3cf241c3d56ff19f5192cb42a025bc6582b6e8fa

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
