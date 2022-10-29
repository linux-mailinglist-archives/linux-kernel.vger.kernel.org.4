Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E99612626
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 00:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJ2WI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 18:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ2WIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 18:08:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8EC63A6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 15:08:54 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oou0W-0008NZ-5E; Sun, 30 Oct 2022 00:08:48 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, hjc@rock-chips.com
Cc:     Heiko Stuebner <heiko@sntech.de>, daniel@ffwll.ch,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@gmail.com
Subject: Re: [PATCH] drm/rockchip: dsi: Remove the unused function dsi_update_bits()
Date:   Sun, 30 Oct 2022 00:08:43 +0200
Message-Id: <166708118165.1656095.106090992653500085.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017084330.94117-1-jiapeng.chong@linux.alibaba.com>
References: <20221017084330.94117-1-jiapeng.chong@linux.alibaba.com>
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

On Mon, 17 Oct 2022 16:43:30 +0800, Jiapeng Chong wrote:
> The function dsi_update_bits() is defined in the dw-mipi-dsi-rockchip.c
> file, but not called elsewhere, so delete this unused function.
> 
> drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c:367:20: warning: unused function 'dsi_update_bits'.
> 
> https://bugzilla.openanolis.cn/show_bug.cgi?id=2414
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: dsi: Remove the unused function dsi_update_bits()
      commit: 3daf391fee830f2343cc6b1ba131b1b5115dea1f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
