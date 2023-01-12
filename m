Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33C866792C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjALP0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240344AbjALP0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:26:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5DA3D1D5;
        Thu, 12 Jan 2023 07:18:41 -0800 (PST)
Date:   Thu, 12 Jan 2023 15:18:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673536719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a26o9qFZ1IQnwNC/53Q+fF2ma7/E4nJliNLMeedpM04=;
        b=FmZlNCl5soR6vWZ8LP9he5ATsHtWU8TSt6szbotLZ6eND360dBznV/cw10T+X8D7UpkUlK
        ECr4SrEP5hIHQrRWt0b2qVQNjuJsKk+mYzCe/DPWD3ttQ4xclGZ7OkcEP1Xr7MuFLHco/m
        qbOgGoVVt701K7r6EJRyDQnn2FglSssuemDFNZt0h2OWrmm9ojKmIuVGgdnrxQH+DH7QCz
        hvuJ6YQqKLlVTBTkrClVVS5BN5QXLlyZM1cGrmrGgwtbh94LkAR3MC+PStuR/sJ7+t7nQD
        6mcukE4WfY38488PowfSEtsIPwzn3lFxiI4H+jvGMLwRmLbjC6tALofVE16CTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673536719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a26o9qFZ1IQnwNC/53Q+fF2ma7/E4nJliNLMeedpM04=;
        b=U0cnG0gDc1/v2yW3zrobBlqzU1hBfp1gjUqqoJAtGvuipOtqt1A52uw2fK9FEpQOdjuIj+
        wlOmi4BZz36cLkBw==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Revert "selftests/rseq: Add
 mm_numa_cid to test script"
Cc:     kernel test robot <oliver.sang@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202301040903.2dd1e25b-oliver.sang@intel.com>
References: <202301040903.2dd1e25b-oliver.sang@intel.com>
MIME-Version: 1.0
Message-ID: <167353671881.4906.17023070386600990258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c91b0bf3e590a2dd0f2af4bb048abc0542eabf2e
Gitweb:        https://git.kernel.org/tip/c91b0bf3e590a2dd0f2af4bb048abc0542eabf2e
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Wed, 04 Jan 2023 11:35:42 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 12 Jan 2023 11:22:22 +01:00

selftests/rseq: Revert "selftests/rseq: Add mm_numa_cid to test script"

The mm_numa_cid related rseq patches from the series were not picked up
into the tip tree, so enabling the mm_numa_cid test needs to be
reverted.

This reverts commit b344b8f2d88dbf095caf97ac57fd3645843fa70f.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/oe-lkp/202301040903.2dd1e25b-oliver.sang@intel.com
---
 tools/testing/selftests/rseq/run_param_test.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
index 603b3b6..8d31426 100755
--- a/tools/testing/selftests/rseq/run_param_test.sh
+++ b/tools/testing/selftests/rseq/run_param_test.sh
@@ -47,11 +47,6 @@ function do_tests()
 		./param_test_mm_cid ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		echo "Running mm_cid compare-twice test ${TEST_NAME[$i]}"
 		./param_test_mm_cid_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
-
-		echo "Running mm_numa_cid test ${TEST_NAME[$i]}"
-		./param_test_mm_numa_cid ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
-		echo "Running mm_numa_cid compare-twice test ${TEST_NAME[$i]}"
-		./param_test_mm_numa_cid_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		let "i++"
 	done
 }
