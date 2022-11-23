Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7B4634E79
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 04:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiKWDme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 22:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbiKWDmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 22:42:31 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A19ACD4;
        Tue, 22 Nov 2022 19:42:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VVV8TGg_1669174943;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VVV8TGg_1669174943)
          by smtp.aliyun-inc.com;
          Wed, 23 Nov 2022 11:42:26 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     rafael@kernel.org
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ACPI: bus: make osc_sb_ffh_opregion_support_confirmed static
Date:   Wed, 23 Nov 2022 11:42:15 +0800
Message-Id: <20221123034215.119461-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of bus.c, so marks it static.

drivers/acpi/bus.c:304:6: warning: symbol 'osc_sb_ffh_opregion_support_confirmed' was not declared. Should it be static?

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3241
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/acpi/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a5ec8120e510..c2effd3f56ab 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -301,7 +301,7 @@ EXPORT_SYMBOL_GPL(osc_sb_native_usb4_support_confirmed);
 
 bool osc_sb_cppc2_support_acked;
 
-bool osc_sb_ffh_opregion_support_confirmed;
+static bool osc_sb_ffh_opregion_support_confirmed;
 
 static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
 static void acpi_bus_osc_negotiate_platform_control(void)
-- 
2.20.1.7.g153144c

