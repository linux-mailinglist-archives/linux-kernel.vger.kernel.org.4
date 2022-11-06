Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0457261E175
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiKFKBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiKFKBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:01:41 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D182FDF52;
        Sun,  6 Nov 2022 02:01:40 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y4so8642756plb.2;
        Sun, 06 Nov 2022 02:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4JSxMfPPRi4uvWXezJ7MJrT+ZDAtZISikWvFV4s0SgQ=;
        b=gTRWgnHcqhlcoBtdif83fdV4mva/ZapwzVcR8KshqADQ2Pwmj+m1TnLSEijgzk7Xh+
         BTBJnK3gwUevL9PG3sMDTTVLsUwo0KFUhmlXLNpyxrA46eaT5bDfUuIBrKG7UY0pansw
         lBQ5sEWuINn/hej//F8zR2qZkZelxYqNYj1gUqy1FYWv29PFqXfANR2ZNTQAsg5bfdBu
         STd+xlPM3LqI1paK4w6zihZ75awvhVJNK/r7vUfXN6WdDY/469XsRgLP4OVEWW7OwGiT
         i8mi0buV1dCE7k7fReVqoX7pWjx6EmueGhze0MlMjEPTkS9lKuyyR5HlgEYMnhZ4snMw
         Zgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JSxMfPPRi4uvWXezJ7MJrT+ZDAtZISikWvFV4s0SgQ=;
        b=gKef9HqUN3G5kS0M5ajO8KKFViKkyeu3FWRKTrRSNqsW3Czm3hipoFPHfHpqbaSUwW
         TeXew10b5r8MG9WjBEfOdgXLOMTVYY98eWZMVJhfTiX9myB20tU7wmDGZGMT9mMpfNVv
         HWNHeGB3PI3mTeOOk1YIroLGeQKbZR+XoXzNwFhVrjj4ZaewVlpRtyGqo3A4JXZ7YFF9
         ZQ7oDwztpslY0BgVa3p0ahuSJEQdlhqukx/djavlUJlA7pioZUYj3ssI1tDADF2/nYs9
         jPMr08P7s80Cmx6M4P5lGYvjbU1Jqk6UyPDLjqn5kkXKP631j5ev+kgoBWIM7DdTRzpQ
         7nAQ==
X-Gm-Message-State: ACrzQf0WIR5g0bsQNDCj6NehDimVhXXF1k+vkjtBJ0caG5cgpaJJFaQ8
        PgmGI3hDtXBBLUd+kjcNVvClOU9iBI+80w==
X-Google-Smtp-Source: AMsMyM5C+jHIBqMqQXTkgKW6u0PNrZTygm4RyoN6U36CvPFnLu+pimivqAl48KcVIBAvmJ732zZ7NA==
X-Received: by 2002:a17:903:54a:b0:186:c41b:dd7f with SMTP id jo10-20020a170903054a00b00186c41bdd7fmr45242141plb.33.1667728899787;
        Sun, 06 Nov 2022 02:01:39 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d67-20020a621d46000000b00562a237179esm2382997pfd.131.2022.11.06.02.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 02:01:39 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] can: etas_es58x: sort the includes by alphabetic order
Date:   Sun,  6 Nov 2022 19:01:20 +0900
Message-Id: <20221106100120.849735-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the best practices, reorder the includes.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es581_4.c    | 2 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c | 4 ++--
 drivers/net/can/usb/etas_es58x/es58x_fd.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es581_4.c b/drivers/net/can/usb/etas_es58x/es581_4.c
index 29c03c8b3f07..eaab5c13f09e 100644
--- a/drivers/net/can/usb/etas_es58x/es581_4.c
+++ b/drivers/net/can/usb/etas_es58x/es581_4.c
@@ -9,9 +9,9 @@
  * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
+#include <asm/unaligned.h>
 #include <linux/kernel.h>
 #include <linux/units.h>
-#include <asm/unaligned.h>
 
 #include "es58x_core.h"
 #include "es581_4.h"
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index db86ca995c5d..81ac1fedcdf5 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -10,12 +10,12 @@
  * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
+#include <asm/unaligned.h>
+#include <linux/crc16.h>
 #include <linux/ethtool.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/usb.h>
-#include <linux/crc16.h>
-#include <asm/unaligned.h>
 
 #include "es58x_core.h"
 
diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
index aa7a4866f870..c1e176dfc090 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
@@ -11,9 +11,9 @@
  * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
+#include <asm/unaligned.h>
 #include <linux/kernel.h>
 #include <linux/units.h>
-#include <asm/unaligned.h>
 
 #include "es58x_core.h"
 #include "es58x_fd.h"
-- 
2.37.4

