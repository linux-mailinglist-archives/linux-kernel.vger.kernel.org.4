Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6CE72D042
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbjFLUN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjFLUNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:13:53 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94971709
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:13:47 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 8nv2q2OP12KZV8nv8qCDA3; Mon, 12 Jun 2023 22:13:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686600826;
        bh=J/2JLtm8exGsXMCV+3V9bGaq28GcUnszoK7rIe0Hpa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=X7fAGo4TuIVG+qDntP/1a5pzA/sKX+7zWKBY6X1z/QQg8NQKl1nygGq7wp5RnsHbG
         5iUOvRMvft8s7SKdlZDEXtx2+BbBDMGfTC0PjHkqtGyyfQGwyh4GMQyJ2X6MvjQ/pm
         S9fFpD4TxsSqI6dJxf2nx45UeQgQGSW6ICSzEW0hpxeRgHowCDAn6b6UWnuZUgEEIf
         QMbpXeemmSA/OYSmYMqitKsuquypMIdQtoXujve9hfa8Gti8Wid7x4fHVJU9E+aXvF
         GLArxT3+eeo4+CMWry/aL1V5VPqrF927hnYQ9kQ7XlrGGON/PaAnHQWxltWb4cQsCZ
         YUONXPyglvTwg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 12 Jun 2023 22:13:46 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: st_sensors: Remove some redundant includes in st_sensors.h
Date:   Mon, 12 Jun 2023 22:13:37 +0200
Message-Id: <bd7fa0b07c85172ecba384e239cb0ecf0780766a.1686600780.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <045ca726a9108325a3eaace807a264170895686c.1686600780.git.christophe.jaillet@wanadoo.fr>
References: <045ca726a9108325a3eaace807a264170895686c.1686600780.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to include i2c.h and spi/spi.h in st_sensors.h.
Should it be needed, st_sensors_(i2c|spi).h should be used.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Based on one of my script, this reduces the number of included files from
573 files to 515 files when compiling drivers/iio/accel/st_accel_buffer.c
---
 include/linux/iio/common/st_sensors.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 607c3a89a647..a1d3d57d6d6e 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -10,8 +10,6 @@
 #ifndef ST_SENSORS_H
 #define ST_SENSORS_H
 
-#include <linux/i2c.h>
-#include <linux/spi/spi.h>
 #include <linux/irqreturn.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
-- 
2.34.1

