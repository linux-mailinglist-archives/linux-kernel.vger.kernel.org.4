Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB5174F020
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjGKN3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjGKN3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:29:50 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7569A10D2;
        Tue, 11 Jul 2023 06:29:43 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qJDQu-0008E7-Oc; Tue, 11 Jul 2023 15:29:36 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        kernel@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/13] Improve Rock 5A Device Tree
Date:   Tue, 11 Jul 2023 15:29:35 +0200
Message-Id: <168908206875.1895326.643066920213723100.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710165228.105983-1-sebastian.reichel@collabora.com>
References: <20230710165228.105983-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 18:52:15 +0200, Sebastian Reichel wrote:
> This brings Rock 5A on par with the Rock 5B. All necessary driver
> changes have already been merged.
> 
> -- Sebastian
> 
> Lucas Tanure (1):
>   arm64: dts: rockchip: rock-5a: add SD card support
> 
> [...]

Applied, thanks!

After talking with Arnd on IRC, I also picked the two binding patches
for the eeprom.

I also fixed a number of nits when applying:
- "-regulator" suffix was missing on most added fixed regulators
- one regulator@42 was instead a rk6*@42
- some ordering issues


[01/13] dt-bindings: vendor-prefixes: Add prefix for belling
        commit: 3dc9c73e65fbe1d8b4762b2ef763d8f5941e87bb
[02/13] dt-bindings: at24: add Belling BL24C16A
        commit: 892e989559c7352cd8cacc95729aa6d5bf63b897
[03/13] arm64: dts: rockchip: rock-5a: add PMIC
        commit: 75fdcbc8f4c1557545aaabe3f3d41a7337a1ffd8
[04/13] arm64: dts: rockchip: rock-5a: add vdd_cpu_big regulators
        commit: 4bbca5c7f4f0175c95588709535e3466a936dd2e
[05/13] arm64: dts: rockchip: rock-5a: add 5V regulator
        commit: 53bf040e14c0245711a3cae6f3259e589ac8171b
[06/13] arm64: dts: rockchip: rock-5a: add SD card support
        commit: ea3e66e7ad0d8ca1a4248a55e235fa27817ac3da
[07/13] arm64: dts: rockchip: rock-5a: add status LED
        commit: db02f866b140dc04eb13da8bc8d9b1e36232102c
[08/13] arm64: dts: rockchip: rock-5a: add analog audio
        commit: fb031e6275fc165100a2bf65d630872b89a97c08
[09/13] arm64: dts: rockchip: rock-5a: add I2C EEPROM
        commit: 89c880808cff8bc6f1ea6e1b5edc603e6232310e
[10/13] arm64: dts: rockchip: rock-5a: add vdd_npu_s0 regulator
        commit: afc3925f694a1a16f38ce66dfc7dcf88cc77b8ee
[11/13] arm64: dts: rockchip: rock-5a: enable I2C interface from DSI and CSI connectors
        commit: aa00cf88bd8c5ac22f4da9ae390790268b111f97
[12/13] arm64: dts: rockchip: rock-5a: add ADC
        commit: 43465c67518c3d2e6293e9d97e577de434ad682b
[13/13] arm64: dts: rockchip: rock-5a: add fan support
        commit: dd4464ecced6f07b0e62f67752928d1424883dee

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
