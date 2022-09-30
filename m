Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804B65F07E5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiI3Jpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiI3JpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:45:24 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698534BA65;
        Fri, 30 Sep 2022 02:45:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so8545329pjh.2;
        Fri, 30 Sep 2022 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=01csQ8DlrzSvMM7Az3qJeMprGZ73Hm/q0Ht2rfrJyG4=;
        b=Wyv2QVOiUxQayzYZmso8eCNs6aXJ+rt009E2YoWJiW+iJci2hy0oJ00fWBHnUy02k4
         jo7R7De7gjwD4DNEfZ1ucHtQZJGyRHYy+ed6BaBMcaLK17K4BAh3sjhtlhofxEFDWSr1
         Loabtj5CJrK3ECbt1d7bMUIOrGXNfmch6CIpRuE63YFSAtQhZZACrA86BIwrwBRjEQ7S
         voG0GQquxkk+u8sWLShHRQFnthCyDnHUGVGqiQjaYRI+l1FDaugd0pHwUBOUvIqacIq1
         hg8kcWaInapbnz27HU/ZE6u3m7lPq1WDmk1LJv1GCEJG35lUr3/Y4QWeiiyou0yBCNjQ
         qx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=01csQ8DlrzSvMM7Az3qJeMprGZ73Hm/q0Ht2rfrJyG4=;
        b=WC8HJqlBVgAgfxnOqnXjpY1MegS/D3YhPbMtXhb/SjQsh41CVMZInVSvwukO98MO+6
         e5g58YQPFwoRTVPSFNC1s6zGoQE9PTn3DxhPNGcLC7KV9JTlAkegzPE1njnLdJmM9ktH
         JeiELdI2LGJIlK4rJxTjQ+9EkPwt38YnJnxE1ciA/EuNX24AzQpnZIBMcWeRGWYJkVs0
         6aLIyJDhRd/5gYPJGDeoeA/pzLfJ9DhNkLXaoTnMibdmZL/FdU1MpGnkhfNgiUsEfPQU
         DCIh/DN/18PtJB466hS8lE/NqyDhpQjuuqkm/UstF7QDVgYF5xIQMMce674bDNoJovG2
         MmmA==
X-Gm-Message-State: ACrzQf1yr8dUdfqP5uxaILmEPHwYh1J30yGfX1zPtQUFv6yzfg5pd1kL
        6rrdTKzE90XuEQd3Anjr1zw=
X-Google-Smtp-Source: AMsMyM7+M6z3xsySa9uNc4Ve0DDMYVrM1hZ0ipQxCygJzT9uDub59ZfDhCauAucihHL9aqBNsA4zPw==
X-Received: by 2002:a17:902:ecc2:b0:178:1313:afc3 with SMTP id a2-20020a170902ecc200b001781313afc3mr8061981plh.139.1664531112173;
        Fri, 30 Sep 2022 02:45:12 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:579:1b3a:4d22:d83a:1d4a:43f1])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b0016dc78d0153sm1398051plk.296.2022.09.30.02.45.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2022 02:45:11 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/3] Documentation: power: rt9471: Document exported sysfs entries
Date:   Fri, 30 Sep 2022 17:44:39 +0800
Message-Id: <1664531079-15915-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664531079-15915-1-git-send-email-u0084500@gmail.com>
References: <1664531079-15915-1-git-send-email-u0084500@gmail.com>
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

