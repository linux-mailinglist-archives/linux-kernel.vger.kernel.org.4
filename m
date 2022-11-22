Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6494633666
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKVHzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiKVHy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:54:56 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DBD32B9B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:54:51 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so16540905pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FaD45/LH3TZ6LbPUcB/tZTNJd6oSSleYgrDKwVHXXS8=;
        b=VXTHMSvhK6rf+7XuYyG/Gc5csVm38SGJclqk6icVnehGJCmZm36gv1dNZd/ovtPDJL
         elT7gvTL5S4ggs/JMsETB9Bd5ncHE2XwVRXV8MU4Nea822u+N5+S2i3hrDshAk7Oj7yz
         VDNPHxehjxo009md4A5dm5XiKHdp2LGzlHOAeLxGlLQs5ge7QAR5juXK0XJlqwBVIjuf
         MpJTJhbGkge1ODNOOz2QQymNH52SZbDh1d0nFwp2Lb4d2+b0j8gTyDcW62cnyI0Ej0/o
         Zqb49YSUw3WjUc1I2LECR2D/U5vtYudC4yB4PvmpHOKeAiQx/AOjp/aNsfOuMBwH7i/s
         tNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FaD45/LH3TZ6LbPUcB/tZTNJd6oSSleYgrDKwVHXXS8=;
        b=zcOM0o55IrMkOPVOjHTk8pwBFdwoq/sObT0rhlvgbsph3YLiSagYTq1Vq4UQ9sy2E+
         IMXoT5t9MMZZxOzQdOYdgpbzyWADv1zB9F6eS2hAUwvncvI49PknWEnhjC9oICXsI1ar
         Oz3VmfehpRl60gTClEX23X+FjciLOGU3XTI+Sw2ww04cAkLXUpWzNrOh9i+X57SA1wws
         x3celw/+c1sWStKSuXmDmN8oy/bJ23Bj7TiL504WhSXhtC6dLSuVxahRrGbvoa/6fMTy
         Vh9H3kTOiabx3kX9FlIl9P51mLS4ooBBOa3q6Q6T5tlDY186ioEqz+l0BK0h8qaImFqy
         Aqzw==
X-Gm-Message-State: ANoB5pkzF6zYYukTjYFplE6hQMnqLuDbreTLaTN37EYvz/jrtm4RA0G0
        pSUQj0RYn42Vf1iZGTF9BjY=
X-Google-Smtp-Source: AA0mqf4i0LyLXge3UiPlp/TJqbVFTXCUKervCrY1UnSc8o6dLKUtk/1OH1tm/qSlyQIyPVzzTMDRrA==
X-Received: by 2002:a17:90a:ac0f:b0:218:bc3e:95f4 with SMTP id o15-20020a17090aac0f00b00218bc3e95f4mr7143299pjq.150.1669103690943;
        Mon, 21 Nov 2022 23:54:50 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id 131-20020a621689000000b00545f5046372sm9891909pfw.208.2022.11.21.23.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 23:54:50 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH] riscv/ftrace: fix ftrace_modify_call bug
Date:   Tue, 22 Nov 2022 15:54:40 +0800
Message-Id: <20221122075440.1165172-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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

With this commit (riscv: ftrace: Reduce the detour code size to half)
patched, ftrace bug occurred When hosting kprobe and function tracer
at the same function.

Obviously, the variable caller in ftrace_modify_call was assigned by
rec->ip with 4 offset failing the code replacing at function entry.
And the caller should be assigned by rec->ip directly to indicate
the function entry.

The following is the ftrace bug log.

```
[  419.632855] 00000000f8776803: expected (ffe00297 1a4282e7) but got (1a8282e7 f0227179)
[  419.633390] ------------[ ftrace bug ]------------
[  419.633553] ftrace failed to modify
[  419.633569] [<ffffffff802091cc>] kernel_read+0x0/0x52
[  419.633863]  actual:   97:02:e0:ff:e7:82:82:1a
[  419.634087] Updating ftrace call site to call a different ftrace function
[  419.634279] ftrace record flags: e0000002
[  419.634487]  (2) R
[  419.634487]  expected tramp: ffffffff800093cc
[  419.634935] ------------[ cut here ]------------
```

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 8c77f236fc71..61b24d767e2e 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -132,7 +132,7 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		       unsigned long addr)
 {
 	unsigned int call[2];
-	unsigned long caller = rec->ip + 4;
+	unsigned long caller = rec->ip;
 	int ret;
 
 	make_call_t0(caller, old_addr, call);
-- 
2.20.1

