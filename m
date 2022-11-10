Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18F3623D77
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiKJI0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiKJI0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:26:20 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0F21EED5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:26:19 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso983632pjc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Op8P6TOhSTkI0Hw7ShIPubcI7qhXU4xJVLOd8tRKgxo=;
        b=eddClnw6IpCqsFupjDOEtKiB+3YFzl0JqMRPz6yOic//pXTtr1Vm+xkpvaK5BkOAEq
         2TlfbhZgPthE+eFiJTo1P/jTFpOklEjludWJx7IoEX5BT0oAzUsiFNnMF32/Go5hOaaC
         sg9u/od4Q6lryEu0zrzhWV/H+qcfo8Z2prs/InBBiglfe3B727D7dxsSGOaFkGSs8n7L
         H5/VGEpZisxubpl92e1PAOG2WfV1cTmTQHNBMimXsjbAXAXQVL+Vs6DpiH9as5SerrsY
         psYA59gQunDV0Ti9I8kH+N7qLlNPBxsfg4oiUx1Do8gR11qzm9uZHucCPPoNO+2iWaGV
         sayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Op8P6TOhSTkI0Hw7ShIPubcI7qhXU4xJVLOd8tRKgxo=;
        b=4JajLXvAWWynEDlbLdXJ4ZadaCnJzw2CKxzZBIP4yw6DLiskX0DIvmZJzSSUwP/YR5
         5NJfpb3UyYv+h/yyuPCNHcjQGvFHvcx2ULahvwO+9df+tuEH762fp9DxKx6PR3xBIlfF
         R+e2+niQZMkzKr/5DlIMOqJSTRDfpsCgB0cnsTxKoCTy6INBQDpUwMaKm9B3+X6y/Y3i
         otVUEJF/pHm2dlll1UVcA8nOh3qg9ru0r+7rm9Mn9EJ+DHsPmHeAstsuUFNr7+i19JTR
         XolRkyi+vjWSLVXLK5SNtIRNI4i49yq7qevRZ0sX/DUOStwVgf8tRJ9LYl+crAp0zNUl
         jiAQ==
X-Gm-Message-State: ACrzQf1sItheFy0F8u1hQWQS30iGDpp8fKcWhLzQzeIvvFWbv0fs21Ff
        Z4z8G6bDgatIJKYluSGWqwPIatOZCUs33g==
X-Google-Smtp-Source: AMsMyM5UkSSAibp/Wfc4FEfVeB5cE3xXNXfCVPTh2xqJ8U1ZfLRM44BbXb3FerHCq+5WK4+hiuODzA==
X-Received: by 2002:a17:902:b581:b0:186:fb90:1151 with SMTP id a1-20020a170902b58100b00186fb901151mr64032745pls.43.1668068778627;
        Thu, 10 Nov 2022 00:26:18 -0800 (PST)
Received: from localhost.localdomain ([2406:840:dc37:cbd2:a67b:c975:e566:74])
        by smtp.gmail.com with ESMTPSA id nm13-20020a17090b19cd00b0020087d7e778sm2522656pjb.37.2022.11.10.00.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 00:26:17 -0800 (PST)
From:   Genjian <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian <zhanggenjian@kylinos.cn>
To:     frederic@kernel.org, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, zhanggenjian123@gmail.com,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>, kernel test robot <lkp@intel.com>
Subject: [PATCH] context_tracking: Use arch_atomic_*() in __ct_user_enter and __ct_user_exit
Date:   Thu, 10 Nov 2022 16:24:43 +0800
Message-Id: <20221110082443.4069161-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Genjian Zhang <zhanggenjian@kylinos.cn>

vmlinux.o: warning: objtool: __ct_user_enter+0x45: call to
__kasan_check_write() leaves .noinstr.text section
vmlinux.o: warning: objtool: __ct_user_exit+0x3f: call to
__kasan_check_write() leaves .noinstr.text section

noinstr cannot have atomic_*() functions.because they have explicit
instrumentation.Switch to arch_ prefixed atomic operation functions to
avoid the explicit instrumentation.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 kernel/context_tracking.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 77978e372377..a09f1c19336a 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -510,7 +510,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 * In this we case we don't care about any concurrency/ordering.
 			 */
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
-				atomic_set(&ct->state, state);
+				arch_atomic_set(&ct->state, state);
 		} else {
 			/*
 			 * Even if context tracking is disabled on this CPU, because it's outside
@@ -527,7 +527,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 */
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
 				/* Tracking for vtime only, no concurrent RCU EQS accounting */
-				atomic_set(&ct->state, state);
+				arch_atomic_set(&ct->state, state);
 			} else {
 				/*
 				 * Tracking for vtime and RCU EQS. Make sure we don't race
@@ -535,7 +535,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 				 * RCU only requires RCU_DYNTICKS_IDX increments to be fully
 				 * ordered.
 				 */
-				atomic_add(state, &ct->state);
+				arch_atomic_add(state, &ct->state);
 			}
 		}
 	}
@@ -630,12 +630,12 @@ void noinstr __ct_user_exit(enum ctx_state state)
 			 * In this we case we don't care about any concurrency/ordering.
 			 */
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
-				atomic_set(&ct->state, CONTEXT_KERNEL);
+				arch_atomic_set(&ct->state, CONTEXT_KERNEL);
 
 		} else {
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
 				/* Tracking for vtime only, no concurrent RCU EQS accounting */
-				atomic_set(&ct->state, CONTEXT_KERNEL);
+				arch_atomic_set(&ct->state, CONTEXT_KERNEL);
 			} else {
 				/*
 				 * Tracking for vtime and RCU EQS. Make sure we don't race
@@ -643,7 +643,7 @@ void noinstr __ct_user_exit(enum ctx_state state)
 				 * RCU only requires RCU_DYNTICKS_IDX increments to be fully
 				 * ordered.
 				 */
-				atomic_sub(state, &ct->state);
+				arch_atomic_sub(state, &ct->state);
 			}
 		}
 	}
-- 
2.25.1

