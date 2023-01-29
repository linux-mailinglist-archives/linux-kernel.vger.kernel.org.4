Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D39A67FF6A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 14:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjA2Nj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 08:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjA2NjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 08:39:23 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE24713505;
        Sun, 29 Jan 2023 05:39:22 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pM7ts-0003rM-T7; Sun, 29 Jan 2023 14:39:16 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, David Airlie <airlied@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Sascha Hauer <sha@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: (subset) [PATCH v3 0/6] drm/rockchip: vop2: add support for the rgb output block
Date:   Sun, 29 Jan 2023 14:39:11 +0100
Message-Id: <167499930025.3595793.9316815837713750123.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124054706.3921383-1-michael.riesch@wolfvision.net>
References: <20230124054706.3921383-1-michael.riesch@wolfvision.net>
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

On Tue, 24 Jan 2023 06:47:00 +0100, Michael Riesch wrote:
> This series adds support for the RGB output block that can be found in the
> Rockchip Video Output Processor (VOP) 2. Version 2 of this series
> incorporates the feedback by Dan Carpenter and Sascha Hauer. Version 3
> fixes a dumb mistake pointed out by Sascha :-) Thanks for your comments!
> 
> Patches 1-4 clean up the code and make it more general.
> 
> [...]

Applied, thanks!

[6/6] arm64: dts: rockchip: add pinctrls for 16-bit/18-bit rgb interface to rk356x
      commit: 381b6d432f6eb00e1faff763f55e67519af9fa23

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
