Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6E772D041
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjFLUN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbjFLUNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:13:48 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BC210F9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:13:43 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 8nv2q2OP12KZV8nv2qCD99; Mon, 12 Jun 2023 22:13:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686600820;
        bh=C0M6mK52caELyzvGykIbR2TnUvJ7TdmnReFTsMllVYY=;
        h=From:To:Cc:Subject:Date;
        b=soYZ4Z1zClx9uA/59Yc5hZhdVWI68kOqEadC2OWkjc+bhbMltnjgANW3zXEY+jIkN
         nIwo051uMcEFR8+NptvigkAN6a0yRVYm2TMzBDN6AO1MyDLpan9IsBbethzp26WX7R
         XKmABLqhj13LtfHbs7uZNpu/d1ZHVUisotyIhYH3UoHu92b6daRouKk+6eI6WZ4Gzx
         m+edUtp14+QNKOxtl/y6I/gKrdWRRbFN5Yya6cxtVJwAu9caP27y1+DYpfatYCtUS/
         oeJFM7N8/P1tsXni6cPMBgcMho7wghJEUQlXiPgUs2d0o0/I5rz3vx50E0MZhYXlUv
         zgjrpuS3E2wJA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 12 Jun 2023 22:13:40 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: st_sensors: Remove some redundant includes
Date:   Mon, 12 Jun 2023 22:13:36 +0200
Message-Id: <045ca726a9108325a3eaace807a264170895686c.1686600780.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st_sensors_(i2c|spi).h already include st_sensors.h, so there is no need
to include it explicitly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/accel/st_accel_spi.c       | 1 -
 drivers/iio/gyro/st_gyro_i2c.c         | 1 -
 drivers/iio/gyro/st_gyro_spi.c         | 1 -
 drivers/iio/magnetometer/st_magn_i2c.c | 1 -
 drivers/iio/magnetometer/st_magn_spi.c | 1 -
 drivers/iio/pressure/st_pressure_i2c.c | 1 -
 drivers/iio/pressure/st_pressure_spi.c | 1 -
 7 files changed, 7 deletions(-)

diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index f72a24f45322..ae5bf3b47209 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -13,7 +13,6 @@
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 
-#include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_spi.h>
 #include "st_accel.h"
 
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 5a10a3556ab0..ceebd246100c 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -13,7 +13,6 @@
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 
-#include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_gyro.h"
 
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 22aaabe48e4a..afdb8dffd72d 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -13,7 +13,6 @@
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 
-#include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_spi.h>
 #include "st_gyro.h"
 
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 950826dd20bf..b9221794cf00 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -13,7 +13,6 @@
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 
-#include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_magn.h"
 
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index f203e1f87eec..5540500ba9fa 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -13,7 +13,6 @@
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 
-#include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_spi.h>
 #include "st_magn.h"
 
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 5101552e3f38..8ba0d1212401 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -14,7 +14,6 @@
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 
-#include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_pressure.h"
 
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 25cca5ad7c55..ffa1970a5aeb 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -13,7 +13,6 @@
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 
-#include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_spi.h>
 #include "st_pressure.h"
 
-- 
2.34.1

