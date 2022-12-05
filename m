Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D590A642EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiLER3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiLER3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:29:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6FE20BF4;
        Mon,  5 Dec 2022 09:29:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0B0FB81193;
        Mon,  5 Dec 2022 17:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5330FC43146;
        Mon,  5 Dec 2022 17:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670261365;
        bh=Iglcsh9dUGdpPN+LIC0wDCQLfKz8jZC48/VNMVNhIzk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=nc2dJC9TTCyAIelPevVjJu/JKMyYf7kYI4nY9KqU7Jdq+pekcJrptBiszC/tpR+pi
         0b4a+qaxXiy8gEkB2g8Vd3vFsSIVkQDi2F2msAOP3xjgmPANrgFW8lyhBXCNsJBH1Z
         q/nNgADhbNgQ1/OGtj29X2XS1ofTYIdW8HZbXsaY4zoJzGxF9kXysZ1aVlqGtV56PN
         wfMtB2kPBBaVdRpEA6L6gSRT3JRy8xN9yOBjGwSVWlb9E0+mlvuusrVG5bWv2U8/Rv
         3x0KZ9o9cR2mShhr/lu3SPIs5Bbxw9pivEiiOeKilCqtunulpCOwyyeNiOasnAkhur
         Wp3pmsdY9bmTw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221204113621.151303-1-krzysztof.kozlowski@linaro.org>
References: <20221204113621.151303-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: maxim,max98504: Convert to DT schema
Message-Id: <167026136406.536379.456604968048408965.b4-ty@kernel.org>
Date:   Mon, 05 Dec 2022 17:29:24 +0000
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

On Sun, 4 Dec 2022 12:36:21 +0100, Krzysztof Kozlowski wrote:
> Convert the Maxim Integrated MAX98504 amplifier bindings to DT schema.
> Few properties are made optional:
> 1. interrupts: current Linux driver implementation does not use them,
> 2. supplies: on some boards these might be wired to battery, for which
>    no regulator is provided.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: maxim,max98504: Convert to DT schema
      commit: 715f45854f559f361d2c222a0353a3a1818875ed

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
