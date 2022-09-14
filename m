Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EB45B8D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiINQcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiINQbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:31:39 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2DB7CAA9;
        Wed, 14 Sep 2022 09:30:32 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q63so14780542pga.9;
        Wed, 14 Sep 2022 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=bj3Xd1B2V1MMZML2lCuLJf7Wr+7882Xj1TmG9cTsN8k=;
        b=DOtnThQ4jR3IjbiA8VsfYvEj8rd3bK+a00Zhs1fYgFzXHXcixcRCiJV2IcLc1r6znT
         QKWTCfUfPFn40CNBZ6h4/DqONIpx/P0w7nHBu6hjJ4m9m/eHOWZhszvLy031gG0xUVgn
         QgkSCThdOM+EbWjiDPj69QWVHwpZHVs4zR6gooY9owJ8LMcH4UVmu2em2ep/UbsYa2N3
         4xZDwBNEXv8yqFeabZkFcSCaKxf9W06LhTKmxEWfOPc3X+hb/WVe9rJgFupwAyBvXrfi
         nzDgUmzUctMGODJ8swgj2LydmLDwrXr+fkEwX2abaHM4WVcLIsRHj5uYsNnrjkkwqY/O
         NTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bj3Xd1B2V1MMZML2lCuLJf7Wr+7882Xj1TmG9cTsN8k=;
        b=iN/UTCGgBUOWnT4dAQMKGrnBrN606Fk4o7Nxp40jamQR4I88NsQqRo6cnf3eOkyDW8
         w8uJPC2Wr9PUJ9Pi6G/qrAhTUhxRqnjVQAJ2F896NR8uoPyArICuG7L2n94jDF2qbzcF
         vGG3J9yrArT0b4ZNTmyRvWXdkBbS5TMjLY6uGq763FqicXe4PxICPzmgnoYTSYlAE70B
         bJb+1xBYFWZBiFcB/VJ44PwqQ2vH8KhpFL6cRMY2jnQkS+Oj3M/DULaQ+hsmymGstTFg
         1VzfttrKuV7hkz8pmtVRElRn5vbJnrvijYXSz9sGcj9atkFY9DacWMzeqnh8naXlHiWD
         cz3w==
X-Gm-Message-State: ACgBeo2g5V5fPru62K1+ZSaQwlU6mLb//ycL3bsyXzF0EAFQnj03qmtl
        VylFJACZ97+ntpyAO6QSyhk=
X-Google-Smtp-Source: AA6agR5XYgCuQzv8omJRokcCH7uU16KBeGarnpEFW8KHmeuPCjPYdig0regHKgnhKFXBKKD9J0NkgA==
X-Received: by 2002:a63:2b48:0:b0:434:eb45:9c6a with SMTP id r69-20020a632b48000000b00434eb459c6amr30596556pgr.508.1663173030888;
        Wed, 14 Sep 2022 09:30:30 -0700 (PDT)
Received: from localhost.localdomain (1-171-4-145.dynamic-ip.hinet.net. [1.171.4.145])
        by smtp.gmail.com with ESMTPSA id l22-20020a17090af8d600b002031264a864sm1899991pjd.41.2022.09.14.09.30.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Sep 2022 09:30:30 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] Documentation: power: rt9471: Document exported sysfs entries
Date:   Thu, 15 Sep 2022 00:30:15 +0800
Message-Id: <1663173015-7934-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663173015-7934-1-git-send-email-u0084500@gmail.com>
References: <1663173015-7934-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Since v5:
- Recover all the change in sysfs-class-power.
- New a sysfs-class-power-rt9471 file.
- Remove 'charge_term_enable' sysfs entry, directly integrate it in
  'charge_term_current' power supply property control.

---
 Documentation/ABI/testing/sysfs-class-power-rt9471 | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9471

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
new file mode 100644
index 00000000..ad5b049
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
@@ -0,0 +1,29 @@
+What:		/sys/class/power_supply/rt9471-*/sysoff_enable
+Date:		Oct 2022
+KernelVersion:	6.1
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry allows enabling the sysoff mode of rt9471 charger devices.
+		If enabled and the input is removed, the internal battery FET is turned
+		off to reduce the leakage from the BAT pin. See device datasheet for details.
+		It's commonly used when the product enter shipping stage.
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

