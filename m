Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E89645E96
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiLGQVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLGQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:21:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD4663BA8;
        Wed,  7 Dec 2022 08:21:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C898661A8E;
        Wed,  7 Dec 2022 16:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78524C433C1;
        Wed,  7 Dec 2022 16:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670430069;
        bh=gD687UUnJea8Yfc6ECxObJUR701yC6QpmwJ0PK2TfFY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VyU3Y5hy+bQNIm+Jx5Cahbr6ZDz21sn3CCp/2OS2bIKG5n3Z0KzSl00Ggk0s+6Iiy
         D5dxPqE6NWbwAhjLdJHo87NatU+ry2i+sLDiweaxEBdPgN7e9MzLKJiLVehssk66cc
         zE840mb2mK834BN2MSPQVO/0ikGbGRfUePV7YVKN0EDIW6odVPWjmlX4vSqnfXvg+x
         R2Do/Gkw1gvfmZ3OamSkfac9msiCweI9eYquKfELDyuFfhOzGCQ+biWu1Pg5MvFxkG
         WrzqsqDXc/Cvc6tBqw37SBJ3t75ShuHauf7EkFGYOA1n6jSr+Efj74fnxRPCtvzB9Y
         x/8MMCG9gsZQQ==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Bayi Cheng <bayi.cheng@mediatek.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
In-Reply-To: <20221207055435.30557-1-bayi.cheng@mediatek.com>
References: <20221207055435.30557-1-bayi.cheng@mediatek.com>
Subject: Re: [PATCH v2] spi: spi-mtk-nor: Add recovery mechanism for dma read timeout
Message-Id: <167043006609.286366.2467608192853584896.b4-ty@kernel.org>
Date:   Wed, 07 Dec 2022 16:21:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-b77ec
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Dec 2022 13:54:35 +0800, Bayi Cheng wrote:
> The state machine of MTK spi nor controller may be disturbed by some
> glitch signals from the relevant BUS during dma read, Although the
> possibility of causing the dma read to fail is next to nothing,
> However, if error-handling is not implemented, which makes the feature
> somewhat risky.
> 
> Add an error-handling mechanism here, reset the state machine and
> re-read the data when an error occurs.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mtk-nor: Add recovery mechanism for dma read timeout
      commit: 8330e9e8269bb76dd502e84efb5f351016512cf8

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
