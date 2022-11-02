Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0179615914
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiKBDE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiKBDDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:03:50 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EFF23157
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 20:03:37 -0700 (PDT)
X-UUID: 62be35110c8c4e9cb0491871ab831092-20221102
X-CPASD-INFO: 179bf9045a37408e83ca3bb448de10ca@eodzgpNrXmRhgXWDg3ODn1hkk5FjjoK
        DdnKElV9gj4GVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBgXoZgUZB3gHlzgpZnYA==
X-CLOUD-ID: 179bf9045a37408e83ca3bb448de10ca
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:185.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:83.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5.
        0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-5
        ,AUF:15,DUF:7224,ACD:128,DCD:128,SL:0,EISP:0,AG:0,CFC:0.612,CFSR:0.068,UAT:0,
        RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0
        ,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 62be35110c8c4e9cb0491871ab831092-20221102
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 62be35110c8c4e9cb0491871ab831092-20221102
X-User: chenzhang@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <chenzhang@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 992120326; Wed, 02 Nov 2022 11:03:38 +0800
From:   chen zhang <chenzhang@kylinos.cn>
To:     gregkh@linuxfoundation.org, error27@gmail.com, ztong0001@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        chen zhang <chenzhang@kylinos.cn>, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v2] staging: rtl8192u: Fix typo in comments
Date:   Wed,  2 Nov 2022 11:03:30 +0800
Message-Id: <20221102030330.22049-1-chenzhang@kylinos.cn>
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
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 0a60ef20107c..f6a0992b059b 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4574,7 +4574,7 @@ static int rtl8192_usb_probe(struct usb_interface *intf,
 	return ret;
 }
 
-/* detach all the work and timer structure declared or inititialize
+/* detach all the work and timer structure declared or initialize
  * in r8192U_init function.
  */
 static void rtl8192_cancel_deferred_work(struct r8192_priv *priv)
-- 
2.25.1

