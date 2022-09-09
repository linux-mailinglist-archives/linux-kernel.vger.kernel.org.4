Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753E65B326B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiIIIxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiIIIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A17812F702;
        Fri,  9 Sep 2022 01:52:49 -0700 (PDT)
Date:   Fri, 09 Sep 2022 08:52:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662713568;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fczsH602MDqW7eOBg323dtueNJSY5qmbikPmqQ2ZTcU=;
        b=m8GzjPBu3RA/27o6eE4QGVzDbFv30AaRH65cOUJhrJLqxPycYDXXh6Gw8K/jiCNMMoBgt2
        q8wmZ6G3UNlSOo52eQaXNw2RbhUqoZDNMRkTvQ1TgA4Pa2dT4AFVNpJ2Cx8nfXUqBj/iS3
        51TSo+CM3iA8AZ4nzSWWg5znrOw9D9QXpFT7M9bDkgQfS4W9u3uIYH8ExmLpiguUoF6BBR
        IKH7xSUVRcvlPw4KhyaSjpPuS5r8OXz562xwjvB35cwGjhEHmDoxhg+tE1jJfRFs6zWTbI
        F9RJdCFWDzDqFNWNsO8M8kSrbYa4bqNwHyOu3gBNmTO+yEHbN106VsJP+5dsSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662713568;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fczsH602MDqW7eOBg323dtueNJSY5qmbikPmqQ2ZTcU=;
        b=VHEnLEqMDHDU99vLs5v0luY+/sL4cIiwemLaChYGHwEAVeVbzuSzQLKRbUkNL7/Hp7FbTX
        giGeTikAVtnRt1CQ==
From:   "tip-bot2 for Anshuman Khandual" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Expand PERF_EVENT_FLAG_ARCH
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        James Clark <james.clark@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220907091924.439193-2-anshuman.khandual@arm.com>
References: <20220907091924.439193-2-anshuman.khandual@arm.com>
MIME-Version: 1.0
Message-ID: <166271356698.401.16929961100735486879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7517f08b9a5eef0fa683b976c97d6178d00e6a3d
Gitweb:        https://git.kernel.org/tip/7517f08b9a5eef0fa683b976c97d6178d00e6a3d
Author:        Anshuman Khandual <anshuman.khandual@arm.com>
AuthorDate:    Wed, 07 Sep 2022 14:49:21 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:54:00 +02:00

perf/core: Expand PERF_EVENT_FLAG_ARCH

Two hardware event flags on x86 platform has overshot PERF_EVENT_FLAG_ARCH
(0x0000ffff). These flags are PERF_X86_EVENT_PEBS_LAT_HYBRID (0x20000) and
PERF_X86_EVENT_AMD_BRS (0x10000). Lets expand PERF_EVENT_FLAG_ARCH mask to
accommodate those flags, and also create room for two more in the future.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: James Clark <james.clark@arm.com>
Link: https://lkml.kernel.org/r/20220907091924.439193-2-anshuman.khandual@arm.com
---
 include/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a627528..3e3c075 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -138,7 +138,7 @@ struct hw_perf_event_extra {
  * PERF_EVENT_FLAG_ARCH bits are reserved for architecture-specific
  * usage.
  */
-#define PERF_EVENT_FLAG_ARCH			0x0000ffff
+#define PERF_EVENT_FLAG_ARCH			0x000fffff
 #define PERF_EVENT_FLAG_USER_READ_CNT		0x80000000
 
 /**
