Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBE06294FE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiKOJ5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiKOJ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:57:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9967155AA;
        Tue, 15 Nov 2022 01:57:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4799EB8188D;
        Tue, 15 Nov 2022 09:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D60C433C1;
        Tue, 15 Nov 2022 09:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668506222;
        bh=PSY+LeXq5fcKInvMeGl2Yo5EbcIopd9QnKvQjf6hmOM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=P2dzTxIbcSgBgDHQpVjFUsLkIHyFwd2Bx2wmRZkSV6+AWeyfJ9j0lMjbvZRaBNY2z
         FCT3O024Pv01gwUFDdiIuDOZLu7m7G2Fzqxe46LQzX6zS2MP4xsQ5s6Yqn8kGHfb+S
         FL3kyp8+Y92SzQ2X8Nvwn+xyUZVm94XQMDsOXyuwRxDxXH4YTNaocX/ANbRST+k38T
         8wecaVkesYuamGZtIRjUFuBCOLPx8x54zZe6M834sw5phM/3Irn/MVIInG2pEVQLYp
         jSVSKIrOSs1Br+sCeYm7/pbBCEnJt6Hhk9lqfhRAJg3XLRWumXMkAiESYWXL0iIDWJ
         63+yJAFqr0XVg==
From:   Mark Brown <broonie@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
In-Reply-To: <20221114081327.25750-1-bayi.cheng@mediatek.com>
References: <20221114081327.25750-1-bayi.cheng@mediatek.com>
Subject: Re: [PATCH v2] spi: spi-mtk-nor: Optimize timeout for dma read
Message-Id: <166850622037.114886.18108936961480983517.b4-ty@kernel.org>
Date:   Tue, 15 Nov 2022 09:57:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 16:13:27 +0800, Bayi Cheng wrote:
> From: bayi cheng <bayi.cheng@mediatek.com>
> 
> The timeout value of the current dma read is unreasonable. For example,
> If the spi flash clock is 26Mhz, It will takes about 1.3ms to read a
> 4KB data in spi mode. But the actual measurement exceeds 50s when a
> dma read timeout is encountered.
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mtk-nor: Optimize timeout for dma read
      commit: d52a826b40604387d3e24b54e12e404867902fbb

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
