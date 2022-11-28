Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C175463AD80
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiK1QTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiK1QTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:19:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980B5219B;
        Mon, 28 Nov 2022 08:19:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6F72B80D89;
        Mon, 28 Nov 2022 16:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F3AC433D6;
        Mon, 28 Nov 2022 16:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669652358;
        bh=i0y/liEwV8DEyD+39Xmd9FgUWdMvwnQEigBzYVpa2kY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XvLTx3qDg/MyqlXFMWlq2auUM1z2S6pKc3Qh/ueg84vGINx+dNHNuUbFz5UTaUEez
         zJV70ubR7QPbHEh/r3J7DZK4kJAmO80Apb3gqZKEJNb6tSd7Z55NM9VBvFA8ctQDYE
         7bNASHtYwCU/VnheYuLMqRCOu84KAjr3wok632uiAtviH/ImJ2892ja/wGgUpeO3PQ
         v9iDm+zyG+72E88Hfq053vOraEi5rBR4sB8XxwiwMrUklyUuq4zCA7XvYN2pOp+9Ou
         G5jJntS6Cq2pVOYPqnGFwzcVZYFWRMPJcmmVOKGAjZJmDmBzGcz4G6J3lcG3ppU2gL
         YW9jYA4svMkrQ==
From:   Mark Brown <broonie@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221115124655.10124-1-bayi.cheng@mediatek.com>
References: <20221115124655.10124-1-bayi.cheng@mediatek.com>
Subject: Re: [PATCH v1] spi: spi-mtk-nor: Unify write buffer on/off
Message-Id: <166965235645.555844.12992456289264361457.b4-ty@kernel.org>
Date:   Mon, 28 Nov 2022 16:19:16 +0000
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

On Tue, 15 Nov 2022 20:46:55 +0800, Bayi Cheng wrote:
> From: bayi cheng <bayi.cheng@mediatek.com>
> 
> The logical structures of mtk_nor_write_buffer_enable and
> mtk_nor_write_buffer_disable are very similar, So it is necessary to
> combine them into one.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mtk-nor: Unify write buffer on/off
      commit: 63d9a4d88499569210c445a862209515207c2732

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
