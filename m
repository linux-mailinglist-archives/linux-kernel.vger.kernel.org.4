Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB8A72F780
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbjFNIOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243030AbjFNIN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:13:58 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913931713
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:13:56 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgyqk2GxJzBSJbT
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:13:54 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686730434; x=1689322435; bh=0QerdF6PEGVomEzCR4TDRGGvCJf
        hkBqdi3oPYHVbl54=; b=pJzMnlwE0NrO63D7mLHk02dBGZEqE1imQqSleh8OnXg
        CNudoCfO6fY6foy/F23U8zRFmF5t2RS2xkeQSSKhktVby50WiNV+EXTJ0HUVkC4W
        NIOQ0nlGSEHUSMh7O8eQZSRLaZimGphw0b3rcaZH5iI3Vdb8TJ7eEHuQfol0fdED
        3LZVKkdOpT50RkMfES+9EXcy2K5kdOK+s4Sn7B3QNsa7KEDwC+4YVx3/XNR4Ly7A
        NW3TI1845+gOApxwxrEUUJY9nC4x5TKa4RXUBxBf1OfBddN2BJH6+S0mGFzE9+c0
        ReR14hWotH4WdHel2y/jlLMcwfBMyZEH2NjE8qMbNIA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8qkw816NsW6d for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 16:13:54 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgyqj4BlLzBQJZ2;
        Wed, 14 Jun 2023 16:13:53 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 16:13:53 +0800
From:   baomingtong001@208suo.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf parse-events: Remove unneeded semicolon
In-Reply-To: <20230614080937.54937-1-luojianhong@cdjrlc.com>
References: <20230614080937.54937-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <2c733a91717eae93119ba2226420fd8f@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./tools/perf/util/parse-events.c:1466:2-3: Unneeded semicolon

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  tools/perf/util/parse-events.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c 
b/tools/perf/util/parse-events.c
index 629f7bd9fd59..42f84f61fabc 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1463,7 +1463,7 @@ static int __parse_events_add_numeric(struct 
parse_events_state *parse_state,
      if (extended_type && (type == PERF_TYPE_HARDWARE || type == 
PERF_TYPE_HW_CACHE)) {
          assert(perf_pmus__supports_extended_type());
          attr.config |= (u64)extended_type << PERF_PMU_TYPE_SHIFT;
-    };
+    }

      if (head_config) {
          if (config_attr(&attr, head_config, parse_state->error,
