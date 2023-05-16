Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE4705062
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjEPOTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjEPOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:18:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D0D7689
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0898C63A9B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AB6C4339C;
        Tue, 16 May 2023 14:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684246706;
        bh=YXhBO9eG7UWbqzuiSK1fn6Kv4L06SYxCu/Poh/mJHwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T5Z7Rp6T/k00U4NfiIA60xzvdndp67Bi9eF0AXmi1sA/kR32HdVQVykmsjg7jpBY3
         hrl4quu7TpWXEaSdRD0/00cH3TVaDAnwl2GzwGDu/KBVuCWG4cHEfGl4PnPaqHFV23
         LLvsveTXCqPOThx9ey11JL9f2wLczR0XpLfjr4NIsqGSxKDVbXUhbEyRLLeeqQbetu
         jR3zKAFkY1IEEACvliEdA3dTw7DcVNYSPZ4BsYy80UReKX36g/7iAKu+ooov0hPAi8
         HeuJcT7z/GMYo4dw+9UmllPbFYrEXcAXcQmm/Q7XXFNwa16RX/sKMXFVOM8q+BiSVI
         cbMpIcnnQaU5w==
Date:   Tue, 16 May 2023 19:48:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        chunfeng.yun@mediatek.com, kishon@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: mediatek: rework the floating point comparisons
 to fixed point
Message-ID: <ZGOQroo9KB0IKeu1@matsya>
References: <20230502145005.2927101-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230502145005.2927101-1-trix@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-05-23, 10:50, Tom Rix wrote:
> gcc on aarch64 reports
> drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c: In function ‘mtk_hdmi_pll_set_rate’:
> drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:240:52: error: ‘-mgeneral-regs-only’
>   is incompatible with the use of floating-point types
>   240 |         else if (tmds_clk >= 54 * MEGA && tmds_clk < 148.35 * MEGA)
> 
> Floating point should not be used, so rework the floating point comparisons
> to fixed point.

Applied, thanks

-- 
~Vinod
