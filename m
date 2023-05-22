Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AE370B932
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjEVJil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjEVJic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:38:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358B4FD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684748287; x=1716284287;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/Xeh6MC2bHWJ3JrwjlgkwhiH2KNsjV1ulsMTAFwTvBk=;
  b=rv83skDxw9VTyuF8ZdXkTHDwsvAbFsA8QHHV5QMbs6D5X9MzUzf1UH41
   JkIrhbXn/CSUq4Rtb2Uw7REAMGaV1mHRe/36/724CukQ6f6dO6o+6uQBc
   vsr54fbFlj+rehxAvERmvYmsq4ugcOAJ23ESt8Fz+Pux67RhCCh8rvToI
   IfLFcXGV4T8pg0P49X42T8OLe+2QwZCdRPmN0FvTfA1id/gs+VnHK7icv
   JCLFKwi8C03SblI/htPfjzcLenSgvu3byzsfvCj/Uy/aD8kYnC4oOuk9R
   cJ2r744DdcxKuCOIkxoj9EsywK2MZMuPriVP4aGou3V+yJgv5xg977o4N
   w==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="216613248"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 02:38:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 02:37:59 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 02:37:57 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <soc@kernel.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH v2] MAINTAINERS: update arm64 Microchip entries
Date:   Mon, 22 May 2023 10:37:01 +0100
Message-ID: <20230522-wagon-stencil-a164ec39322a@wendy>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2204; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=/Xeh6MC2bHWJ3JrwjlgkwhiH2KNsjV1ulsMTAFwTvBk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnZ5rv1pF4XHzA41PPgSVhe9nGZ/hV5V003vJpouF34xdUH v44xdpSwMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiiSUMX+XuZHkvusPftHDZRJkQTk 9Nxx0yzd5ifFKTGqbHmh4qYGQ42tL/qOfWa/1f3i8X/w8p21bO0NPyafHmDRu+Kkz2POTMBAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof noticed that patches for arch/arm64/boot/dts/microchip were
getting lost & the listed tree was inactive.

Nicolas and I are willing to shepherd patches to Arnd, using the
existing at91 tree, so add a new entry covering
arch/arm64/boot/dts/microchip, listing us as maintainers.

Drop the tree from the existing sparx5 entry & narrow the devicetree
pattern to just sparx devices, leaving Lars, Steen and Daniel looking
after support for their SoCs.

CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Conor Dooley <conor@kernel.org>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Claudiu Beznea <claudiu.beznea@microchip.com>
CC: soc@kernel.org
CC: Lars Povlsen <lars.povlsen@microchip.com>
CC: Steen Hegelund <Steen.Hegelund@microchip.com>
CC: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
- add Claudiu
---
 MAINTAINERS | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3182992769aa..9ae07caa4e6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2433,6 +2433,15 @@ X:	drivers/net/wireless/atmel/
 N:	at91
 N:	atmel
 
+ARM/MICROCHIP (ARM64) SoC support
+M:	Conor Dooley <conor@kernel.org>
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
+F:	arch/arm64/boot/dts/microchip/
+
 ARM/Microchip Sparx5 SoC support
 M:	Lars Povlsen <lars.povlsen@microchip.com>
 M:	Steen Hegelund <Steen.Hegelund@microchip.com>
@@ -2440,8 +2449,7 @@ M:	Daniel Machon <daniel.machon@microchip.com>
 M:	UNGLinuxDriver@microchip.com
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
-T:	git git://github.com/microchip-ung/linux-upstream.git
-F:	arch/arm64/boot/dts/microchip/
+F:	arch/arm64/boot/dts/microchip/sparx*
 F:	drivers/net/ethernet/microchip/vcap/
 F:	drivers/pinctrl/pinctrl-microchip-sgpio.c
 N:	sparx5
-- 
2.39.2

