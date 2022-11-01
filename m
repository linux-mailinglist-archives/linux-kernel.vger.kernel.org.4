Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97887614F51
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKAQcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiKAQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:31:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5431CFDE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:31:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v7so3400328wmn.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/rZtCQJIH1tcdWsQUgVvKDosjDAE+Gq7OIwmjNOiDI=;
        b=obRRjsLUzj/9fSS9Ir2oWyllMpjsDNqARAhKoqpMrwQ6CoYPS++qDEkHEIMH8F7/xS
         f+QlD9OHiyvr3q2A+Kr1KlvLOe71vneqkDZ/6KksiuiXPuTWoPwfp0p4FTBdjbY9JK0z
         hCfj+zKEZ6qFNcilBOvhmSrun5HELIFnM2abmw+66O96lPuzMvJNyD82gDOuIsAp/T6C
         JkHqJ0tRh2Lc47sHosftOP2918io6TPIT3oueICQKzVU4h5peJ6BfVZOxM4yzavYfT6/
         omoJS7GFHRXhenMTNLp8bYgtxymMJYVSOlF9R7kc1Xb6FaZgyNl9OCZ7sD5UQWSaAaw3
         rT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/rZtCQJIH1tcdWsQUgVvKDosjDAE+Gq7OIwmjNOiDI=;
        b=bBe9CEOwABt7I9nQBIIf10DFTLlG4DVtW3H7zof5hCGjeykIvJ0dl64QFWcPKuvPvS
         bFY+9+BC/ZiGHz2Q650y8OqXbDqXt1aW3fNo9ilxZdirIXaZS4qlOGnCWkLByCy0nIiA
         Z05D82YQd2o9EJBH8gKQWqzcnlTb0Gyp3BQWbi3hZ9HigxA6THp2LVFVxQS94UfzpE8I
         pzFnM5b1J7PA6RwU3QSde3/SOvbCa4aii3aGLyfas3iamtmj5sdG9ez8XeFFTNAxzmuU
         fZVAwysMv9mJT7GefsxiWGoz2YCDAu1X4nhF6VtVxmxQ6nI9pFAD4lFmg0Mot8sfmSgu
         e3zA==
X-Gm-Message-State: ACrzQf0beyo+6o2lrzr5TwOfq9nHdRdadb02c4hy5RFflGQR4Qci8X3y
        dYvn5fMQYHP8Oerg71QXpVAzjA==
X-Google-Smtp-Source: AMsMyM6IU2ns6NLnyGvlHGiTa9VHUODxQoTiE+yXYHZwqyNMR484p4jVR+dqMo3bW7TOYVgWwkzPIg==
X-Received: by 2002:a1c:448b:0:b0:3cf:6fcd:e171 with SMTP id r133-20020a1c448b000000b003cf6fcde171mr8659097wma.163.1667320293696;
        Tue, 01 Nov 2022 09:31:33 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:e844:18b6:fc5:bbc9])
        by smtp.gmail.com with ESMTPSA id bu15-20020a056000078f00b0022ac1be009esm8339844wrb.16.2022.11.01.09.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:31:33 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 11/14] kernel: events: Export perf_report_aux_output_id()
Date:   Tue,  1 Nov 2022 16:31:00 +0000
Message-Id: <20221101163103.17921-12-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101163103.17921-1-mike.leach@linaro.org>
References: <20221101163103.17921-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight trace being updated to use the perf_report_aux_output_id()
in a similar way to intel-pt.

This function in needs export visibility to allow it to be called from
kernel loadable modules, which CoreSight may configured to be built as.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ec3717003d5..ad388552f1d5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9231,6 +9231,7 @@ void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
 
 	perf_output_end(&handle);
 }
+EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
 
 static int
 __perf_event_account_interrupt(struct perf_event *event, int throttle)
-- 
2.17.1

