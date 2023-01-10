Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963136642BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbjAJOFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjAJOEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:04:46 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54D050F58;
        Tue, 10 Jan 2023 06:04:44 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pFFF5-0004vx-4K; Tue, 10 Jan 2023 15:04:43 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Yuteng Zhong <zonyitoo@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wenhao Cui <lasstp5011@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v9 1/3] arm64: dts: rockchip: Add EmbedFire LubanCat 1
Date:   Tue, 10 Jan 2023 15:04:39 +0100
Message-Id: <167335938203.2550251.11515354599498861656.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Y6UdjhBD/Xa7ALya@VM-66-53-centos>
References: <Y6UdjhBD/Xa7ALya@VM-66-53-centos>
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

On Fri, 23 Dec 2022 11:16:30 +0800, Yuteng Zhong wrote:
> From: Wenhao Cui <lasstp5011@gmail.com>
> 
> The LubanCat 1 is a RK3566 based SBC, developed by Dongguan EmbedFire
> Electronic Technology Co., Ltd.
> 
> It has the following characteristics:
> - MicroSD card slot, onboard eMMC flash memory
> - 1GbE Realtek RTL8211F Ethernet Transceiver
> - 1 USB Type-C port (power and USB2.0 OTG)
> - 1 USB 3.0 Host port
> - 3 USB 2.0 Host ports
> - 1 HDMI
> - 1 infrared receiver
> - 1 MIPI DSI
> - 1 MIPI CSI
> - 1 x 4-section headphone jack
> - Mini PCIe socket (USB or PCIe)
> - 1 SIM Card slot
> - 1 SYS LED and 1 PWR LED
> - 40-pin GPIO expansion header
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: Add EmbedFire LubanCat 1
      commit: 8d94da58de534634c835f22a43070f56caa2fcb6
[2/3] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 1
      commit: 1e83f6bfaf84d9e0bcb221304bb47e74c0e80924
[3/3] dt-bindings: vendor-prefixes: Document EmbedFire
      commit: 43ba22818788f5a8fff5b1feaa329fa4991a3225

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
