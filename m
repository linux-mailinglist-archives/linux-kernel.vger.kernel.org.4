Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D321B615A62
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiKBDaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiKBD3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:29:52 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1CE2656E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 20:29:48 -0700 (PDT)
X-UUID: 0df324e9a4c04a1cb5026f7fec8996c0-20221102
X-CPASD-INFO: 5214261e0dfa43d1bb22a58e783c426a@foJrVF9oX5VchKitg3ava4KTZl6BhHq
        fV2hhk2BSi7OMbFJkYl1ZgYFqUWJpX2FZVXp4blJgYGJcWHh4lHKPVGBeYIJUdJOAd2xRZGBm
X-CLOUD-ID: 5214261e0dfa43d1bb22a58e783c426a
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:185.
        0,ESV:0.0,ECOM:-5.0,ML:14.0,FD:0.0,CUTS:113.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-
        5.0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:
        -5,AUF:16,DUF:7232,ACD:128,DCD:128,SL:0,EISP:0,AG:0,CFC:0.52,CFSR:0.021,UAT:0
        ,RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:
        0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 0df324e9a4c04a1cb5026f7fec8996c0-20221102
X-CPASD-BLOCK: 14
X-CPASD-STAGE: 1
X-UUID: 0df324e9a4c04a1cb5026f7fec8996c0-20221102
X-User: chenzhang@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <chenzhang@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2125014377; Wed, 02 Nov 2022 11:29:49 +0800
From:   chen zhang <chenzhang@kylinos.cn>
To:     hdegoede@redhat.com
Cc:     linux-kernel@vger.kernel.org, chenzhang_0901@163.com,
        chen zhang <chenzhang@kylinos.cn>, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] platform/x86: ISST: Fix typo in comments
Date:   Wed,  2 Nov 2022 11:29:40 +0800
Message-Id: <20221102032940.24912-1-chenzhang@kylinos.cn>
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
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index fd102678c75f..c1d7f4f38765 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -623,7 +623,7 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 
 /* Lock to prevent module registration when already opened by user space */
 static DEFINE_MUTEX(punit_misc_dev_open_lock);
-/* Lock to allow one share misc device for all ISST interace */
+/* Lock to allow one share misc device for all ISST interface */
 static DEFINE_MUTEX(punit_misc_dev_reg_lock);
 static int misc_usage_count;
 static int misc_device_ret;
-- 
2.25.1

