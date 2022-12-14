Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB9B64CC2D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbiLNO1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238635AbiLNO1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:27:08 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA98420355;
        Wed, 14 Dec 2022 06:27:05 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p5Sis-00050J-MP; Wed, 14 Dec 2022 15:27:02 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hjc@rock-chips.com,
        zhangqing@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
        philipp.tomsich@vrull.eu, soc@kernel.org, tglx@linutronix.de,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-rockchip@lists.infradead.org, sjg@chromium.org,
        olof@lixom.net
Subject: Re: (subset) [PATCH v2 0/4] Add basic Rockchip rk3128 DT support
Date:   Wed, 14 Dec 2022 15:26:59 +0100
Message-Id: <167102796007.2796496.11503501153122031880.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <e83964fe-ad87-0905-4586-e235757c6b2b@gmail.com>
References: <e83964fe-ad87-0905-4586-e235757c6b2b@gmail.com>
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

On Fri, 28 Oct 2022 16:39:04 +0200, Johan Jonker wrote:
> Add basic Rockchip rk3128 DT support.
> 
> Features:
>   Quad-core ARM Cortex-A7MP Core processor
>   Clock & reset unit
>   Power management unit
>   Interrupt controller
>   DMAC
>   6x 64 bits Timers
>   4x PWMs
>   1x 32 bits watchdog
> 
> [...]

Applied for 6.3, thanks!

[1/4] dt-bindings: arm: rockchip: Add Rockchip RK3128 Evaluation board
      commit: a1392d5ac60864a3682c447fe62392eb56e9d93b
[3/4] ARM: dts: rockchip: add rk3128.dtsi
      commit: 9ef609cbdbf7a45599b0c9c21e9e7d2ae625896f
[4/4] ARM: dts: rockchip: add rk3128-evb.dts
      commit: 7232dafab89ac23b570d0adb3402164719fcbe3d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
