Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8766B187E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCIBHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCIBHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:07:35 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490FD8C0C6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 17:07:32 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pa4kd-00041d-LT; Thu, 09 Mar 2023 02:07:23 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     Heiko Stuebner <heiko@sntech.de>, David Airlie <airlied@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>
Subject: Re: [PATCH] drm/rockchip: vop2: add polarity flags to RGB output
Date:   Thu,  9 Mar 2023 02:07:19 +0100
Message-Id: <167832398246.362678.16304848436685688668.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230302123949.957998-1-gerald.loacker@wolfvision.net>
References: <20230302123949.957998-1-gerald.loacker@wolfvision.net>
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

On Thu, 2 Mar 2023 13:39:49 +0100, Gerald Loacker wrote:
> Use h/v-sync and pixel clock polarity flags for RGB output. For all other
> outputs this is already implemented.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: vop2: add polarity flags to RGB output
      commit: 66ab57574f2c8233550f641ecdc34fd0ef61341d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
