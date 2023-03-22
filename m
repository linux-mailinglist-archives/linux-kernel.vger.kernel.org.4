Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36146C540B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjCVSsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjCVSsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:48:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D501369CC5;
        Wed, 22 Mar 2023 11:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 283EBCE1EA1;
        Wed, 22 Mar 2023 18:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4EBC433EF;
        Wed, 22 Mar 2023 18:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679510864;
        bh=8gRlDYNu0P9XXUL+bHIrct6C6b7x/NDZwwEy5sp45L8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XzhFDKL6qxoFFooQnLkjFCUb35RgtI9lVCKfSzzm1mDieqAj/zTP5vhlF6v3SQmY2
         TJP/N4J7NfCVvi6MDijsqnaqZ4VLMU19cbKiOdVNn687cVAzIDooFlEaKR4ejHIzWJ
         mKMHkymQmXWTYu/oApuL/nmvXvPTXmdNStdqIDuvlLQLaQZWpQwwOZPltLVTsoLgqn
         Zv7Ti27Mu9yrRkCwARYUpoxYyIWaKQq5o1ZvtFvVztN6fuYz7CwqjtEBwnFaUJMzJi
         GheVhFoKZCS4ST677RC7Dr+dICJcMB3a27YYe/voE3mAoGiUwtkhJfSWSTH4VkGjoQ
         NSPtV9COTosDA==
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230322023101.24490-1-hayashi.kunihiko@socionext.com>
References: <20230322023101.24490-1-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH] spi: f_ospi: Add missing spi_mem_default_supports_op()
 helper
Message-Id: <167951086286.1093026.17196294862299360106.b4-ty@kernel.org>
Date:   Wed, 22 Mar 2023 18:47:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 11:31:01 +0900, Kunihiko Hayashi wrote:
> The .supports_op() callback function returns true by default after
> performing driver-specific checks. Therefore the driver cannot apply
> the buswidth in devicetree.
> 
> Call spi_mem_default_supports_op() helper to handle the buswidth
> in devicetree.
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: f_ospi: Add missing spi_mem_default_supports_op() helper
      commit: bc43c5ec1a97772269785d19f62d32c91ac5fc36

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

