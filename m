Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F2E62C14C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKPOtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiKPOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:49:19 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD651A218;
        Wed, 16 Nov 2022 06:49:19 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id i9so11718925qki.10;
        Wed, 16 Nov 2022 06:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhR7eY/FHUNkamlu87P06c2sFlG0j+sFMpgEhxSGbjE=;
        b=Z8AEhLrjv453G4hwPs1L5mhG7GbIvre6FObGi8TKYbrjzVV0Z/cPvFGjtqKKIVjFEZ
         WenvBmMN9WZ691aONBMHBR7YVW25qnB50D6vBJedMXs8MY3WcZpjbp/f4X67hEdltbp7
         7q475laYXvWLLcpqU0oW04fbwSbxK74DBNUwjO5aLRsj7xPfCguq3E54WtVXWk5AvrWL
         Lq124W/b7eAUDNibkkl6kN5LWVU2TZ8dgTyzs0s1f7YPHBW7bIUPGyax+RxHo0rUqLhE
         t5spOsmpxSx4YQYwHb1hhtwjRmEiPvTo2JR0+SyS14qiFjthfwpy5ZwQuCy83bOFl0vL
         u4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhR7eY/FHUNkamlu87P06c2sFlG0j+sFMpgEhxSGbjE=;
        b=465dlKJ6EM/iFllbjhs37nW2AR9wt38MYhq6rIfRm0u2P0wIdS4Nv9CZGTiWxkj3XD
         6E6nL9f+YYq3w4JTwv7Usq6fWG4XvfcnQNhTwKeCZh3mJ8vCwqs6lSxjYZFCSyNc0K8A
         JcCULrRC7JNBL3XwhORaESr1ujjplEHPfXAJ/pYFwJ7CaXvZLl9L8J/i/LZP+YOHORrx
         sDJ9lfM0V7q6XXRhY448KqhF8FujAlxSTuAD7FkLJWRTiB+AQLNLj8AAQe1u/0J5X3i2
         0+4y8Fc0R3aoP7F10YzoVDMdi/hswrweNV1EQ3jJRMee8CrZgieoFGmDtFBjpcQsoC7H
         ia0w==
X-Gm-Message-State: ANoB5plUBxqr3WhH1Y1jdgqZX7hHjhGpynU0fUTR/KWQ9V78SipApplj
        5YjSVulnvlaZt12cEFwyrwnyCVEdKp8Few==
X-Google-Smtp-Source: AA0mqf4Szr2A4jFj3lfVSAI5qD4/n9TvM+CrDDB3Yov4qxKVCNXziZNirxyFL+Jv9+fG8VBpt2dzvA==
X-Received: by 2002:a05:620a:20cb:b0:6f9:26a0:53af with SMTP id f11-20020a05620a20cb00b006f926a053afmr19127501qka.768.1668610158036;
        Wed, 16 Nov 2022 06:49:18 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id g5-20020ac84805000000b0039a55f78792sm8729624qtq.89.2022.11.16.06.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:49:17 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 02/14] serial: liteuart: use bit number macros
Date:   Wed, 16 Nov 2022 09:48:56 -0500
Message-Id: <20221116144908.234154-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116144908.234154-1-gsomlo@gmail.com>
References: <20221116144908.234154-1-gsomlo@gmail.com>
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

Replace magic bit constants (e.g., 1, 2, 4) with BIT(x) expressions.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---

New in v4:
  - explicitly include <linux/bits.h>

 drivers/tty/serial/liteuart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index db898751ffe3..18c1eb315ee9 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2019-2020 Antmicro <www.antmicro.com>
  */
 
+#include <linux/bits.h>
 #include <linux/console.h>
 #include <linux/litex.h>
 #include <linux/module.h>
@@ -38,8 +39,8 @@
 #define OFF_EV_ENABLE	0x14
 
 /* events */
-#define EV_TX		0x1
-#define EV_RX		0x2
+#define EV_TX		BIT(0)
+#define EV_RX		BIT(1)
 
 struct liteuart_port {
 	struct uart_port port;
-- 
2.38.1

