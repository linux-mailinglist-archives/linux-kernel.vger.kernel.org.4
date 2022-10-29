Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD4C612625
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 00:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJ2WI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 18:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ2WIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 18:08:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110711AD8A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 15:08:53 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oou0V-0008NZ-Ni; Sun, 30 Oct 2022 00:08:47 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     john@metanate.com, Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, daniel@ffwll.ch,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, hjc@rock-chips.com,
        airlied@gmail.com
Subject: Re: [PATCH v1] drm: rockchip: remove rockchip_drm_framebuffer_init() function
Date:   Sun, 30 Oct 2022 00:08:42 +0200
Message-Id: <166708118163.1656095.18036790011991165334.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <ebe91504-c5df-99e4-635f-832218584051@gmail.com>
References: <ebe91504-c5df-99e4-635f-832218584051@gmail.com>
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

On Wed, 19 Oct 2022 23:35:03 +0200, Johan Jonker wrote:
> The function rockchip_drm_framebuffer_init() was in use
> in the rockchip_drm_fbdev.c file, but that is now replaced
> by a generic fbdev setup. Reduce the image size by
> removing the rockchip_drm_framebuffer_init() and sub function
> rockchip_fb_alloc() and cleanup the rockchip_drm_fb.h header file.
> 
> 
> [...]

Applied, thanks!

[1/1] drm: rockchip: remove rockchip_drm_framebuffer_init() function
      commit: 4016379301a33e8bd0c2ef5c02f5d7f6a4afece4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
