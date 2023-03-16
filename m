Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB1C6BDA44
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCPUgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCPUgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:36:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E8A5F6DD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:36:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y4so12631289edo.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678998966;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlklHImdXNdfrwXUolyZOA6zccOo5LXTGnwZM8Pnl/c=;
        b=nsi0lmetyD8+cOZwRD24PWCpnreqOPE4J6EMotaThWM/55/PxNJo/mAAvfAx4nK2il
         3cFGk2OrcExyZ3zx5r8a5M81Cez8H1UiaGXP+c2GgHfyZWHiqMycH4/F9k6MMT5gcjn5
         BbkkfIKt4yk5KK0oL5OTk0Et1MCIoiYkGauP9mDiW0htEsg0TilUuXmBI8D4ivW3/sGG
         1JXkRIemzPcFizJt8glZEG2uIWaIP6hdfT2870R7zH6lpwZbhdr5YeK2E1lIJFhxQHmr
         2wDqqa/JIRypAQ17nGDNEuta2Sy5HRs3dOIZZEYnRjLKgbg/Irab6HFQXqmyULRq9dlK
         y7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678998966;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PlklHImdXNdfrwXUolyZOA6zccOo5LXTGnwZM8Pnl/c=;
        b=ULsYn+2F2jd3BxqEiaD50y/IVTjEbjgN/rErqWPaZ7a5fhAAKSYw81r3kFyArevO1I
         Qk5rLMnVfxXTiwLorrHX+geUE/6JY1XJPUC57aeHWCn2vJ3Hpj9l8zJ9VR9yqYlCoFXc
         yZNgHHPZYriiHZiTDC5VEWBa8djeEbkCThLT7fM93sg0BtIz6c3iqfe/Wxva/hOapHUg
         GNIM7QrRfaljGcEilMCiaXkZkqDQkAG1a0rRNMFqJ0j+Zo7xAWAB35+si0hzgpuC5Dto
         qeRbwCVmlG2RVsGTgkRwobsjoT9RLAEfvytcNwYJmkTkV1bVcPb8iwIgobHK14zvB325
         q7aQ==
X-Gm-Message-State: AO0yUKX5rW3dp5i12APiSnPTRApipmnv7KqB/Cgw/q5dBraLKYxjy4MY
        G+c6TwcGi1t9c4GvxlEnc1M=
X-Google-Smtp-Source: AK7set9uBhkJsWXrSQvMm8ZsZuWKdazV/qmMhFVW58QNQp7a0nVT82Yp7HjwhsnBJDPjhAGAnHoI+Q==
X-Received: by 2002:a17:906:29d9:b0:8ab:a378:5f96 with SMTP id y25-20020a17090629d900b008aba3785f96mr693209eje.3.1678998966483;
        Thu, 16 Mar 2023 13:36:06 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c416:2100:138:7dfa:fb30:53f? (dynamic-2a01-0c23-c416-2100-0138-7dfa-fb30-053f.c23.pool.telefonica.de. [2a01:c23:c416:2100:138:7dfa:fb30:53f])
        by smtp.googlemail.com with ESMTPSA id d23-20020a50f697000000b004fd2a7aa1ecsm227179edn.32.2023.03.16.13.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 13:36:05 -0700 (PDT)
Message-ID: <d667b435-bf4c-ee7d-2da8-559354124578@gmail.com>
Date:   Thu, 16 Mar 2023 21:35:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] base: soc: set machine name in soc_device_register if empty
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several SoC drivers use the same of-based mechanism to populate the machine
name. Therefore move this to the core and try to populate the machine name
in soc_device_register if it's not set yet.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/base/soc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 0fb1d4ab9..8dec5228f 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -7,6 +7,7 @@
 
 #include <linux/sysfs.h>
 #include <linux/init.h>
+#include <linux/of.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
@@ -110,6 +111,18 @@ static void soc_release(struct device *dev)
 	kfree(soc_dev);
 }
 
+static void soc_device_set_machine(struct soc_device_attribute *soc_dev_attr)
+{
+	struct device_node *np;
+
+	if (soc_dev_attr->machine)
+		return;
+
+	np = of_find_node_by_path("/");
+	of_property_read_string(np, "model", &soc_dev_attr->machine);
+	of_node_put(np);
+}
+
 static struct soc_device_attribute *early_soc_dev_attr;
 
 struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr)
@@ -118,6 +131,8 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
 	const struct attribute_group **soc_attr_groups;
 	int ret;
 
+	soc_device_set_machine(soc_dev_attr);
+
 	if (!soc_bus_registered) {
 		if (early_soc_dev_attr)
 			return ERR_PTR(-EBUSY);
-- 
2.39.2

