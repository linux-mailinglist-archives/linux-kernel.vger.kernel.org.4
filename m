Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA4A6B804D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCMSVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCMSUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:20:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599604DBFD;
        Mon, 13 Mar 2023 11:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7CA761474;
        Mon, 13 Mar 2023 18:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C1EC433D2;
        Mon, 13 Mar 2023 18:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678731623;
        bh=VmJSNLbcqMVS5XBn0qBDsURYenyy5STxRhO9nfHg3jM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=q5nehehm6DhM7LTxA3Tcsai0rlo4A/Ldw1Eeq/YAxyoo/cVFjkeP+gDcdL23Dn7VM
         eApJ1w4hci/qI/CbUIXAiFsarK/XLGmFLx71mbNDT+HejE4bC757pE2Ay2GgrgW5cG
         gwj+IBnyCg7Et4XZo35kc3EhSgtDc0oxLitsibbqg016yUW7RYXRElaDTZb1HzNUnw
         23WAlkoSFlDDOTwRurPvPWz8bS4nOG+fsmL7NMX2ojROmyVscvtkTzeaC0k1FZr22O
         QRFzky4a6D622fslc7tS98bZj9J+Vesx6j+WJise8sKdiR+Spo7nkzc5EgVtvi/LVB
         s2EqJx3eIooAQ==
From:   Mark Brown <broonie@kernel.org>
To:     Min Li <min.li.xe@renesas.com>, Lee Jones <lee@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <cover.1678704562.git.geert+renesas@glider.be>
References: <cover.1678704562.git.geert+renesas@glider.be>
Subject: Re: (subset) [PATCH 0/6] spi: struct spi_device constification
Message-Id: <167873162127.102913.8422691549398667827.b4-ty@kernel.org>
Date:   Mon, 13 Mar 2023 18:20:21 +0000
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

On Mon, 13 Mar 2023 11:58:32 +0100, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> After noticing new cases of casting away constness, I went over all
> spi_get_*() functions and their callers, and made the following changes:
>   1. Make all pointer parameters const where possible,
>   2. Remove unneeded casts, some not even related to constness.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/6] spi: fsl-dspi: Remove unneeded cast to same type
      commit: 9c8400e3795decefe6390646ece820a310b37b79
[3/6] spi: Constify spi_get_ctldata()'s spi parameter
      commit: cc4b15670340315fb0b25d886c06bffb5f128f02
[4/6] spi: Constify spi_get_drvdata()'s spi parameter
      commit: 38dca04d659a422d842f7edcecd32253c7a6fb5e
[5/6] spi: Constify spi parameters of chip select APIs
      commit: d2f19eec510424caa55ea949f016ddabe2d8173a
[6/6] spi: sh-msiof: Remove casts to drop constness
      commit: 7859ad5a401b73bf2ddfa274950b5722492c3150

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

