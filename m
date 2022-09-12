Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567B65B56E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiILI6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiILI6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:58:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74343186EF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:58:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so11658068pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=9xXKuA/RuFEtQpMHeBL2xKtprriOHjs4a6CMxj7T1LE=;
        b=B9SvQWz54Q8Fjsqm7tHuL2MioTs8PrE9sYDRrGOhVgVhUAK9gKTF1CzTUSU+4DN9fE
         UzZ0s5pnsQ2HI9YYr8mazFVs1fMSI+GXEvJ1J9Y8Tx4JZ5Gu2oU9OMAgTxYcUwLYF/HY
         USg5CJ/EcmSXNZlPGM7YMFF0QUTZvWJi2H0eDUE1/WJ9q1R3kOMZ21DW8/W2HnZRFjVh
         eCrPwOXlfVnmXmHR+hxmRz2gL2php4RZ5/PHtpcNKd6S+4THdcmiAJs4Jorl7222RDbS
         0jy/WAl7Ky2p6x61AZ0cCX3ZcCVTMDfwpAFGEF8LVrUps4CgZy2+lOiKTs+K4CWio6gl
         Gwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9xXKuA/RuFEtQpMHeBL2xKtprriOHjs4a6CMxj7T1LE=;
        b=OxE6vcxONHHknCxo/S6NIeaV+VGOU7hDtg5RRstCx1mWJ7nUSjAdkjsQPJZRwLTXDU
         pn6siJPun3SGK25OnhRU+nc88F63JhqEhRSbitenrOQtZOfGKgx+I9Mi4Z6b68254uRs
         ImCbzEudjWCBNrToUXkhjqIxCB/mr7BuarYS+Ylo0O6YDLbqg6DjSq57PPEZrLMS9I00
         vgkWg2L8Ay3TUHTR4v0Yl0wUP4B5O3lbTHicQnyGo+xKFNzEBgVma9cybsrnht/K7Mhq
         WWNPpzxjJVbWf5OHwD4r2PLf6aSe6Da7qsoI3xF0FPpzj4ofoXZW49rKa6wyvahzYL2d
         xONA==
X-Gm-Message-State: ACgBeo0jr/GnZJwxwi6MoF9aWyzealejQJgA8yhFXeGMbJQtUiFlTYjS
        L7uQKX4lTcqjODxoKHl7yi8=
X-Google-Smtp-Source: AA6agR7rYUlTsgIRn6HiQ9hWEpTbYoeDhZAYi0FA4RkjDwfsFPHcxHaQjhmKTL9AEWM6OO5vJ0LoBA==
X-Received: by 2002:a17:902:f641:b0:172:e2f8:7efb with SMTP id m1-20020a170902f64100b00172e2f87efbmr24718802plg.140.1662973121973;
        Mon, 12 Sep 2022 01:58:41 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001730a1af0fbsm5446503pln.23.2022.09.12.01.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 01:58:40 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] sched: remove duplicate referenced header files
Date:   Mon, 12 Sep 2022 08:58:24 +0000
Message-Id: <20220912085823.17983-1-xu.panda@zte.com.cn>
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

linux/cgroup.h is included more than once,
and linux/static_key.h is included more than once.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 kernel/sched/sched.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f616e0cec20c..ab75e421a96b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -75,14 +75,9 @@
 #include "../workqueue_internal.h"

 #ifdef CONFIG_CGROUP_SCHED
-#include <linux/cgroup.h>
 #include <linux/psi.h>
 #endif

-#ifdef CONFIG_SCHED_DEBUG
-# include <linux/static_key.h>
-#endif
-
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
 # include <asm/paravirt_api_clock.h>
-- 
2.15.2

