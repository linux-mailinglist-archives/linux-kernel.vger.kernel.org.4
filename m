Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769C75F9FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJJOM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJJOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:12:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3BCBE11;
        Mon, 10 Oct 2022 07:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0746860F67;
        Mon, 10 Oct 2022 14:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F16C433D7;
        Mon, 10 Oct 2022 14:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665411170;
        bh=i+nTuecqo88xOxtIonJejeCxD46J/wAXbJ3XX3wP5tw=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=rS+ol3nlPgDNrGzZR/PNfnMdXZvGHsaHmgOA1Gz93bGvDnK2IhTxXPVHnLnqDMUE9
         o3/AC4GtBt9o1NJGSx4URHMVdqxp45kb0Ts2HUSv6v9J2UC5ZH/BTwnx3jJ8hjjAOG
         +7lITAlCddVy7QUyGqcJ62avRFPaI2Ou3ftEyKoCUBWarFM3c4+Bo1U5lxkUzDYVRQ
         2Hd05bSUnsor230vY1GU7p/eMlUiVRbLpT2+ftdoKumEnRv+u3jBcOq25Djgd7iVCj
         yDkZhLDnD4XDs8gdt65kMgMkSH9cP9HkzwBdz1mLpXGITPL1rGoVOjFudiqGbUvsJK
         YfK5xEFuNf1rg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, clg@kaod.org, joel@jms.id.au,
        steven_lee@aspeedtech.com, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, andrew@aj.id.au,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
In-Reply-To: <20221005083209.222272-1-chin-ting_kuo@aspeedtech.com>
References: <20221005083209.222272-1-chin-ting_kuo@aspeedtech.com>
Subject: Re: [v2] spi: aspeed: Fix typo in mode_bits field for AST2600 platform
Message-Id: <166541116820.121778.9566592036880610465.b4-ty@kernel.org>
Date:   Mon, 10 Oct 2022 15:12:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2022 16:32:09 +0800, Chin-Ting Kuo wrote:
> Both quad SPI TX and RX modes can be supported on AST2600.
> Correct typo in mode_bits field in both ast2600_fmc_data
> and ast2600_spi_data structs.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: aspeed: Fix typo in mode_bits field for AST2600 platform
      commit: 5302e1ff315b40dfc9bb3f08911f5a788cc1de01

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
