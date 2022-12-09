Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18B4647C6C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiLICwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLICwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:52:10 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F2787433
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:52:10 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 6so2659689pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 18:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0bEbv6gKjkvLzK6FnFgGRMzqaf35Emb3acYPllCJUpQ=;
        b=ob+aYaXKyBkaa1yH1tnSzc5hV1m6S7VA5t2hXtvKOBOFo+wS6KXNL3VU2VKb1V6IKh
         U3HnG8rBsGV3GVJrdATw06VdpIfEau0F4tCXPig7i4zl8YAtuzAKrjT4SZYHrdMSEX0e
         +vIRFTyj8PqGi5dq7tcTpsaU+IrRoYS6US1OTas5Bo7nQEyP+diWvOMa39gS0M36W2hT
         1sLGxHwFSDHq0D5ABzsZCTkqCoCD6xmtbCAayNNGWY20UURGwinVrxaA1U1PolvRzibf
         OOjMz8KcAIAwj6D2Q0q/IIGzdl21zaRTZeZbzK/wUl5wa9Ayz5o0J4f9n8t7l6M556eC
         o5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bEbv6gKjkvLzK6FnFgGRMzqaf35Emb3acYPllCJUpQ=;
        b=gN9YH3ERcExNXy+z+4qpwx2r2VHXGEX5Nx7FMnLRgPTA+UkDe+6ur2z2zdQisaN9JH
         LfC9jJo/jMXn6XWxMS41dmmUingTpzW6fs4We0xadEp17YXpzwFS09ynOgSbSSJHQ/5X
         nS8o97/ghn1rkcWQAnmr9pXxFzxDrgbaY8JJX+Gx21So8vkvJ++GZ3IlAYLaWh8y7QC/
         +SKyStVy2pHidNX+YF6aVerAY/+CwpDOxF5nC99pMKbbJWoJNbgvBsjuq68JxJIEYCVR
         eLeYzreMbgoDUrNs9ufXi+guwyGEBSWT1EHlA6JGOtPZl8sUsowIdjrWsv3siOnvhPwQ
         EOMg==
X-Gm-Message-State: ANoB5pkmgXXwLlER8MFOoX9iLufrWGFTLBkdiGWXMElGYihx/Xu5h6XL
        gs4pjF8GyLb5o6Ff6fz/js+D1JAW0j8=
X-Google-Smtp-Source: AA0mqf6Io21FkjrBOCGdxZED4ZsZpOkNliX8qu7U0NU1pciOqWiD+HsZjEZKBnrWSc3ZQ5qn7SMSjg==
X-Received: by 2002:aa7:9ecd:0:b0:576:9455:4c5e with SMTP id r13-20020aa79ecd000000b0057694554c5emr4024654pfq.24.1670554329827;
        Thu, 08 Dec 2022 18:52:09 -0800 (PST)
Received: from ubuntu.localdomain ([118.73.12.140])
        by smtp.gmail.com with ESMTPSA id i125-20020a628783000000b00576b603a913sm208230pfe.0.2022.12.08.18.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 18:52:08 -0800 (PST)
From:   Donglin Peng <dolinux.peng@gmail.com>
To:     rostedt@goodmis.org
Cc:     tzanussi@gmail.com, linux-kernel@vger.kernel.org,
        Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH] docs: ftrace: fix a issue with duplicated subtitle number
Date:   Thu,  8 Dec 2022 18:51:19 -0800
Message-Id: <20221209025119.1371570-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The subtitle "5.3 Clearing filters" and "5.3 Subsystem filters" has
the same index number, let's fix it.

Fixes: 95b696088c1c ("tracing/filters: add filter Documentation")
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 Documentation/trace/events.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index c47f381d0c00..8f86eef1bada 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -258,7 +258,7 @@ file.
 To clear the filters for all events in a subsystem, write a '0' to the
 subsystem's filter file.
 
-5.3 Subsystem filters
+5.4 Subsystem filters
 ---------------------
 
 For convenience, filters for every event in a subsystem can be set or
@@ -305,7 +305,7 @@ their old filters)::
 	# cat sched_wakeup/filter
 	common_pid == 0
 
-5.4 PID filtering
+5.5 PID filtering
 -----------------
 
 The set_event_pid file in the same directory as the top events directory
-- 
2.25.1

