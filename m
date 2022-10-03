Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE7C5F2E7B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiJCJtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiJCJtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:49:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B570F24099;
        Mon,  3 Oct 2022 02:48:29 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y136so9754081pfb.3;
        Mon, 03 Oct 2022 02:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=+mvi2JTs0dvAwwc0ZcikqL3pBiRVFH5ocOGLIEQjniw=;
        b=qypILY/yq24wXIwO+qr1bJrABvOfG8SNkstwBQ2TdbVn/oHdvwuZEO3neJknyq3pWM
         9+HO9wrE2/WtljZH7vjx1T0lJq7OswV+TFOB7fiUeIDHgk1so+et+sqV+lhAVyYSJbQx
         LPoIGclcKU7ejThadKP4KDrpoz05qoqvi3iwfBlLCxOTlbr0PvEz0dS32XmrWIBVaD4L
         dQFE0R75HeZ+SbRD0FrHx48cjtvNbhfaFzvh072KY07GiS+/OIrNuARa9zUJqYKVdJh8
         /y3HIwf2d0QxvZqDg7b8zCwWxD0i6fkH2NPnbV5Da/h84zg2LxkOoTv217IBl/RtdezP
         26xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+mvi2JTs0dvAwwc0ZcikqL3pBiRVFH5ocOGLIEQjniw=;
        b=QFKgsoJsaV7n761NdxrWHnh1SaYzAiNNy4YsVviJCMIQCahNm/b3zICy+7Zcz2288o
         hKbMvxUzJOc4xoKteUARz5jYMmA50cKt1TxL1FIiG2ZkX85Wt4+ZK63pYpm2BscBQJQt
         p6ga/uroS+FeQlnboTTh/7W3R4PSLA7BQ69+v+tNIAbvhwDJkJbo7rHqfgeaphGYcehG
         USrwCsOESDBHaC/YbggDQm8u4VbwB7RussDgUCsfldqxM0PWhGmwVlDDCbWKHhEc5Y+R
         PJcaa+cK4CTqTlbSuG/sjCv9OMoLcRNTf/2VrmMiQgbCYqQC879PYznniKusngePhA45
         5v5w==
X-Gm-Message-State: ACrzQf2uq4hvUSM6vb+WRq8PIz+9rHSXrjXqFDcBch4NQDqAEXKNYfVt
        k25XHWH89n7Jysyp1eR/n5rMiXqOC9U=
X-Google-Smtp-Source: AMsMyM4Eu0sNI9P8WSSJLTw4nTz8DfICDghJ79BLVd01qFCxHJF1rxjERJtMNv9a5VAa/gL8kI9TrQ==
X-Received: by 2002:a05:6a00:2446:b0:528:5f22:5b6f with SMTP id d6-20020a056a00244600b005285f225b6fmr22136033pfj.73.1664790508859;
        Mon, 03 Oct 2022 02:48:28 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:da00:1dbc:8208:4596:9e9c])
        by smtp.gmail.com with ESMTPSA id t23-20020a6564d7000000b0043014f9a4c9sm6142230pgv.93.2022.10.03.02.48.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2022 02:48:28 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     cy_huang@richtek.com, allen_chiang@richtek.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Documentation: power: rt9759: Document exported sysfs entries
Date:   Mon,  3 Oct 2022 17:48:13 +0800
Message-Id: <1664790493-16386-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664790493-16386-1-git-send-email-u0084500@gmail.com>
References: <1664790493-16386-1-git-send-email-u0084500@gmail.com>
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

Document the settings exported by rt9759 charger driver through sysfs
entries:

- watchdog_timer
- battery_voltage
- battery_current

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9759 | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9759

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9759 b/Documentation/ABI/testing/sysfs-class-power-rt9759
new file mode 100644
index 00000000..7657419
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9759
@@ -0,0 +1,37 @@
+What:		/sys/class/power_supply/rt9759-*/watchdog_timer
+Date:		Oct 2022
+KernelVersion:	6.1
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
+Date:		Oct 2022
+KernelVersion:	6.1
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		Reports the current BAT voltage.
+
+		Access: Read-Only
+
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/rt9759-*/battery_current
+Date:		Oct 2022
+KernelVersion:	6.1
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		Reports the current BAT current.
+
+		Access: Read-Only
+
+		Valid values: Represented in microamps
-- 
2.7.4

