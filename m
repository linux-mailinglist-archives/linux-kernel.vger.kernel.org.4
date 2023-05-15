Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE2B703173
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbjEOPWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242413AbjEOPWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:22:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5127E2D74;
        Mon, 15 May 2023 08:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B2A76261F;
        Mon, 15 May 2023 15:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018BEC433EF;
        Mon, 15 May 2023 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684164131;
        bh=8pixPTs1hKpzfgnN7sWBey95JJn+751x7B1R4Xl+cu4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tV5tt8+0AILsbLnCo796sFFYgUkFfBJzx6Iq8TeF7XLXRqT9OSTk0mBteC7HiQSHS
         ppuI05esFlrByz/B+cIVYL63LEP7/cdWC/YT0OR5vbY2hPv0CwcCO6QsXio98wuCi/
         8gB0JJwJzRv+AbiuAMM5JpqLGn8vK/Xy9ecHq5rPb1RnTsXISvsuIo6tRSQzVuyfjm
         l46rfuovoXHMGNCcEvYMVyCtr4uo0aetUg2rYoKFaGlBZxTF4HtKfd2Z0Z1ArSvOhp
         iW5gFDhs0kG0+pkTKbS/5djuR97dfPrZ9lu9OeaLqzMKWUVuU7FTRq4iOP2Yad5AMl
         6OKwFfshiaBMA==
From:   Mark Brown <broonie@kernel.org>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com
In-Reply-To: <20230512104746.1797865-1-joychakr@google.com>
References: <20230512104746.1797865-1-joychakr@google.com>
Subject: Re: [PATCH v11 0/3] spi: dw: DW SPI DMA Driver updates
Message-Id: <168416412980.414118.17659139951368059982.b4-ty@kernel.org>
Date:   Tue, 16 May 2023 00:22:09 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 10:47:42 +0000, Joy Chakraborty wrote:
> This Patch series adds support for 32 bits per word trasfers using DMA
> and some defensive checks around dma controller capabilities.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dw: Add DMA directional capability check
      commit: d1ca1c5297ba9260942c0b3f1171a98a432bdfec
[2/3] spi: dw: Add DMA address widths capability check
      commit: 020a3947e7f18e790cc72785281755f8c49e11d4
[3/3] spi: dw: Round of n_bytes to power of 2
      commit: 9f34baf67e4d08908fd94ff29c825bb673295336

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

