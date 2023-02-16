Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631E369899A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBPBD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBPBD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:03:56 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C9E25BAC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:03:54 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id dr8so1345650ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oHY5hRid8MSg+DgBSSpcw3a50RDU4+6ZiCtEsIAAH9s=;
        b=iQKaJw1nLmlCMjRG+OthFAxR9mbjJ+rW24jbPBbi9qUBv0/NMoyF8T95AwJaNbjZd6
         cXELlt9ubm/ckUE3lGHdaccVBlOAzBseJRFrIRgeeerOiV7BBV3Vc9/1DT5UDvp+lA1K
         0TNVtz7YOYtcBz8sT0UItmLskjKTIiMd5XpzklHcrdd5WCgdde42yoqNF9dYpjnhiRfk
         u2pH0XhFd1xjsbb9T3sELFalZ/XCPn2GaxV2VIIbiu1voUm5rL3a7lykdjDc8kOqPSK+
         qWGKrToY7VIGz7gVCKg9W17JnFN1Efct8vmWmbhmObhHQyRQoUe/v4FfAwNgDsXK1vzN
         VFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHY5hRid8MSg+DgBSSpcw3a50RDU4+6ZiCtEsIAAH9s=;
        b=P0E6uv9X84JUc3uefQTWIIAatwl328mmB1/vZipwcDPdAa2Gp+3Un5M7Vd1Y6QZE6e
         PDYlF4KKix64RksGCWW6sjZZD2XTiYmt2QRCU3RqeCx3+JaoTRNBp8I/Nb633xAmVKqU
         LIrmxPRFI0RUY2WhuAnlZZUF41MFzrmNVQa35EwQB580tOxmyCJ9/2rad/l5KDAVe51h
         E3za/Vu+gECbXf7j6to2czNBZqHuofdexim9f2p2frLASB251hz0DZza9NGOU8QAp8w8
         QAE1vN8m/7oRFkxyEHEZP8u3rARCko03hBZ0y7OUegtWyVsnbVz5Eflv8YaBR+ztGSLx
         Db2A==
X-Gm-Message-State: AO0yUKVU54jH+x0VCt6CEFHWknnVRYY3/txZO1f+tMTCZjn0JzHhqlNy
        JbUXuXwDQD7xZJns1r4HIXotUiiN7fCZK07M
X-Google-Smtp-Source: AK7set8NemRNakE3+qIOQf9YOqnubJ6ZLwvDNGxsO6zDZulVrYaN9KIr8L+XgoTCG3vTPoiHFolFSg==
X-Received: by 2002:a17:906:af8c:b0:878:61d8:d7c2 with SMTP id mj12-20020a170906af8c00b0087861d8d7c2mr4469327ejb.39.1676509433212;
        Wed, 15 Feb 2023 17:03:53 -0800 (PST)
Received: from smurf (80.71.142.58.ipv4.parknet.dk. [80.71.142.58])
        by smtp.gmail.com with ESMTPSA id qh20-20020a170906ecb400b008b13836801bsm72306ejb.183.2023.02.15.17.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 17:03:52 -0800 (PST)
Date:   Thu, 16 Feb 2023 02:03:29 +0100 (CET)
From:   Jesper Juhl <jesperjuhl76@gmail.com>
To:     linux-kernel@vger.kernel.org
cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [Patch] [samples/trace_events] Remove unnecessary version.h include
 pointed out by 'make versioncheck'
Message-ID: <86718c8a-4a55-7254-f489-9c071588bc25@gmail.com>
User-Agent: Alpine 2.26 (LNX 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 8917ba4246c3fa7344523a0c46b793c5dbb0400b Mon Sep 17 00:00:00 2001
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Mon, 13 Feb 2023 02:53:37 +0100
Subject: [PATCH 07/12] [samples/trace_events] Remove unneeded version.h
  include pointed out by 'make versioncheck'

Signed-ogg-by: Jesper Juhl <jesperjuhl76@gmail.com>
---
  samples/trace_events/trace_custom_sched.c | 1 -
  1 file changed, 1 deletion(-)

diff --git a/samples/trace_events/trace_custom_sched.c b/samples/trace_events/trace_custom_sched.c
index b99d9ab7db85..dd409b704b35 100644
--- a/samples/trace_events/trace_custom_sched.c
+++ b/samples/trace_events/trace_custom_sched.c
@@ -8,7 +8,6 @@
  #define pr_fmt(fmt) fmt

  #include <linux/trace_events.h>
-#include <linux/version.h>
  #include <linux/module.h>
  #include <linux/sched.h>

-- 
2.39.2

