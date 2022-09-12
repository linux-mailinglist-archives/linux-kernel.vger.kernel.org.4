Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5AC5B563B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiILIbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiILIbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:31:18 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68332389D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:31:04 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y136so7917740pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=oNXzENisJipNneL7zATJDx8su8CIEdjuoeO858q6IRM=;
        b=PNS9YKAtvuHDskyRH6e+Ty+jVb2SlJ7DyoV/vlwzfGDAFN1zWKKM3C2l7DBrGuMLhs
         Nbi26WXf2ZgybX7NOWQVAd159J2mAW4eksjp6ilkqdXOcsq92vpuVcXjb4pHGY8L4C0/
         txY2E8wkUbhRWTfPZ9qUElPvvgD65rpReIX1/h6blbPfb3dHSO3kUdJqKuSFWv38kqDF
         /2k49Ee/zipfct/Rti3EVPjnYTZy6NneOlPpoyKXFWx48sOwQJF+pkxkroAQrF+bOKlP
         BihAb2J9VuYSuoVE3F4tRpXDt36EnGh5wmyAFwl6kfNwhQ3SgkyopC3n4cmmT0ak8/Ld
         fAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=oNXzENisJipNneL7zATJDx8su8CIEdjuoeO858q6IRM=;
        b=58sa6FXsxpVQL/2AwZr1t0eRCkHdRIGJUeG9/4Hg7d78WmGwdZMPBtubh2XNugrl2l
         7gxz8Fsi+KOwucCGVirTUAFHKQ2kZbol38vJKFY4vO87YDHBMURXNNyK0v2BlytukrX0
         UMpTRAheZ81Qn3Sl3XENxtMuUJfDPEAZ+cN28W4NvvTxLcT2fQeUtl8cL84ZRj7sviq1
         /R8uC79HHHKjlX0zgX+xzmXdnmkYSbh+XR/mBSj+ywjV4rXT7AOcw0IykhnkhV/NDnFO
         QAu1ieopzkzxW97pHcr6hwzhZZglszDMz/Y9YSeghWB/pky2bREYDA5p64hRCzWsqoGi
         lybw==
X-Gm-Message-State: ACgBeo3SthHUYJNQ8v1lJEotJhodORuToy1rWYlhE2mNwUVIXJUvoYG1
        2dU1kAx7a6WKfCibpzMzoOI=
X-Google-Smtp-Source: AA6agR5E3KZArHImu0M2Fk+6RPG4kSfnISHPqjVFqsl0vq+xVKdT7i2SFqK0t6iJnDIG9oGb4rOEEg==
X-Received: by 2002:a63:2bcc:0:b0:434:eb77:28a with SMTP id r195-20020a632bcc000000b00434eb77028amr20868606pgr.168.1662971463940;
        Mon, 12 Sep 2022 01:31:03 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ie5-20020a17090b400500b00202d585c4basm1078814pjb.5.2022.09.12.01.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 01:31:02 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] sched/fair: remove duplicate referenced header files
Date:   Mon, 12 Sep 2022 08:30:49 +0000
Message-Id: <20220912083048.17916-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

linux/sched/cond_resched.h is included more than once.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 kernel/sched/fair.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cf3300b1a1d2..66d4c4a4dfd1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -50,8 +50,6 @@

 #include <asm/switch_to.h>

-#include <linux/sched/cond_resched.h>
-
 #include "sched.h"
 #include "stats.h"
 #include "autogroup.h"
-- 
2.15.2
