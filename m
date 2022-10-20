Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D95605835
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiJTHQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiJTHP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:15:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB311645D7;
        Thu, 20 Oct 2022 00:15:32 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a6-20020a17090abe0600b0020d7c0c6650so2605424pjs.0;
        Thu, 20 Oct 2022 00:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DmfdEJpNjjO+x1iePOhK0E+t1GpP7iYAwgO5IBrcKHc=;
        b=OE/GWaHtdBtupArnXxMRTPndWJWm9LKKuWmPpgTC9rb8de3se5I197W/Nx3hwg9ioK
         D4VBhqPyfePM9VAI7qWpWY8/j7K6mrOdZAwjtFT/yGneaLf+aiaJSdF7gV1Jcl3i7xWu
         uYbGCY38Tnq4Jr8KLiw5I0eGaTe9prvtxCp8CGBQ+v0nzpF9N6x5+6jdJ7pqS0JLAACp
         qVWUhN3FAqfxISoHEXAPi7hVaNeaIjzGGhla0x/hL7707esi23ZKQN4MG+eHA5c67RG0
         8Sz6AdGFEIklNE1APzyac24ZQEFkJTM1xW8SQbUnNJzz5u2Jvk5YobAfIv8UfFR4AvwE
         jdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmfdEJpNjjO+x1iePOhK0E+t1GpP7iYAwgO5IBrcKHc=;
        b=srZ9iVKVmcgfOhyfvOFjCRbIdCqW7FLus39rTjqdxCLc/QwznqaednB46hLO82Y06d
         bfFcNgHs0aA/W5EXFHfcjQ0wkEr7AeSr/WQeyPepPUQ5XGJVljWY2YYE+mxQf8a1tjXN
         i1ECYW2IBoxL+/emu5xva5/nR4Fzu7wwMPXQDhYlTfE1ta42RIirFaVOE1NunHJMaiSo
         LYW8WmXzBLqEEZ80ChG+Kv/MLcSFVehQlRwfb0Eh3u1fTOHU03WrrIU6Rt1UfBF3J7nQ
         xnpRGYrbPaoKxhRHTjkgOFjS5RhVVP9PGurDIL72bNLHXH5cW7pWDQFH7fEFW7nomS+J
         otIw==
X-Gm-Message-State: ACrzQf1FdnUfftKBpyX/tCx/FjWBpNdI1XlYMM4/c6Vw5Xtj+9BecTKs
        PVp32DW8sEaCrd9tvCXfRY8=
X-Google-Smtp-Source: AMsMyM6q7YeswKtR1nzftzrgrtTg0PTmQ4VTdLcJq0Q2ohGeXjSdMty9zwalFPzc5a1KE50Kc9pFew==
X-Received: by 2002:a17:902:6bcc:b0:182:df88:e6c8 with SMTP id m12-20020a1709026bcc00b00182df88e6c8mr12645555plt.117.1666250083595;
        Thu, 20 Oct 2022 00:14:43 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:a12c:444a:ed28:4831:fc95])
        by smtp.gmail.com with ESMTPSA id m8-20020a170902db0800b0018157b415dbsm12094679plx.63.2022.10.20.00.14.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 00:14:43 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     cy_huang@richtek.com, allen_chiang@richtek.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] Documentation: power: rt9759: Document exported sysfs entries
Date:   Thu, 20 Oct 2022 15:14:21 +0800
Message-Id: <1666250061-18686-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1666250061-18686-1-git-send-email-u0084500@gmail.com>
References: <1666250061-18686-1-git-send-email-u0084500@gmail.com>
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

