Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADACD74FA98
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjGKWEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjGKWEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:04:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A83170C;
        Tue, 11 Jul 2023 15:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBCD16162C;
        Tue, 11 Jul 2023 22:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE87C433C9;
        Tue, 11 Jul 2023 22:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689113054;
        bh=C5llUpZJ5p8wbhDynWvhQ29CDjDyt7Q1pKHQ8wc7lJg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ng5TO3uSTKD7A1zOm5t+LzfdfOYibbcx+u+hAYJUCqldUVNa01JJK5DzMDvjI2BDv
         ozMRXJ6xumOWsH91+xvTzB4wLRAvXNwBGyPf8amjqjJyV8DXeqJWplKRyv7tdhy4kY
         ZH4puIkrBfxUvthe92iNgFFS77e82tK8OPZdHSW98G9dbbjm5Ue9yhkNiE/15WNmE4
         mPCWbcHFNw1NZGJFhg99Ns+n5A2WntKEMEJY0lFhP8rGJ5GMqTLYdOhF+HWDXBDMfT
         xQMeKawhzwlkOv2tUU9bX8Pf+lv/0ka6V2arz+RAIpqA3NSoT5UwMdkMLYqqR9qCL7
         qXS+tYGEsiWXw==
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Yangtao Li <frank.li@vivo.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230706032727.9180-1-frank.li@vivo.com>
References: <20230706032727.9180-1-frank.li@vivo.com>
Subject: Re: [PATCH 1/7] spi: atmel: Use
 devm_platform_get_and_ioremap_resource()
Message-Id: <168911305243.642798.12211060786449791679.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 23:04:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2023 11:27:20 +0800, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/7] spi: atmel: Use devm_platform_get_and_ioremap_resource()
      commit: 616a733ccaee2412cd8def29f6f106e22c3cfabb
[2/7] spi: davinci: Use devm_platform_get_and_ioremap_resource()
      commit: 2ae3c98b6e80f5b99afd9eafbdfab5146330dae5
[3/7] spi: ep93xx: Use devm_platform_get_and_ioremap_resource()
      commit: cb8ea3dd55acd191f80847488d2231a1d18ab1ed
[4/7] spi: spi-nxp-fspi: Convert to devm_platform_ioremap_resource() and devm_platform_ioremap_resource_byname()
      commit: 8c8e947b6be037d0a311f11688212c7d87aa5440
[5/7] spi: rspi: Use devm_platform_get_and_ioremap_resource()
      commit: b778d967979d7ed638fe1de8c2465ff33ace47d8
[6/7] spi: tegra20-slink: Use devm_platform_get_and_ioremap_resource()
      commit: 2e4ed2577936476e0e9bb9a07158e94effb86285
[7/7] spi: s3c64xx: Use devm_platform_get_and_ioremap_resource()
      commit: 4f81b540ccdf023b7b39432f5c0a26c7eadcc9ce

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

