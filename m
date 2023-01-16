Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392AD66D218
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjAPW6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjAPW6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:58:18 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA1D274B5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:58:17 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id y8so20474871qvn.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hAVeJ3QCRJXUeljpomXwE9NpCpHhvuz/NJiGaZWhfFw=;
        b=KJQ2yk4hC0LhFeEZ9kvAmS2enIdFwP4k1kv4Uzj5G2KHoT1BAU73mB0lXPos19uZv/
         AMw/Wd5vPAme6ZW1IPCSFOWoQM4GWSxYKU+lBfMlexrSazehIzyewBMpGJXMwxvlUn/q
         8MVKGxpnLUy2gVwonxxrX5VaLGgVpgr2xgVPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAVeJ3QCRJXUeljpomXwE9NpCpHhvuz/NJiGaZWhfFw=;
        b=R5J0ZNAFadtPY75zvRn1ND1VVy7gLMFGen0lDDdhaULHxKQv6OCBpIHGvN9sj45QQE
         hLT9rjPbrp2qEJYmPXJCTJ3HcoKIkRufyHlrBEktKz2nmqS7tJX19Jk19OkAbdu7Ea9p
         QzUkLjOxBQHuhNk9A6HmT/9JedSG38h9zJpHA6C/Ez/jPDhstFJ0nPOTKfNBjo/ZFarn
         Fkw5bVWfxGmr/7qPRQ3a55lLzEsbvX2ht58vXkEBHjd4oeRBrltGoV7wTt/AnOmlHJJS
         FsRYyWGfkNDLONQ3na+WOaX3fThHyYUqSOdWhExit565tH3MjF5PBBNqmPpeC11/Uuvf
         cpOw==
X-Gm-Message-State: AFqh2kojcTHhltj5SRbF3piclCr6+DZl/l6gsnctSXm9WvmA5TekZfuD
        X+D3h751eRXYcjBUVkMUsl//JQ==
X-Google-Smtp-Source: AMrXdXtm3mFEZc+22VlVjLu5vcUPcyXQ8lMkk5Mo3FjUVi9xJJFcushAFrgq6LYg00xFQLdFORLbNA==
X-Received: by 2002:a05:6214:449e:b0:521:2df4:f467 with SMTP id on30-20020a056214449e00b005212df4f467mr2173798qvb.38.1673909896207;
        Mon, 16 Jan 2023 14:58:16 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a408800b006b5cc25535fsm19477633qko.99.2023.01.16.14.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 14:58:15 -0800 (PST)
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Mon, 16 Jan 2023 17:58:10 -0500
Subject: [PATCH v2] Documentation: Avoid duplicate Kconfig inclusion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230114-doc-v2-1-853a8434ac95@pefoley.com>
X-B4-Tracking: v=1; b=H4sIAILWxWMC/1WNyw7CIBREf6W5azG8NK0r/8N0QeEiJLY00BCbh
 n8XunN5Zk5mDkgYPSZ4dAdEzD75sFTglw60U8sbiTeVgVMuKGOSmKAJpTdjpdI9GwRUc1IJyRTV
 ol1zZ5U2jK1YI1r/PedfY2Xn0xbifr5l1tL/4cwII2hR83s/oOTiuaINH9yvOswwllJ+Sqhm9rE
 AAAA=
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673909895; l=1830;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=SbAysLBIHcEAKkk779RsONCQdynE04KhleZNtYfEcD4=;
 b=lxXIOfwh/KHXc/bz1tm270KM2GGlxntlDtXSBAJq8DtFGt7ywdzUtCMCzTEO78nTiPlOCMlPWQ1F
 rlfV63CxCoZHmFsqbpLuEf0emhQwKe5faIxCTSxg/sKlTwGT4NZy
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/Kconfig is already included from top-level, avoid
including it again from lib/Kconfig.debug.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
Changes in v2:
- Add a top-level Documentation entry instead of nesting under Kernel hacking
- Link to v1: https://lore.kernel.org/r/20230114-doc-v1-1-efec2689e423@pefoley.com
---
 Documentation/Kconfig | 10 ++++++++--
 lib/Kconfig.debug     |  2 --
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/Kconfig b/Documentation/Kconfig
index 252bfc164dbdc..3a0e7ac0c4e32 100644
--- a/Documentation/Kconfig
+++ b/Documentation/Kconfig
@@ -1,6 +1,9 @@
+if COMPILE_TEST
+
+menu "Documentation"
+
 config WARN_MISSING_DOCUMENTS
 	bool "Warn if there's a missing documentation file"
-	depends on COMPILE_TEST
 	help
 	  It is not uncommon that a document gets renamed.
 	  This option makes the Kernel to check for missing dependencies,
@@ -11,7 +14,6 @@ config WARN_MISSING_DOCUMENTS
 
 config WARN_ABI_ERRORS
 	bool "Warn if there are errors at ABI files"
-	depends on COMPILE_TEST
 	help
 	  The files under Documentation/ABI should follow what's
 	  described at Documentation/ABI/README. Yet, as they're manually
@@ -20,3 +22,7 @@ config WARN_ABI_ERRORS
 	  scripts/get_abi.pl. Add a check to verify them.
 
 	  If unsure, select 'N'.
+
+endmenu
+
+endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 881c3f84e88a3..4bafc5ca51f20 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2872,6 +2872,4 @@ config RUST_BUILD_ASSERT_ALLOW
 
 endmenu # "Rust"
 
-source "Documentation/Kconfig"
-
 endmenu # Kernel hacking

---
base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
change-id: 20230114-doc-005df4ac8193

Best regards,
-- 
Peter Foley <pefoley2@pefoley.com>
