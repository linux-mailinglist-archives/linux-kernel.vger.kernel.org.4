Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051755BABFD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIPLG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiIPLF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:05:58 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D854F6B2;
        Fri, 16 Sep 2022 03:58:51 -0700 (PDT)
Received: from [89.101.193.72] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oZ93U-0002Gh-Oy; Fri, 16 Sep 2022 12:58:44 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     Heiko Stuebner <heiko@sntech.de>, jbx6244@gmail.com,
        linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        devicetree@vger.kernel.org, david@ixit.cz,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: add i2s0 I2S/PDM/TDM 8ch controller to px30
Date:   Fri, 16 Sep 2022 12:58:43 +0200
Message-Id: <166332591117.210113.10532001908680538652.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916091746.35108-1-foss+kernel@0leil.net>
References: <20220916091746.35108-1-foss+kernel@0leil.net>
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

On Fri, 16 Sep 2022 11:17:46 +0200, Quentin Schulz wrote:
> The Rockchip PX30 SoC has three I2S controllers, i2s1 and i2s2 are
> 2-channel I2S/PCM controllers handled by the same controller driver, and
> i2s0 a 8-channel I2S/PCM/TDM controller handled by another controller
> driver.
> 
> This adds the device tree node required to enable I2S0 on PX30.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: add i2s0 I2S/PDM/TDM 8ch controller to px30
      commit: 27c92c60d1e6d37e2c34fc18e1e36186fade2186

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
