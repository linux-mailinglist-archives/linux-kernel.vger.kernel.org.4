Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3D463D55D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiK3MSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiK3MSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:18:06 -0500
X-Greylist: delayed 322 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 04:18:03 PST
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43F7F192B8;
        Wed, 30 Nov 2022 04:18:03 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id 246875DE3E;
        Wed, 30 Nov 2022 13:12:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669810329;
        bh=mbWc09qzvq+TsmeKSXKlW9F4y+FGW/fHcrpI/xzbG2Y=;
        h=From:To:CC:Subject:Date:From;
        b=JkTHmZoQ/3vbGL8WmJeJQtbUNTpFIKpMNr6l1TdVUljcYPT177Qc8j3KfjTOKCMwl
         Ly3WQwI6o9aZivrktgLec2wQQhm8ib0IySiOmRUixssjNIlEfCDPriESRFKPS573q3
         ob23A87GwMvAYqsEEM3sMxk4eE/M2bSugjdNkIjb2/BnWSfDzFA6YPT2CzixXhUutz
         Rqy9NhYsKcyug1b/REq4Eh9hy2Tn1k5t1LJZ74wSkhuiX36lO0BOfwq1C8KpKl2Bq+
         m+0F9/R69I5SJdiAihKF7tX/bk0n0kXEG9oc5J+fzjDOMYwIjlaaMO+NGalLg5pwiO
         PO2GXQXUor5iw==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 30 Nov 2022 13:11:50 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Wed, 30 Nov 2022 13:11:50 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, <kernel@dh-electronics.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V3] dt-bindings: mmc: Remove comment on wakeup-source property
Date:   Wed, 30 Nov 2022 13:10:33 +0100
Message-ID: <20221130121033.7270-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current comment on wakeup-source is a little confusing because
the word deprecated can be interpreted at first glance to mean that
wakeup-source is deprecated. Also mentioning the obsolete property
confuses more than it helps. Therefore, the comment should be removed
completely because the enable-sdio-wakeup property is not used in
any current DTs. Also remove enable-sdio-wakeup reference in
wakeup-source.txt

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org
To: linux-kernel@vger.kernel.org
---
V2: - Instead of changing the comment, remove it
V3: - Remove also reference in power/wakeup-source.txt
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml |  1 -
 Documentation/devicetree/bindings/power/wakeup-source.txt | 13 ++++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 802e3ca8be4d..e82c00368088 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -293,7 +293,6 @@ properties:
     description:
       SDIO only. Preserves card power during a suspend/resume cycle.
 
-  # Deprecated: enable-sdio-wakeup
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
diff --git a/Documentation/devicetree/bindings/power/wakeup-source.txt b/Documentation/devicetree/bindings/power/wakeup-source.txt
index cfd74659fbed..697333a56d5e 100644
--- a/Documentation/devicetree/bindings/power/wakeup-source.txt
+++ b/Documentation/devicetree/bindings/power/wakeup-source.txt
@@ -17,15 +17,14 @@ interrupt.
 List of legacy properties and respective binding document
 ---------------------------------------------------------
 
-1. "enable-sdio-wakeup"		Documentation/devicetree/bindings/mmc/mmc.txt
-2. "gpio-key,wakeup"		Documentation/devicetree/bindings/input/gpio-keys{,-polled}.txt
-3. "has-tpo"			Documentation/devicetree/bindings/rtc/rtc-opal.txt
-4. "linux,wakeup"		Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
+1. "gpio-key,wakeup"		Documentation/devicetree/bindings/input/gpio-keys{,-polled}.txt
+2. "has-tpo"			Documentation/devicetree/bindings/rtc/rtc-opal.txt
+3. "linux,wakeup"		Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
 				Documentation/devicetree/bindings/mfd/tc3589x.txt
 				Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
-5. "linux,keypad-wakeup"	Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
-6. "linux,input-wakeup"		Documentation/devicetree/bindings/input/samsung-keypad.txt
-7. "nvidia,wakeup-source"	Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
+4. "linux,keypad-wakeup"	Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
+5. "linux,input-wakeup"		Documentation/devicetree/bindings/input/samsung-keypad.txt
+6. "nvidia,wakeup-source"	Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
 
 Examples
 --------
-- 
2.11.0

