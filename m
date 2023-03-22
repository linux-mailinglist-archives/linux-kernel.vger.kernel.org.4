Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36436C5A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCVXZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCVXZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:25:08 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3734020D09
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:25:03 -0700 (PDT)
Received: from p508fd58e.dip0.t-ipconnect.de ([80.143.213.142] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pf7pA-0005S5-JT; Thu, 23 Mar 2023 00:24:56 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sandy Huang <hjc@rock-chips.com>, Toby Chen <tobyc@nvidia.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: dw_hdmi: cleanup drm encoder during unbind
Date:   Thu, 23 Mar 2023 00:24:54 +0100
Message-Id: <167952749009.1581958.8929689445648705036.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230317005126.496-1-tobyc@nvidia.com>
References: <20230317005126.496-1-tobyc@nvidia.com>
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

On Thu, 16 Mar 2023 17:51:26 -0700, Toby Chen wrote:
> This fixes a use-after-free crash during rmmod.
> 
> The DRM encoder is embedded inside the larger rockchip_hdmi,
> which is allocated with the component. The component memory
> gets freed before the main drm device is destroyed. Fix it
> by running encoder cleanup before tearing down its container.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: dw_hdmi: cleanup drm encoder during unbind
      commit: b5af48eedcb53491c02ded55d5991e03d6da6dbf

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
