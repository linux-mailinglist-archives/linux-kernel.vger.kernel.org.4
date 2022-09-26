Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F75E9806
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 04:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiIZCk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 22:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiIZCkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 22:40:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E72656B;
        Sun, 25 Sep 2022 19:40:00 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w2so5373246pfb.0;
        Sun, 25 Sep 2022 19:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=01csQ8DlrzSvMM7Az3qJeMprGZ73Hm/q0Ht2rfrJyG4=;
        b=SY4a1RdR15vckV/KtC0tO6/YDw465wilHSDuC20bezMsfWWp1+8ZH++YdYcyuO0fbN
         HSazgSKNBv6kHTcBb49sG7N9+pSV8+MiBC9cIWAqi0LGvbNVNBnJkwqWHu3YXpnNEaJj
         k2Z4UWEYSfGpQ462SyJZub1MY6+qLhcz6Mzo6GQysIcUonquIfsi/KSEGlwRzZ8iXffK
         wX37wgbs042yn/8ysAhi24JQEuuvURctOb9kMgaA/TKc09DP4QsvrPwKMwgO6v/IkCL/
         cy6D+Mu5bxYoO7j0S9QWYnD5R0pBqcnfByjNUgOv4GzyS+dpzrtfauD/w+tKgrp87bQ1
         PeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=01csQ8DlrzSvMM7Az3qJeMprGZ73Hm/q0Ht2rfrJyG4=;
        b=ymUEcek818vMM/o91x5tYM/zT5RDK5Y7TQ2vyDM8y5bEARMF7g/2cCWB27kv0FpsCp
         hB3bqYhrRZYGYpkKQAiPDVoaN+HkqkUTfT+QeuhqrZjBzSfpCBR26tMPckW+GllRv5lI
         /u2OPvv7aDTQK/ob8K3GUR+r4nGLkpt4Y/Eo4s8eR0m83LUYO7K22vO44G/a3AGJVj6l
         /fXMUhyujcoejNPDCGHm86oAwEQuzVgwq7Z/MuEfDIRXyuGmxxmmzxN+YviZRvJN2trU
         1jiKR2mMkHNU9rRzRaXlR85MIjVyJomFA/d3rGHemj+5dFuOEk/OypSHpJKVGFe589tI
         5w1w==
X-Gm-Message-State: ACrzQf0MKP57VJ+cMUN7WqJMlJrcrk7ZxJlAVsY9NxJBW08OVSOapIxk
        E+/hrufc2q6DYHFBoYxzVYo=
X-Google-Smtp-Source: AMsMyM4eXba6s36NqMLO4Rmjf0+6Cw0XUww09mKMuYzzzLPIq2JBC+D02MmMmtueWt7GWX+QO7OmEQ==
X-Received: by 2002:a63:191d:0:b0:434:4bb3:e016 with SMTP id z29-20020a63191d000000b004344bb3e016mr18413226pgl.133.1664159999420;
        Sun, 25 Sep 2022 19:39:59 -0700 (PDT)
Received: from localhost.localdomain ([49.216.30.246])
        by smtp.gmail.com with ESMTPSA id y3-20020aa793c3000000b005383988ec0fsm10667584pff.162.2022.09.25.19.39.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2022 19:39:58 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] Documentation: power: rt9471: Document exported sysfs entries
Date:   Mon, 26 Sep 2022 10:39:32 +0800
Message-Id: <1664159972-4391-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664159972-4391-1-git-send-email-u0084500@gmail.com>
References: <1664159972-4391-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Document the settings exported by rt9471 charger driver through sysfs entries:
- sysoff_enable
- port_detect_enable

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v6:
- Explain more details for sysoff_enable attribute.

Since v5:
- Recover all the change in sysfs-class-power.
- New a sysfs-class-power-rt9471 file.
- Remove 'charge_term_enable' sysfs entry, directly integrate it in
  'charge_term_current' power supply property control.

---
 Documentation/ABI/testing/sysfs-class-power-rt9471 | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9471

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
new file mode 100644
index 00000000..38227a8
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
@@ -0,0 +1,32 @@
+What:		/sys/class/power_supply/rt9471-*/sysoff_enable
+Date:		Oct 2022
+KernelVersion:	6.1
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry allows enabling the sysoff mode of rt9471 charger devices.
+		If enabled and the input is removed, the internal battery FET is turned
+		off to reduce the leakage from the BAT pin. See device datasheet for details.
+		It's commonly used when the product enter shipping stage. After entering
+		shipping mode, only 'VBUS' or 'Power key" pressed can make it leave this
+		mode. 'Disable' also can help to leave it, but it's more like to abort
+		the action before the device really enter shipping mode.
+
+		Access: Read, Write
+		Valid values:
+		- 1: enabled
+		- 0: disabled
+
+What:		/sys/class/power_supply/rt9471-*/port_detect_enable
+Date:		Oct 2022
+KernelVersion:	6.1
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry allows enabling the USB BC12 port detect function of rt9471 charger
+		devices. If enabled and VBUS is inserted, device will start to do the BC12
+		port detect and report the usb port type when port detect is done. See
+		datasheet for details. Normally controlled when TypeC/USBPD port integrated.
+
+		Access: Read, Write
+		Valid values:
+		- 1: enabled
+		- 0: disabled
-- 
2.7.4

