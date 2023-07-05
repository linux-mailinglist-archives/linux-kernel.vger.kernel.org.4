Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9570C7485B0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjGEOKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGEOK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:10:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3F4E57;
        Wed,  5 Jul 2023 07:10:28 -0700 (PDT)
Received: from obbardc-t14.home (unknown [IPv6:2a00:23c8:b70a:ae01:7599:ed26:1798:f430])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F2C3B6601F5E;
        Wed,  5 Jul 2023 15:10:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688566227;
        bh=y0Ghe9koICkN/RpJzROtFUmgT0UnN61Nopi/vdGHi5c=;
        h=From:To:Cc:Subject:Date:From;
        b=BxqEg2BidsL4JQgj2HaFCORG8pylLXX+9b3F5qjWGa2cl12kvYjrjKSA2lOr1AvWD
         3koGNDg/GI01yi4W59UQsAjhheQWQJtflBVgRQfvDxHFRwFCLEvuoOOMox6KIwIsiD
         qgs3ghfsR0ACx+IoaW+jibfqmmQEk23pxcjC3jmqAvucncUqra5WEO16/Og7RW385s
         /EfDNY6VZ2hQ9/dU/No9gTc3HFBAb7aaFVOXOLzQKK0Gh6kWiMNgliMat37E3GtJrR
         PMBKTwtLYm0PmpczSxqKShGsj4B8ZBGPlPolhsHKnK6M0Ldg18DX2dUc9gqdNxPKG4
         P6HogS4purCWw==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>, Andy Yan <andyshrk@163.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Conor Dooley <conor+dt@kernel.org>,
        FUKAUMI Naoki <naoki@radxa.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Add support for Radxa ROCK 4SE
Date:   Wed,  5 Jul 2023 15:10:08 +0100
Message-Id: <20230705141011.111568-1-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the RK3399T-based Radxa ROCK 4SE board. This board offers
similar peripherals and form-factor to the ROCK Pi 4B but uses the
cost-optimised RK3399T processor (which has different a OPP table but
otherwise minimal changes) and some other minor hardware changes between
the Rock Pi 4B (described in the devicetree).

The first patch moves the RK3399 OPP table from the generic Radxa ROCK
Pi 4 dtsi into board-specific devicetree files, in preparation for the
ROCK 4SE devicetree file (in later patches).

The second patch adds the devicetree binding documentation for the Radxa
ROCK 4SE.

The third patch adds the board-specific devicetree file for the Radxa ROCK
4SE.


Christopher Obbard (3):
  arm64: dts: rockchip: Move OPP table from ROCK Pi 4 dtsi
  dt-bindings: arm: rockchip: Add Radxa ROCK 4SE
  arm64: dts: rockchip: Add Radxa ROCK 4SE

 .../devicetree/bindings/arm/rockchip.yaml     |  5 ++
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3399-rock-4se.dts     | 65 +++++++++++++++++++
 .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   |  1 -
 .../boot/dts/rockchip/rk3399-rock-pi-4a.dts   |  1 +
 .../boot/dts/rockchip/rk3399-rock-pi-4b.dts   |  1 +
 .../boot/dts/rockchip/rk3399-rock-pi-4c.dts   |  1 +
 7 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dts

-- 
2.40.1

