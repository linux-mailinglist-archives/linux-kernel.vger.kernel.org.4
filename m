Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4415F0E12
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiI3OxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiI3Owi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:52:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8005DEDE8A;
        Fri, 30 Sep 2022 07:50:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d24so4185364pls.4;
        Fri, 30 Sep 2022 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=01csQ8DlrzSvMM7Az3qJeMprGZ73Hm/q0Ht2rfrJyG4=;
        b=D4WGRMS8RpYnAAA1t62rHLemKlklRH1lkMdUNNr2bDHFXk2L0mAIr3ri/pVbB27yZe
         lyiw+iy6jEf4DiGhi0b4u7ZsWaIZBcGCk289IQyXUNqcAY0dcQmLmZn3A3kmVwnZ/ojZ
         sKN1dTCjam/XLomTDtBIaKMKgGbpfEj8g8HSrqRV8smEsVM6ja+aAQiaK5m/eH9b+baU
         xREEPj0cJZLIEqVV56iVOXXC9X1hTA2CkJs2uAjLUtr+phk55dGgFHtjerQoQDRYWI3C
         GqpVY1ZR+SdDajedaMDreHus1fjezdcFnRCpSNj7FjbXJjT4EMfsPiRdecxBdwn5u4L2
         UFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=01csQ8DlrzSvMM7Az3qJeMprGZ73Hm/q0Ht2rfrJyG4=;
        b=d9RBoXMsDyA11RHxVYxXqtQaJz7i2wNHt0fiH0JWzUcYbf1UfMWK+KuQ7BlK/Gzvyi
         mc5qDwUfouAz0kJkMo3+RH+S5cX9TmvS6RjBTA4JFgsc0syTtL8GhGURKaSVsZ0upaTD
         PwfBfu5OER27osUwTk0l0NA3KyueKQylM7brGfGFWPQ5rV/BegTwRh/BStTSkZGHvAeg
         tVY50z6TnyEXpt3UP4A0yyTmw7zVKHJKbitSbOl3UJN0t0If8iwoeHfWgWYMS24O0AMZ
         oHy7kXp9a9Y3MXY1jBoUdQOE7V7SOZvvsJRhtLFPb4m6vSe/UyB58O1hF0rSXSwSHTdD
         TYZQ==
X-Gm-Message-State: ACrzQf1OothnFT6FTlTAWjGM1dBsiSXbUGe48epUdE5p2DQsRGbu411x
        +beZVPyUtSv+Tcz9hZQP+gVgREpOazhzBw==
X-Google-Smtp-Source: AMsMyM6gUwhgz1Tqe0zgVoINvIVWMUecyQZac6FvQB/QJKp1V+7XHWyehDeg+VzPv3EU3KYQ+yQnQA==
X-Received: by 2002:a17:903:11c4:b0:178:634b:1485 with SMTP id q4-20020a17090311c400b00178634b1485mr8973245plh.142.1664549430927;
        Fri, 30 Sep 2022 07:50:30 -0700 (PDT)
Received: from localhost.localdomain (1-171-4-69.dynamic-ip.hinet.net. [1.171.4.69])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a01c300b001fb1de10a4dsm1731608pjd.33.2022.09.30.07.50.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2022 07:50:30 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/3] Documentation: power: rt9471: Document exported sysfs entries
Date:   Fri, 30 Sep 2022 22:50:09 +0800
Message-Id: <1664549409-4280-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664549409-4280-1-git-send-email-u0084500@gmail.com>
References: <1664549409-4280-1-git-send-email-u0084500@gmail.com>
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

