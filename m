Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52426BD250
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjCPO0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjCPO0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F19BE5CA;
        Thu, 16 Mar 2023 07:26:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AD5362031;
        Thu, 16 Mar 2023 14:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440BFC433D2;
        Thu, 16 Mar 2023 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678976762;
        bh=TmFspmgORjl7/xkwkOpZK0s6w/uuvRf/o9+BvQnquxc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IOvyFy90JHYWwv2fzbjxgfE4pF42BrBrCHEbxNBdMHw2pY7p7DTe0TmM64cDNROgw
         nQFL04N78UiuPd7ogEI8lbAtid1J3U6IqbG+sCCgZ0iW2S33b1XarljB38jl7lph/K
         /AznfxUI4lREDpVk5LQsWE+h5rnIeG+O4CESCq4yDVq272s28t9vewsfxXmg1GgYM3
         TcQKObDhJivVOnFqVR2YQYWz1YHvVrN3Wic/ayLEq/VuUrmEzsIEQ5wHlmUBFvAbPy
         CFiqQgcXYv7T//ZfHJfX3pfFB/xulDgSRvx0bXwP9BAc4kd8WRiCzKL7T9GJB7X+eF
         yMNY7jAP5G8AQ==
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230310092053.1006459-1-l.goehrs@pengutronix.de>
References: <20230310092053.1006459-1-l.goehrs@pengutronix.de>
Subject: Re: [PATCH v1 1/2] spi: core: add spi_split_transfers_maxwords
Message-Id: <167897676081.99723.1247903400904206637.b4-ty@kernel.org>
Date:   Thu, 16 Mar 2023 14:26:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 10:20:52 +0100, Leonard Göhrs wrote:
> Add spi_split_transfers_maxwords() function that splits
> spi_transfers transparently into multiple transfers
> that are below a given number of SPI words.
> 
> This function reuses most of its code from
> spi_split_transfers_maxsize() and for transfers with
> eight or less bits per word actually behaves the same.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: core: add spi_split_transfers_maxwords
      commit: 027781f3920ad16f40133890fc87247b8baa2d8d
[2/2] spi: stm32: split large transfers based on word size instead of bytes
      commit: 1e4929112507f145951f4c356161ab80ad9c1f0e

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

