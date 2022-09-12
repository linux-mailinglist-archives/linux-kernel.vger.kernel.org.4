Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403185B552E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiILHRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiILHRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:17:00 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 959C730544;
        Mon, 12 Sep 2022 00:16:06 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 12 Sep 2022 16:15:59 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 63B6220584CE;
        Mon, 12 Sep 2022 16:15:59 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 12 Sep 2022 16:15:59 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 02DA4B62A4;
        Mon, 12 Sep 2022 16:15:58 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 8/9] arm64: dts: uniphier: Remove compatible "snps,dw-pcie" from pcie node
Date:   Mon, 12 Sep 2022 16:15:53 +0900
Message-Id: <20220912071554.1480-9-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220912071554.1480-1-hayashi.kunihiko@socionext.com>
References: <20220912071554.1480-1-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic platform driver pcie-designware-plat.c doesn't work for
UniPhier PCIe host controller, because the controller has some
necessary initialization sequence for the controller-specific logic.

Currently the controller doesn't use "snps,dw-pcie" compatible,
so this is no longer needed. Remove the compatible string from the
pcie node.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 0d75a90d1342..e24784e12b7b 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -896,7 +896,7 @@ usb_ssphy1: ss-phy@310 {
 		};
 
 		pcie: pcie@66000000 {
-			compatible = "socionext,uniphier-pcie", "snps,dw-pcie";
+			compatible = "socionext,uniphier-pcie";
 			status = "disabled";
 			reg-names = "dbi", "link", "config";
 			reg = <0x66000000 0x1000>, <0x66010000 0x10000>,
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index f49a8db3e918..6277be04a974 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -873,7 +873,7 @@ usb1_ssphy0: ss-phy@300 {
 		};
 
 		pcie: pcie@66000000 {
-			compatible = "socionext,uniphier-pcie", "snps,dw-pcie";
+			compatible = "socionext,uniphier-pcie";
 			status = "disabled";
 			reg-names = "dbi", "link", "config";
 			reg = <0x66000000 0x1000>, <0x66010000 0x10000>,
-- 
2.25.1

