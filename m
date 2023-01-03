Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721B765C053
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbjACMtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237632AbjACMtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:49:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69867262A;
        Tue,  3 Jan 2023 04:49:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9C1A152B;
        Tue,  3 Jan 2023 04:50:10 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C4893F587;
        Tue,  3 Jan 2023 04:49:28 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, mhiramat@kernel.org, revest@chromium.org,
        rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ftrace: Maintain samples/ftrace
Date:   Tue,  3 Jan 2023 12:49:10 +0000
Message-Id: <20230103124912.2948963-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230103124912.2948963-1-mark.rutland@arm.com>
References: <20230103124912.2948963-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no entry in MAINTAINERS for samples/ftrace. Add one so that the
FTRACE maintainers are kept in the loop.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427a..739006e245fbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8571,6 +8571,7 @@ F:	kernel/trace/fgraph.c
 F:	arch/*/*/*/*ftrace*
 F:	arch/*/*/*ftrace*
 F:	include/*/ftrace.h
+F:	samples/ftrace
 
 FUNGIBLE ETHERNET DRIVERS
 M:	Dimitris Michailidis <dmichail@fungible.com>
-- 
2.30.2

