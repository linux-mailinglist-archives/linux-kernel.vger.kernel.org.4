Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4E75F07A0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiI3Jba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiI3JbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:31:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F16EC902D;
        Fri, 30 Sep 2022 02:31:06 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:31:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664530264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4q5jmrvANuAXc5hhK5/6sYAQwRIKCMij9bcglc9rC8w=;
        b=gtAXdHcS6vfKTtGmajdGEBE62BPu49S+VfCAISyYqijXPoqfzCtyFO7d4CIHbRa8lk73vt
        DUc8r69elFclkdsZg/P44vlRPzZaI2881YbhDgEOFTvfvYkzWLP3FVtJxonW7KlNWlI1eF
        DkEvtUn1/GvD+HMyRdCq+HAK0os/AIAaooYRxI8xrv2YVnNRDL/RqahyPD5nfF5yKUjcRg
        zpD115Xn04qEiKoO2OVZh/SM3E57ck30/uxYO5XcFJ0601NvDa1/Dkp/ix5Fk8JM6+qCeW
        jFrLhI+SayRofyMlrnLffBCsXP+2FnZDOwXVgcWaSXZKUVFPlp5J1fUjLcWwww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664530264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4q5jmrvANuAXc5hhK5/6sYAQwRIKCMij9bcglc9rC8w=;
        b=yOWpjVsmLzpBuoDp/QuaVv93NH47S4DmIvzkTzo5MmwQyHQG4n5IAv29YgoTo2MeEEqTRk
        a2frkywJDTzf1UAA==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/uapi: Define PERF_MEM_SNOOPX_PEER in kernel header file
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220928095805.596-8-ravi.bangoria@amd.com>
References: <20220928095805.596-8-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <166453026266.401.9628855261394901995.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     cfef80bad4cf79cdc964a53c98254dfa462be83f
Gitweb:        https://git.kernel.org/tip/cfef80bad4cf79cdc964a53c98254dfa462be83f
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 28 Sep 2022 15:27:57 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Sep 2022 12:20:56 +02:00

perf/uapi: Define PERF_MEM_SNOOPX_PEER in kernel header file

PERF_MEM_SNOOPX_PEER is defined only in tools uapi header. Although
it's used only by perf tool, not defining it in kernel header can
create problems in future.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220928095805.596-8-ravi.bangoria@amd.com
---
 include/uapi/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 4ae3c24..85be78e 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1356,7 +1356,7 @@ union perf_mem_data_src {
 #define PERF_MEM_SNOOP_SHIFT	19
 
 #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
-/* 1 free */
+#define PERF_MEM_SNOOPX_PEER	0x02 /* xfer from peer */
 #define PERF_MEM_SNOOPX_SHIFT  38
 
 /* locked instruction */
