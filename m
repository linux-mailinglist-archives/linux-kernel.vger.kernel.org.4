Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB3573C5A5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 02:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjFXA7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 20:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFXA7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 20:59:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84724193;
        Fri, 23 Jun 2023 17:59:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B0C460909;
        Sat, 24 Jun 2023 00:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0030C433C8;
        Sat, 24 Jun 2023 00:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687568349;
        bh=A69HKFnnXAvV3RVr01IkrP1MPlvjyD+ytgmek1ed6F8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HFdSwfkvAxGbVyLkxqNrTFnSLo3y1RruYsspG3samw27Vj1qbAnTPUBkjgdWNrMEq
         mgVNyoxCckwiSBINUu6nrvsrAAYdM2T8u5GQ3A7a7wHnmhb0OY07oOhusO9ykUKszj
         f4G8s1muNqsNa0D1svQGG36lBb5e5ZXG7Wb1xp/tjpFgppnMLe65S5lRpDI7XGN8Oh
         koKkOLIiioAgYrds+9OtdCWAtVKe7I4t/JjgxF0egl+3iGHP7fT6ZCvEbvgV9AfCWu
         yq8ZA5x0Oaor5892p1SFQ0Wbodu/XQr/YJ37wqrp0zNryF0cICZfMp09ewx4JicAeO
         Bq4MZUmXklctw==
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Trent Piepho <tpiepho@gmail.com>, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230623140948.384762-1-biju.das.jz@bp.renesas.com>
References: <20230623140948.384762-1-biju.das.jz@bp.renesas.com>
Subject: Re: (subset) [PATCH v7 00/10] Add Renesas PMIC RAA215300 and
 built-in RTC support
Message-Id: <168756834422.1159557.5305753537854426980.b4-ty@kernel.org>
Date:   Sat, 24 Jun 2023 01:59:04 +0100
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

On Fri, 23 Jun 2023 15:09:38 +0100, Biju Das wrote:
> This patch series aims to add support for Renesas PMIC RAA215300 and
> built-in RTC found on this PMIC device.
> 
> The details of PMIC can be found here[1].
> 
> Renesas PMIC RAA215300 exposes two separate i2c devices, one for the main
> device and another for rtc device.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[01/10] regulator: dt-bindings: Add Renesas RAA215300 PMIC bindings
        commit: fff8f6b0723159f09eb2c067e626fb96402c0e53
[02/10] regulator: Add Renesas PMIC RAA215300 driver
        commit: 7bce16630837c705f72e8fd53a11ae8c236236f4

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

