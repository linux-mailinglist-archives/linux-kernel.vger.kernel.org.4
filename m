Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41136600FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJQNJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiJQNJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:09:22 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D38B307;
        Mon, 17 Oct 2022 06:09:20 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id o64so11996042oib.12;
        Mon, 17 Oct 2022 06:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tEB+/8vVKq9rF95ePeiHY4k9BKsvRlONK/3JFhRY2Y=;
        b=Xt5fGBbphOq+fnSLeYp6ANZDd7pi9UYGXhf30GPpD+K04mnbcPPCfmnGlsP/kmn+UQ
         ZwfoeVeIXQbU6lFZmXA5JyRn05OkSTxXwqXlLe0/ZUSMuvBWgmghwQAZEqcF7QPTkoH7
         vn5fWYWInUa5NfwZshnts9ozD9YYwI/ytfSRWtB8lcslVHDu++fcueNe41SChRbpibU0
         wjPOHsDSC1jELzPZRn0i5h8jiLcZixKoOQuXpt8PINxnifCDknEkTm9M6/XsEkABipXw
         4d+k/uBbgFpEeM+9RSPH+sp8HWrxUFRrqXx2a7IFDZ3ls45m3CSrS6JxbJ8Tolu81v07
         ugkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3tEB+/8vVKq9rF95ePeiHY4k9BKsvRlONK/3JFhRY2Y=;
        b=BtM45oUeorhniVaMmmcOpcpM66u6eYPX2c+SZs+Wd1ZBkFf8vn/jXzYUYghUOosOB5
         CBZjzB2itMbqp9lYeQN62h+M5DcZmM1+6c8VPCPGgqs6p8w7LWuXMJmG4+Kfo2dSvMfm
         5NvcTLXOohDRGco/VRMNFtiOU9cM6vbUTNo1prInD6R6BvAQgbPreaY0EHpGHVn2ZQb/
         ZVgegctQoo8gKEHvJgsif5MeYvnfkGqdpf4cm0k47SempiE4ZhlqtOdiT510abERl9Yc
         QLaNGYG2G1zR562NE+cwwmZNlZDzk4hiqGDqp0dMVmDQ1kwfU6hJMQ2CUlGj5ASOT49H
         Csfw==
X-Gm-Message-State: ACrzQf19gCG4Gwbu/aW9YcRR7VBh0NNMqn1SZEVPHSMJNUnoOpxadXUu
        ywcB+pVglW/ayM/z0FOoyLY=
X-Google-Smtp-Source: AMsMyM4tvkKCCBz9kkOEjNP6jITM+8t7W5ZSj9M6iPVfEezUoBj1SkzRIbYwOZw4WOp38LJV5bDqjw==
X-Received: by 2002:a05:6808:17a7:b0:355:3cba:7d41 with SMTP id bg39-20020a05680817a700b003553cba7d41mr1371077oib.244.1666012159671;
        Mon, 17 Oct 2022 06:09:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s4-20020a056870248400b00136cfb02a94sm4593172oaq.7.2022.10.17.06.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:09:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/9] thermal/core: Move parameter validation from __thermal_zone_get_temp to thermal_zone_get_temp
Date:   Mon, 17 Oct 2022 06:09:05 -0700
Message-Id: <20221017130910.2307118-5-linux@roeck-us.net>
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

All callers of __thermal_zone_get_temp() already validated the
thermal zone parameters. Move validation to thermal_zone_get_temp()
where it is actually needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/thermal/thermal_helpers.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 3bac0b7a4c62..0161d5fb1cf2 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -64,6 +64,20 @@ get_thermal_instance(struct thermal_zone_device *tz,
 }
 EXPORT_SYMBOL(get_thermal_instance);
 
+/**
+ * __thermal_zone_get_temp() - returns the temperature of a thermal zone
+ * @tz: a valid pointer to a struct thermal_zone_device
+ * @temp: a valid pointer to where to store the resulting temperature.
+ *
+ * When a valid thermal zone reference is passed, it will fetch its
+ * temperature and fill @temp.
+ *
+ * Both tz and tz->ops must be valid pointers when calling this function,
+ * and the tz->ops->get_temp callback must be provided.
+ * The function must be called under tz->lock.
+ *
+ * Return: On success returns 0, an error code otherwise
+ */
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int ret = -EINVAL;
@@ -73,9 +87,6 @@ int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	lockdep_assert_held(&tz->lock);
 
-	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
-		return -EINVAL;
-
 	ret = tz->ops->get_temp(tz, temp);
 
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
@@ -114,7 +125,16 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int ret;
 
+	if (!tz || IS_ERR(tz))
+		return -EINVAL;
+
 	mutex_lock(&tz->lock);
+
+	if (!tz->ops->get_temp) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
 	if (!device_is_registered(&tz->device)) {
 		ret = -ENODEV;
 		goto unlock;
-- 
2.36.2

