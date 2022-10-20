Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858A56061A4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJTNa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJTNaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:30:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C287F986D;
        Thu, 20 Oct 2022 06:30:22 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso2167511wmb.5;
        Thu, 20 Oct 2022 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sNZ1fDkOKC9Jo5TF5/JPoCj3fNA67pPTBhDMAPFRJaE=;
        b=p7R3MLJVulWOVWoJxUiuy38kQNO+DB9kySC1q1IDTEHlTCge3yHPJVvwfk121zyS0t
         aZXEGk7Km24OTocNAHOU/qb8whnMFnBbofdpchAXsw60g1idZfhn7+XgiVkhlqyRWkSe
         xREgVqLMtW/sZyNnSe57eV1yNCjeTDEtPH0ftiVpflWb7A5fMaPsBfeg/sKRcc/wTxV9
         4bU+SgCg+e8eUzacH29oH67R4v8K6UESwzA76kRzTzyBNTTjWGaFip84juhWJ3i5xaMz
         NsSinsFFMKp0EKzJDPndD0t2RTLkOovPZTUaOmkPNBLg/wVcTjO23pV+8CPEiVpV4hVg
         Ixxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNZ1fDkOKC9Jo5TF5/JPoCj3fNA67pPTBhDMAPFRJaE=;
        b=BCyGLmDigb7jyd3VeK2/x0SDL4TfEyYiyYXRS2DgHVIcF/cht6iU233CZFT5dgqiVN
         RIGTOE8KjsMy4LETvM/AjLC55NqG5/C3XHvTLYWLKrgXiW7N4Xg5bq7cnumbKS+dGKTz
         MpM/zD2wgRpFxBe0FiwAhG0AFmitmAqtEuX1HLjs+UyCWoEk3N3LgySfD2UUPgvzwmro
         IeUco+aGqmtzWmDz7g0DbWMaGPLV+tWwnb8MZLrz8VY+egF0ovZedFbqASqU8F5RxEqX
         +fWcj61YNmfGUPFDwhZ46wXVfynjRfPryvBlAPDXmIK81sOPtBU8mOfTMCeXz6eX+pQz
         ACPA==
X-Gm-Message-State: ACrzQf0R1RD0xnKoEYoYlNBU5QiNmK/eEk28+XD39zZ60Tz8EFjhUaDl
        5AUdacshv49jeyEaESROSjA=
X-Google-Smtp-Source: AMsMyM7u77J1zc1h/AiiXbf/YKSxR3EuP7pKQBm+knpBnREYCSLYcG97NY84AN3S+oS+Yst1gnFweg==
X-Received: by 2002:a05:600c:384d:b0:3c6:f5ad:1e0 with SMTP id s13-20020a05600c384d00b003c6f5ad01e0mr15286356wmr.127.1666272620613;
        Thu, 20 Oct 2022 06:30:20 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c204200b003c6bd12ac27sm1381899wmg.37.2022.10.20.06.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 06:30:20 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing/hist: add in missing * in comment blocks
Date:   Thu, 20 Oct 2022 14:30:19 +0100
Message-Id: <20221020133019.1547587-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
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

There are a couple of missing * in comment blocks. Fix these.
Cleans up two clang warnings:

kernel/trace/trace_events_hist.c:986: warning: bad line:
kernel/trace/trace_events_hist.c:3229: warning: bad line:

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/trace/trace_events_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 48465f7e97b4..087c19548049 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -983,7 +983,7 @@ static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
  * A trigger can define one or more variables.  If any one of them is
  * currently referenced by any other trigger, this function will
  * determine that.
-
+ *
  * Typically used to determine whether or not a trigger can be removed
  * - if there are any references to a trigger's variables, it cannot.
  *
@@ -3226,7 +3226,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
  * events.  However, for convenience, users are allowed to directly
  * specify an event field in an action, which will be automatically
  * converted into a variable on their behalf.
-
+ *
  * This function creates a field variable with the name var_name on
  * the hist trigger currently being defined on the target event.  If
  * subsys_name and event_name are specified, this function simply
-- 
2.37.3

