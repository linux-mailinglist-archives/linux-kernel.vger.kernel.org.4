Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB9A617395
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKCBK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKCBKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:10:50 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A0E12760
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:10:50 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q1-20020a17090aa00100b002139a592adbso2647878pjp.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 18:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/vy9fIPcvn2rwaNqM4HfeZWrqvTDpalnz2HwsiIC1NU=;
        b=aDP5nCCE3d4x1FyofAIpujyLzNhqQX5ACcKmQzD89IqR+y5Fb5ybFRrypKxfYh/sRd
         5Jud/kEPqc3U82bG4IL/QiQN6j28f9ih7EOka58yWZbrqL8pWAnkKn7+9nb5nECpm7Lo
         MuFMPJ8/0L1nhRQOw7YcO0ONsRWg8esIjYcjn1V07njqfMFk0z58RpdSMLACtlTZrVu2
         rqpJ77/U5q7sj8jII1ZCxdH647mhOq74v8S84VEl/Up0SyDT0HjJgHJRretO4oT4AAvN
         KWQcNf3zR+Ytu8AKJwadHs/NJ18EHTEFJ/Gx3f4hlXNoIhxUqujJ96saSE5wy0/SMpVc
         NhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vy9fIPcvn2rwaNqM4HfeZWrqvTDpalnz2HwsiIC1NU=;
        b=Qvnh599yOTXeucu4nRp5dcwyhPV0WCKRug/JbmJBfgjGF+XhLWlR40JqEAhn1aNWb/
         mgMZ4Q4HVHTILEzbzbtjQj3zwdwmWGp+3j2YT4xJrAfrXSXKCH6HYPC4IrUmbjZaH239
         anNup839SQhkb9Y2XnhLr2yBT0+mJW+0sXFgf2oGu5yL/k0PbA7cuRzqyfOrU/Q4al0y
         /TzxkIM1Vae6b65IV3vgnATtj8mp8GbM2k0muSSpHrOWOfPK62ptpAzbVMCj+UU8Es4B
         uX/GaBahJry5ZNhLMZNWj17RqecHlc5e1NrMtroOp4sFA3/xU379jgrHaX53A9QDg3MB
         jX2A==
X-Gm-Message-State: ACrzQf30byTdlrcEwWqy9HjiQrv2Yi6c3ob5CC55U8+BX2bNJNHxKyvD
        wTroL7uWhwU51GSPKlBdIGUFrolNTgnacAvLp/OR3vU7i/IFb68vt5Mfz4MjOfvWx6KiMPjGPrj
        MRu5n1nrnNFYy61H4BotLvbRZwP5JMolxTsOyR6ATWEeuZwE/EndiCNxcT2gimBTZHbXBxSeVYo
        530IJ0lng=
X-Google-Smtp-Source: AMsMyM5EtDWAjQfv41Kno66MJVeSgoE6NBFzuwJ3clBidP2c5/OvehpdOviwMC+pzthFYy1liERdu4m+ZlisPVhuaQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90a:304b:b0:213:d60f:7fc6 with
 SMTP id q11-20020a17090a304b00b00213d60f7fc6mr20298759pjl.92.1667437849701;
 Wed, 02 Nov 2022 18:10:49 -0700 (PDT)
Date:   Thu,  3 Nov 2022 01:10:37 +0000
In-Reply-To: <20221103011038.1542614-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221103011038.1542614-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221103011038.1542614-4-dionnaglaze@google.com>
Subject: [PATCH v6 3/4] virt: sev-guest: Remove err in handle_guest_request
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Haowen Bai <baihaowen@meizu.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The err variable may not be set in the call to snp_issue_guest_request,
yet it is unconditionally written back to fw_err if fw_err is non-null.
This is undefined behavior, and currently returns uninitialized kernel
stack memory to user space.

The fw_err argument is better to just pass through to
snp_issue_guest_request, so we do that. Since the issue_request's
signature has changed fw_err to exitinfo2, we change the argument name
here.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Haowen Bai <baihaowen@meizu.com>
Cc: Liam Merwick <liam.merwick@oracle.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>

Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index f422f9c58ba7..0508c2f46f6b 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -303,9 +303,8 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 
 static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz, __u64 *fw_err)
+				u32 resp_sz, __u64 *exitinfo2)
 {
-	unsigned long err;
 	u64 seqno;
 	int rc;
 
@@ -322,9 +321,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		return rc;
 
 	/* Call firmware to process the request */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
-	if (fw_err)
-		*fw_err = err;
+	rc = snp_issue_guest_request(exit_code, &snp_dev->input, exitinfo2);
 
 	if (rc)
 		return rc;
-- 
2.38.1.273.g43a17bfeac-goog

