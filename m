Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D5362D0AD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiKQBeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiKQBeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:34:18 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476F51DDF9;
        Wed, 16 Nov 2022 17:34:17 -0800 (PST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NCMs25BWqz4xVnD;
        Thu, 17 Nov 2022 09:34:14 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NCMry6TYlz4y3ZB;
        Thu, 17 Nov 2022 09:34:10 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AH1XxdK072447;
        Thu, 17 Nov 2022 09:33:59 +0800 (+08)
        (envelope-from guo.ziliang@zte.com.cn)
Received: from mapi (xaxapp03[null])
        by mapi (Zmail) with MAPI id mid32;
        Thu, 17 Nov 2022 09:34:00 +0800 (CST)
Date:   Thu, 17 Nov 2022 09:34:00 +0800 (CST)
X-Zmail-TransId: 2afb63758f887390f199
X-Mailer: Zmail v1.0
Message-ID: <202211170934005278113@zte.com.cn>
Mime-Version: 1.0
From:   <guo.ziliang@zte.com.cn>
To:     <rafael@kernel.org>
Cc:     <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIEFDUEk6IHN5c2ZzOiB1c2Ugc3lzZnNfZW1pdCgpIHRvIGluc3RlYWQgb2Ygc2NucHJpbnRmKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AH1XxdK072447
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63758F96.002 by FangMail milter!
X-FangMail-Envelope: 1668648854/4NCMs25BWqz4xVnD/63758F96.002/192.168.251.13/[192.168.251.13]/mxct.zte.com.cn/<guo.ziliang@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63758F96.002/4NCMs25BWqz4xVnD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: guo ziliang <guo.ziliang@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>
---
 drivers/acpi/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 2d81c74..7db3b53 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -198,7 +198,7 @@ static int param_set_trace_method_name(const char *val,

 static int param_get_trace_method_name(char *buffer, const struct kernel_param *kp)
 {
-       return scnprintf(buffer, PAGE_SIZE, "%s\n", acpi_gbl_trace_method_name);
+       return sysfs_emit(buffer, "%s\n", acpi_gbl_trace_method_name);
 }

 static const struct kernel_param_ops param_ops_trace_method = {
--
1.8.3.1
