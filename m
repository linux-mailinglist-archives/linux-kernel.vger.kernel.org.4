Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F59F5F6C8C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiJFRMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiJFRME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:12:04 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5772A925B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:11:57 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h2-20020a656382000000b0044b0f6c572fso1470555pgv.20
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 10:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+m8/CnpnyvF/GMTtF6+sToX6YjEtcCxB1JvOB9LqxJw=;
        b=bEEeGStkWQ9tDtAKZlxY+aXZsDrTvhsrjG04Pv36MqoKltKsnid4WbSy2RSNz46eE+
         wfMcjVWl30Yvd54pq3N34yb9539uZvYgC1OqaNs68OFdNrnaTYseY/fOh+MpHckIwEBe
         om+WC3S1xvhTToqZsFJmFKV3IHMISih/NJsHOm01cRYXL04CDsGEjB8f4IQr8qGGC3H1
         rFkrCgzmZvGwDiBo57nLXz4BIgvbXz+CDL7bnk+KwTIPGPtv6tL/roFLdolKl9JTlWsZ
         hacEcHi7jCRUmtO66Z6LEaoAwNtXunMpfTFunchWUiMrMak5YiOYZvLavEib/T8RlMM5
         Ta7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+m8/CnpnyvF/GMTtF6+sToX6YjEtcCxB1JvOB9LqxJw=;
        b=IwPzkqlCG31GDv0sGZMYSMsFDdOrPk5EJWW7Mza5bsXvSCjtN23kJcUjHuhIOeGvE3
         M+0jLNc9b2eLp/uo3IWpE0/7DmN/sQfh4lYG2YHcJu/iAiRmdWdyubEHpXazqd4c05x2
         KUPmS56XI1QmP9srEkeJFvHUEJE+1E8XB2t0ETO8Cx0AZHCWMJu1CvzmG5xvazOG+u7Z
         hxoygjB9Q5CsV6qUU8I0o/VS/5ta/sE79N4cBX2K9Ll0fMx4ii1bBLITAXTiDkWB6jcy
         LiMOaK8xRivpHttYbYHKrkSYyy70zi5+UOmFQZuFDtc+xcsR4YU+yvA6btsdvpMvRb9p
         Ncng==
X-Gm-Message-State: ACrzQf0GtKt4sGxR+XeqygJqGQuF59/UMlzbCb89z6YLM0yIcmrTz3bs
        yCHjvshrfAL6jK46Y1zdvLW7tAs48NKE
X-Google-Smtp-Source: AMsMyM4EuWUAtLJuSMcBhnzgG5uMCwio8Ayx/qHOQZsTb78oFzUaXV1VZD7SwBIexyvMajxtUufsLA/RzpgT
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:902:d591:b0:17d:9cd9:2ae6 with SMTP id
 k17-20020a170902d59100b0017d9cd92ae6mr409223plh.165.1665076316595; Thu, 06
 Oct 2022 10:11:56 -0700 (PDT)
Date:   Thu,  6 Oct 2022 10:11:30 -0700
In-Reply-To: <20221006171133.372359-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221006171133.372359-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006171133.372359-3-vipinsh@google.com>
Subject: [PATCH v4 2/4] KVM: selftests: Put command line options in
 alphabetical order in dirty_log_perf_test
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc:     andrew.jones@linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
2.38.0.rc1.362.ged0d419d3c-goog

