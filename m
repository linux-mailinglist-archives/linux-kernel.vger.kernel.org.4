Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448D762CB14
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiKPUf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKPUfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:35:45 -0500
Received: from smtpcmd0986.aruba.it (smtpcmd0986.aruba.it [62.149.156.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B32611C03
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:35:42 -0800 (PST)
Received: from localhost.localdomain ([146.241.88.137])
        by Aruba Outgoing Smtp  with ESMTPSA
        id vP8FomxyItoIqvP8HoagyX; Wed, 16 Nov 2022 21:35:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1668630942; bh=LENZi1b3AdNSRIltPRrfcoLFEds+tTCOlcYNoW/SI9Q=;
        h=From:To:Subject:Date:MIME-Version;
        b=kzZveuQpbjoTb8/GBgvxia4NL28LnELZ2MMwKQHQipTGfo7qQoHg3hTXqEE2YEir+
         3wa8g+sb5TgSRQWbaowP3Xze5E/yZogX1hN571iqLeednkUZ+aZimBBUweG/vZp19D
         CdUnmr6OzS6abZTtpT+shGL0Z47Pz8IU/meO1YZC6ORN4iK0Ht3WKnXZEP96Zqufn5
         G8ReeflVBpVZ4PAqWzogOCxEqCKy6EjRbz3hHD9IaPdzRNNyB2q9yKUqb4HHqFe8Qu
         RTPQAakhRgCOlT47e1Yba8QqlceVOEsTtOnKYzEp7Rzd2HJzjEqHA1eydUJDrLxpr1
         g2OGNGXfu6veg==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Subject: [PATCH v3 3/4] ARM: dts: imxrt1050: increase mmc max-frequency property
Date:   Wed, 16 Nov 2022 21:35:19 +0100
Message-Id: <20221116203520.8300-3-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116203520.8300-1-giulio.benetti@benettiengineering.com>
References: <20221116203520.8300-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPLxc4+Xt2t8YgBb40JmyUT3VUGyCD1EDKDMqrUTdVrLUcjhQyqNnH+9UHkIQL1SAbjdwLoK9DYqs4h6qX9klT7BVTUaLrnUUUbqvTSjwJH2tnqD1GA3
 3N1Gw+9QufgLCJ/LFG9HKomNLjluTT3E63bW51AhOdZnsu/sDayd22/BQO0IqnBxwnZg44zzq6HI9SFlPJkfmiz7G9xZw4rzTb9vHdWeILuJSevRAp1YzMjF
 IWf4QFCAKn3xCHgciAlyqyYNZ++oDTIyzV93VqSvsO6iOE8NKvbpMbj2sIdOtFhWmBWzPOEkI0BeyziuU6RNjHUW3JJEoIn42sGswpDlKqYYUZJtxxFYlmbO
 oICI67+p5/0vUWHuY/hlWxKTGcgF0h1Ar3rxaBdI5utvKoOb88fgZFpguU5mhblpAkCqUl/IFvDDoGEasNdvXGQm4GK1q9d5VDIj+KkrdA0KN7S1XRcKwCoF
 m+jqkEpd17QVGADOEChJbuJrBWwfHpygNNqroRU8237q+bFrbU9mzcnPSlJUY/Ri4078mXueya1s2UqRlbd9nW5TseC4EsvcI9xTghKYMw7dHb/yqu0NrMHZ
 Argohgbegnx0TPOLJJUMuj3X4Dzmx8ug1iCCjDTgRZkaLoZ2noV+ewFdsLktIS3LMxOjugrtemqg+K9JOCeQfwGDW60rj2Xxt1yMEGg6m8qS87coCMD0yTop
 ZrFjzR4khqRNMKX1rhSMkEUTpz223+CmLbj6JxZQCOmeT62wZZOnl0hP+KH6K5RchD4ZSeEFQJVL1HdR6suxm1AF77O5ifBKW0+H+gIZSUHlX/AlnKOxVA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to i.MXRT1050 Datasheet usdhc supports up to 200Mhz clock so
let's increase max-frequency property to 200Mhz.

Cc: Jesse Taube <mr.bossman075@gmail.com>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Acked-by: Jesse Taube <mr.bossman075@gmail.com>
---
V1->V2:
* nothing done
V2->V3:
* added Jesse Taube's Acked-by:
---
 arch/arm/boot/dts/imxrt1050.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imxrt1050.dtsi b/arch/arm/boot/dts/imxrt1050.dtsi
index 114465e4dde6..5b1991c32748 100644
--- a/arch/arm/boot/dts/imxrt1050.dtsi
+++ b/arch/arm/boot/dts/imxrt1050.dtsi
@@ -93,7 +93,7 @@ usdhc1: mmc@402c0000 {
 			bus-width = <4>;
 			fsl,wp-controller;
 			no-1-8-v;
-			max-frequency = <4000000>;
+			max-frequency = <200000000>;
 			fsl,tuning-start-tap = <20>;
 			fsl,tuning-step = <2>;
 			status = "disabled";
-- 
2.34.1

