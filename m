Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54397668EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbjAMHAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240902AbjAMG72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:59:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66946728AC;
        Thu, 12 Jan 2023 22:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fqIqaAISbuV78gm+ZKDzeP4zhLAE8UJMsDX1PuhwLYM=; b=PF+9Lz5ubQXlPIM+3pSVn+uTfE
        1xpi3CoxRQru/l6Jc/B6b1uHzY9agon7SxoUjud1qzx/0Kt6/6N27SlmayD3EI/uuH/qYR8B4844u
        3UDHrW1POSS16bZ97YxrTJcGpQ5OIj/vjEGr5Z721DQtisFdH3PNYU7M5lTwAGW3HtStpZz/Kpbg0
        dKGi7HhfPIO4W4fB/Ueyy/CIHETkTHlqj3THiTM9+ReAxYhHkxsmxybG29p21HcDsi59wulU7bv6O
        5xqgZTQt+F0GyK+NU4hSAbqaGU00jaeqxPRCkZxeo1IhamuVWFDpQpDrUXZdy2bhtgOpbFJHZzLth
        jaWG2Fkw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDp0-000sLV-U2; Fri, 13 Jan 2023 06:45:51 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: (hih6130) fix kernel-doc warnings
Date:   Thu, 12 Jan 2023 22:45:49 -0800
Message-Id: <20230113064549.21289-1-rdunlap@infradead.org>
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

Use the correct function name in kernel-doc comments to prevent these
warnings:

drivers/hwmon/hih6130.c:164: warning: expecting prototype for hih6130_show_temperature(). Prototype was for hih6130_temperature_show() instead
drivers/hwmon/hih6130.c:185: warning: expecting prototype for hih6130_show_humidity(). Prototype was for hih6130_humidity_show() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
---
 drivers/hwmon/hih6130.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/hwmon/hih6130.c b/drivers/hwmon/hih6130.c
--- a/drivers/hwmon/hih6130.c
+++ b/drivers/hwmon/hih6130.c
@@ -150,7 +150,7 @@ out:
 }
 
 /**
- * hih6130_show_temperature() - show temperature measurement value in sysfs
+ * hih6130_temperature_show() - show temperature measurement value in sysfs
  * @dev: device
  * @attr: device attribute
  * @buf: sysfs buffer (PAGE_SIZE) where measurement values are written to
@@ -172,7 +172,7 @@ static ssize_t hih6130_temperature_show(
 }
 
 /**
- * hih6130_show_humidity() - show humidity measurement value in sysfs
+ * hih6130_humidity_show() - show humidity measurement value in sysfs
  * @dev: device
  * @attr: device attribute
  * @buf: sysfs buffer (PAGE_SIZE) where measurement values are written to
