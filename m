Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60950705FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjEQGNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjEQGNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:13:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D329B90
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:13:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-250175762b8so466173a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684304026; x=1686896026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z86PqrX4y/+5+oq8xVr+6WozU9j8YjeC6sHlGXCN8vk=;
        b=a4yivuudbHo2I09uLb17GD7LFYcnXFZLkrA8t2TQRTRgY1l/ZYZTmqEfNmRA1o46QM
         /6lStTo7ckehdwIqfpfQect4mMC8bp03TV8/rlSIZeRUS2FYZXrUSMe43Bo6zapLUl0+
         UNAJtznpePtCc0oL3xCgL9qbPfZ3NGKDWVlcfzgks8t8guujZg6P6gmHRQUu2cuncPCn
         9yCUF/kvtcO0ohgSz9iWMhdsC66wwtdCi/kThibuIK7E2MCJokPjYyzoRuXrzAWaTCaB
         TcijDkBv+/MSISX6NcnVXwUAS1jw8TSOIH64HGiMl46dAqpPV+AczcN3+DpBWlSIa41L
         x44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684304026; x=1686896026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z86PqrX4y/+5+oq8xVr+6WozU9j8YjeC6sHlGXCN8vk=;
        b=GMCyaH0+fzMPdKYSmfgMWfFYo26LD8ehabfh3wgEf9BGUSQkZw0tvd6YN9e4fi5p0t
         G8CCs9ijRpKYYdlwISEQZwD/QowSP9J78QhbUQWaSYW8YwRaeNZCJkWY7T6EU/Fv6bJE
         igp0UtBUXS2kykDmyxh83WGh7p8kb/W3FbomfWyvtV+l3ES/7vfdyfxgbN+a5RaoFRzq
         sc+nnY5saBx1WcPLt7U0emmuO79n3PmYlBjh7Q9g0roCV61B6PANm7zNxPTEQagd+C0u
         jhvta5moa7P/CxBsBe1mBuSIC+tN5USeMsYG2Pb3OQt7vMUD/UnWVxTnhypyx5uRzBsw
         Zl0w==
X-Gm-Message-State: AC+VfDx6MsowI4G8Tm0MY2dWYq5d8j9a01sWRpnyHwEMpI1r8yUfFdVa
        b+UIOGguwtKFlm2qIHuWm8Y=
X-Google-Smtp-Source: ACHHUZ59Fb6B1V0IpPx/BhwgSlzvc+1qI/A70mwZvm5kY/Zf6hYxhklPLqss4zU1uYE2aFipqmzd6A==
X-Received: by 2002:a17:90a:bb0a:b0:250:9aee:563c with SMTP id u10-20020a17090abb0a00b002509aee563cmr29331115pjr.41.1684304026203;
        Tue, 16 May 2023 23:13:46 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-16.three.co.id. [180.214.232.16])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a660900b00250cf4e7d25sm672067pjj.41.2023.05.16.23.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:13:45 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 040DF106276; Wed, 17 May 2023 13:13:41 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Pavel Machek <pavel@ucw.cz>, Kalle Valo <kvalo@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 3/3] pcmcia: pd6729: Replace unversioned GPL notice with SPDX identifier
Date:   Wed, 17 May 2023 13:13:38 +0700
Message-Id: <20230517061338.1081810-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517061338.1081810-1-bagasdotme@gmail.com>
References: <20230517061338.1081810-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=829; i=bagasdotme@gmail.com; h=from:subject; bh=WhP7jEPNgJg24gXqpUXwX3DhB31Gt7LSd5vVgGlSECY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkpBZMedy/g4JdPSCn4X3/pgJOssdfZhDi31wXWh5oNG Q/8KfHvKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwEQeeTEyfJWZmGs398LCR33/ 3mW27V+s90etbC/7Bj0j95kG0cuTCxj+J2Y3xlUffLDc9oGHhEdw5+/k+oZLKt/TuZQOWb70TDX lAwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boilerplate notice doesn't mention any GPL version. Replace it with
SPDX license identifier for GPL 1.0+.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/pcmcia/pd6729.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pcmcia/pd6729.c b/drivers/pcmcia/pd6729.c
index a0a2e7f18356c5..d6a28fa6da840b 100644
--- a/drivers/pcmcia/pd6729.c
+++ b/drivers/pcmcia/pd6729.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-1.0+
 /*
  * Driver for the Cirrus PD6729 PCI-PCMCIA bridge.
  *
  * Based on the i82092.c driver.
  *
- * This software may be used and distributed according to the terms of
- * the GNU General Public License, incorporated herein by reference.
  */
 
 #include <linux/kernel.h>
-- 
An old man doll... just what I always wanted! - Clara

