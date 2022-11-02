Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475316172BD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiKBXgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiKBXg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:36:27 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6181D64E0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:28:25 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id b1-20020a17090a10c100b0020da29fa5e5so85790pje.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 16:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdCA7mcVjAUWc0YMUhoHrXJZD+ZYpCbmWTqjMXRG8IY=;
        b=PGaFr+qGgiFZsuqNJ4r0qGcqe0peI7+c4i53VjKhst54w0URdIJKXzZNrE1Ly93vHm
         ZUbVyccc+uf8FdIO/NLMK+zN19LS2ILfB8gdsaXOgRqmNf5gNf8Sq41ErU5US7FBhDnN
         IbJDzyfjQaKFpkHkPl3bYwopRjVjLACAqEC0DNB29g1Ge5y9OBvBYWx5FgfCeRj47bTd
         uP0JA8MOwOO3U1UGREYehl5yuws8MbqIXcCuXKo+lp0r7KUXTVAPpiUkXP49Oc4FpCms
         bJYwo+JQ3/cJgnCgmhkiynV8huNUX8jXmwm0fx3NQvdXEGtKtu0iZB7J+Ljry5Hp06qq
         yEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdCA7mcVjAUWc0YMUhoHrXJZD+ZYpCbmWTqjMXRG8IY=;
        b=s5z3+ULMvN782tjsjGE35o4jCaaPV5SC6OhzOPyhs3qlNakcaAUoxs8ufwXfKL7J7X
         vpT41/CY4BL7Uc79sUgiV+PGjBGkFkAMLi1/3MW1u0wBtibaN6+llmTT91oovjjXVIWq
         YetP3tI3DUVchIw0vtsi6QY7QCtciihQZKpIL95JetJZ6pF3BeTRRTzjH+vQo9EopGZ/
         m8DzLetCEZAakIo/rp4KLjAXhAOkIuj8d84sCni1ndRCznEL9xtU7TUXzS3OuWhSGUu2
         eeQIpczFqdNBe9j5gXKu+WwYaGQAUwXCA76OQDXXfuiJKy8JDeo9I7ISnYiPzn1BhLlR
         ue0w==
X-Gm-Message-State: ACrzQf0w6U0J7rGHDkOjvBupGlujDXMLiLEYbirCw5HBlax/pHKt4N0J
        IX87pyaJUH997RSu8+Ka+aQDT7bLfKMo
X-Google-Smtp-Source: AMsMyM5M51SBliksPw4hjyh5H8KgxwpLFcsPlsHV+oP4PcuheLjuLujI4gSr6/UNQROWpz1JhoxEzZ9Vk5HT
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:903:2342:b0:181:bc30:b02f with SMTP id
 c2-20020a170903234200b00181bc30b02fmr27154262plh.30.1667431664230; Wed, 02
 Nov 2022 16:27:44 -0700 (PDT)
Date:   Wed,  2 Nov 2022 16:27:32 -0700
In-Reply-To: <20221102232737.1351745-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221102232737.1351745-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102232737.1351745-3-vipinsh@google.com>
Subject: [PATCH v8 2/7] KVM: selftests: Put command line options in
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

