Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53536080A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiJUVSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiJUVSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:18:30 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93E72A4E0D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:18:28 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a11-20020a056a001d0b00b005635c581a24so1904869pfx.17
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vMVJJoBCzsMQyaPTMVzkUL5zwK0EC1PhaZ6zsLS80Z8=;
        b=HJ9djxnnBohMH2BuprRhqnTKlyK1QQaQQXtmQoanmuQoqUMDQMYGc9BSE002jjc0Fg
         DXHA1NrvZ90Vx0Glb1IZHVqqv5aPUe/3FdfYJxiuPWrI03UNtpkP0nS5o36wpmdQV6pf
         X5T5T7j6X1VRYDo+/BCdUkiM6ydddIS4Iw/VRrYJqljLPLzI1gwN0EnFx9cKBddI+89F
         +NVywaVi0bTZqZf4HCCwUrqDXjMJzdy1hu+yOpcnO22t4ecRkNrjuBWdccFZzlJmAb9H
         sKLwBYRi4ODZCSnVQBhSxMtJC1HB/hs1CvqxRcnzUjdoq6MWB9hbqGRsgI0ARWqSZagv
         53ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMVJJoBCzsMQyaPTMVzkUL5zwK0EC1PhaZ6zsLS80Z8=;
        b=QSmF9gAaHjEVOuuNLFWTAMWloOi1/5sqJjJrsutCtPdIJk2RMbNvtmL2urmrEcBtZz
         JqErexjdAG+dJaikfSi+xI7SYwNFW+F+eO/Jh63Jb5c3yy4qcZpiKAZY0LY+tN8Ox/CD
         rFprUaCaFqKyl44HicgUdYhDwK32ioIy2qmKuTBB5XT4Y2teXOehut/QbKc6M+cxgR/E
         avK6Zpy3vlBJV38S3zH9L/ulcvsmeCRUoPmeK5vivUKK0AMXLA8zU1W82uZcpo3w4t2u
         4eNy4z3K+XMfjsE/xU4LvXghfPygnUL0N5Bgt8ZF2EyreyTpudDguUqIW+DHqDh3wdQ3
         iDdA==
X-Gm-Message-State: ACrzQf04XyNmA6QdzzhiRi0FxdEhbsoFx+sMVs5TNZbf7TuHUQCcnrdo
        aYwHFkVHwNQan2n5xFREiv4G5uvqBFXL
X-Google-Smtp-Source: AMsMyM7V4uXgcGGlfWbQJ7+kkGcksx4OvxRBy8B8Ny2q3pJ+N0RT61EiANiSuuOJzJcLOB5DiO2vhb55kYZq
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a05:6a00:1306:b0:555:6d3f:11ed with SMTP
 id j6-20020a056a00130600b005556d3f11edmr21113463pfu.55.1666387107996; Fri, 21
 Oct 2022 14:18:27 -0700 (PDT)
Date:   Fri, 21 Oct 2022 14:18:13 -0700
In-Reply-To: <20221021211816.1525201-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221021211816.1525201-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021211816.1525201-3-vipinsh@google.com>
Subject: [PATCH v6 2/5] KVM: selftests: Put command line options in
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
2.38.0.135.g90850a2211-goog

