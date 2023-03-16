Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7726BC79C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCPHq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCPHqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:46:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18FA4033;
        Thu, 16 Mar 2023 00:46:15 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j13so841815pjd.1;
        Thu, 16 Mar 2023 00:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678952774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sp8n21BUQb5dHlsU/Jl3vAwa9E+kF9N6pkWBGTGEZ/c=;
        b=m0xT41KK42bpQg1SdxIkvBesNYR67uqep4fC7Gyt9rg/ikc4w1rrJGMUwThWNw8C0q
         COvG8Ynqr0eH9nU5VuxjbKeRAX8dZWztf30gYL2Q+gn57HUOMk2Yt8M9MXKKAG5uh0z2
         dlGyX2rbAd28ALqBvXcKayQl00R0u5MhP5lkZVRdjuhyPz5a0YShAh51D2on3kTsnqN+
         LB3Gkd7xol02CSwTpzHfhNKzInylacO7kiJWosuRUqy4P1Vku/IY7IwIEhWf0OPtHxxz
         xZ63Ixv4p0Ql4tloNsrNGq2gOF9OtEdOEWfKzodBWo7tr/8CdK+yLrFrZNOlgxBqMOBg
         JjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sp8n21BUQb5dHlsU/Jl3vAwa9E+kF9N6pkWBGTGEZ/c=;
        b=4B3axtaYpTaEhy2ybPA8hdwAk9NDjm+IAGNTaLmKzw6zJfLsDogiaEpgNkKfbcXVKW
         m3/jA3Tntc62ML2dPz/i/9+dVazsJk+BVin1Rga5YXKXRbHUzwHE6Bjs3tB0P9kCfofc
         QszcDyXNgxlmcWC6k5c8tNg3Sle6UmYlCw93HLBwlAZqZt+5i8WRohTU7kZ0qKHWlX1a
         naPzUzpKowtM6PX0o7XzvuiO/EXbqgfDI5zGRpwtU6/AZoF1C+qt+niCb8tzu7sgcCT+
         wzhwFK/iJoZzYuZLnyTAx6XqmTUj0zcc477NDCFMcN3frAF7tetahbiB5RH4hrae3fjl
         h4AA==
X-Gm-Message-State: AO0yUKXoGDF6aKnweFjM1Di05m0Dgi5lRJ10YeMb7KOqj9rLBz1VOmXA
        zzouQSCqlmYEWu+2iztTIPSo4Dl1v9ww2A==
X-Google-Smtp-Source: AK7set8XFIK72Rtk0X1EhThGMVUB3zTC+gG6Mvs3ElWDeAAJgFTs5JfLsQrVjIjBH8tAINbxh3yB/A==
X-Received: by 2002:a17:903:41d0:b0:1a0:41eb:fdb3 with SMTP id u16-20020a17090341d000b001a041ebfdb3mr2499067ple.10.1678952773962;
        Thu, 16 Mar 2023 00:46:13 -0700 (PDT)
Received: from kazuki-mac.lan ([2400:4051:ea3:5910::789])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b0019b9a075f1fsm4889717plb.80.2023.03.16.00.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 00:46:13 -0700 (PDT)
From:   Kazuki H <kazukih0205@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Kazuki H <kazukih0205@gmail.com>,
        Kazuki Hashimoto <kazuki0205@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] sched/idle: Remove stale comments
Date:   Thu, 16 Mar 2023 16:45:58 +0900
Message-Id: <20230316074600.288864-1-kazukih0205@gmail.com>
X-Mailer: git-send-email 2.40.0
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

rcu_idle_enter/exit() got removed in commit 1098582a0f6c
("sched,idle,rcu: Push rcu_idle deeper into the idle path"), so this
comment is outdated. Remove it.

Signed-off-by: Kazuki Hashimoto <kazuki0205@gmail.com>
---
 kernel/sched/idle.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f26ab2675f7d..dbfc2eb5ccbd 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -179,12 +179,6 @@ static void cpuidle_idle_call(void)
 		return;
 	}
 
-	/*
-	 * The RCU framework needs to be told that we are entering an idle
-	 * section, so no more rcu read side critical sections and one more
-	 * step to the grace period
-	 */
-
 	if (cpuidle_not_available(drv, dev)) {
 		tick_nohz_idle_stop_tick();
 
-- 
2.40.0

