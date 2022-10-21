Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF331607AC7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJUPca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiJUPcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:32:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4821E2502BB;
        Fri, 21 Oct 2022 08:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7426A61EF5;
        Fri, 21 Oct 2022 15:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7059AC433D7;
        Fri, 21 Oct 2022 15:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666366305;
        bh=KIqECE/AwusXWYnWOotySPw8bPzXAq2SrDXGneZih/s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iS3zmIuW1S87i25QxozXKfWSD4ymBN0nd5+OPvX27FC85LRa11nCp6NfVeKpWJzTH
         xZCeG5iZCy193jQQpnTcl6zmRcfHjyj6dOSfB9vEurg4vzOPBCPB6ukcKIYM/bMyPz
         LZuUsRQV7eSawhIlVz+C8frgosKrYXD8mS+2Z6kmGJXF1wdXH7gyg9AhqACz/MMBRU
         JeWZ5aXWi7+5UbejvIGuM2vciJKM1D3GTh9tDc90vAIj4krbg7PnitbsK17W0/C74O
         49ul+5HSVHuX9G4Ss0v2dixA2gkaiV+BHGtjyiWw8FELBAbOo4/7oOQo9aca/KduVS
         lPyvUYEVIQhNA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>
In-Reply-To: <20221020194500.10225-1-andriy.shevchenko@linux.intel.com>
References: <20221020194500.10225-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v4 0/5] spi: pxa2xx: Pass the SSP type via device property
Message-Id: <166636630417.311920.2410945917919956553.b4-ty@kernel.org>
Date:   Fri, 21 Oct 2022 16:31:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 22:44:55 +0300, Andy Shevchenko wrote:
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

[4/5] spi: pxa2xx: Consistently use dev variable in pxa2xx_spi_init_pdata()
      commit: 8fc8250a1586008cceaadd6f4df9db23643d4b3e
[5/5] spi: pxa2xx: Switch from PM ifdeffery to pm_ptr()
      commit: 6c3c438c085b2cd79b3291b67f8f7ece62371947

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
