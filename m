Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37562668E51
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjAMGwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjAMGv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:51:27 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51DE87F458;
        Thu, 12 Jan 2023 22:35:22 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(16475:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Fri, 13 Jan 2023 14:34:44 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 13 Jan
 2023 14:34:43 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Fri, 13 Jan 2023 14:34:43 +0800
From:   <cy_huang@richtek.com>
To:     <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <allen_chiang@richtek.com>, <cy_huang@richtek.com>,
        <u0084500@gmail.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v3 3/3] Documentation: power: rt9759: Document exported sysfs entries
Date:   Fri, 13 Jan 2023 14:34:42 +0800
Message-ID: <1673591682-25789-4-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673591682-25789-1-git-send-email-cy_huang@richtek.com>
References: <1673591682-25789-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Document the settings exported by rt9759 charger driver through sysfs
entries:

- watchdog_timer
- battery_voltage
- battery_current

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v3:
No change

Since v2:
- Change ABI document date from Oct 2022 to Nov 2022 and KernelVersion
  from 6.1 to 6.2

---
 Documentation/ABI/testing/sysfs-class-power-rt9759 | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9759

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9759 b/Documentation/ABI/testing/sysfs-class-power-rt9759
new file mode 100644
index 00000000..8a7258f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9759
@@ -0,0 +1,37 @@
+What:		/sys/class/power_supply/rt9759-*/watchdog_timer
+Date:		Nov 2022
+KernelVersion:	6.2
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry shows and sets the watchdog timer when rt9759 charger
+		operates in charging mode. When the timer expires, the device
+		will disable the charging. To prevent the timer expires, any
+		host communication can make the timer restarted.
+
+		Access: Read, Write
+
+		Valid values:
+		- 500, 1000, 5000 or 30000 (milliseconds),
+		- 0: disabled
+
+What:		/sys/class/power_supply/rt9759-*/battery_voltage
+Date:		Nov 2022
+KernelVersion:	6.2
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		Reports the current BAT voltage.
+
+		Access: Read-Only
+
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/rt9759-*/battery_current
+Date:		Nov 2022
+KernelVersion:	6.2
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		Reports the current BAT current.
+
+		Access: Read-Only
+
+		Valid values: Represented in microamps
-- 
2.7.4

