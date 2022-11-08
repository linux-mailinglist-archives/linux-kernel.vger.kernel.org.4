Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51888621E8E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKHVci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKHVcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:32:33 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39476176A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 13:32:32 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id o7-20020a170902d4c700b001868cdac9adso12000992plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 13:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6KVCLfVygq1k3xfQxWHSpnj24cxWuIfItMrTfQREV0k=;
        b=guRac4bj6Iv5ovM6ORxT521q3mfUZ0Tw298MV6FSMx2DHp6RxZCINoP7Z7+2mogaQ6
         Owwyx9TNQ0DLSm8uEYjFw1y1WoxdUs5EkJy+jEz/6da2ikpgHlK0iclhaScwSfBlbabG
         3A3IMDaWGTYiok5PTWkshF01dwRDrMG/4P/nafPV6y+zMRnB4V2uoG15EMANyWwp/r6f
         JUzVtVsjYCHOg9HyKN4Q23M1/9wwvC1Y99B/AC4qgy4xzdVZ8scMOn0Xgb4OncRWZ/AU
         snQcdJEBLTd+FB32kGnmtURFHBi2oSK+gGlBEYUVYneKk0SCELU3W/LeabjeZ4aj6mz5
         9D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KVCLfVygq1k3xfQxWHSpnj24cxWuIfItMrTfQREV0k=;
        b=jb9hnWGy/9RK2W0Zg2l1BLPC8NRHI9Y6S2h07S+p0pnvrVDUKzRwO39fCvOfZXcooj
         MOICY+dCGuguZA1+CUHtgA68TCAuocOF9xMo83IOZvA18Bbsu8LCfPI92oe/JX7a61ss
         K1wylONMP/bRhytHfX/fRL9tLnG4AlwVZBjfeEtU7ZOCaULUrU1ACRgHt1taDmiZsubb
         GXjDAKq+aoH6aFGnLQXeYLU+t/og/9kb3P1Tm+w9wMoL1XWyps5tFKtp/knFFm/SnO37
         O4lKa3tCygPYjBwwDuZJCfiGze/njrn/5VUm741z5q/wnaBpu0+MtJD1pQ/KXenzoE7O
         TcYg==
X-Gm-Message-State: ACrzQf3WXm1V5vJvdPlDCSki3HTdRZ/C0+qldYPVq6Llsgx74FutgWls
        JLLkncnb2u3a0EtLgR8ZbqGKmpLmn4Ix+kmpycndxT2LPg9tXOaA7+SoROAvIoZ3o8vvxip1wGD
        dYOaKCX/S2r9zizzno3eZ+VpAZovhlD3vvsIjbQYlbSEAEpkc2JFZefiKV4Ubb3GXtBYngtRXwi
        r+sEL4/Jc=
X-Google-Smtp-Source: AMsMyM4Bgk6d+ZWIBxyGcsbyvwL6TLevGQSeE3B6pICu5ZNDC+EAOoHxEbrFuKY8j6N35LVoE50Me6DY03uXkNFRpg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:903:264b:b0:186:af7a:391d with
 SMTP id je11-20020a170903264b00b00186af7a391dmr58090859plb.19.1667943152082;
 Tue, 08 Nov 2022 13:32:32 -0800 (PST)
Date:   Tue,  8 Nov 2022 21:32:26 +0000
In-Reply-To: <20221108213226.3340496-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221108213226.3340496-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221108213226.3340496-3-dionnaglaze@google.com>
Subject: [PATCH 2/2] kvm: sev: If ccp is busy, report throttled to guest
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>
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

The ccp driver can be overloaded even with 1 HZ throttling. The return
value of -EBUSY means that there is no firmware error to report back to
user space, so the guest VM would see this as exitinfo2 = 0. The false
success can trick the guest to update its the message sequence number
when it shouldn't have.

Instead, when ccp returns -EBUSY, we report that to userspace as the
throttling return value.

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/kvm/svm/sev.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a9f67bfd60d9..6493fb527110 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3641,7 +3641,13 @@ static void snp_handle_guest_request(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t
 		goto unlock;
 
 	rc = sev_issue_cmd(kvm, SEV_CMD_SNP_GUEST_REQUEST, &data, &err);
-	if (rc)
+	/*
+	 * The ccp driver can return -EBUSY if the PSP is overloaded, so
+	 * we offer that as a throttling signal too.
+	 */
+	if (rc == -EBUSY)
+		rc = SNP_GUEST_REQ_THROTTLED;
+	else if (rc)
 		/* use the firmware error code */
 		rc = err;
 
@@ -3698,7 +3704,14 @@ static void snp_handle_ext_guest_request(struct vcpu_svm *svm, gpa_t req_gpa, gp
 
 	rc = snp_guest_ext_guest_request(&req, (unsigned long)sev->snp_certs_data,
 					 &data_npages, &err);
-	if (rc) {
+	/*
+	 * The ccp driver can return -EBUSY if the PSP is overloaded, so
+	 * we offer that as a throttling signal too.
+	 */
+	if (rc == -EBUSY) {
+               rc = SNP_GUEST_REQ_THROTTLED;
+	       goto cleanup;
+	} else if (rc) {
 		/*
 		 * If buffer length is small then return the expected
 		 * length in rbx.
-- 
2.38.1.431.g37b22c650d-goog

