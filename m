Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C49B5EE8CE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiI1V6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiI1V6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:58:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26B0AF0D8;
        Wed, 28 Sep 2022 14:58:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x18so21777401wrm.7;
        Wed, 28 Sep 2022 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=1ZM1xivpgRrEvA+BtygIUXZXEYNOT83pkKY0ZX950F0=;
        b=D/mZDxTrHQm1U498H52oaCkB6vHmG09pTcmIXtz4Yc4y+OL4JiOeVIS19CDNB+z72F
         ENnAsuths80YMGX2pgfV7QN4sHZ+8isL4UtFj0/WZqbxur0Bj+J3ciFtieCA5rph3yKM
         gpIWYbXq5aLriNpo7gYU6OlBtdQOQ45zAqJllvjNjctNezhGs+i7NkVDOF0Q/Jy2hg2E
         kZA4RMNsN/Ta5VfcC9uJ3MGuO85spB96V1eigomQki+laqYozmlCSN/aV6OcrOEAFLyc
         1oIvVsBX5eHmMZr5kp36rBuqWLLQRLFmqwtbwxsxTuJYgdMw3MXuHdhW5OquHMWKPr0b
         BqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1ZM1xivpgRrEvA+BtygIUXZXEYNOT83pkKY0ZX950F0=;
        b=Pbkcy/I0gSoXyg+P7ToFNDRX7aAy7bU24XGIAlnt7zFK8iWws7xDzfbXWZ/xS76pQ3
         /ipK0PQ9BcwdPjohfcBdcsEV8UiwRuzctG/Cd3UXIa7c2FzJO8THkwOGEjI1vEV2pYrw
         uROmHxdPLTjedj2DWJRQOoojm71Z8ra1q1CgUb6rZBuR95luyhK0JBCOvOsoO/m6gO16
         7AilUFCF+/K55EFRhKL/ps58fDh45tzUq5C+wbPLBWLqHbgJmkRox7HZGi55/VFqX8Gz
         us9B4kR8u9WijLde3xwLJ/Y68/cuvB3AZ6Tj4e+vKfBq9BNkndqI/rc2KuS/2rX0VK5D
         VC9Q==
X-Gm-Message-State: ACrzQf2wGKUXI/I4/9YePKjPDWGXdLNQlAosLv4EfPo6IRmzJaR65HNH
        LgjR5B8lFDcR2lHORx3ouGk=
X-Google-Smtp-Source: AMsMyM6UfiR5TxXOe/PqBn+GlHxQWrQNdmh5uRki3ac6QqVLyvtRj09mmiy9/wBlzhx0jIrBQJZpHA==
X-Received: by 2002:a05:6000:144b:b0:22c:9161:76b4 with SMTP id v11-20020a056000144b00b0022c916176b4mr15335724wrx.145.1664402309256;
        Wed, 28 Sep 2022 14:58:29 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d22-20020a05600c34d600b003b49ab8ff53sm2790158wmq.8.2022.09.28.14.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:58:28 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix spelling mistake "preapre" -> "prepare"
Date:   Wed, 28 Sep 2022 22:58:28 +0100
Message-Id: <20220928215828.66325-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in the trace text. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3005279165d..623c5691ab21 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10091,7 +10091,7 @@ __init static int tracer_alloc_buffers(void)
 	 * buffer. The memory will be removed once the "instance" is removed.
 	 */
 	ret = cpuhp_setup_state_multi(CPUHP_TRACE_RB_PREPARE,
-				      "trace/RB:preapre", trace_rb_cpu_prepare,
+				      "trace/RB:prepare", trace_rb_cpu_prepare,
 				      NULL);
 	if (ret < 0)
 		goto out_free_cpumask;
-- 
2.37.1

