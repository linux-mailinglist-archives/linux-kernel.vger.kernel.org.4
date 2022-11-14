Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F4462776B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbiKNIVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiKNIVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:21:14 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D451AF03;
        Mon, 14 Nov 2022 00:21:10 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p21so9398220plr.7;
        Mon, 14 Nov 2022 00:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WDpwxLGYQHucsjbGGxsVmJprs34jMYlaaLdB2Tw2WYk=;
        b=e2vJRow3dF2A/9HFreVhoneMvppmyICDUnFXXVJwhbM7Ztoc7/m7YVnv4Qon7fFe96
         FQk7Kl27px0mDAh3kOYwZzuHglRCUG0RrrLH6UWJWDA2EJmwY82+Qhn73WAuevRSl5Nf
         QCyTDZu6x4NYxo21NjMeWoYwP2Y7qkBwaOfM7rlD/Yj48ey7CPXKreBr4afOMRGNIXBP
         Ypj0hfAGn3ZUIcehmxIxu8Reqh5aBjiftXIoyiOC4eZ6kCOiHjoQKjRv+OvpiQ2VD3ym
         226r3d5xJRT1Gi+0Hb0W/Ca1VGXhxUnjFDBvAFj1RSmO6V3peovIH5rvTLJd4HKi2Cri
         sPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDpwxLGYQHucsjbGGxsVmJprs34jMYlaaLdB2Tw2WYk=;
        b=Z/o2olfzACmQIQJTpwRZpjYstJ25JHgFvjnNe4LnT3CJn30mugSpWgz5QA6LEJ05rw
         k+hApP0d0sv4/v/oa+K88sEJO7px9YSGpZiEeuPvMV1mfddTFPv8kK/wwvXxVtX4X/0S
         VEDbtyfqACjKW1D+uJULxldaMfgRXPshkNsJA+GsrXXTrNHqbZYUPiefmS7axMpBc5sM
         97nWA6KI2Ae+vOfL3O9+W5nfGmP9P65syoU5iJTEa2OUPx8GmwjCnF01RpHsOxAk5KcF
         yRDjUYA3HhkKxQObP6M9FvasJp5BvZz0GpjHq09q0W/hfjg4cR/2b7ZEzCIPqaqUfu/x
         ik5g==
X-Gm-Message-State: ANoB5pkxhUJ2U7Ju2N2DLinRvmN76QcwMqzHYfBaL56GQHIa15IPGYQb
        gu9ZFkISgikoJqUNSbqCAfc=
X-Google-Smtp-Source: AA0mqf4vIsAcwVQGuuoCr6Xd/nbzYQ970mN3lftmnrqu4v69NOKt6qWtTYWiJSUCIQ6perPcFYyADg==
X-Received: by 2002:a17:902:9a4a:b0:188:8e14:b4df with SMTP id x10-20020a1709029a4a00b001888e14b4dfmr12327323plv.136.1668414069875;
        Mon, 14 Nov 2022 00:21:09 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:487:fe99:8803:61a2:a857:2b40])
        by smtp.gmail.com with ESMTPSA id o38-20020a634e66000000b004639c772878sm5419997pgl.48.2022.11.14.00.21.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:21:09 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     cy_huang@richtek.com, allen_chiang@richtek.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] Documentation: power: rt9759: Document exported sysfs entries
Date:   Mon, 14 Nov 2022 16:20:53 +0800
Message-Id: <1668414053-32728-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1668414053-32728-1-git-send-email-u0084500@gmail.com>
References: <1668414053-32728-1-git-send-email-u0084500@gmail.com>
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

