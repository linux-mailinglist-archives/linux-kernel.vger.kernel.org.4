Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6C05BC53A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiISJWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiISJWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:22:33 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D972AE037;
        Mon, 19 Sep 2022 02:22:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay36so10872677wmb.0;
        Mon, 19 Sep 2022 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=X5muVDkWOVxzQ6wgkwwpHxHDBdSd+oJ93yCiJ8+DBQw=;
        b=HAX/dADWDZnTXUpTu/pQ+0WnU9zf9XN2Rc0kpp1WmMVD2FtKYyQSVU/DRDMHBXlVM1
         fNBbtk4MdopD+Od5m9CjSFDnr85R+eQnNl7eTiHFJTST1NEAh2NmApGajRYYxeleGvS4
         /CdtHATfRVomTOjbvDgInUiiJyCXcDwuFwvvFrkpsafO9rpGNF+Zjc0EAgmbb5ridkOB
         7USX84qp4IV3tHNyZXDEzQo/E+Xq34BHfpgWPlQNBplrYcEtw7EggBB7zKRKsV0RZ+PI
         CkAaD/joVq4TU3NORFd+jkOqfO9ZvqlZaI6+sn9+OfsRAqyodpxG1lDYZX5Yw/jM1svq
         eh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=X5muVDkWOVxzQ6wgkwwpHxHDBdSd+oJ93yCiJ8+DBQw=;
        b=2IkG1UlzcY22rB/FgTkPsw7hCCI1nffft10hHYDoiIV9fEszSHp56neGM0txw3e7vw
         SxvOrOKvUR4ZN4nySzCx02hdE4w7NzwICPNqUBq6R+LBcq39Wo/9xd9gWOqSLNCifLBY
         LeyGUnVyrwROSi9l9gMvatMV/MgEvrPekmQw8DqZjXhylYZzo1fKhTmKkQ5cC57YK7T9
         Y0oh4PuVX1SB2AvbS6xNJgckotMO8WAOYkJOROPY9fe4cRUNKFUuOTAaQxBKcW0B8m3Z
         Pj6PLjK6cJgMcAlxDjE3W7njt6+VT63+ZhxmJw5jXT3Agzu3Dk0PqEvRiF65ktBVtkYu
         tq0w==
X-Gm-Message-State: ACrzQf3bdtp98Ee4rBzyrwBsPFkTEeWlJz0DfR7XqJEv934/No3Lyhvy
        N0vVJIQrM7OfVmpejbxNdCg=
X-Google-Smtp-Source: AMsMyM5mgfLPwqf2mn6UC7ZoonhS/2BI8Ibv0grWvch38W4Mz8Vz/TOc8EqiKkvCDCcF3afXSbK/xA==
X-Received: by 2002:a7b:cc15:0:b0:3b4:ca90:970d with SMTP id f21-20020a7bcc15000000b003b4ca90970dmr6257630wmh.198.1663579350336;
        Mon, 19 Sep 2022 02:22:30 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:453:ec29:bd55:6b15])
        by smtp.gmail.com with ESMTPSA id b11-20020adfd1cb000000b00225239d9265sm7754130wrd.74.2022.09.19.02.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 02:22:29 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] arm64: dts: renesas: rzg2lc-smarc: Include SoM DTSI into board DTS
Date:   Mon, 19 Sep 2022 10:21:30 +0100
Message-Id: <20220919092130.93074-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Move including the rzg2lc-smarc-som.dtsi from the carrier board
rzg2lc-smarc.dtsi to the actual RZ/G2LC SMARC EVK board dts
r9a07g044c2-smarc.dts. Also move the SW1 related macros along with
PMOD1_SER0 to board dts so that we have all the configuration options
in the same file.

This patch is to keep consistency with other SMARC EVKs (RZ/G2L, RZ/G2UL)
and it makes sense not include the SoM into the carrier board as we might
in future have a different carrier board with the same SoM.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../boot/dts/renesas/r9a07g044c2-smarc.dts    | 30 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi | 28 -----------------
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
index fc34058002e2..f67a6f125d9c 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
@@ -6,7 +6,37 @@
  */
 
 /dts-v1/;
+
+/*
+ * DIP-Switch SW1 setting on SoM
+ * 1 : High; 0: Low
+ * SW1-2 : SW_SD0_DEV_SEL	(1: eMMC; 0: uSD)
+ * SW1-3 : SW_SCIF_CAN		(1: CAN1; 0: SCIF1)
+ * SW1-4 : SW_RSPI_CAN		(1: CAN1; 0: RSPI1)
+ * SW1-5 : SW_I2S0_I2S1		(1: I2S2 (HDMI audio); 0: I2S0)
+ * Please change below macros according to SW1 setting
+ */
+
+#define SW_SD0_DEV_SEL	1
+
+#define SW_SCIF_CAN	0
+#if (SW_SCIF_CAN)
+/* Due to HW routing, SW_RSPI_CAN is always 0 when SW_SCIF_CAN is set to 1 */
+#define SW_RSPI_CAN	0
+#else
+/* Please set SW_RSPI_CAN. Default value is 1 */
+#define SW_RSPI_CAN	1
+#endif
+
+#if (SW_SCIF_CAN && SW_RSPI_CAN)
+#error "Can not set 1 to both SW_SCIF_CAN and SW_RSPI_CAN due to HW routing"
+#endif
+
+/* comment the #define statement to disable SCIF1 (SER0) on PMOD1 (CN7) */
+#define PMOD1_SER0	1
+
 #include "r9a07g044c2.dtsi"
+#include "rzg2lc-smarc-som.dtsi"
 #include "rzg2lc-smarc.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
index 6be25a8a28db..b6bd27196d88 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
@@ -8,37 +8,9 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
-/*
- * DIP-Switch SW1 setting on SoM
- * 1 : High; 0: Low
- * SW1-2 : SW_SD0_DEV_SEL	(1: eMMC; 0: uSD)
- * SW1-3 : SW_SCIF_CAN		(1: CAN1; 0: SCIF1)
- * SW1-4 : SW_RSPI_CAN		(1: CAN1; 0: RSPI1)
- * SW1-5 : SW_I2S0_I2S1		(1: I2S2 (HDMI audio); 0: I2S0)
- * Please change below macros according to SW1 setting
- */
-
-#define SW_SD0_DEV_SEL	1
-
-#define SW_SCIF_CAN	0
-#if (SW_SCIF_CAN)
-/* Due to HW routing, SW_RSPI_CAN is always 0 when SW_SCIF_CAN is set to 1 */
-#define SW_RSPI_CAN	0
-#else
-/* Please set SW_RSPI_CAN. Default value is 1 */
-#define SW_RSPI_CAN	1
-#endif
-
-#if (SW_SCIF_CAN && SW_RSPI_CAN)
-#error "Can not set 1 to both SW_SCIF_CAN and SW_RSPI_CAN due to HW routing"
-#endif
-
-#include "rzg2lc-smarc-som.dtsi"
 #include "rzg2lc-smarc-pinfunction.dtsi"
 #include "rz-smarc-common.dtsi"
 
-/* comment the #define statement to disable SCIF1 (SER0) on PMOD1 (CN7) */
-#define PMOD1_SER0	1
 
 / {
 	aliases {
-- 
2.25.1

