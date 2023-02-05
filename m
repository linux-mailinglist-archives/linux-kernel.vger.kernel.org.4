Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563B668B073
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 15:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBEO4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 09:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjBEO4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 09:56:38 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604561F5F3
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 06:56:37 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pOgRN-0007OK-2c; Sun, 05 Feb 2023 15:56:25 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        David Airlie <airlied@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        Rob Clark <robdclark@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/rockchip: Drop unbalanced obj unref
Date:   Sun,  5 Feb 2023 15:56:22 +0100
Message-Id: <167560896727.1025063.1209601146004303880.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119231734.2884543-1-robdclark@gmail.com>
References: <20230119231734.2884543-1-robdclark@gmail.com>
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

On Thu, 19 Jan 2023 15:17:34 -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> In the error path, rockchip_drm_gem_object_mmap() is dropping an obj
> reference that it doesn't own.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: Drop unbalanced obj unref
      commit: 8ee3b0e85f6ccd9e6c527bc50eaba774c3bb18d0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
