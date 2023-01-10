Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B606642B9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjAJOEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjAJOEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:04:46 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8124857922;
        Tue, 10 Jan 2023 06:04:44 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pFFF3-0004vx-76; Tue, 10 Jan 2023 15:04:41 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: rockchip: rk3328: Add Orange Pi R1 Plus
Date:   Tue, 10 Jan 2023 15:04:33 +0100
Message-Id: <167335938206.2550251.12948376009985320157.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221203074149.11543-1-amadeus@jmu.edu.cn>
References: <20221203074149.11543-1-amadeus@jmu.edu.cn>
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

On Sat, 3 Dec 2022 15:41:47 +0800, Chukun Pan wrote:
> > Changes from v2:
> > * Add regulator suffix.
> > * Collected acked-by.
> 
> Chukun Pan (2):
>   dt-bindings: arm: rockchip: Add Orange Pi R1 Plus
>   arm64: dts: rockchip: rk3328: Add Orange Pi R1 Plus
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add Orange Pi R1 Plus
      commit: 21a6d804d1fc737d0b8493d1ed0baa0a5a67e369
[2/2] arm64: dts: rockchip: rk3328: Add Orange Pi R1 Plus
      commit: 6d7961ddd3c2fcad6aea812fee9f6a6356b130a4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
