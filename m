Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44426EF2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbjDZK5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjDZK53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:57:29 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60508BF;
        Wed, 26 Apr 2023 03:57:26 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1prcpi-0003hk-K1; Wed, 26 Apr 2023 12:57:10 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        kernel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH v3 0/3] Enable rk3588 timer support
Date:   Wed, 26 Apr 2023 12:57:08 +0200
Message-Id: <168250659572.356856.7990087922862518615.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230419181309.338354-1-cristian.ciocaltea@collabora.com>
References: <20230419181309.338354-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 21:13:06 +0300, Cristian Ciocaltea wrote:
> This patchset enables Rockchip RK3588/RK3588S SoC timer support.
> While here, it also handles a minor DT binding issue related to RK3288.
> 
> Changes in v3:
>  - Updated commit description in patch 1, per Krzysztof's review
>  - Added Acked-by tag from Krzysztof in patch 2
>  - v2: https://lore.kernel.org/lkml/20230418120624.284551-1-cristian.ciocaltea@collabora.com/
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: rockchip: Add rk3588 timer
      commit: 9558529472d72a79ee6cd02da6c4439ec12a63e9
      [will be rebased on top of 6.4-rc1]

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
