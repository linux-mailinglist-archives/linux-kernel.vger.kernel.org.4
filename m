Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4536E6188A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiKCTTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiKCTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:19:30 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A567B21E29
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:17:46 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id z19-20020a056a001d9300b0056df4b6f421so1166202pfw.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 12:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdCA7mcVjAUWc0YMUhoHrXJZD+ZYpCbmWTqjMXRG8IY=;
        b=pnlY6lt9AE3Wye06t72FYxFjWn5g3gS0fYyXsxR0EfX0iDaUgNNrB5BITICOypIS4v
         q4gC+05NoCiVyqxHENvoesUvV+5e06TskofpdABhypIrppaUtTZgS0VJkCrkIY8XpmjJ
         uXRVZ8k4gKLVhedwUVuPFLI/G4yYmqlE947WazZ4jbcapJ8tkg5grM5q95OxH2PO5XIx
         SYzCBEW8+TTuccwEF4555/2r7zS9NqLnWMjVPhIcJz8YKrmEDa6nPPqpk9WgUKv3aheH
         rN2gf+RApGZ/ADXJq8rhn7ZSW+6dkaCUouR6TWVNKnQMTIJ2uQlhWUaIsPjmAnOgjqqf
         iDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdCA7mcVjAUWc0YMUhoHrXJZD+ZYpCbmWTqjMXRG8IY=;
        b=ToLvdViqvrpvQSK8FFmQrIR5gu16m1VNiR0Us4ERFSMFSt0d4nABifq8Lykkz7zgub
         ZhaTfBJcnuPgtVaCRMLbpUMh8gSYrfOAyavq7Jb5/c4iPD9oyTvWM+6r3E7oB2btpMm1
         zTU+80GLfMYSBf0u6Wmt2NadyvsFZkTqQmGSk99guq/dn00JWmi4urPMMzFfZDh/dwJc
         DZiJlJnAfyj4INHspSJprgHYqp1ifcWFWff5Yombpzem3AGZ6PvfOBgnO4ovApe9mPRj
         d7kGRkhkcs6Yre6+c8g7y2CYAh0H/Sff+fwjqmCT8ToRT8D+DVmY+GmsYgtJrEFc7RN1
         YObw==
X-Gm-Message-State: ACrzQf22198rMB4SltBMi2qxx+gUquAaXD1gfIdoioxg/31pHcxrq/td
        Q8MTxkySLMzmvW351i5j/BURk4hiJ1LG
X-Google-Smtp-Source: AMsMyM5Kdl8repQpl244UmXPbsHI32KFm+JzEqMV4d0SzRxSBkejh24SRjU+P86TpDCijL1kriw/DqwmBDZm
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:7348:b0:213:2708:8dc3 with SMTP id
 j8-20020a17090a734800b0021327088dc3mr608839pjs.2.1667503049368; Thu, 03 Nov
 2022 12:17:29 -0700 (PDT)
Date:   Thu,  3 Nov 2022 12:17:14 -0700
In-Reply-To: <20221103191719.1559407-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221103191719.1559407-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221103191719.1559407-3-vipinsh@google.com>
Subject: [PATCH v9 2/7] KVM: selftests: Put command line options in
 alphabetical order in dirty_log_perf_test
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc:     andrew.jones@linux.dev, wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
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

There are 13 command line options and they are not in any order. Put
them in alphabetical order to make it easy to add new options.

No functional change intended.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Reviewed-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/dirty_log_perf_test.c       | 36 ++++++++++---------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 56e08da3a87f..5bb6954b2358 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -406,50 +406,52 @@ int main(int argc, char *argv[])
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "eghi:p:m:nb:f:v:os:x:")) != -1) {
+	while ((opt = getopt(argc, argv, "b:ef:ghi:m:nop:s:v:x:")) != -1) {
 		switch (opt) {
+		case 'b':
+			guest_percpu_mem_size = parse_size(optarg);
+			break;
 		case 'e':
 			/* 'e' is for evil. */
 			run_vcpus_while_disabling_dirty_logging = true;
 			break;
+		case 'f':
+			p.wr_fract = atoi(optarg);
+			TEST_ASSERT(p.wr_fract >= 1,
+				    "Write fraction cannot be less than one");
+			break;
 		case 'g':
 			dirty_log_manual_caps = 0;
 			break;
+		case 'h':
+			help(argv[0]);
+			break;
 		case 'i':
 			p.iterations = atoi(optarg);
 			break;
-		case 'p':
-			p.phys_offset = strtoull(optarg, NULL, 0);
-			break;
 		case 'm':
 			guest_modes_cmdline(optarg);
 			break;
 		case 'n':
 			perf_test_args.nested = true;
 			break;
-		case 'b':
-			guest_percpu_mem_size = parse_size(optarg);
+		case 'o':
+			p.partition_vcpu_memory_access = false;
 			break;
-		case 'f':
-			p.wr_fract = atoi(optarg);
-			TEST_ASSERT(p.wr_fract >= 1,
-				    "Write fraction cannot be less than one");
+		case 'p':
+			p.phys_offset = strtoull(optarg, NULL, 0);
+			break;
+		case 's':
+			p.backing_src = parse_backing_src_type(optarg);
 			break;
 		case 'v':
 			nr_vcpus = atoi(optarg);
 			TEST_ASSERT(nr_vcpus > 0 && nr_vcpus <= max_vcpus,
 				    "Invalid number of vcpus, must be between 1 and %d", max_vcpus);
 			break;
-		case 'o':
-			p.partition_vcpu_memory_access = false;
-			break;
-		case 's':
-			p.backing_src = parse_backing_src_type(optarg);
-			break;
 		case 'x':
 			p.slots = atoi(optarg);
 			break;
-		case 'h':
 		default:
 			help(argv[0]);
 			break;
-- 
2.38.1.273.g43a17bfeac-goog

