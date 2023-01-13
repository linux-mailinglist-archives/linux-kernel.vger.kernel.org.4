Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAD5668EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbjAMHAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241097AbjAMG7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:59:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24718235;
        Thu, 12 Jan 2023 22:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MmWO9HI/fqEBVN+B802vvmSHYfQAKEOqu/eZMK0viVI=; b=1uCHAczluEigvg/9GbYT3i7R8y
        ArTnj5v+tWDuLLTd2kT5UVAV/vTSIhCRq+trNvfA8VzmlcZtSJVLANTzg6rXZtHERpS4sEw9YfojZ
        ho4YVDpT9VDbjoAm5IGpHW2QiPCR/55JI4mF6zUCRk1kh0+tfCefabumyRqJzK1fB5XAmKssHos37
        RhSLO/UEzmCv3eYeA50V4WgU73L/OrUs4vTu2K2IY4uk7zJSGGAkHiayCQK+RmHTf0Vemq9K56tTq
        WYFtr9WWJDFbkct+tyvapp+yrVNmjYsMdFLfOYy1Zb0nuISvq1NNo5qqHtriChBIMdjCxeO5xgCA4
        8TQwZFfQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDp7-000sPw-FO; Fri, 13 Jan 2023 06:45:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: (sht15,sht21) fix kernel-doc warnings
Date:   Thu, 12 Jan 2023 22:45:56 -0800
Message-Id: <20230113064556.21685-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct function names in kernel-doc comments to prevent these
warnings:

drivers/hwmon/sht15.c:682: warning: expecting prototype for sht15_show_status(). Prototype was for sht15_status_show() instead
drivers/hwmon/sht15.c:705: warning: expecting prototype for sht15_store_heater(). Prototype was for sht15_status_store() instead
drivers/hwmon/sht15.c:738: warning: expecting prototype for sht15_show_temp(). Prototype was for sht15_temp_show() instead
drivers/hwmon/sht15.c:760: warning: expecting prototype for sht15_show_humidity(). Prototype was for sht15_humidity_show() instead
drivers/hwmon/sht21.c:128: warning: expecting prototype for sht21_show_temperature(). Prototype was for sht21_temperature_show() instead
drivers/hwmon/sht21.c:149: warning: expecting prototype for sht21_show_humidity(). Prototype was for sht21_humidity_show() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
---
 drivers/hwmon/sht15.c |    8 ++++----
 drivers/hwmon/sht21.c |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff -- a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -668,7 +668,7 @@ static inline int sht15_calc_humid(struc
 }
 
 /**
- * sht15_show_status() - show status information in sysfs
+ * sht15_status_show() - show status information in sysfs
  * @dev:	device.
  * @attr:	device attribute.
  * @buf:	sysfs buffer where information is written to.
@@ -690,7 +690,7 @@ static ssize_t sht15_status_show(struct
 }
 
 /**
- * sht15_store_heater() - change heater state via sysfs
+ * sht15_status_store() - change heater state via sysfs
  * @dev:	device.
  * @attr:	device attribute.
  * @buf:	sysfs buffer to read the new heater state from.
@@ -725,7 +725,7 @@ static ssize_t sht15_status_store(struct
 }
 
 /**
- * sht15_show_temp() - show temperature measurement value in sysfs
+ * sht15_temp_show() - show temperature measurement value in sysfs
  * @dev:	device.
  * @attr:	device attribute.
  * @buf:	sysfs buffer where measurement values are written to.
@@ -747,7 +747,7 @@ static ssize_t sht15_temp_show(struct de
 }
 
 /**
- * sht15_show_humidity() - show humidity measurement value in sysfs
+ * sht15_humidity_show() - show humidity measurement value in sysfs
  * @dev:	device.
  * @attr:	device attribute.
  * @buf:	sysfs buffer where measurement values are written to.
diff -- a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -114,7 +114,7 @@ out:
 }
 
 /**
- * sht21_show_temperature() - show temperature measurement value in sysfs
+ * sht21_temperature_show() - show temperature measurement value in sysfs
  * @dev: device
  * @attr: device attribute
  * @buf: sysfs buffer (PAGE_SIZE) where measurement values are written to
@@ -136,7 +136,7 @@ static ssize_t sht21_temperature_show(st
 }
 
 /**
- * sht21_show_humidity() - show humidity measurement value in sysfs
+ * sht21_humidity_show() - show humidity measurement value in sysfs
  * @dev: device
  * @attr: device attribute
  * @buf: sysfs buffer (PAGE_SIZE) where measurement values are written to
