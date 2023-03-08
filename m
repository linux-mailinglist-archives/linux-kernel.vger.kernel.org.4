Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7496B0A0A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjCHNyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjCHNxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:53:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AD17FD5E;
        Wed,  8 Mar 2023 05:53:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79A09B81CD1;
        Wed,  8 Mar 2023 13:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A85C433EF;
        Wed,  8 Mar 2023 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678283591;
        bh=iLlFVOoDIQjiaILiJHm0ULqCparcbp/ihxWOpbFu1sc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jtc+Uz2XdCMX1sfOw1xSMdKhFhqK2jTbUiesH11psFB434aicpdPBGwpSbkDoXZU/
         deviAHfJ2CQQYlrquQpCXu2PoP5V1/mupB8SloUWTO2Zla3ekuuCJr1uItb8vQ3WwR
         0WWJhxo+V9konAhTrl/2Z+G+MSoBc/mSgkKhL0E/QMQ3dC35y6Ieofm583Am+05mNL
         ANLtJ+TqzMy4dwrVEeXk/EFKmRwXb/S85idJuBIGlVZ74gH/xlq7O1kEsyl4l2Ssdd
         ISYnJphhFMCJ7y1QJ8szxtU9bMmVHEXqZlhG0CkCaYd3fmvhGWBY06XrvG4tVfmy4U
         EDh1quZyYVLFQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>
In-Reply-To: <20230306183115.87314-1-andriy.shevchenko@linux.intel.com>
References: <20230306183115.87314-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/5] spi: mpc5xxx-psc: Clean up even more and fix
Message-Id: <167828359003.32144.38378478063789166.b4-ty@kernel.org>
Date:   Wed, 08 Mar 2023 13:53:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Mar 2023 20:31:10 +0200, Andy Shevchenko wrote:
> The recent cleanup series broke the error path in the drivers.
> So fix it and do even more cleanups.
> 
> Andy Shevchenko (5):
>   spi: mpc5xxx-psc: Correct error check for
>     devm_platform_get_and_ioremap_resource()
>   spi: mpc5xxx-psc: Return immediately if IRQ resource is unavailable
>   spi: mpc5xxx-psc: use devm_clk_get_enabled() for core clock
>   spi: mpc5xxx-psc: Propagate firmware node
>   spi: mpc5xxx-psc: Consistently use device property APIs
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: mpc5xxx-psc: Correct error check for devm_platform_get_and_ioremap_resource()
      commit: ee493fa5d91dec02402239a072820b18beb36265
[2/5] spi: mpc5xxx-psc: Return immediately if IRQ resource is unavailable
      commit: 208ee586f86237969a91ac60ea10f48db9135143
[3/5] spi: mpc5xxx-psc: use devm_clk_get_enabled() for core clock
      commit: 9e21720a49589304aef9e37e8b6c6a4196daf156
[4/5] spi: mpc5xxx-psc: Propagate firmware node
      commit: 289c084ddc1317e6ed911911f95371679c10af1e
[5/5] spi: mpc5xxx-psc: Consistently use device property APIs
      commit: 3169c5816a55ba671e9c8a671c6c75818d30c657

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

