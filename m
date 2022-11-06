Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0847F61E385
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 17:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiKFQnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 11:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKFQnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 11:43:47 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA72BF49;
        Sun,  6 Nov 2022 08:43:47 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bk15so13092276wrb.13;
        Sun, 06 Nov 2022 08:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xqBoBKeva5bjtm8UXNXj3BmzMsfCRHx0ULq83teTWw=;
        b=arJZPzh9qxDhjIZmxHdlzONczqql/UqSQEux30BjoIHONRVzB7q3v0hmKAhAIDQU+b
         f1d4ba8O47jQxGa1iEtWmRERr1ZaQtveyzP3CT7e4N3LoL47NUaUadGyfibNP4/3MU3y
         zAt0tx63siVf15t5m0h9GjOrFbbYaxRUViNn/P4LctFvIsb7+2xZPS83SnC5FOvyiFCt
         /MzmZ04nHNepPdWMZW4/lizJudiKqrw2zLs85Y+hnXbCXvnR39IERj+l04wVA8Upifep
         +D4QHZkDlA7RpTHL2FGTDmj8Z9HBuZdcnli8uD/PVYtNouvq3t10V9fYocyRmy5hfSjC
         BWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xqBoBKeva5bjtm8UXNXj3BmzMsfCRHx0ULq83teTWw=;
        b=xdnpfDTxUqfcQxK/nX/DQ6x2F4jbnLPyFSsNQPoVGF6huHywrdF3Nks26ZcjmCikhR
         uTiHoc98cL8jCL0FrthoAMzWEiBhD9BSQ07DtD5PSjAZjcnSki6rtSbJVtSbjLTsAy08
         D2rmTHxDbDFgxTltK6n5xNq/ZQJKQOD+G/AGLq3JF6WfjkTUpCkemtKMOCDZsGyvth8O
         oj5WArzlQY9gK/yXK/Arw7aO+OOED6imdS9+a9c5XlMMGyn1kap5nNV+Coc36nSOMEu4
         vUp8xK3c6aEVzi/MI4t42aqTH1iqOTkZlSDZjv+UDCJ+Z9wYsaGG6TQ6bW8QRq0d+REG
         mMsw==
X-Gm-Message-State: ACrzQf1eR4CRQ2Ge4a0hSgD8KnEnBcHRiHGn9+wokVLy9ljL2FetnFPW
        yoCiLzlyBkSl5lA3aOcZxGjZ0gsETmE=
X-Google-Smtp-Source: AMsMyM7gs76QvhF2kVLXHRr32xuL8tj4gKS95mzVVcQZHc3fBi9q+xA9XNDmav2IizrR7j0pWPF66A==
X-Received: by 2002:adf:e3cc:0:b0:235:95b1:2124 with SMTP id k12-20020adfe3cc000000b0023595b12124mr29321787wrm.693.1667753025525;
        Sun, 06 Nov 2022 08:43:45 -0800 (PST)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d4f02000000b002366553eca7sm4949908wru.83.2022.11.06.08.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 08:43:45 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/2] iio: pressure: bmp280: convert to i2c's .probe_new()
Date:   Sun,  6 Nov 2022 17:43:16 +0100
Message-Id: <237d16807630c6f2a9d2864521228b9d837984b6.1667750698.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667750698.git.ang.iglesiasg@gmail.com>
References: <cover.1667750698.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use i2c_client_get_device_id() to get the i2c_device_id* parameter in the
.new_probe() callback.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 0c27211f3ea0..14eab086d24a 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -5,11 +5,11 @@
 
 #include "bmp280.h"
 
-static int bmp280_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static int bmp280_i2c_probe(struct i2c_client *client)
 {
 	struct regmap *regmap;
 	const struct regmap_config *regmap_config;
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 
 	switch (id->driver_data) {
 	case BMP180_CHIP_ID:
@@ -65,7 +65,7 @@ static struct i2c_driver bmp280_i2c_driver = {
 		.of_match_table = bmp280_of_i2c_match,
 		.pm = pm_ptr(&bmp280_dev_pm_ops),
 	},
-	.probe		= bmp280_i2c_probe,
+	.probe_new	= bmp280_i2c_probe,
 	.id_table	= bmp280_i2c_id,
 };
 module_i2c_driver(bmp280_i2c_driver);
-- 
2.38.1

