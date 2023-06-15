Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB647731A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbjFON6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344779AbjFON63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:58:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0301BE8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 875D1638B3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596B6C433C8;
        Thu, 15 Jun 2023 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686837501;
        bh=t+2wC354QWhU+O19T6Rgik2yRjFWn188LUJeRwNUofc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=K//TbDnohYFTagexGKtrRwrEcpN/jzaTeuXG/IgwXLO0tFsKSB2ekf1fUWY6laii1
         vYKI1iTvA/ARANfsLZpZr7aOvHlfYkeWAUBIuWwYCfK2ttfbnKwyndrzncdYo89vro
         BAJGpMo0u134UwgHdV2qEllY1Z6q1vL4Kgj5r2jpNTjGT82vFqrEgbRmD9qjCJpnt7
         z6PQ/kSbZ7YMWix3F+oTjpvKZMT6XlxmIOmBrz7anElgNaPi4TqLcdIM/04sFPCNn7
         3z3yjXZOyHFZlNrVM2Q0k/uu3KnO24RVabGom8+uR0ylXX29cFu/I2vOYC3NeIYd1t
         uSO27Q++cW+YA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, YingKun Meng <mengyingkun@loongson.cn>
Cc:     krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
In-Reply-To: <20230614122140.3402749-1-mengyingkun@loongson.cn>
References: <20230614122140.3402749-1-mengyingkun@loongson.cn>
Subject: Re: [PATCH v3 1/3] ASoC: Add support for Loongson I2S controller
Message-Id: <168683750003.557448.10961262618538846845.b4-ty@kernel.org>
Date:   Thu, 15 Jun 2023 14:58:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 20:21:40 +0800, YingKun Meng wrote:
> Loongson I2S controller is found on 7axxx/2kxxx chips from loongson,
> it is a PCI device with two private DMA controllers, one for playback,
> the other for capture.
> 
> The driver supports the use of DTS or ACPI to describe device resources.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: Add support for Loongson I2S controller
      commit: d84881e06836dc1655777a592b4279be76ad7324

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

