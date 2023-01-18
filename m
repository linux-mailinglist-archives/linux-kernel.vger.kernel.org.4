Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32E6670F87
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjARBH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjARBGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:06:51 -0500
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9102510D5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:57:11 -0800 (PST)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id NRX00008
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:57:08 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 08:57:08 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] firmware: memmap: fix typos in comments
Date:   Tue, 17 Jan 2023 19:57:02 -0500
Message-ID: <20230118005702.4291-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201619.home.langchao.com (10.100.2.19)
tUid:   202311808570837e3f817f95849883bc248b505887c70
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change `syfs` to `sysfs`.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/firmware/memmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
index 8e59be3782cb..8e72bd678b4e 100644
--- a/drivers/firmware/memmap.c
+++ b/drivers/firmware/memmap.c
@@ -275,7 +275,7 @@ firmware_map_find_entry_bootmem(u64 start, u64 end, const char *type)
  *
  * Adds a firmware mapping entry. This function is for memory hotplug, it is
  * similar to function firmware_map_add_early(). The only difference is that
- * it will create the syfs entry dynamically.
+ * it will create the sysfs entry dynamically.
  *
  * Return: 0 on success, or -ENOMEM if no memory could be allocated.
  */
-- 
2.27.0

