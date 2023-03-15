Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39F36BA5A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjCODfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCODfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:35:15 -0400
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AD1265B7;
        Tue, 14 Mar 2023 20:35:13 -0700 (PDT)
From:   Yixun Lan <dlan@gentoo.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Yixun Lan <dlan@gentoo.org>, Nick Xie <nick@khadas.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: rockchip: Add Khadas edge2 board
Date:   Wed, 15 Mar 2023 11:34:39 +0800
Message-Id: <20230315033441.32719-1-dlan@gentoo.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch series, we will try to add basic support for 
Khadas Edge2 board, currently only UART and eMMC are enabled.
The ethernet connect to Pads expansion board via USB which will need extra
effort, so no ethernet for now.

The first patch introduce a dt-bindings for Edge2 board,
the second patch will add basic device tree.

Yixun Lan (2):
  dt-bindings: arm: rockchip: Add Khadas Edge2 board
  arm64: dts: rockchip: Add Khadas edge2 board

 .../devicetree/bindings/arm/rockchip.yaml     |  5 +++
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 37 +++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts

-- 
2.39.2

