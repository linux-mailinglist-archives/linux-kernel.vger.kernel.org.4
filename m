Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936F4692603
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 20:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjBJTDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 14:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjBJTDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:03:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B023303FC;
        Fri, 10 Feb 2023 11:03:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B91761E00;
        Fri, 10 Feb 2023 19:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1602C433D2;
        Fri, 10 Feb 2023 19:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676055789;
        bh=+L5y/sC72atkAzvcrkXUTp9Lmt9XbqjceDkhJa/LIRw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I9f4uSYA93Sz/lcVNuXBDxzQkSL72+vOcieeNoFmEs6sWmqvGUX98osjvNX1DYfU7
         NZLlz2CQ7FMPOeW2rUJNYrDaX+TU+3+RQHgmkfvElZkTIqN7v0B0ETaAvFmM3JDR1A
         BTMfvjV88krhh9K69SHHuzdPpJfBJGrh2JxwQkGpip1LloYpk3f7iCaqnoadj3iiPd
         ntOnbUMn3TgEbf56ohgczsOvyh4YoadBbW+c2L4KVrocDpxspS1Fqp/BNpKSUgm8eY
         ScBCQWia1/cNSnqhxbZhJWZliCEWDXByrNeKwcDY4HjJz50dGSiClIWCoojUrDKWkx
         csS/Qt1hssJZw==
From:   Mark Brown <broonie@kernel.org>
To:     mika.westerberg@linux.intel.com,
        Mauro Lima <mauro.lima@eclypsium.com>
Cc:     michael@walle.cc, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230210164158.211065-1-mauro.lima@eclypsium.com>
References: <20230210164158.211065-1-mauro.lima@eclypsium.com>
Subject: Re: [PATCH v2] spi: intel: Update help text of PCI and Platform
 drivers
Message-Id: <167605578764.957618.11554851569704837842.b4-ty@kernel.org>
Date:   Fri, 10 Feb 2023 19:03:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 13:41:58 -0300, Mauro Lima wrote:
> Modern intel hardware uses controllers that work in hardware
> sequencing mode. In this mode, the controller exposes a subset
> of operations, like read, write and erase, making it easier
> and less error-prone for use.
> On the other hand, most of the controllers handled by the
> platform driver use software sequencing that exposes the
> entire set of operations i.e. exposes the low level SPI-NOR
> opcodes to the software for use.
> Update PCI and Platform help text with this information.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Update help text of PCI and Platform drivers
      commit: 2ea9b08a661274b9b7b182327bf6ffe29605d671

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

