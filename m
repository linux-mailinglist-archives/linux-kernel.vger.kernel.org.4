Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36A770A765
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjETK40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 06:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjETK4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 06:56:11 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEED10E2;
        Sat, 20 May 2023 03:55:47 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53202149ae2so2854954a12.3;
        Sat, 20 May 2023 03:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684580147; x=1687172147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqnSMbm/6Ectn2CYqx189TQe5e/cS2LzaVCJe3APFzw=;
        b=CENLKEgNXISW8/aToe+yvRvK5CYjJ9ZMbVvZCaZqjjKELJTp6lsLGo4cZ9pJXadqrL
         8tQ7RRCDiaBsEiDtEtcWLD8tl1/OsaOTq38h9hspjk0GhorGiEq7LNjPrBgFTAtav6JX
         kMgjzIkSUJDRMYlDKAPb7Gq+UE/hR1jU4s0M/LWvqLkH7v+cZPnMnzvE5G5G8EsZDQ4F
         rClaheFxcOtskEmvdg/Zp+A8yiiP3jhMJyDgmx197UpVKPTYINhoPRJY1W+BE0w+7g0h
         mLHgZtzX/JwYmOQZQU+tI06mzldpLK/DP2wGK5CqtMOy+eoahyBlM6R3Tt4bgV4HSFNY
         17Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684580147; x=1687172147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqnSMbm/6Ectn2CYqx189TQe5e/cS2LzaVCJe3APFzw=;
        b=j88T1wL5+VzX/34Z1lnZCiHLB/xSqwsslI2Y9m8rJ5BOgYcFVsnCcXqrkgTZqe/i2E
         J6cgDRFgCvUTB3VKejlNJHzMQKv4B4CQAjTF1v2UaLto9ZxQdBuJ4T0UsddGX9H1k8K0
         3I3xWQSBnaI1y7HVKh+YLWni3NZZaaknSqxaOX/KAepmS3OFZLqxuURmBzxfgXKWaHI7
         a+teVnSxWyz33UzKabZ2K8SXpsojbSzwkCLywzgc3D0L9TvP8aElXQ4vyco/Dy+CpX2u
         p9j6M/4RbApKfWPl0MS/1Bx9We74ZCa4x7Bhr7zhbsJKIPcdTHNS0vRl6o4Rpi8mgAm+
         K5hA==
X-Gm-Message-State: AC+VfDz/nf+DMRjxItH8vBXIhKERcDKjRZZEiB3iGsfU6iZ7VabCZm+J
        qHNl1Ufv64R9XscNwkwDpYM=
X-Google-Smtp-Source: ACHHUZ5q3SImtHGpXCKPllfeKoar7nlgwzbaPyHenAH5Yw52X+HtbAx3FzT2XjgeNfyQGzbaqQwz2A==
X-Received: by 2002:a17:90b:905:b0:247:5654:fcf3 with SMTP id bo5-20020a17090b090500b002475654fcf3mr4803212pjb.11.1684580146988;
        Sat, 20 May 2023 03:55:46 -0700 (PDT)
Received: from yoga ([2400:1f00:13:245c:9b1a:1a9d:79c2:5b3b])
        by smtp.gmail.com with ESMTPSA id 137-20020a63028f000000b0053423447a12sm1167233pgc.73.2023.05.20.03.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 03:55:46 -0700 (PDT)
Date:   Sat, 20 May 2023 16:25:38 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        u.kleine-koenig@pengutronix.de, andriy.shevchenko@linux.intel.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: temperature: tmp006: Add OF device matching
 support
Message-ID: <72746bdfd8f74171943e41759b891c7af40627ec.1684579603.git.anupnewsmail@gmail.com>
References: <cover.1684579603.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684579603.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an of_device_id table entry to the driver, enabling
device matching through device tree. With this update, the driver
can now match devices using both the i2c_device_id entry and the
newly added of_device_id table.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>

---
Changes:
V1 -> V2: Keep the exsisting MODULE_DEVICE_TABLE entry.
	  Removed the inner comma in of_device_id.
	  Order the included header to improve code organization.
---
 drivers/iio/temperature/tmp006.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index cdf08477e63f..5f5a7450bd5b 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -15,6 +15,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pm.h>
 #include <linux/bitops.h>
 
@@ -272,6 +273,12 @@ static int tmp006_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(tmp006_pm_ops, tmp006_suspend, tmp006_resume);
 
+static const struct of_device_id tmp006_of_match[] = {
+	{ .compatible = "ti,tmp006" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tmp006_of_match);
+
 static const struct i2c_device_id tmp006_id[] = {
 	{ "tmp006", 0 },
 	{ }
@@ -281,6 +288,7 @@ MODULE_DEVICE_TABLE(i2c, tmp006_id);
 static struct i2c_driver tmp006_driver = {
 	.driver = {
 		.name	= "tmp006",
+		.of_match_table = tmp006_of_match,
 		.pm	= pm_sleep_ptr(&tmp006_pm_ops),
 	},
 	.probe_new = tmp006_probe,
-- 
2.34.1

