Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBFA74F29F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjGKOtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbjGKOtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:49:03 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2F5E4F;
        Tue, 11 Jul 2023 07:49:02 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qJEfX-0000LD-7M; Tue, 11 Jul 2023 16:48:47 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Christopher Obbard <chris.obbard@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Jagan Teki <jagan@edgeble.ai>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Tianling Shen <cnsztl@gmail.com>,
        kernel@collabora.com, FUKAUMI Naoki <naoki@radxa.com>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Andy Yan <andyshrk@163.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/3] Add support for Radxa ROCK 4SE
Date:   Tue, 11 Jul 2023 16:48:41 +0200
Message-Id: <168908688810.1964886.2244740186424760492.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710115025.507439-1-chris.obbard@collabora.com>
References: <20230710115025.507439-1-chris.obbard@collabora.com>
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

On Mon, 10 Jul 2023 12:50:22 +0100, Christopher Obbard wrote:
> Add support for the RK3399T-based Radxa ROCK 4SE board. This board offers
> similar peripherals and form-factor to the ROCK Pi 4B but uses the
> cost-optimised RK3399T processor (which has different a OPP table but
> otherwise minimal changes) and some other minor hardware changes between
> the Rock Pi 4B (described in the devicetree).
> 
> The first patch moves the RK3399 OPP table from the generic Radxa ROCK
> Pi 4 dtsi into board-specific devicetree files, in preparation for the
> ROCK 4SE devicetree file (in later patches).
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: Move OPP table from ROCK Pi 4 dtsi
      commit: fd2762a626461ca4d9d829431a8a7f9f8e6c3395
[2/3] dt-bindings: arm: rockchip: Add Radxa ROCK 4SE
      commit: e7afb99e8f52f24514267f5482cd2f274220b360
[3/3] arm64: dts: rockchip: Add Radxa ROCK 4SE
      commit: 86a0e14a82ea723c7b7381799f060612dc65cdf3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
