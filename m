Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AEA701F25
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 21:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjENTDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 15:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjENTDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 15:03:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E5FCD;
        Sun, 14 May 2023 12:03:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-644d9bf05b7so6574878b3a.3;
        Sun, 14 May 2023 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684090994; x=1686682994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3NYyCK6m61BtfzEI6h4GpxH3Ua7tXLcQbXWKvXZ90I=;
        b=M0K9ISx8RHlOy1rx+PhJV1JaYMwG21jThoIpr1P0K0JtA9XQee0QHDdR4pC+xo01fK
         R+OodJGH8+6EMe3MieiVfA+rghDC/oqf5riWBaGMcbocS0SwFd9P9sC0MMJEQ6TbE3SH
         /GvkisCBFxekeK1Vd2X/6+2MqJqLJkeutAi3Px+Br353+rixopEkfnp1hQvsWNz7KpJX
         yq0Bj9zpEhB0UKh7SVcomMtknEZ0XvsTRJtN6kYbhmyDduwRoZ40BbeizDZiN3ycoNmx
         tJ7w04rieMID9DpegeeOA+egcnYTSvfero4msJfG3/fbyD4j+j5WtpbiBjMMs4dLZzxA
         NzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684090994; x=1686682994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3NYyCK6m61BtfzEI6h4GpxH3Ua7tXLcQbXWKvXZ90I=;
        b=gA5El8AlshIXafQv9+XPBv93pJAnnjJcXOHnXA8ITXQl3x+IfniIn+/2qDtFR3AhCx
         lK8BclZa8mFiW8rEgxxeBYlSx4ImaARL6ahmh2ImeyRDFwqfEJlUByf35xdNnpFe1GvU
         qBC2suppOGykJfENXWUygeUHg8lTljyhpjDrO0PdlovUFbBI/wZ8uAKNCaL4vJvQ+zPx
         7eWzjlmKqJSD69LhcBz6vv6rXxRtQW6oSXJt9UTR1rdSuqUWPQ+WQAvO6WFxEcsemRd2
         2Tm+RnbLwNiwNS4nSZUpQEub+BuACgmEcw9sPhAmro1gAtCGozmwzCzTtI5DRs/FLvWG
         Q0rw==
X-Gm-Message-State: AC+VfDyPnshAiq9JDMdMzoWUql+CwtpMzyab4+CUbF7AuMXpjfHf3015
        x3nCp92x65hAv3+g9Rxtwfc=
X-Google-Smtp-Source: ACHHUZ4duiZPhAIPMwEPCtmxsJBTASifVnab23g6zElCg2Iv9OtRoj2g/Ci2fxsMfOG44WBmhtXdyg==
X-Received: by 2002:a05:6a00:1950:b0:647:2ce5:57c4 with SMTP id s16-20020a056a00195000b006472ce557c4mr25095963pfk.5.1684090993715;
        Sun, 14 May 2023 12:03:13 -0700 (PDT)
Received: from yoga ([2400:1f00:13:3840:2d88:3593:2af7:2b37])
        by smtp.gmail.com with ESMTPSA id x5-20020aa784c5000000b0064394d63458sm1098352pfn.78.2023.05.14.12.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 12:03:13 -0700 (PDT)
Date:   Mon, 15 May 2023 00:33:06 +0530
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
Subject: [PATCH 2/2] iio: temperature: tmp006: Add OF device matching support
Message-ID: <d0114a66fa3e9fb07a98dde3cc0bd87c526a3753.1684089997.git.anupnewsmail@gmail.com>
References: <cover.1684089997.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684089997.git.anupnewsmail@gmail.com>
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
 drivers/iio/temperature/tmp006.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index cdf08477e63f..2b1782263cc9 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/bitops.h>
+#include <linux/mod_devicetable.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -272,15 +273,22 @@ static int tmp006_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(tmp006_pm_ops, tmp006_suspend, tmp006_resume);
 
+static const struct of_device_id tmp006_of_match[] = {
+	{ .compatible = "ti,tmp006", },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, tmp006_of_match);
+
 static const struct i2c_device_id tmp006_id[] = {
 	{ "tmp006", 0 },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, tmp006_id);
 
 static struct i2c_driver tmp006_driver = {
 	.driver = {
 		.name	= "tmp006",
+		.of_match_table = tmp006_of_match,
 		.pm	= pm_sleep_ptr(&tmp006_pm_ops),
 	},
 	.probe_new = tmp006_probe,
-- 
2.34.1

