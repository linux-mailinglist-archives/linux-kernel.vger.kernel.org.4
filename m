Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B506FFFE3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 07:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbjELFYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 01:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjELFYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 01:24:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E7E2722;
        Thu, 11 May 2023 22:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5677C63EF2;
        Fri, 12 May 2023 05:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0BAC433D2;
        Fri, 12 May 2023 05:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683869085;
        bh=tX7KXgnuK8lqbNh920fj8SiOGOJFJBgIs9eJVO2OaCo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Xf9JOuaYCM3EPmqhsz48M30Y+Tb9ZyOYop62KsGUdEDtoCz0F52/nnFRdjRQuiu8i
         3JhjWP18oVH7yU5vJXwyys0q89EX/828pwuuiyyo1g1ZltMy8bIx6u1elxGBypct0j
         ZyI5ZrIu3qsg/TG6RZgamtwzQfDoBAeW7bC0nWGrM63qzQe+SfTCy5Qk/foOBeniPK
         FkTHlJlOI1rR9xFWOVA5bBxoQMgtRMCsYgc+JCwTif2Xs5eeQGeUCq90RnpvaaTOQh
         cxQUu7Jp4RF9S1rtflEEXAtO9rp9XCQyqgHNRtT8S0y/o1tizAunDgRl5qCrAMeuxX
         fd5ge+cyFGtkw==
From:   Mark Brown <broonie@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>,
        Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
In-Reply-To: <20230510081121.3463710-1-bigunclemax@gmail.com>
References: <20230510081121.3463710-1-bigunclemax@gmail.com>
Subject: Re: (subset) [PATCH v5 0/5] Allwinner R329/D1/R528/T113s SPI
 support
Message-Id: <168386905416.366566.2289755397704500905.b4-ty@kernel.org>
Date:   Fri, 12 May 2023 14:24:14 +0900
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

On Wed, 10 May 2023 11:11:07 +0300, Maksim Kiselev wrote:
> v5:
>   - fixed DT bindings (Allowed three-string compatibility)
> 
> v4:
>   - fixed SPI sample mode configuration
>   - sorted DT bindings list
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] dt-bindings: spi: sun6i: add DT bindings for Allwinner R329/D1/R528/T113s SPI
      commit: f603a3f083aeb9438865975c28b27be0afaae0c1
[2/5] spi: sun6i: change OF match data to a struct
      commit: b00c0d8932f1e7e36570edf0f000c64399e985e0
[3/5] spi: sun6i: add quirk for in-controller clock divider
      commit: 8e886ac838ef12f6994ed9b13ab87784c4f0bc35
[4/5] spi: sun6i: add support for R329/D1/R528/T113s SPI controllers
      commit: 046484cb214b43dc4463343e8c49133d9edb5454

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

