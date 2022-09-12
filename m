Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D648F5B63A7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiILW10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiILW1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:27:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15EF205D2;
        Mon, 12 Sep 2022 15:27:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b5so17778592wrr.5;
        Mon, 12 Sep 2022 15:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=W9K0Nbt/PATc7AYj/Tml8RmmX7jWgySUjWvxLIPI9Hs=;
        b=OPQqp90XxQK8MNhCyZoOlB+WrzpdCGgXnFA/R5DjvJaGBHJm4UEwGxwqHJQNkKNiZI
         YFTR9ACJo8zLkhPIoZiE0/Y5V83TVrqbFIqmcEEpynmAg6cZCQoa1O7lBU/69WWUm6Pg
         Y5J4fVXZ53akuJRe0UxiG8kwxWzWspUmBiceMW/GiAnEF32IO2izerYbStj5DfCHmW6/
         L8Fg0UpFn5HN/8lSahK7yCPjJLaYTBfhBXbIUNnFFTeT0q23Dl9WHyZ5TIfsh12t8bEX
         Pau5H9DBHmjl6CYkpi129TjS3SOKJY3Hip4zBTmu3zmVgVtc4S+dnkLkv1wbYq+Cb4/E
         rA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=W9K0Nbt/PATc7AYj/Tml8RmmX7jWgySUjWvxLIPI9Hs=;
        b=ICYamR3BClZ6nvUnlDTyLdl7mpoRU9TEB5LKsnegFjAQknqgLezQE9AN9LKc/O7Mr5
         khkMAoox9uchUQQkAEOlCB3oNX0cSB/HiZLtBEXM0l7HPcd8glw0t2EwvjrXLZ4iBnXB
         GSsWcQG0N02hb24xSYczKV++s0t7ihtv5KUr4bsOfpMzdbEVPgivr48iPpr02VZt8UYZ
         cgDxqSvE79plIm8rmPfO2Q+QSQTaMLDRzgrVTBH+ytYcrmjXjsr4EgeFLAW4cBsoveaK
         qd6BRfuFb4940Zd7sVYh140uiHcNx3Ewudt4etfuQ2wC2SlVKqFQuUDiVTpnRWxJu/Tu
         K1sw==
X-Gm-Message-State: ACgBeo1lS+zszAbNEy3zltIbEXetFprIpI02r1zNvKm4J1HMBXzl4jCf
        SsxCQOmQv7ukXz28++1ap5cAFggvSBs=
X-Google-Smtp-Source: AA6agR6tnpc15rOuInOrql8gSUcH9upaUnlMbRgDrT3Wk8XtoGK4DV88jFgk9B0Q7nj2TsQ+B3jrmQ==
X-Received: by 2002:a05:6000:1561:b0:22a:72a1:e3f1 with SMTP id 1-20020a056000156100b0022a72a1e3f1mr5392788wrz.456.1663021640859;
        Mon, 12 Sep 2022 15:27:20 -0700 (PDT)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id n186-20020a1ca4c3000000b003b47b80cec3sm7067940wme.42.2022.09.12.15.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:27:20 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: pressure: bmp280: fix datasheet links
Date:   Tue, 13 Sep 2022 00:26:44 +0200
Message-Id: <20220912222645.377874-1-ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <CAHp75VeSsVD8rMz-Cj6kFovqdQQPjbH7rUXWS6paRtsBaB-Kww@mail.gmail.com>
References: <CAHp75VeSsVD8rMz-Cj6kFovqdQQPjbH7rUXWS6paRtsBaB-Kww@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated links for BMP280 and BME280 datasheets on Bosch website.
Datasheet of BMP180 is no longer available on the manufacturer's website,
changed the link to a copy hosted by a third party.

Changelog in v2:
* Added a notice about the situation with bmp180 datasheet and list
  missing changes from newer versions.

Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fe7aa81e7cc9..01cd32003ca8 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -9,9 +9,15 @@
  * Driver for Bosch Sensortec BMP180 and BMP280 digital pressure sensor.
  *
  * Datasheet:
- * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP180-DS000-121.pdf
- * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP280-DS001-12.pdf
- * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280_DS001-11.pdf
+ * https://cdn-shop.adafruit.com/datasheets/BST-BMP180-DS000-09.pdf
+ * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp280-ds001.pdf
+ * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme280-ds002.pdf
+ *
+ * Notice:
+ * The link to the bmp180 datasheet points to an outdated version missing these changes:
+ * - Changed document referral from ANP015 to BST-MPS-AN004-00 on page 26
+ * - Updated equation for B3 param on section 3.5 to ((((long)AC1 * 4 + X3) << oss) + 2) / 4
+ * - Updated RoHS directive to 2011/65/EU effective 8 June 2011 on page 26
  */
 
 #define pr_fmt(fmt) "bmp280: " fmt

base-commit: 2f61ff8272967c9bdcba810aa978170814b08f7c
-- 
2.37.3

