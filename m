Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC116173C5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiKCBda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKCBd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:33:28 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A9A60FF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:33:22 -0700 (PDT)
X-UUID: 63241d4bb1804973853be90ccfa0acb7-20221103
X-CPASD-INFO: 0ae3ba845421497eaf831dbfadd630ad@ebGfU4-TZmRhVHR9g3yCn4GXaGNikIK
        1o56EaGFgjYSVhH5xTV5uYFV9fWtVYV9dYVR6eGxQY2BgZFJ4i3-XblBiXoZgUZB3f6OfU5SPaA==
X-CLOUD-ID: 0ae3ba845421497eaf831dbfadd630ad
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:2.0,URL:-5,TVAL:185.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:1.0,CUTS:136.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:2.0,CFOB:2.0,SPC:0,SIG:-
        5,AUF:19,DUF:7304,ACD:129,DCD:129,SL:0,EISP:0,AG:0,CFC:0.447,CFSR:0.02,UAT:0,
        RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0
        ,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 63241d4bb1804973853be90ccfa0acb7-20221103
X-CPASD-BLOCK: 1001
X-CPASD-STAGE: 1
X-UUID: 63241d4bb1804973853be90ccfa0acb7-20221103
X-User: chenzhang@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <chenzhang@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 171813269; Thu, 03 Nov 2022 09:33:24 +0800
From:   chen zhang <chenzhang@kylinos.cn>
To:     hdegoede@redhat.com, rdunlap@infradead.org, bagasdotme@gmail.com
Cc:     linux-kernel@vger.kernel.org, chenzhang_0901@163.com,
        chen zhang <chenzhang@kylinos.cn>, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v3] platform/x86: ISST: Fix typo in comments
Date:   Thu,  3 Nov 2022 09:33:13 +0800
Message-Id: <20221103013313.13278-1-chenzhang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,T_SPF_PERMERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling typo in comments.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: chen zhang <chenzhang@kylinos.cn>
---
v3: Change "interace" to "interfaces", Change "share" to "shared"
Thanks for your advice.
v2: update the comments
There is a bug with my company's mailbox with kylinos.cn, and sometimes 
I can't receive reply emails. I cc my personal 163 mailbox, so that I can
receive feedback from reviewer on time.
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index fd102678c75f..a7e02b24a87a 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -623,7 +623,7 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 
 /* Lock to prevent module registration when already opened by user space */
 static DEFINE_MUTEX(punit_misc_dev_open_lock);
-/* Lock to allow one share misc device for all ISST interace */
+/* Lock to allow one shared misc device for all ISST interfaces */
 static DEFINE_MUTEX(punit_misc_dev_reg_lock);
 static int misc_usage_count;
 static int misc_device_ret;
-- 
2.25.1

