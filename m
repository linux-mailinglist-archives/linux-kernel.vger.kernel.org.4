Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433D574E84A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjGKHpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjGKHpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:45:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DE610C0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA8186135C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF6EC43395;
        Tue, 11 Jul 2023 07:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689061498;
        bh=ciw16WjgCbpUQ78bDN+pzL0lSeeM/GqmjDYLxzcY6yI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IwPp3mQJ1TpyDP96+oR3Fu3Y/tisMwzJG2v0fVSWQJXN7gzCcGlh4uys5YlZL++SC
         kLrTV4b97MmeAs3dMISU77AFKE4abftNKYLCBgtQsxd7jlJ5+qGDTDgjcJM6xik/nf
         /9X79Cnes411fTfqgKKacopYEzKKjablX4KPmEgO5Zt6gMZUUnipyKQVV7BfP1+9Ih
         xBsXI/HcbssfS+AyGNjsamXF+M+3lcpfdppFLe//nShQV7d69khbihCujMoj0SP+I4
         vei1AFDr1r2/qiPhmJp+O7vrcCb1zXKVJO9fzEi5IPTmzL2ZXJhj/HMBYgf5Bo5JCr
         3LcTzz2ZggEgQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     chunkuang.hu@kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     p.zabel@pengutronix.de, chunfeng.yun@mediatek.com,
        kishon@kernel.org, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
In-Reply-To: <20230525115258.90091-1-angelogioacchino.delregno@collabora.com>
References: <20230525115258.90091-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 0/3] MediaTek MIPI-DSI PHY: Cleanups
Message-Id: <168906149382.189433.16193247421071563678.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 13:14:53 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 May 2023 13:52:55 +0200, AngeloGioacchino Del Regno wrote:
> This series performs some cleanups to the MediaTek mipi-dsi PHY, used in
> various MediaTek SoCs; in particular, it's migrating this driver to
> register its clock as clk_hw provider instead and makes use of the devm
> function for the same, allowing to remove a pointer to struct clk and
> the whole .remove_new() callback, as it's not needed anymore.
> This also cleans up the of_device_id table.
> 
> [...]

Applied, thanks!

[1/3] phy: mediatek: mipi-dsi: Convert to register clk_hw
      commit: b1a34e7d196646a8fc0a6f91c2bf98943f3d440a
[2/3] phy: mediatek: mipi-dsi: Use devm variant for of_clk_add_hw_provider()
      commit: e812c5b62a978ae67d23c5eb237959596734a86e
[3/3] phy: mediatek: mipi-dsi: Compress of_device_id match entries
      commit: 5d295c1a20c747425c27dd9212ff091528136e55

Best regards,
-- 
~Vinod


