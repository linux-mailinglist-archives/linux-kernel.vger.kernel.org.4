Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB496165B4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiKBPDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiKBPCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:02:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D041D2B610;
        Wed,  2 Nov 2022 08:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EF10619F7;
        Wed,  2 Nov 2022 15:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18473C433D6;
        Wed,  2 Nov 2022 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667401366;
        bh=ySDnWLtgKmB4MsWkDhRm3ekTNs1QeMnC8N/ulBhv1O4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uFAgba06loLQK4xeCO8L6yA1xDpNGCVUqS0F6XDlPaNvRw47cvnlE0yTRg1aWmZJX
         Fu+xOO+Rj99idT4VZ7z2PAkz9tqY7QppEk4mvh3BXh7SkYcM9BhU/YaPjmpvMB+lct
         3N2V/glp6DGf0z7z0CsXxXIKXVakb3R7tAJjp+ETSbZIwm3jY0HqvMuS3aMO6greDd
         fuYl11+ZtPng1WsxcnpQg9sfLkQpxyCMztoaSHT1HBco9e+ClOV3t2WC0TK/HNh54j
         QzJdE9l8NlIC0G+ZwRxhslXH8bBuF1JytES2U4t84R0lcOj/XtI0is46ful6PrRMiY
         fYl3Vt481po1g==
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
In-Reply-To: <20221027-b4-spicc-burst-delay-fix-v2-0-8cc2bab3417a@linaro.org>
References: <20221027-b4-spicc-burst-delay-fix-v2-0-8cc2bab3417a@linaro.org>
Subject: Re: [PATCH v2] spi: meson-spicc: fix do_div build error on non-arm64
Message-Id: <166740136480.261515.18042223753301117319.b4-ty@kernel.org>
Date:   Wed, 02 Nov 2022 15:02:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Nov 2022 09:46:01 +0100, Neil Armstrong wrote:
> This fixes :
> error: passing argument 1 of '__div64_32' from incompatible pointer type
> 
> By passing an uint64_t as first variable to do_div().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: meson-spicc: fix do_div build error on non-arm64
      commit: 134af9aa88453aeb9224e407092530ebba366c6c

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
