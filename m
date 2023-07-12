Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA837506CC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjGLLsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjGLLsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:48:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51E4210E;
        Wed, 12 Jul 2023 04:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A015617A0;
        Wed, 12 Jul 2023 11:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419D5C433C8;
        Wed, 12 Jul 2023 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162464;
        bh=MmDyn1rAtTKX49+lb+u+gcqGTH+0y12gnihcalWBBkY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BInlGNRxi22YcYKoLBBL0iWHdsOgYLAyncWbHTg208cl14xmKKna6x+Uu1ZBcd2C5
         k61hPujabWgYNCY1H9MSsS9uL8E69wYAZyK1Q6lCL3T2xw9F7QzmWPC4PJmbpSAm4v
         sWvmDPdAlyaiMJ4Bf+DMG00PiTyX1Emowjls1/LH0OJb2DQ+j4mczEq5+wwif2ctdN
         32FvZBIpK7EHaCDwsuibwF0+0DCuVJqrxFqWcLeIaeED4QPs74fKieEQgfH0m+G6Zu
         zuPwFQmBEa5mnwaGnpM1NT3Jhz4s9ZkA4UOnG6veF4tKCNjyZigHSJHXcmjMjzCy20
         VwfFSwPs5CvOA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230624131632.2972546-1-bigunclemax@gmail.com>
References: <20230624131632.2972546-1-bigunclemax@gmail.com>
Subject: Re: (subset) [PATCH v1 0/3] Allwinner R329/D1/R528/T113s Dual/Quad
 SPI modes support
Message-Id: <168916246098.47003.15457344630251001511.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 12:47:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2023 16:16:21 +0300, Maksim Kiselev wrote:
> This series extends the previous https://lore.kernel.org/all/20230510081121.3463710-1-bigunclemax@gmail.com
> And adds support for Dual and Quad SPI modes for the listed SoCs.
> Both modes have been tested on the T113s and should work on
> other Allwinner's SoCs that have a similar SPI conttoller.
> It may also work for previous SoCs that support Dual/Quad modes.
> One of them are H6 and H616.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: sun6i: add quirk for dual and quad SPI modes support
      commit: 0605d9fb411f3337482976842a3901d6c125d298
[2/3] spi: sun6i: add dual and quad SPI modes support for R329/D1/R528/T113s
      commit: 25453d797d7abe8801951c8290ea11ea8bba7b96

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

