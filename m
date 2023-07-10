Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D135874DD6A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjGJSgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjGJSfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:35:55 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6C4C3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:35:54 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-262dc0ba9ceso8031232a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689014153; x=1691606153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S9zW43FbHuOlleSu+un6XWqUn1fn2QP5MnKtge68NZw=;
        b=2BvIE+7Cb5J6MVl7t68AQmPcTEFhZlWe+/b7KN/uzDN9+Ao94fJCMlNpxZlDgcGKeB
         m7Tl+0X9ccOfZ5iYWxiMFwYu8nN55HeVYr4+ygARqmsVCzleZFu1hQDTPf+6UsV5eCOl
         kLBmxXHq0U/yhc0QwEqq00hwEhv3CEZRvWM7eMi65KLJY6UXulbtXwlfFOOvNvw9zY1U
         yedqcc3skBZ6xL9hEdYz7sPiFHWBSANUiAkJAZOILfsY9K1OSZgWw3wcPdmj7Kt8fZcu
         ZjEHV76VEFbS5c51oWd9V7kbiPIXZgzl+hqRGNa3UlpuufenDyzzjDzQuQYbYuxS7VeN
         VuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689014153; x=1691606153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9zW43FbHuOlleSu+un6XWqUn1fn2QP5MnKtge68NZw=;
        b=b8Rfdd3DReUjbsRQ17WGFA0m/vJKQkWm71H6nCzt7HuELcM6+MI4kH0EiUeXPsOySu
         nmAGNeCU+StZyNiRHtfCjAZwqfDh6xM/8o8Gss97eBWF2dmH5N1oDjswpJE26DkwOqtY
         fFhZQThmIUBw40n9RLX2zHcPOCpnwv1KqPg0MQrWFDePe2+4wP5+uzc1wTV5Voul7qfo
         rt9VCk3pf0tQ6Vw5+ifuWQSPI7jzbge47D6XdhXOszE9RNW2b5AWH2QTHFCGOhzRFniM
         alHNcTh+klSFjQlecwnivJ9E6fLoDv7gYQHlOJ+3ENiHgv6CL8d6x9CwUJ+zQX638y1a
         6DBg==
X-Gm-Message-State: ABy/qLZMsmSqXN5xWwqIu/q8NplD+n5TWk8Yk4Bl/YqR1m4v1DDXoy8z
        bOqqrByWGbKokhu5pEkQXNx3+p7Z7JFNHcTKGB4=
X-Google-Smtp-Source: APBJJlEHUxfZq7uWFQrz0VKHKSqMYGKtLRHE2eeMBabDYg36u9soDrUt3GcdQwg/5s00tNoVMufWeUuLPI80l6/+3Fc=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:90a:8912:b0:263:dcce:ca9a with
 SMTP id u18-20020a17090a891200b00263dcceca9amr10877384pjn.1.1689014153561;
 Mon, 10 Jul 2023 11:35:53 -0700 (PDT)
Date:   Mon, 10 Jul 2023 18:35:48 +0000
In-Reply-To: <20230710183544.999540-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230710183544.999540-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=977; i=samitolvanen@google.com;
 h=from:subject; bh=SyYGssy02WwznPseKLFWBeRZamjspo0IenMK/78d1Tw=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBkrE+AvhWQwKiqzsK7Notr2TR4pdX+nw6HsLRg3
 vakDRSEwnyJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZKxPgAAKCRBMtfaEi7xW
 7m1tC/9kAC6G5E9nlSHjofInL/y8Zju/2BQWR+G6A2hA1YqzCT8IGkEC1AOGiEzHTcV3GCT/87U
 h87Ilj+zvqCqR/d+1E7J9h46MhhF+f91eFa3Q5kJ2dnf1eX0M4HYypa5V/CoQ7RZNtqr4I39GY8
 v5SyYiUxkMUMEemjvdfuawjqjnFuPAyWyWVdfZICe+4Sz3zISBhytRl/GX56rQnYFBa3M97kAq+
 AM8FE6CO1URei4DbbZk7iNcBStfCfgywRwJonIGhtU7ySqz56WP4VVchnPlMDd2/uFrWwVfnaOR
 gHgFbUIGyvvJRDS2ioIDNTWhYuiAwUzyqbpnysqXGWuSm4fshKMe2+HwhBVABEk2757Tq21sNoN
 jvxlF6Rf8fhicoFRZHmWrSpYAHFemEceYre4wE8AI9ZC1v6f1raY1lMDD5QEk9XE3mFHOQDjdU0 BmpHkd0OocbQjGmBzxP6u2W+S41FuvElG8m9BI30J7iGdiMFpjgsS9pXwLLwK75J6Z0PQ=
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230710183544.999540-11-samitolvanen@google.com>
Subject: [PATCH v2 3/6] riscv: Add ftrace_stub_graph
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 883bbbffa5a4 ("ftrace,kcfi: Separate ftrace_stub() and
ftrace_stub_graph()") added a separate ftrace_stub_graph function for
CFI_CLANG. Add the stub to fix FUNCTION_GRAPH_TRACER compatibility
with CFI.

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/kernel/mcount.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
index 6c9469050f4c..8818a8fa9ff3 100644
--- a/arch/riscv/kernel/mcount.S
+++ b/arch/riscv/kernel/mcount.S
@@ -57,6 +57,10 @@ SYM_TYPED_FUNC_START(ftrace_stub)
 SYM_FUNC_END(ftrace_stub)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
+SYM_TYPED_FUNC_START(ftrace_stub_graph)
+	ret
+SYM_FUNC_END(ftrace_stub_graph)
+
 ENTRY(return_to_handler)
 /*
  * On implementing the frame point test, the ideal way is to compare the
-- 
2.41.0.255.g8b1d071c50-goog

