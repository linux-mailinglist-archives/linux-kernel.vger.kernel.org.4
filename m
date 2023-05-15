Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927F3702B21
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241277AbjEOLKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241244AbjEOLJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:09:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED03E5B;
        Mon, 15 May 2023 04:09:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C271462295;
        Mon, 15 May 2023 11:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0814C433D2;
        Mon, 15 May 2023 11:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684148992;
        bh=dY7dcUuhtCnaIotYfTGR91pIk6dZNsFbIzgqKiaUhL4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=pBwcLOM5+iavGmzVbrLZ8x7hXzFMI71seHb8fYtFhF0/9J4/E3d0jS4HyOidOJlfR
         wL9bvm2/zjRWe+7ctIY9isccslzoYDCpJuZqIKBRn+6ElG9TmHFKOyZTsnbi3njWui
         hhFVIkXHUOgEtcu+uJiawyfJ1navPvBA1VTgVgBLvveyw42Z+31fHbARztfq3Svs3H
         wlSLyMQXuw9c2YSK63H1HWB8IX2q9xo6gMw4j9s/1TdRjyPZFt7WNM/V8u2aSvc8wo
         N53+umW7IlO6amkNspsD63MTbEY2rOroAtZaY2WckkZue7n1y2P+vG6arjB1sWoyIS
         /riLzPgNKC0UQ==
From:   Mark Brown <broonie@kernel.org>
To:     Andi Shyti <andi.shyti@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230513173646.4306-1-krzysztof.kozlowski@linaro.org>
References: <20230513173646.4306-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] spi: MAINTAINERS: drop Krzysztof Kozlowski from
 Samsung SPI
Message-Id: <168414899059.394221.12943543309007276806.b4-ty@kernel.org>
Date:   Mon, 15 May 2023 20:09:50 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 May 2023 19:36:46 +0200, Krzysztof Kozlowski wrote:
> Remove Krzysztof Kozlowski from maintainers of Samsung SoC SPI drivers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: MAINTAINERS: drop Krzysztof Kozlowski from Samsung SPI
      commit: ec9452594e04804cabbc561e88e96b48ab4655e4

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

