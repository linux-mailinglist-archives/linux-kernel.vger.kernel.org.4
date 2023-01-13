Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09782668EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241203AbjAMHAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbjAMG7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:59:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4666B5E3;
        Thu, 12 Jan 2023 22:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=09K4dkdI4zxUjfN9hP0vNQGNi8DcDHDFtxm3QRSJOl8=; b=mJ3xHkmeskeJf6lJ1SV35HIbSZ
        8LC0ERiioH7FZq1/DcX+ea4RM9nVneJI3S3pGidp6fikinA7bNd7xLlSdYVIbmi0ypXCiGygaNGo/
        KmFx5zJ6FT36pSUd0Kv6+McYR8xWi+k3KKzHXm3p9wGOJUVXU4MCOH6CYPzzB/icp9P6/AAnxcilx
        5+xLRg0fnuL28SAM9pyL1oz22jL6goQTP8fHYzcsd9Mdpx6Izf4MyAakjVCTfNm2MCDJ0/9FuFdDa
        qSZtVUomvC5KSc1Finjv0X2+1kLTcWSIMlH5UqIQvRXhz7H9lwZGfvVNgMnDvssPKz7qi5ajq0jsy
        KDpDiHRw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDoq-000sGa-O0; Fri, 13 Jan 2023 06:45:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: (emc2305) fix kernel-doc warnings
Date:   Thu, 12 Jan 2023 22:45:40 -0800
Message-Id: <20230113064540.20179-1-rdunlap@infradead.org>
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

Fix kernel-doc warnings:
drivers/hwmon/emc2305.c:62: warning: Cannot understand  * @cdev: cooling device;
 on line 62 - I thought it was a doc line
drivers/hwmon/emc2305.c:89: warning: Cannot understand  * @client: i2c client;
 on line 89 - I thought it was a doc line

and drop ';' at end of each struct member line.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
---
 drivers/hwmon/emc2305.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff -- a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -59,10 +59,11 @@ static const struct i2c_device_id emc230
 MODULE_DEVICE_TABLE(i2c, emc2305_ids);
 
 /**
- * @cdev: cooling device;
- * @curr_state: cooling current state;
- * @last_hwmon_state: last cooling state updated by hwmon subsystem;
- * @last_thermal_state: last cooling state updated by thermal subsystem;
+ * struct emc2305_cdev_data - device-specific cooling device state
+ * @cdev: cooling device
+ * @cur_state: cooling current state
+ * @last_hwmon_state: last cooling state updated by hwmon subsystem
+ * @last_thermal_state: last cooling state updated by thermal subsystem
  *
  * The 'last_hwmon_state' and 'last_thermal_state' fields are provided to support fan low limit
  * speed feature. The purpose of this feature is to provides ability to limit fan speed
@@ -86,13 +87,14 @@ struct emc2305_cdev_data {
 };
 
 /**
- * @client: i2c client;
- * @hwmon_dev: hwmon device;
- * @max_state: maximum cooling state of the cooling device;
- * @pwm_num: number of PWM channels;
- * @pwm_separate: separate PWM settings for every channel;
- * @pwm_min: array of minimum PWM per channel;
- * @cdev_data: array of cooling devices data;
+ * struct emc2305_data - device-specific data
+ * @client: i2c client
+ * @hwmon_dev: hwmon device
+ * @max_state: maximum cooling state of the cooling device
+ * @pwm_num: number of PWM channels
+ * @pwm_separate: separate PWM settings for every channel
+ * @pwm_min: array of minimum PWM per channel
+ * @cdev_data: array of cooling devices data
  */
 struct emc2305_data {
 	struct i2c_client *client;
