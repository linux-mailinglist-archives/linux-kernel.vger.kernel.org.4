Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0425B5633
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiILIaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiILI3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:29:38 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5F8641B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:28:56 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t70so7592394pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=OBbTmrnGYYEQknZ8kYcYWaHEkIjSOpCEkGm+S0dkFok=;
        b=JqyWF7jyFbnOIzpxQ4UrlkX4S72p+kGaGmGFz8sLCsxdoMKrW8XQxRJX9QPV2xizrY
         WWpletd/ughqX41hBUrLinorrNFIasfWbLfkdnLNj80gbJclBaKBk/8lmL9XplSe2uIO
         9begGKzgmYQjF0vO7wuLtqlUjR3b7BZvNbpvnw7BNy1Ve9Nb7MOWyANtEe+vxEhNkOyA
         yOOB3DREDMuFxt4Yn3DcccqPhvpEwiUh9R2XCnZJwbkYoQnq9INWmz1ajMyMi/nkskqr
         jJLY82EtcqIbM8Q3TKda99g4ehxW8mfwJ7sXxvOJknSxnTSBhQ35IxKoP+ZWAckhP9t3
         enzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=OBbTmrnGYYEQknZ8kYcYWaHEkIjSOpCEkGm+S0dkFok=;
        b=rtrhhfpzZxSTi+uDZqXFM9t7yaqr/ams++bI1eZmsiJbg7oppoeBF3QR07n4pk7cY9
         dOZZ5CB/OvaRIr2nuj4rA90NRlNajQyIREARslynghuvQDN97ghnBOsg9KTM5ZxOcJJd
         fQZswUB5/rnH903m9qExLeH+PO0dsGyGBthK2f8qjTmbMGVBMQokvtfP/7yC0u5Zje00
         +HtJAMtF3IaHjaQrBLKPTlnUJ2qkccPl00oAMud+kApYk1MonWtBp07NCtcl8qeG4MaM
         pIVazbprcS4Ln9S7qUu8s5uu++/dAPBnIqYzXCjbKCplPSBf1vVNHVgjn0jjxFpu/snb
         3Z/w==
X-Gm-Message-State: ACgBeo16pKbo5XbdPvlxUnfgCOKfWsKaR7xtBVIXrgvWtE1787vKDH54
        7OoVYRFamBpPnU6xdXGWtFg=
X-Google-Smtp-Source: AA6agR43py9T3T1JIAFnTBCV2vChN1bFk6dnRK/385q4EHMzdUDnzfImqQl3c+fcaIZRI/d0fERY0Q==
X-Received: by 2002:a65:594b:0:b0:42b:f6bc:a04d with SMTP id g11-20020a65594b000000b0042bf6bca04dmr23157234pgu.313.1662971335839;
        Mon, 12 Sep 2022 01:28:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902aa9700b00174849e6914sm5301053plr.191.2022.09.12.01.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 01:28:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] sched/core: remove duplicate referenced header files
Date:   Mon, 12 Sep 2022 08:28:48 +0000
Message-Id: <20220912082848.17859-1-xu.panda@zte.com.cn>
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

linux/entry-common.h is included more than once,
and linux/sched/rseq_api.h is included more than once.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 kernel/sched/core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b60422300af6..1de0c26a370f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -78,7 +78,6 @@
 #include <asm/tlb.h>

 #define CREATE_TRACE_POINTS
-#include <linux/sched/rseq_api.h>
 #include <trace/events/sched.h>
 #undef CREATE_TRACE_POINTS

@@ -8427,12 +8426,6 @@ int __cond_resched_rwlock_write(rwlock_t *lock)
 }
 EXPORT_SYMBOL(__cond_resched_rwlock_write);

-#ifdef CONFIG_PREEMPT_DYNAMIC
-
-#ifdef CONFIG_GENERIC_ENTRY
-#include <linux/entry-common.h>
-#endif
-
 /*
  * SC:cond_resched
  * SC:might_resched
-- 
2.15.2

