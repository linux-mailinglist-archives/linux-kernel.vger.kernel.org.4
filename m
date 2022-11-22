Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266AC634A15
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiKVWeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiKVWeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:34:22 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568E2C67E1;
        Tue, 22 Nov 2022 14:34:20 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oxbqJ-0004DQ-8F; Tue, 22 Nov 2022 23:34:15 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        Peter Geis <pgwipeout@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 0/4] Misc SOQuartz Enablement
Date:   Tue, 22 Nov 2022 23:34:10 +0100
Message-Id: <166915627085.1689466.13486151224430970136.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221116115337.541601-1-frattaroli.nicolas@gmail.com>
References: <20221116115337.541601-1-frattaroli.nicolas@gmail.com>
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

On Wed, 16 Nov 2022 12:53:33 +0100, Nicolas Frattaroli wrote:
> This series adds the following:
>  * SOQuartz Blade bindings (patch 1)
>  * SOQuartz Blade device tree (patch 2)
>  * SOQuartz Model A bindings (patch 3)
>  * SOQuartz Model A device tree (patch 4)
> 
> The name of this patch series is a bit inaccurate as it has
> evolved, now entirely consisting of new baseboards for the
> SOQuartz. Nevertheless I chose to keep it as to make it easier
> for maintainers to track what this is a follow-up to.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: arm: rockchip: Add SOQuartz Blade
      commit: 8c84c2e51f3ee39b40e8078ebe3ad9c01fb17aff
[2/4] arm64: dts: rockchip: Add SOQuartz blade board
      commit: a5c826ecde5222f755e7d8a0c8d795189c5c1228
[3/4] dt-bindings: arm: rockchip: Add SOQuartz Model A
      commit: 7441d8c437883581dddfb616a087b399338244f0
[4/4] arm64: dts: rockchip: rk3566: Add SOQuartz Model A baseboard
      commit: afbaed737fb45bcae91e4606025fb31da71b9dfe

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
