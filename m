Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73C1743134
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjF2XnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjF2Xm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:42:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7602D55
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:42:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c118efd0c3cso1081688276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688082175; x=1690674175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xnc4kEY4EbaBnYfn4j7l+LmuswSwMsWgqgbgeywLsM=;
        b=kp2ERfWqnMk1aYCcY3Lh5Z6gm14ZJ3i2mXlb/00TiljzMsnxeQFs5kbVGLwdlHdXWH
         1Pr+W0hxAGlZuFtJ34Gw8FWCTQKcdth2yYQ4kpxbIRDw+N4gAfjsiMTV7jzpomXHcLTS
         0kT2wDspmdW0ky6LKXOjJbvqFbwXOfI+Uqy9S8KBiTg+C/CpcRA4cNvS8TaL+WBXZhiJ
         gqG0bbHz3u6ZHweyCgmLfplLh+OdA+qcH5DUy3t0ecNfXfQIxRtzjJjc8ialYxW+YbE9
         hNIbzRRmtDZvI0K4dsHoLvVVFESxxWxy+57P+dee5eOgXSh7DXoAPg7ADh/35TMj2lK4
         3t9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688082175; x=1690674175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xnc4kEY4EbaBnYfn4j7l+LmuswSwMsWgqgbgeywLsM=;
        b=mGQafSENtUyDg44/AfOBCLh5vfgyQTb4pFlSQRLdtxPnn93nwH543ox3gbdvPtKl8M
         sJvZusj/lKppeQYdtRRPHMoWfE6BQSPLoRdTRm2LpWC3ULcdKlXELcuum3mfWwSEt1y1
         4wGVCUNt3zdbzF5iCGT6AgFlzYyeEEbNWOCp61DerfLnSVtOPYjiZRNuZixq2tZ2HoaL
         tChiycV8xcmMOD/3/I1iXAbmiBh/Lfx0vdFiJzYkDsrEboq8NGAJGq9OILGPwuy4d03y
         8CPH8VVwWHfwN0/nOyEziHKY8BgyxyE/Pe6kGg1eLoJtRTDlohfwK8ujcwH8jPENLulB
         hEnA==
X-Gm-Message-State: ABy/qLbsjqZC6lFPGzy8YIViVK0yon91QCewKYaPpHUvevZBxqzRNsPx
        mxQEhXo2t7sEthKHke0OnjC7koAa48UcO1eY4X8=
X-Google-Smtp-Source: APBJJlELQmIdC0rGqtb4VJitzpWLBDF1z2wW/3vjqsBQPQv0tSZIA2LaC77zwb28Y653cXNP4FPxNLuggPDhhv7s5Yw=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a25:3f44:0:b0:c39:4e0b:2f05 with SMTP
 id m65-20020a253f44000000b00c394e0b2f05mr7310yba.6.1688082175113; Thu, 29 Jun
 2023 16:42:55 -0700 (PDT)
Date:   Thu, 29 Jun 2023 23:42:48 +0000
In-Reply-To: <20230629234244.1752366-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230629234244.1752366-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=samitolvanen@google.com;
 h=from:subject; bh=jTMsDVHp3vLP+kp6kYa8Yt2xhzF3g8PflLJEr5zwipc=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBknhb19IaK8IPSrcbSiqkp1zwKDFD22eRwAN9KJ
 9YK7ujl6kKJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZJ4W9QAKCRBMtfaEi7xW
 7hKeC/9phxEf9/+dB3hfrEFRxhxmmCZAlHL7B2GBUkQCOpdHg2ck1MABWcoko419h0tlSz45RPv
 IyV9eudwY59txN8eLDO2Lh+KuGtj/I/xL9yy+6j71mkvxiRbmFzuLHv/QwdBqbMDOUZdK9LNjwC
 hjDZ12Mk+tdQ2pAfhWRG7oI2pvSd76+bgvv5glho5QYig7FnKmOdl6Lly7gAjjaP/bsB2ESWl/f
 5wZ6tCp/E/iOu6m6yF4LBt0RObJUIyuvpYsPmObRxGFVZVAQkogHlMGdi0l0XVwpHY2xcKqzusS
 HhpVp8d4J/FreeR1zKHdC3oJqbkgtBa0poSZnm9iOzOtdaMNnRRYqf5ih9YbDcrim2hjDQGfTZc
 iaP32nHcDEaHWHNpHRw0gEionM52PXSz8IxY4GPajiUthGRen5n5T/2UzAho1Odw6xFE36Kvd3/ ayJR/eygigxaJNCGU8rkS9ho97aA+Ng4gci+jDMa+FPMitZDgr6U1fYKqpHrXzUK/jUjA=
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230629234244.1752366-11-samitolvanen@google.com>
Subject: [PATCH 3/6] riscv: Add ftrace_stub_graph
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
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

Commit 883bbbffa5a4 ("ftrace,kcfi: Separate ftrace_stub() and
ftrace_stub_graph()") added a separate ftrace_stub_graph function for
CFI_CLANG. Add the stub to fix FUNCTION_GRAPH_TRACER compatibility
with CFI.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/kernel/mcount.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
index 712c1d2c2723..c73d7514e45f 100644
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

