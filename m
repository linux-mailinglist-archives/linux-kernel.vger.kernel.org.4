Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A54468B078
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 15:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBEO4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 09:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjBEO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 09:56:47 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DDF20D1F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 06:56:43 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pOgRM-0007OK-9T; Sun, 05 Feb 2023 15:56:24 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     John Keeping <john@metanate.com>, Sandy Huang <hjc@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: avoid duplicate mappings for IOMMU devices
Date:   Sun,  5 Feb 2023 15:56:20 +0100
Message-Id: <167560896726.1025063.3569913562158180840.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221110172415.2853420-1-john@metanate.com>
References: <20221110172415.2853420-1-john@metanate.com>
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

On Thu, 10 Nov 2022 17:24:14 +0000, John Keeping wrote:
> If a buffer is allocated with alloc_kmap, then it is vmap'd on creation
> and there is no reason to map it again in rockchip_gem_prime_vmap() when
> the existing mapping can be used.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: avoid duplicate mappings for IOMMU devices
      commit: 0020d4cfa3eea0e5fad23af49411217da854fc83

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
