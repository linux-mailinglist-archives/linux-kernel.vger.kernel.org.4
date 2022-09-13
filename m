Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A145B66E0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiIME0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiIMEZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:25:48 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC05957E17;
        Mon, 12 Sep 2022 21:23:00 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 13 Sep 2022 13:22:54 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 2670E20584CE;
        Tue, 13 Sep 2022 13:22:54 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Sep 2022 13:22:54 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id A8DF0B62A4;
        Tue, 13 Sep 2022 13:22:53 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 8/9] ARM: dts: uniphier: Move interrupt-parent property to each child node in uniphier-support-card
Date:   Tue, 13 Sep 2022 13:22:48 +0900
Message-Id: <20220913042249.4708-9-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913042249.4708-1-hayashi.kunihiko@socionext.com>
References: <20220913042249.4708-1-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dtschema warning:
  uniphier-ld11-ref.dt.yaml: system-bus@58c00000: 'interrupt-parent' does not
  match any of the regexes: '^.*@[1-5],[1-9a-f][0-9a-f]+$', 'pinctrl-[0-9]+'

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-support-card.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/uniphier-support-card.dtsi b/arch/arm/boot/dts/uniphier-support-card.dtsi
index 444802fee9fb..97e7d5db8eb8 100644
--- a/arch/arm/boot/dts/uniphier-support-card.dtsi
+++ b/arch/arm/boot/dts/uniphier-support-card.dtsi
@@ -8,13 +8,13 @@
 &system_bus {
 	status = "okay";
 	ranges = <1 0x00000000 0x42000000 0x02000000>;
-	interrupt-parent = <&gpio>;
 
 	ethsc: ethernet@1,1f00000 {
 		compatible = "smsc,lan9118", "smsc,lan9115";
 		reg = <1 0x01f00000 0x1000>;
 		phy-mode = "mii";
 		reg-io-width = <4>;
+		interrupt-parent = <&gpio>;
 	};
 
 	serialsc: serial@1,1fb0000 {
@@ -22,5 +22,6 @@ serialsc: serial@1,1fb0000 {
 		reg = <1 0x01fb0000 0x20>;
 		clock-frequency = <12288000>;
 		reg-shift = <1>;
+		interrupt-parent = <&gpio>;
 	};
 };
-- 
2.25.1

