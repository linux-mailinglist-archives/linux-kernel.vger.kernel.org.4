Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC9A600FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJQNJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJQNJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:09:18 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CACD12D;
        Mon, 17 Oct 2022 06:09:17 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id p127so11357514oih.9;
        Mon, 17 Oct 2022 06:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKfBoF1vAy9J7XDh1mrV+p3UkSxmJG+dWUnnE4QiU30=;
        b=JBTRePECk0TrlmszbwZ/Qq8e4ibi7Q3gZqBLVv8QbyCizjJ/jwCPNqWND9vi1Tg7O2
         X5SRrAEH6fnVSouHXKClyxTb8q7H7NuPxyCvjGS9xAkFDdgxo0GkuurYGi0Ldb9baZ0W
         fTf+cPVNiYUBN3uVxj3HV2U4d8BzlLh17jeWcEeFMO+FqL1vgtUogthVFeVElPuRj06S
         1jXPdHlpXIOOqYp8nNvUK1s5sbYjmy0pde6JELjguyv+sCpDIb1urTz+YjeMOeKLGzQH
         J/E4iAYL9IIVMcewoT+IBCwD2dex8sGOoh3ADCVwuOj44Y9MiSgJ9fv2MVF5XCJlA9NI
         GbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QKfBoF1vAy9J7XDh1mrV+p3UkSxmJG+dWUnnE4QiU30=;
        b=2eJMoPScNwMbTawExXKC3gfsgDxrDvWA2Pokh8bzycxWszjb0XOoF0CaFhlCe/I+yq
         Od8HVTnEW5UrzHuoBB8gTEby8T9n1/n07gYS7Cen0RAby1rxZhk367Nu66kzbB7RLDYj
         mRllXs6jtYhOwLoydnTSGjvZGaVWSmQsiyMcc1c5n+NcPlIhfLcLMg9UnbVrhZFgkfSe
         UHmQKHIjkcMbI48fATHYQt/88pV8tL2fyWP6LULRXBzN4raPgwfn0aol0Fgl37Y1UXA6
         GDfBUitMV64ciQCAO5SiUiFoQfK+Z11PHww8wZN/1t6UROqdDfp7Uqt0MuWHDcw6kdt9
         lHyw==
X-Gm-Message-State: ACrzQf3tDJGYFtnlGlAuZgj3OmPc48x4N1vfuyFyQYK0orjnPPCjlP4u
        vhkM39x0+EbhNYFTgeav1wU=
X-Google-Smtp-Source: AMsMyM5e8mNFM6gkFXS3s0Tz9WuZqf4ZxfwoscN7qwkyRvAKVLnx/JpvXPbryxnh/vdd+Uve7oBOxg==
X-Received: by 2002:a05:6808:114c:b0:355:989:7ce7 with SMTP id u12-20020a056808114c00b0035509897ce7mr9607598oiu.153.1666012156849;
        Mon, 17 Oct 2022 06:09:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x12-20020a4aca8c000000b004767a4863basm4245858ooq.14.2022.10.17.06.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:09:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/9] thermal/core: Delete device under thermal device zone lock
Date:   Mon, 17 Oct 2022 06:09:03 -0700
Message-Id: <20221017130910.2307118-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <20221017130910.2307118-1-linux@roeck-us.net>
References: <20221017130910.2307118-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal device attributes may still be opened after unregistering
the thermal zone and deleting the thermal device.

Currently there is no protection against accessing thermal device
operations after unregistering a thermal zone. To enable adding
such protection, protect the device delete operation with the
thermal zone device mutex. This requires splitting the call to
device_unregister() into its components, device_del() and put_device().
Only the first call can be executed under mutex protection, since
put_device() may result in releasing the thermal zone device memory.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/thermal/thermal_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f548875a016d..562ece8d16aa 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1391,7 +1391,12 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
-	device_unregister(&tz->device);
+
+	mutex_lock(&tz->lock);
+	device_del(&tz->device);
+	mutex_unlock(&tz->lock);
+
+	put_device(&tz->device);
 
 	thermal_notify_tz_delete(tz_id);
 }
-- 
2.36.2

