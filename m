Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0135D67FF6F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 14:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjA2Njb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 08:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjA2NjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 08:39:25 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0861E9CD;
        Sun, 29 Jan 2023 05:39:24 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pM7tr-0003rM-Vi; Sun, 29 Jan 2023 14:39:16 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] arm64: dts: rockchip: align rk3399 DMC OPP table with bindings
Date:   Sun, 29 Jan 2023 14:39:09 +0100
Message-Id: <167499930029.3595793.8500719965840161860.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119124631.91080-1-krzysztof.kozlowski@linaro.org>
References: <20230119124631.91080-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 19 Jan 2023 13:46:31 +0100, Krzysztof Kozlowski wrote:
> Bindings expect certain pattern for OPP table node name and underscores
> are not allowed:
> 
>   rk3399-rock-pi-4a-plus.dtb: dmc_opp_table: $nodename:0: 'dmc_opp_table' does not match '^opp-table(-[a-z0-9]+)?$'
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: align rk3399 DMC OPP table with bindings
      commit: 65b3fb36073a1a79c0cc291281ea1e478ef388d1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
