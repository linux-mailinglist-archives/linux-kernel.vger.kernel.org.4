Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E1A60B143
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiJXQR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbiJXQPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:15:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0371852FCB;
        Mon, 24 Oct 2022 08:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1A7DB81BA2;
        Mon, 24 Oct 2022 14:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271F7C433C1;
        Mon, 24 Oct 2022 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666620813;
        bh=enWWnfXFctYRIjwy/dBACRIWMkD2S/LPIlskceBorm0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nUjRLriR6nX1Izc+MMw0nSDvNcVQVIWKxR4xtulDsb9lQfHCuKinMFv/7w+7zdMMx
         xKUgLE9pamP0IUglNLqsRLb7pxFC6/Kx+MHzfvUfsstZRR4+ozPOBr2c8g3VRXIoxC
         33E1X20nkm3Hjt/1N0E35XumiLLdMTqyv3+win8mxt6lmwcVMy9ihovNqJr2N/OFHl
         LBqK3TQsQ2iqtU03SW/LZLNRK05GGO5odP17X8YBNXNvSdQLbmxHq4wm9fEWRMLzpf
         P5pijsXP+ke7J9bMdSA5f2osgZINqLceTko5gzJl+Ay7DxO8Bett5x81RgVdqo55Gt
         sExRFKuSR3t+A==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org
Cc:     Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>
In-Reply-To: <20221021190018.63646-1-andriy.shevchenko@linux.intel.com>
References: <20221021190018.63646-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 0/4] spi: pxa2xx: Pass the SSP type via device property
Message-Id: <166662081186.262681.14528029830842691867.b4-ty@kernel.org>
Date:   Mon, 24 Oct 2022 15:13:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 22:00:14 +0300, Andy Shevchenko wrote:
> Currently the SPI PXA2xx devices on Intel platforms can be instantiated
> via the following paths:
>  1) as ACPI LPSS device on Haswell, Bay Trail and Cherry Trail;
>  2) as ACPI LPSS device on the Sky Lake and newer;
>  3) as PCI LPSS device on Haswell, Bay Trail and Cherry Trail;
>  4) as PCI LPSS device on the Sky Lake and newer;
>  5) as PCI device via ID table.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: pxa2xx: Validate the correctness of the SSP type
      commit: 88a947215c29aa49307c8cd0638ba54e4cf07391
[2/4] spi: pxa2xx: Respect Intel SSP type given by a property
      commit: 1a1864cd879a1497fd46f6ea2f31ddcde8385585
[3/4] spi: pxa2xx: Remove no more needed PCI ID table
      commit: 07c337927e0618faf22ea98475c7162e6b7d2b35
[4/4] spi: pxa2xx: Move OF and ACPI ID tables closer to their user
      commit: 0e1f0b1ca79fdcc03c3e6b4277a994ca894c9fcc

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
