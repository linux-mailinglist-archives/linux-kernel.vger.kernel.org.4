Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4884720240
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjFBMiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbjFBMia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1858818C;
        Fri,  2 Jun 2023 05:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 943E463F0F;
        Fri,  2 Jun 2023 12:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC88C4339B;
        Fri,  2 Jun 2023 12:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685709497;
        bh=TyCZfQmQmlvqOb0Jba/SEqffXg1lO5KwrKh531yXJmQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=nUAuqcrKRA6Q+idYs7QAumgQ86P1q6FxTO7Wk9hFYdudZkM/S7IdyXhEVN/K/I0wu
         fcNSyL9s0ASTQrB1PBX1yfriXvyRyKmthP8Y4Sojyn7E8ouJvPRtzkt/Nx8M7XuQXz
         2UsPdsrsay6uQoJnNP6h33npMnCXcxeQ1ToiDPmpTTUtv1vya1kdv8CkLtm/HXTLg6
         f1oyU7g4zV3iVuvwx2SH7W1B7foyqQYcPawTmV90+tm9UP4aks49XnMshRBPJjJE8V
         5NBt7n++NS//0DMFsgMVBPAdOM/NSh45KjAb58+0qr5KvfWMxjncIO0F407oMT12SK
         WdI9TGUKlqXmw==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601095908.563865-1-krzysztof.kozlowski@linaro.org>
References: <20230601095908.563865-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] spi: dt-bindings: allwinner: simplify with
 unevaluatedProperties
Message-Id: <168570949309.29417.14450045729560361701.b4-ty@kernel.org>
Date:   Fri, 02 Jun 2023 13:38:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 11:59:06 +0200, Krzysztof Kozlowski wrote:
> Remove properties already mentioned by common spi-controller.yaml and
> switch to unevaluatedProperties:false to achieve same functional effect.
> This makes the binding a bit smaller.  Similarly there is no need to
> allow additionalProperties for children, because spi-controller.yaml
> already does it.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dt-bindings: allwinner: simplify with unevaluatedProperties
      commit: c092a878729843c10160c6f22864507ab7dbceb2
[2/3] spi: dt-bindings: samsung: drop cs-gpios
      commit: bbd25f1ae8bfaeb99de2a0e1985d206cd39ac014
[3/3] spi: dt-bindings: socionext,uniphier: drop address/size-cells
      commit: 34fcc0f0a410ff67aba99875d0452a0762d5a98d

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

