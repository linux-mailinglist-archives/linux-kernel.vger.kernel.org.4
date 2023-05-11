Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03116FEB46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbjEKFgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbjEKFgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:36:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A03019D;
        Wed, 10 May 2023 22:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB81164AC2;
        Thu, 11 May 2023 05:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FC6C433D2;
        Thu, 11 May 2023 05:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683783393;
        bh=RNIfE9mDj3xkF1wBguYVY5kCvWbSz6X2nVPVaSpsS1s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=m9+Cfs31UEteVaHjq2C/Stdl0IQDRGa84VGpyAAFNxULWLZrfhthhPQSIrh8eotyL
         QJXSyePvBrLWTTcx6OHxzpXn8SMsCXKbEjzAEYgXxjKJQpC3YUV5Ta+7JIH4c+hgU7
         dE+LM6B2b7yTFRRlesa/cp07KmiQT+2pwbWcGUE6IZ0pL4m8doL4FqJQe0rVRlf3aZ
         xxCrjHBq8Q8uQ8kK2tRsfV1mBycxHEQP/YYrdlm5w3YBvxsF1+NCR0VQlzI/miHidu
         XexFDgUfnzYkNiF1b0hE0NHxoywjRHviD8JDCJhbNE5meulxLulSUhwuinrBm2u25h
         IDH64ZsLkCnSQ==
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Joy Chakraborty <joychakr@google.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com
In-Reply-To: <20230509082244.1069623-1-joychakr@google.com>
References: <20230509082244.1069623-1-joychakr@google.com>
Subject: Re: [PATCH v10 0/5] spi: dw: DW SPI DMA Driver updates
Message-Id: <168378339105.323325.5747252622396046771.b4-ty@kernel.org>
Date:   Thu, 11 May 2023 14:36:31 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 May 2023 08:22:39 +0000, Joy Chakraborty wrote:
> This Patch series adds support for 32 bits per word trasfers using DMA
> and some defensive checks around dma controller capabilities.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
      commit: 5147d5bfddc807e990a762aed0e56724afeda663
[2/5] spi: dw: Move dw_spi_can_dma()
      commit: d2ae5d42464e990b4d26734c180fbff64233992c
[3/5] spi: dw: Add DMA directional capability check
      (no commit info)
[4/5] spi: dw: Add DMA address widths capability check
      (no commit info)
[5/5] spi: dw: Round of n_bytes to power of 2
      (no commit info)

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

