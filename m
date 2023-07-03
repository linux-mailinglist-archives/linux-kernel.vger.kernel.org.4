Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7A5745849
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjGCJX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGCJX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:23:56 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBCFCE;
        Mon,  3 Jul 2023 02:23:55 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b5d57d7db9so3309675a34.3;
        Mon, 03 Jul 2023 02:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688376235; x=1690968235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BJb09g/OfHvshX7XoMoqUcNq7uvwhDrwlKeW8QFnp6M=;
        b=KZOVsUZ92vWvIGav63Q7cazYeOZBueY1L5SJXbcWtjgbJGrPTF/XqwTg1ZCxeT7s0D
         cW2dg/8C+f2vUK1Bgyl5Nc4igUUQlWaxe04FeBRvk47bNKiz3tm4TrWS+5LZJJJZa9No
         MIVcEnHlM6dg5C/TCe3avjst/ziKUV+pZxnLjfX3RPWnxCP4zZuB1dSOsa+taF9Rxr0l
         cB7rHBJ+cJeEqd/KXKJO7bk/ynQlHzkwMC+kePYX0UOTE+7aAaRs2O5fS12I8p6qb7Fj
         jV2Hz9skwOydu7tcGOHGQHojswrmbDQB2RoPsRVapDKhO0PUpsTtu7PWL5HzbftLHbl4
         7v0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688376235; x=1690968235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJb09g/OfHvshX7XoMoqUcNq7uvwhDrwlKeW8QFnp6M=;
        b=i4R0d6bvy9S4jY1Z8VqLxgop1B79rS/yBXwjwA40Pee835ZL/AD2kME8/VsPC52dOS
         vwnMo6IndvN9ilX+ex0bBqKZZKvjDk2OouagB5/xrO0VZU9ybKJ6cgvKnHebxm4UrK49
         0iZC5ePka9cJTuCtCEuoa4DG4hxFKUU8ry7G7e21p57cFHOwa+H6nYgNhQ+PYwXbqF7w
         az9B6sp0yQr4MrmJ5Ugwehar04ldRDTSPMDyAiqi2kpVX+ASGa3XDPcnYQzGV5ak6YeO
         fxwnY3djmUpG6Ap8sU1+Rt4gBZCpgkeI4s9/9W64WzUbirkZhdLxdVRDhOBA6U0xSpQF
         jC7g==
X-Gm-Message-State: AC+VfDykEoJXHZxN6e1ftxSuwJe02LxjBMwGUWcvbr/2FSl3Ka9krkUY
        fgCmLLRkkv4KeBbPobuMP8I=
X-Google-Smtp-Source: ACHHUZ435WUYlPE5HLQZD7t8XpiGSe9lLLNGSvsArLVKY/qHdDDTOmISEZ3HbJDb6FPw+7HtzOLB8Q==
X-Received: by 2002:a9d:6d81:0:b0:6b7:26aa:dbb3 with SMTP id x1-20020a9d6d81000000b006b726aadbb3mr7839695otp.38.1688376234977;
        Mon, 03 Jul 2023 02:23:54 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.15])
        by smtp.googlemail.com with ESMTPSA id p15-20020a63e64f000000b0051b0e564963sm14633495pgj.49.2023.07.03.02.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 02:23:54 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Ze Gao <zegao2021@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Ze Gao <zegao@tencent.com>, Yafang <laoar.shao@gmail.com>
Subject: [PATCH v2] fprobe: add unlock to match a succeeded ftrace_test_recursion_trylock
Date:   Mon,  3 Jul 2023 17:23:36 +0800
Message-Id: <20230703092336.268371-1-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlock ftrace recursion lock when fprobe_kprobe_handler() is failed
because of some running kprobe.

Fixes: 3cc4e2c5fbae ("fprobe: make fprobe_kprobe_handler recursion free")
Reported-by: Yafang <laoar.shao@gmail.com>
Closes: https://lore.kernel.org/linux-trace-kernel/CALOAHbC6UpfFOOibdDiC7xFc5YFUgZnk3MZ=3Ny6we=AcrNbew@mail.gmail.com/
Signed-off-by: Ze Gao <zegao@tencent.com>
---
 kernel/trace/fprobe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 18d36842faf5..93b3e361bb97 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -102,12 +102,14 @@ static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
 
 	if (unlikely(kprobe_running())) {
 		fp->nmissed++;
-		return;
+		goto recursion_unlock;
 	}
 
 	kprobe_busy_begin();
 	__fprobe_handler(ip, parent_ip, ops, fregs);
 	kprobe_busy_end();
+
+recursion_unlock:
 	ftrace_test_recursion_unlock(bit);
 }
 
-- 
2.40.1

