Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C206379EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiKXN1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiKXN1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:27:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34A28FF84;
        Thu, 24 Nov 2022 05:27:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F32462127;
        Thu, 24 Nov 2022 13:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB4BC433C1;
        Thu, 24 Nov 2022 13:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669296424;
        bh=Rrx/a0YRfqPx5rgHb8nvvNQ00yQDgG12Xp3NFnJUGqc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WLhqunNSreRML8Sso8HZSIcf8VbEomG0gYJ3bX0iAeP9c63E66thfjjA6JPa2R+hc
         D243qy/moxMqxmwzx29YFXNOUvZVh+T+cgxB13Yyei1RppFxPKa1taZ+TrFJOBfqCx
         ku1/4X5NQ8QGRL1yisaq7NK9QQ5QWfKygFyUoVfKlNTvI2wb5//RmO99vP6kQb+r8m
         9o0Zr+apHYBxe8JfhVtNTXVWdJSRPaH7dGyJm9+wipNxYgkngjv05QYmW8DQA5uOs8
         1GQ+Oil8x8P/rtfXImXD8dekSPagjniEUYmxhGIaXCey1M07hGOuQ8Car4rVzo9XNR
         NcDMiZk4eeqTw==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20221124003351.7792-1-hayashi.kunihiko@socionext.com>
References: <20221124003351.7792-1-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v3 0/2] Introduce Socionext F_OSPI SPI flash controller
Message-Id: <166929642318.251519.15577322648856458506.b4-ty@kernel.org>
Date:   Thu, 24 Nov 2022 13:27:03 +0000
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

On Thu, 24 Nov 2022 09:33:49 +0900, Kunihiko Hayashi wrote:
> This series adds dt-bindings and a driver for Socionext F_OSPI controller
> for connecting an SPI Flash memory over up to 8-bit wide bus.
> The controller supports up to 4 chip selects.
> 
> Changes since v2:
> - Drop a redundant word in the subject line
> - Drop quotes of referenceing URL in dt-bindings
> - Add Reviewed-by line to dt-bindings patch
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: spi: Add Socionext F_OSPI controller
      commit: bcd58c8ca0f89fe6a890f909916bc97561341a06
[2/2] spi: Add Socionext F_OSPI SPI flash controller driver
      commit: 1b74dd64c8612619e399e5a31da79a3636914495

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
