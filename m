Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBE26C57D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCVUlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjCVUkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:40:37 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912D633CD0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:32:52 -0700 (PDT)
Received: from p508fd58e.dip0.t-ipconnect.de ([80.143.213.142] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pf4mJ-0004Ps-T8; Wed, 22 Mar 2023 21:09:47 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     daniel@ffwll.ch, Tom Rix <trix@redhat.com>, hjc@rock-chips.com,
        nathan@kernel.org, s.hauer@pengutronix.de, airlied@gmail.com,
        ndesaulniers@google.com, michael.riesch@wolfvision.net
Cc:     Heiko Stuebner <heiko@sntech.de>, llvm@lists.linux.dev,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: vop2: fix uninitialized variable possible_crtcs
Date:   Wed, 22 Mar 2023 21:09:45 +0100
Message-Id: <167951576826.1541042.11962083782525897631.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230316132302.531724-1-trix@redhat.com>
References: <20230316132302.531724-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 09:23:02 -0400, Tom Rix wrote:
> clang reportes this error
> drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2322:8: error:
>   variable 'possible_crtcs' is used uninitialized whenever 'if'
>   condition is false [-Werror,-Wsometimes-uninitialized]
>                         if (vp) {
>                             ^~
> drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2336:36: note:
>   uninitialized use occurs here
>                 ret = vop2_plane_init(vop2, win, possible_crtcs);
>                                                  ^~~~~~~~~~~~~~
> drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2322:4:
>   note: remove the 'if' if its condition is always true
>                         if (vp) {
>                         ^~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: vop2: fix uninitialized variable possible_crtcs
      commit: e88adb4ac27a37de4167150b8a6a736d40cf7018

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
