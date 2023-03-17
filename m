Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908BE6BE96E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCQMiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCQMiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:38:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9884674A48
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:37:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ek18so19777996edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679056644;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zG+Fullr1evfHoIsSVfpr6zWgtZeQgscYvErLPyQFGI=;
        b=gCuBPF8Q//qtJHEANJYlS6l2sNTnvzGXgW7oTC/0ZEhziDZzOKxWNrWzMMHXTNNQaB
         qpJ9TBGAx1KZldJ9Q4XGAlKm+biixAVxoASEdMetmF56HW/DHGXq/jOBBagk28gQAxN+
         qS2vWBOSOU7l9hg6M4qMs4fnzxqeyh2F2NdOCj1WKHrEkB2x/ZZnsBfk3caUEv2ml7NE
         Vr/+HbOQu0F3csoE7FmF9Y3XLNU20UF5Go3vwh9AWmDti3T3NtrCEN3siUMxT/hHUagE
         IENK+8SDm8FcxSctWoKtHnFMteYpoeTrReYQccAxNIQqoS08kzKgfIgi8G7ePWYWr+v4
         odjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679056644;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zG+Fullr1evfHoIsSVfpr6zWgtZeQgscYvErLPyQFGI=;
        b=ps1etpqszXyn8s1GrzIGCdHPtqhSp+2MlOmeoRmf816ZBf07jcJjLIZgOpiCykUVbw
         vJJQQ3Kc3ha2QeHR8ozYeH2dVD/BbNIkoXZ55Pkxg6ukxKTFDMGWBwB3WpQUaIMvTXEw
         8a0eBNV5Z+ECs+F4P8e5fpA9L/oWCPQmz0SliNa7341Y1BW9nLMrFCzYYJUTNqSq7I19
         SH08cGOVTgqMHWwe4v6/zY8CYup8kAfS4uTdP19yw/7CC4wUaFfNLc7fQMbfosl/gJrm
         gMlqqxHJ1IvZZH3OjHv8F0BTTvJtKZ2tqJsL0wn6yhAebizcWPp6tFdol0uOkrBUS5If
         eOWg==
X-Gm-Message-State: AO0yUKUhUIZaTF6NJnx5ZkWgiiXYXMD+cyBXi8AYaQlubBMOGaAWZRpe
        tNhz5OUtHBBb/lnLj2NFJ+E=
X-Google-Smtp-Source: AK7set8ayA3Ff2SyNGaRCXyUM/1nEx+2zZjs7st1mYfUKWCv6Bj0GP/yy9Fglwgknwlo75Gv3fY+jQ==
X-Received: by 2002:a17:906:1254:b0:8b1:fc58:a4ad with SMTP id u20-20020a170906125400b008b1fc58a4admr13864475eja.11.1679056643943;
        Fri, 17 Mar 2023 05:37:23 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c5b8:6200:dd0b:20c2:4c96:a825? (dynamic-2a01-0c23-c5b8-6200-dd0b-20c2-4c96-a825.c23.pool.telefonica.de. [2a01:c23:c5b8:6200:dd0b:20c2:4c96:a825])
        by smtp.googlemail.com with ESMTPSA id k6-20020a17090632c600b00924d38bbdc0sm938073ejk.105.2023.03.17.05.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 05:37:23 -0700 (PDT)
Message-ID: <6dbdf458-9f46-613e-de58-b4a56a6cdd9f@gmail.com>
Date:   Fri, 17 Mar 2023 13:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: [PATCH 1/2] base: soc: populate machine name in soc_device_register
 if empty
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <d846047f-b714-3fd1-d8c6-9f774902fb9f@gmail.com>
In-Reply-To: <d846047f-b714-3fd1-d8c6-9f774902fb9f@gmail.com>
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
 
+static void soc_device_get_machine(struct soc_device_attribute *soc_dev_attr)
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
 
+	soc_device_get_machine(soc_dev_attr);
+
 	if (!soc_bus_registered) {
 		if (early_soc_dev_attr)
 			return ERR_PTR(-EBUSY);
-- 
2.39.2


