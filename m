Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA639612314
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 15:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJ2NBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 09:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJ2NA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 09:00:58 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45A6266F
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 06:00:55 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oolSF-0006ID-3J; Sat, 29 Oct 2022 15:00:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Ondrej Jirman <megi@xff.cz>, linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        "open list:DRM DRIVERS FOR ROCKCHIP" 
        <dri-devel@lists.freedesktop.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        David Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/rockchip: dsi: Fix VOP selection on SoCs that support it
Date:   Sat, 29 Oct 2022 15:00:47 +0200
Message-Id: <166704843774.1532410.10169614627003469571.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221023160747.607943-1-megi@xff.cz>
References: <20221023160747.607943-1-megi@xff.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2022 18:07:47 +0200, Ondrej Jirman wrote:
> lcdsel_grf_reg is defined as u32, so "< 0" comaprison is always false,
> which breaks VOP selection on eg. RK3399. Compare against 0.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: dsi: Fix VOP selection on SoCs that support it
      commit: 553c5a429aee26c9cfaf37ae158a8915540270fe

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
