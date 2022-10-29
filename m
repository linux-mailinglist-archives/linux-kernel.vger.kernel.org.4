Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2098B612315
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 15:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJ2NBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 09:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2NA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 09:00:58 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC80F030
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 06:00:54 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oolSD-0006ID-TM; Sat, 29 Oct 2022 15:00:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        "open list:DRM DRIVERS FOR ROCKCHIP" 
        <dri-devel@lists.freedesktop.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        David Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/rockchip: dw_hdmi: filter regulator -EPROBE_DEFER error messages
Date:   Sat, 29 Oct 2022 15:00:44 +0200
Message-Id: <166704843774.1532410.17477567651107458681.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220926203752.5430-1-aurelien@aurel32.net>
References: <20220926203752.5430-1-aurelien@aurel32.net>
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

On Mon, 26 Sep 2022 22:37:52 +0200, Aurelien Jarno wrote:
> When the avdd-0v9 or avdd-1v8 supply are not yet available, EPROBE_DEFER
> is returned by rockchip_hdmi_parse_dt(). This causes the following error
> message to be printed multiple times:
> 
>     dwhdmi-rockchip fe0a0000.hdmi: [drm:dw_hdmi_rockchip_bind [rockchipdrm]] *ERROR* Unable to parse OF data
> 
> Fix that by not printing the message when rockchip_hdmi_parse_dt()
> returns -EPROBE_DEFER.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: dw_hdmi: filter regulator -EPROBE_DEFER error messages
      commit: bfab00b94bd8569cdb84a6511d6615e6a8104e9c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
