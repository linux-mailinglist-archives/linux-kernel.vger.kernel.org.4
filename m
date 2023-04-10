Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5246DCC5B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDJUxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjDJUxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:53:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2625C2105
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:53:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j11so9189186wrd.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681160019; x=1683752019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/sUNls5odRG1ROzcXK2u7tbJwmZU1qshXeSsb4erJk=;
        b=ImG0P6ozhsBNn2wIjXrzV3X3+4UFaj69tjUiqut6D5oEacUyt77fF1/z7QsFadCFKb
         sj+zrnaINyC/6hK37e/jfrNS2KxcuKodwPNwUAn/B+8Akkxk+PqF4fZMo4iyy4cC6IIg
         MOfHE4ZDYTsL75qlt0hHpDuq/tQV+d2hwHE5NLOK0SJZ9KbpPpxZwZSzFDIeyM7xUoIC
         5g5wpbsopEZA9PZOG8Zf/mQB26B0RbHXXwqzRoxQjTzwjcXf49+nUQWxTb8k3e09n+KX
         7tizEJmJSj1XjpfaXM0AYw+l8fDd5WkqVRb0n5o4ySXkON7M3ZK6URKcwl/qL+WkHuNP
         Ab9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160019; x=1683752019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/sUNls5odRG1ROzcXK2u7tbJwmZU1qshXeSsb4erJk=;
        b=x8r8H8oHAfTKWEDGNSumojuEypBBVmH3/1sEiFNRvXcm0LRO5ju84I/cOdYSK6+WlT
         4+saBJNHCoJmaPIqDfwoLwOi8SBp0nfcVEtZ3nFblTvoTrK8VWoYpoZCA1sCgO7kwKAn
         tSgxl2lvmkITY3Gu4zxuljOIphtgq59h+rY/2u7ete3tLloeEu+AiVy6NpTgX9GdjgXt
         MnfitjX0BqbRnc0TX0gHGFf6lXqc2p8ALvp+7afGE74iaP0NMTW5utLsiEju0AbdYhv5
         3DWnDdajAYOdRH17LOqb3Hdif11V5lfKt0jy8xN/u1nzTz5HZr4JnyB8eUagdGlZ1sx4
         MA0Q==
X-Gm-Message-State: AAQBX9cePVnxqwA1A68cEgUdyOiDBH7RQbB+3mmFIX/bgS/CtwN5U4JN
        rmQ/1TDKYS1sGQFnwfj0laiAKA==
X-Google-Smtp-Source: AKy350YFFh/N8fpXptFhx3m4y5KXU6kRPBlm2AH6RBwnHndz3BDlMa+TtqEZuxsNnxAxXFCPqyyfKg==
X-Received: by 2002:adf:e3c5:0:b0:2f0:2154:761 with SMTP id k5-20020adfe3c5000000b002f021540761mr3895233wrm.37.1681160019534;
        Mon, 10 Apr 2023 13:53:39 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2611:592:3b9e:d2ae])
        by smtp.gmail.com with ESMTPSA id e17-20020adffc51000000b002ef2e148d59sm11966789wrs.16.2023.04.10.13.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 13:53:39 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 2/7] thermal/core: Encapsulate tz->device field
Date:   Mon, 10 Apr 2023 22:53:00 +0200
Message-Id: <20230410205305.1649678-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
References: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are still some drivers needing to play with the thermal zone
device internals. That is not the best but until we can figure out if
the information is really needed, let's encapsulate the field used in
the thermal zone device structure, so we can move forward relocating
the thermal zone device structure definition in the thermal framework
private headers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 6 ++++++
 include/linux/thermal.h        | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c5025aca22ee..842f678c1c3e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1398,6 +1398,12 @@ int thermal_zone_device_id(struct thermal_zone_device *tzd)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_id);
 
+struct device *thermal_zone_device(struct thermal_zone_device *tzd)
+{
+	return &tzd->device;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device);
+
 /**
  * thermal_zone_device_unregister - removes the registered thermal zone device
  * @tz: the thermal zone device to remove
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 82ddb32f9876..87837094d549 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -313,6 +313,7 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
 const char *thermal_zone_device_type(struct thermal_zone_device *tzd);
 int thermal_zone_device_id(struct thermal_zone_device *tzd);
+struct device *thermal_zone_device(struct thermal_zone_device *tzd);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
-- 
2.34.1

