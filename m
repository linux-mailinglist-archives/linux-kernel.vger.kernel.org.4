Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B12613D76
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJaShz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJaShw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:37:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616F512626;
        Mon, 31 Oct 2022 11:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1CC561381;
        Mon, 31 Oct 2022 18:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30B8C433D6;
        Mon, 31 Oct 2022 18:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667241470;
        bh=ZpTWBC53pD9jnfi/c4IU8fgvcZSMtpYN97AUUuaHEmI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fISESh/PTcHRhJ2Q0Oz8ZQ5tnCGlOmSb4jvPRe5AA5BhtF/LnVD+b56qgdwKH4val
         g5qLsOHifvGiyDA5nKe+Qhqic46cDUot977FqZeUJI/UFJTS9FyWueA/ob5+BgVkWC
         kNRTskoHiXXZOBa38QenhnqD+P5em2EA6s3HYTUiO6AZvVTB0mMJZfPeESB34qRmzB
         ZHc95UrMfQTq0UnvUvhrEbZRsZ/Y75ntcnpoN9/5g1UD83iBY9WvkVKiLZfaDAavkv
         KaCOQRaskkieL72gzW9AcEGOrpgu7CX5isv7Z7LJKeTv+ldWG/6EYhnOU4J9ya/R0P
         wWBTeu7YRimrw==
From:   Mark Brown <broonie@kernel.org>
To:     Zhichao Liu <zhichao.liu@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-arm-kernel@lists.infradead.org, leilk.liu@mediatek.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221021091653.18297-1-zhichao.liu@mediatek.com>
References: <20221021091653.18297-1-zhichao.liu@mediatek.com>
Subject: Re: [PATCH] spi: mediatek: Fix package division error
Message-Id: <166724146867.755330.12479790403811029953.b4-ty@kernel.org>
Date:   Mon, 31 Oct 2022 18:37:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 17:16:53 +0800, Zhichao Liu wrote:
> From: "zhichao.liu" <zhichao.liu@mediatek.com>
> 
> Commit 7e963fb2a33ce ("spi: mediatek: add ipm design support
> for MT7986") makes a mistake on package dividing operation
> (one change is missing), need to fix it.
> 
> Background:
> Ipm design is expanding the HW capability of dma (adjust package
> length from 1KB to 64KB), and using "dev_comp->ipm_support" flag
> to indicate it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mediatek: Fix package division error
      commit: cf82d0ecb84e8ef9958721193f901609b408655b

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
