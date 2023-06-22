Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED45873AC8D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjFVWdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjFVWdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:33:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B881997;
        Thu, 22 Jun 2023 15:33:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1A356191C;
        Thu, 22 Jun 2023 22:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F27CC433CA;
        Thu, 22 Jun 2023 22:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687473224;
        bh=Fx3v4G/Q/qRPvxtg3Mgx/rYdfAvEoHue1uehMtXOhZQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Jk5peD++dJDfFdJZnWbVzS3MvLCy9R+jOHoXLYovKYM9fB5hizu5axPGxPBWRYp2e
         dX0fTz91H0BC3BlqDJOwEfeyO426zb9qctjpO/37mf+5DxLAPSBRHWhPxGpcsvdQsa
         GdqM3W4TfHjLqT39SAm6sGe8RoPD97ISunnC3sB0x3cKqyvDLzy/VVhf23wG5fzb1h
         KWi8bVxAUlXv1rtUV5dEWxsS4Vf0Yl0gSBVla+pdgqD/lrCqRxhPofk/huDYpbw7Mw
         xbK3hE8R009lLxgJ0IexZNUluF/7g+av++i9JRk+WFzCkBIFdDdfvk2BhgOYmeTPTG
         sfc6hflfW85Ww==
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Rob Herring <robh@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230621231044.3816914-1-robh@kernel.org>
References: <20230621231044.3816914-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: microchip,sama7g5-pdmc: Simplify
 "microchip,mic-pos" constraints
Message-Id: <168747322064.318849.2286093832255639633.b4-ty@kernel.org>
Date:   Thu, 22 Jun 2023 23:33:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 17:10:44 -0600, Rob Herring wrote:
> "enum" values should be integers or strings, not arrays (though json-schema
> does allow arrays, we do not). In this case, all possible combinations are
> allowed anyways, so there's little point in expressing as an array.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: microchip,sama7g5-pdmc: Simplify "microchip,mic-pos" constraints
      commit: b2c28785b125acb28a681462510297410cbbabd7

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

