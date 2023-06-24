Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3FF73CC15
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 19:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjFXRkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 13:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFXRkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 13:40:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95011BC2;
        Sat, 24 Jun 2023 10:40:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 455126092A;
        Sat, 24 Jun 2023 17:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BB2C433C0;
        Sat, 24 Jun 2023 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687628450;
        bh=5uw4ioxmxRm5FpJGvseBufZ9FdZrud/jDgdUzD+9qik=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Ovfqjm6GzxlA1TkFD9ouzjwq5Imvzuk1oQSKZi/+QyZdLMLz+OvyJHt9Yk4PQMQmP
         UtRnFwbTm2BjTUTxb1TVz63aRvJa+wZti0VFYPoRE77+HaEXNsKZ4v2tlcrhY3hCuc
         oA5AdDb9TB9wBxSKLI8mUEwShELHxK1P6xr0+KYzMc3q8eiMpALeb2T5BaUNl4HhEC
         c/TMxexsR0lj4tSFmTmDBvsJDXjpXrcHlRqYW6KbobLcrgRAH/Qn//S4Tmgmed0uqY
         rCzsBooavxI6iS21lBOLh6dvtUnbaFzrusO9V6NY9secxq7uxdVgF4i3WITgYsgG7V
         z0gYmFNGviS2w==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Varshini Rajendran <varshini.rajendran@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230624082054.37697-1-krzysztof.kozlowski@linaro.org>
References: <20230624082054.37697-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] spi: dt-bindings: atmel,at91rm9200-spi: fix broken
 sam9x7 compatible
Message-Id: <168762843922.1328079.8328118275834289222.b4-ty@kernel.org>
Date:   Sat, 24 Jun 2023 18:40:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2023 10:20:54 +0200, Krzysztof Kozlowski wrote:
> Commit a3eb95484f27 ("spi: dt-bindings: atmel,at91rm9200-spi: add sam9x7
> compatible") adding sam9x7 compatible did not make any sense as it added
> new compatible into middle of existing compatible list.  The intention
> was probably to add new set of compatibles with sam9x7 as first one.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: atmel,at91rm9200-spi: fix broken sam9x7 compatible
      commit: e884a133340a470070b2c59833c9ff87aa6517ba

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

