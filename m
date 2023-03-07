Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9526ADB97
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjCGKRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCGKRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:17:05 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CCF3C7B2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:17:03 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pZUNL-0004AV-Ns; Tue, 07 Mar 2023 11:16:55 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@gmail.com, daniel@ffwll.ch,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] drm/rockchip: dsi: Remove the unused function dsi_read()
Date:   Tue,  7 Mar 2023 11:16:39 +0100
Message-Id: <167818417706.10390.2172000059064022458.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230208023429.73696-1-jiapeng.chong@linux.alibaba.com>
References: <20230208023429.73696-1-jiapeng.chong@linux.alibaba.com>
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

On Wed, 8 Feb 2023 10:34:29 +0800, Jiapeng Chong wrote:
> The function dsi_read is defined in the dw-mipi-dsi-rockchip.c file, but
> not called elsewhere, so remove this unused function.
> 
> drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c:362:19: warning: unused function 'dsi_read'.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: dsi: Remove the unused function dsi_read()
      commit: 59585c79f87794c92f040c264b274e86d8522e22

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
