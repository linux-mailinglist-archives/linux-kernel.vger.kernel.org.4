Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741966EE26B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjDYNCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjDYNCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:02:42 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C6018F;
        Tue, 25 Apr 2023 06:02:41 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f18335a870so37199065e9.0;
        Tue, 25 Apr 2023 06:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682427760; x=1685019760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2ASUOIyunU653b3hIoNRkaW7evYIbPbMl1nNELwvTY=;
        b=RqbF3fXtI7lAXqpUWBMTetY6AHqmcbpRX5QIIFhAtPv6A2sazRYJdCVQasGowExWDE
         Io4eWkYRO1pnEqfX2KDL0l/0m7MIsc/h8HRmrnhGMQJ6YHuImMZYADqZJOi+XevJv6PZ
         Jhb1Mpz3IqwQoDZss0ThdZa1jnVsCxTAz9FrzzYFIrMmQTEdf6XV2MHvLmIlOMVHpM6q
         XESK/cLBY7B7UPMEXdYCskl8SvTGqULCKh0CE9K3hLd3Iwg2CjpTdX+HuoGYODreOK/v
         kZGXNHXJ+XhZKvUF2/tJjjWW7p9VEXSyq6BCxA19LPpRH8ibZpkFO3pS4HOTntiGF/1Y
         p7HA==
X-Gm-Message-State: AAQBX9fBBW4QyaQnnah2Zb+whyk0GljCkQ5fKRTwnTph2cye5kB8eJhp
        4lFCOo3EG3jTwGzW7+AB5l8=
X-Google-Smtp-Source: AKy350avZVKPbbCDMPoU5rGqky8x6+SOM0NP9UxMlnpmsalD3Urhdi4hXTlnW2eFN/jlTxpN+A+DlA==
X-Received: by 2002:a05:600c:22d4:b0:3f1:82c6:2d80 with SMTP id 20-20020a05600c22d400b003f182c62d80mr10726539wmg.5.1682427759701;
        Tue, 25 Apr 2023 06:02:39 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b003f0aefcc457sm18429945wmo.45.2023.04.25.06.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:02:38 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] docs: move tracing tools
Date:   Tue, 25 Apr 2023 16:02:30 +0300
Message-Id: <20230425130231.912349-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

from list of development tools to user tools
because these tools work on running kernel
and are invoked from user mode

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/index.rst       | 1 -
 Documentation/tools/index.rst | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 9dfdc826618c..81e1af951731 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -56,7 +56,6 @@ Various other manuals with useful information for all kernel developers.
    dev-tools/index
    dev-tools/testing-overview
    kernel-hacking/index
-   trace/index
    fault-injection/index
    livepatch/index
    rust/index
diff --git a/Documentation/tools/index.rst b/Documentation/tools/index.rst
index 80488e290e10..6a9a44f7f88a 100644
--- a/Documentation/tools/index.rst
+++ b/Documentation/tools/index.rst
@@ -12,6 +12,7 @@ more additions are needed here:
 
    rtla/index
    rv/index
+   ../trace/index
 
 .. only::  subproject and html
 
-- 
2.40.0

