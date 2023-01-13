Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E496C668E93
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbjAMG6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbjAMG4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:56:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B124571FE1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wZX1QHyWVerePTjeZ5i7Pceid0sAB6lehXeRpO+rbsY=; b=fkJCiGX3uPjL4wHWfrmDG9Ht32
        1bYX4lppLvWUk5bjEaJFCAO7BJNjGcv2PhIIkoBtu+/Zyv+VS5RYfnqaYfSzxp+QpywTDac/wIEbb
        hW1VvdunyhbeIDktd/kSJAvOrNg+nvpv3BhIjXUlwaxLYcogCBcCDbJsY4Z8uw0iJzuN6b8AxJZEk
        Xtm5JZg/pyCrcPUmMwNQdIzHWzEApCm4SXiXMilIylscwYIfGGG1+v6VGuWUT+Rx5wQ3nYJ+y5Z8A
        jROYQnuyg3k1UQ/DAC5y6/SRNGuHihFoqhGVxWB1HxYkOC4vfvTrhfON3WXFudv4lk3RMnVIi75xr
        AtT/yfvw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDl7-000r28-18; Fri, 13 Jan 2023 06:41:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Evgeniy Polyakov <zbr@ioremap.net>
Subject: [PATCH] w1: slaves: fix W=1 kernel-doc warnings
Date:   Thu, 12 Jan 2023 22:41:48 -0800
Message-Id: <20230113064148.32298-1-rdunlap@infradead.org>
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

Fix all W=1 kernel-doc warnings in drivers/w1/ by not using
"/**" to begin comments that are not in kernel-doc format.
Fixes these warnings:

drivers/w1/slaves/w1_ds2408.c:210: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Writing to the activity file resets the activity latches.
drivers/w1/slaves/w1_ds2433.c:46: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Check the file size bounds and adjusts count as needed.
drivers/w1/slaves/w1_ds2433.c:141: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Writes to the scratchpad and reads it back for verification.
drivers/w1/slaves/w1_ds28e04.c:57: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Check the file size bounds and adjusts count as needed.
drivers/w1/slaves/w1_ds28e04.c:149: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Writes to the scratchpad and reads it back for verification.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Evgeniy Polyakov <zbr@ioremap.net>
---
 drivers/w1/slaves/w1_ds2408.c  |    2 +-
 drivers/w1/slaves/w1_ds2433.c  |    4 ++--
 drivers/w1/slaves/w1_ds28e04.c |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff -- a/drivers/w1/slaves/w1_ds2408.c b/drivers/w1/slaves/w1_ds2408.c
--- a/drivers/w1/slaves/w1_ds2408.c
+++ b/drivers/w1/slaves/w1_ds2408.c
@@ -206,7 +206,7 @@ out:
 }
 
 
-/**
+/*
  * Writing to the activity file resets the activity latches.
  */
 static ssize_t activity_write(struct file *filp, struct kobject *kobj,
diff -- a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -42,7 +42,7 @@ struct w1_f23_data {
 	u32	validcrc;
 };
 
-/**
+/*
  * Check the file size bounds and adjusts count as needed.
  * This would not be needed if the file size didn't reset to 0 after a write.
  */
@@ -137,7 +137,7 @@ out_up:
 	return count;
 }
 
-/**
+/*
  * Writes to the scratchpad and reads it back for verification.
  * Then copies the scratchpad to EEPROM.
  * The data must be on one page.
diff -- a/drivers/w1/slaves/w1_ds28e04.c b/drivers/w1/slaves/w1_ds28e04.c
--- a/drivers/w1/slaves/w1_ds28e04.c
+++ b/drivers/w1/slaves/w1_ds28e04.c
@@ -53,7 +53,7 @@ struct w1_f1C_data {
 	u32	validcrc;
 };
 
-/**
+/*
  * Check the file size bounds and adjusts count as needed.
  * This would not be needed if the file size didn't reset to 0 after a write.
  */
@@ -145,7 +145,7 @@ out_up:
 	return count;
 }
 
-/**
+/*
  * Writes to the scratchpad and reads it back for verification.
  * Then copies the scratchpad to EEPROM.
  * The data must be on one page.
