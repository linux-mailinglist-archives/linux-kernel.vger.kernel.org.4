Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7D360E6DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiJZRy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiJZRyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E444720365;
        Wed, 26 Oct 2022 10:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AAB262018;
        Wed, 26 Oct 2022 17:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A17C4314E;
        Wed, 26 Oct 2022 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666806891;
        bh=1zMYOW4OGqV7CIj0igClXnh2UOdKvHi5CykJj1DT2RE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XLqyn7YMuswnyGGt7j1DK4BhUt6nikzGyFyef7OeUi58Z3AN9F5DbDCp742WZVfBd
         i7QPJC01uRsTKKPUjKl2NTUFWPV8Fu9iIxQfexwvM4nkL9xxOyDntWwWitUnoDYdmN
         AFad8QNHSDUeY4+XEXJ4fe6vhBI+YPwt8PQO6K1lT1uXwX/GF/zZ62UV2S5c2L8dAI
         fOK0o636grFSLxbw7IfslXrO2usd1JU9ZE6RFp8rx1SPsxEE9vxipkb4t9NuEpUPhz
         pB8LijwQd7oWQn8Or2MBSsQ9/pMU2viz+xzkwUJ04jsg34XKonpx15lNI2fbbV+zRt
         ZXwMI5XFOhlTg==
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Da Xue <da@libre.computer>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20221026-spicc-burst-delay-v1-0-1be5ffb7051a@linaro.org>
References: <20221026-spicc-burst-delay-v1-0-1be5ffb7051a@linaro.org>
Subject: Re: [PATCH] spi: meson-spicc: move wait completion in driver to take bursts delay in account
Message-Id: <166680688974.833294.9389296907324181570.b4-ty@kernel.org>
Date:   Wed, 26 Oct 2022 18:54:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 09:58:28 +0200, Neil Armstrong wrote:
> Some delay occurs between each bursts, thus the default delay is wrong
> and a timeout will occur with big enough transfers.
> 
> The solution is to handle the timeout management in the driver and
> add some delay for each bursts in the timeout calculation.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: meson-spicc: move wait completion in driver to take bursts delay in account
      commit: 04694e50020b62b10bd0d46ff9e9708a6e1c7eb3

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
