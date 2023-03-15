Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DE76BAA1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCOHzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjCOHyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:54:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C2216AC5;
        Wed, 15 Mar 2023 00:54:49 -0700 (PDT)
Received: from [46.183.103.17] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pcLy1-00079f-1K; Wed, 15 Mar 2023 08:54:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Yixun Lan <dlan@gentoo.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christopher Obbard <chris.obbard@collabora.com>,
        Nick Xie <nick@khadas.com>,
        linux-arm-kernel@lists.infradead.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: rockchip: Add Khadas edge2 board
Date:   Wed, 15 Mar 2023 08:54:23 +0100
Message-Id: <167886685398.704797.419468948077719416.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230315033441.32719-1-dlan@gentoo.org>
References: <20230315033441.32719-1-dlan@gentoo.org>
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

On Wed, 15 Mar 2023 11:34:39 +0800, Yixun Lan wrote:
> In this patch series, we will try to add basic support for
> Khadas Edge2 board, currently only UART and eMMC are enabled.
> The ethernet connect to Pads expansion board via USB which will need extra
> effort, so no ethernet for now.
> 
> The first patch introduce a dt-bindings for Edge2 board,
> the second patch will add basic device tree.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add Khadas Edge2 board
      commit: 5a6d76761225bfa31d114f434b990fa2ed9b04c5
[2/2] arm64: dts: rockchip: Add Khadas edge2 board
      commit: 04d5529935229a709d6facb8a80168cc0976c89a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
