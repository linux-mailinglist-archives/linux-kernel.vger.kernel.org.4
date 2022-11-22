Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A23634A13
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiKVWe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiKVWeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:34:22 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8032C75AE;
        Tue, 22 Nov 2022 14:34:20 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oxbqJ-0004DQ-Ji; Tue, 22 Nov 2022 23:34:15 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>,
        linux-rockchip@lists.infradead.org
Subject: Re: (subset) [linux-next-v2 1/5] arm64: dts: rockchip: Fix gmac phy mode to rgmii on Rock 3A SBC.
Date:   Tue, 22 Nov 2022 23:34:11 +0100
Message-Id: <166915627083.1689466.10618700392262605965.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221116200150.4657-2-linux.amoon@gmail.com>
References: <20221116200150.4657-1-linux.amoon@gmail.com> <20221116200150.4657-2-linux.amoon@gmail.com>
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

On Wed, 16 Nov 2022 20:01:43 +0000, Anand Moon wrote:
> On rk356x ethernet phy support reduced media independent interface (RMII)
> and reduced gigabit media independent interface (RGMII).
> So set the phy mode to rgmii to support clock delay, also
> add TX and RX delay for phy-mode.
> 
> Fix following warning
> 
> [...]

Applied, thanks!

[2/5] arm64: dts: rockchip: Add support of external clock to ethernet node on Rock 3A SBC
      commit: ef9f4b4a50206bedd931f45dd9fd57fd4c1714a6
[3/5] arm64: dts: rockchip: Add support of regulator for ethernet node on Rock 3A SBC
      commit: 79aa02ddc682558edb9bd56522ad841759c99201

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
