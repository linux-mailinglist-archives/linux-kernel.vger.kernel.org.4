Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C1D6D6724
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjDDPVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbjDDPVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C324EC3;
        Tue,  4 Apr 2023 08:21:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 453A4635FE;
        Tue,  4 Apr 2023 15:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FFEC433EF;
        Tue,  4 Apr 2023 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680621664;
        bh=Iyz0FpMG4X9tuX8QpnQsjWMsgQwEWPkaBcjg5GtAviw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=THSiTYkjd2eDXpMPKP2WziF0Q/hVKfrHFyQBcuFlOrtdkfdQvvmPx4g0DhK3vagPI
         OUv4bZc4Gyqk/oq11WS8gawWupty7MpO9+mpZEK+lajLiSpP6hSOVI3kyrq3L0VgzB
         2xlM9PlyKM4a9kSCX2FAub3Jz02cpQxVW9uu4r2I/N8sOYg4kOpqv4xLHn1Ow5+GiT
         RmpVwqEsrGMEZlKENwCBQ9R1vmSgOAxcKTiDasQNskYGoqBKNEpOVR4DDP3opqQTc0
         0TC33ORixbWNDN/3Fx/f9EvE7uuLH38z2GIA3peDaqg35PqX5i41sNhsbRGGFPP7x8
         RC/2GgYAxi3mg==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230328062600.93160-1-yang.lee@linux.alibaba.com>
References: <20230328062600.93160-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] spi: imx: Use
 devm_platform_get_and_ioremap_resource()
Message-Id: <168062166206.53383.9938564932306318494.b4-ty@kernel.org>
Date:   Tue, 04 Apr 2023 16:21:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 14:26:00 +0800, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: Use devm_platform_get_and_ioremap_resource()
      commit: d909451ce1db59ba0281fc65ee03d8933d623574

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

