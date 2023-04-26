Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99476EECB8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 05:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbjDZDXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 23:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239102AbjDZDXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 23:23:18 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA5C35A4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:23:15 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1a9719cedb4so21540175ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682479395; x=1685071395;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GprFFKPXx2RqkeiVQsck1rqQO3e+bSYuG2v+cq5MA2o=;
        b=zG8dWV9YQYGogBf4sPw4WVCUPNbo01U7qJjyVSZgW0dMMWE/csSxij64YMjW47WXMr
         UqSLZdwQqkvWJeTf7TTx3joW47ivyJdK3qLoyt/DtnIuv6oIToeLBjzriQoO52YpUXmu
         u5TXAL4ILR6DZboKzKdk4bKjxDFEXPBUvO6xgRaAonU01xfDvC95Fllr9PDlVAJLuGae
         hRztRCc+bnRt3oELFhD2RnqAsebqUnVD9RMkD+jKJmXVl7p+tR0PgotwJ++Zfww7qqyj
         EeuL+KYKP+0/p3ATtjdtHKiUgIQqLqaViD2niN14y+t8Kw+5GLCvl/z6O+UEq8UbczVo
         MGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682479395; x=1685071395;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GprFFKPXx2RqkeiVQsck1rqQO3e+bSYuG2v+cq5MA2o=;
        b=FdMn8jmgX/+tkCTB0BBbVHjSos9tVuxTREwSjEzeWzWWe136Bx7t9SyJ71+SGw6bed
         PQlRYLpZTaCdYIE4o7FKQgVcc48PzWG7RZXWiKbTQ4E32DCnoU9LcrGc33llN59yF7Xb
         DqhZNJnXZmHP9SDwNvA9oL+CmogEsjcxDRnSpFLrpz9HvwRbHH/hepa5er3WQQ2vknpZ
         l3vK8vYyzFeno1kQC/KARxV+w9AvLuG4GXSdKXB8xwUUzB90IGcBRQKv5rC6YE+4rzIE
         7X1VxlP1VYNPHO7UCT7EANgsnJqR1rjr5FRSuvmubtwMLN18j/PRjrRzTXM2eKgiBarR
         j8bg==
X-Gm-Message-State: AAQBX9f6GAjKhkIAL9mlwzCrER50z9s1yG7OhwvGK7Z4FpknUbYMeUlr
        s4DXFtqFmpMxkBHUrrPQKYSktxPfZeb5/A==
X-Google-Smtp-Source: AKy350ZRoCLFcTyyFEvF5QtfiEvLZsdibFceuXM7THIILhocaE/DRKxNJrFTO28Xy6zCv05NvLpT8gof7WgbBQ==
X-Received: from lyenting.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:1090])
 (user=lyenting job=sendgmr) by 2002:a17:903:11c4:b0:1a2:1674:3902 with SMTP
 id q4-20020a17090311c400b001a216743902mr6244670plh.10.1682479394899; Tue, 25
 Apr 2023 20:23:14 -0700 (PDT)
Date:   Wed, 26 Apr 2023 03:22:57 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230426032257.3157247-1-lyenting@google.com>
Subject: [PATCH] tracing: Add missing spaces in trace_print_hex_seq()
From:   Ken Lin <lyenting@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Ken Lin <lyenting@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the buffer length is larger than 16 and concatenate is set to false,
there would be missing spaces every 16 bytes.
Example:
  Before: c5 11 10 50 05 4d 31 40 00 40 00 40 00 4d 31 4000 40 00
  After:  c5 11 10 50 05 4d 31 40 00 40 00 40 00 4d 31 40 00 40 00

Signed-off-by: Ken Lin <lyenting@google.com>
---
 kernel/trace/trace_output.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index bd475a00f96d..6e45cf18d816 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -221,8 +221,11 @@ trace_print_hex_seq(struct trace_seq *p, const unsigned char *buf, int buf_len,
 	const char *ret = trace_seq_buffer_ptr(p);
 	const char *fmt = concatenate ? "%*phN" : "%*ph";
 
-	for (i = 0; i < buf_len; i += 16)
+	for (i = 0; i < buf_len; i += 16) {
+		if (!concatenate && i != 0)
+			trace_seq_putc(p, ' ');
 		trace_seq_printf(p, fmt, min(buf_len - i, 16), &buf[i]);
+	}
 	trace_seq_putc(p, 0);
 
 	return ret;
-- 
2.40.1.495.gc816e09b53d-goog

