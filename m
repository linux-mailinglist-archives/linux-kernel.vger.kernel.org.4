Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B6D66C83C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjAPQhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbjAPQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:36:34 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2668B32E44;
        Mon, 16 Jan 2023 08:25:30 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ss4so62015659ejb.11;
        Mon, 16 Jan 2023 08:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FqXjMQkYS4EvIeq90gP/HUPBM251gTsCOw0vQocW76c=;
        b=f4XeiWEzsAcCtqVk0q1uzAUNea+XDAdF2YH35e6ZNEy4lnsrIjJVLwdJKmztQg3djX
         nAyAO5wzKJCgrYFQWEKXS9SjSIrnJKNfhDVQr5sF3lXpCMZMHNH61Z0+fPKLFwkwJwW7
         Y0TleNOVxNHnnuapn5b/0OgDWfIGLzRpCSeRJls7P2M76miN5vky5eQiyRk6POK01fBG
         gqWnFJjrbYA8MF0zeKols+ddjQHbvlXazqbLrQH43Ex/X2U73vvf9v0UxMdGg3Y+7x2L
         Ul8hYssEpTYMG1uLeDMtcyCRsud4hrM+hcqa7R+UBS4vq63D99MUmr3w6jFM7LYSTfkA
         9PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqXjMQkYS4EvIeq90gP/HUPBM251gTsCOw0vQocW76c=;
        b=Yfsg+bhVoOJQdpStyWV+3QrnHVTjwdk9QkOIMVXr50HQ5PUTl5e0E/Bh9xuBW07zp6
         WT3aoklAfuqJKz5XFwg6dExXzAPBjylTYcMJJ2B4CQKJTofoNhqSTuqFGcZzLyvR0WxJ
         U8FSVlNqXZxy/+5MoaoXaNa2X7Bb42t2TcrZx+BiArsa6WjT9gEiVSSrarUwfC8oTC0Q
         QB+5NDg29V0WKJ1Z+0N4/NAMLoB5kbKEzxUgQ+BilqxTdR2fSmo6Fb91J4/HsLCB/MS0
         qNwDw8ts6fYic7tqou/gRudS9s90u87rtKIDICRWkitZQS9pGfKIngWexQLi45wC9oYs
         qfxw==
X-Gm-Message-State: AFqh2kr2a1ut4x05jaAeU4hZ8QOoe/afXFFO51TRvgazIAsPX7Kji7gA
        eX7CDqWCF74NA/9NWw1RGFCmYvMzByPsfw==
X-Google-Smtp-Source: AMrXdXthYSAeZE33qLrnytKv7HGXW8TCnicQsE3yRFIkz/ccQ3TFsVQTgsYiSS4pOGTzDkkFAgtiDw==
X-Received: by 2002:a17:907:395:b0:7c0:d2b2:eb07 with SMTP id ss21-20020a170907039500b007c0d2b2eb07mr12994866ejb.26.1673886328265;
        Mon, 16 Jan 2023 08:25:28 -0800 (PST)
Received: from fedora.. ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090790c800b0084d35ffbc20sm10956060ejb.68.2023.01.16.08.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:25:27 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-pm@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/ACPI/boot: use try_cmpxchg in __acpi_{acquire,release}_global_lock
Date:   Mon, 16 Jan 2023 17:25:22 +0100
Message-Id: <20230116162522.4072-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.0
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

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
__acpi_{acquire,release}_global_lock.  x86 CMPXCHG instruction returns
success in ZF flag, so this change saves a compare after cmpxchg
(and related move instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

Note that the value from *ptr should be read using READ_ONCE to prevent
the compiler from merging, refetching or reordering the read.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/acpi/boot.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 907cc98b1938..4177577c173b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1840,23 +1840,23 @@ early_param("acpi_sci", setup_acpi_sci);
 
 int __acpi_acquire_global_lock(unsigned int *lock)
 {
-	unsigned int old, new, val;
+	unsigned int old, new;
+
+	old = READ_ONCE(*lock);
 	do {
-		old = *lock;
 		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
-		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
+	} while (!try_cmpxchg(lock, &old, new));
 	return ((new & 0x3) < 3) ? -1 : 0;
 }
 
 int __acpi_release_global_lock(unsigned int *lock)
 {
-	unsigned int old, new, val;
+	unsigned int old, new;
+
+	old = READ_ONCE(*lock);
 	do {
-		old = *lock;
 		new = old & ~0x3;
-		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
+	} while (!try_cmpxchg(lock, &old, new));
 	return old & 0x1;
 }
 
-- 
2.39.0

