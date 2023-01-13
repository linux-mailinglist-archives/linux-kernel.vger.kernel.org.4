Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0DE668B04
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjAMEtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjAMEtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:49:19 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009BF48282
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:49:17 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id g10so8633380qvo.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPMupWzHNPM6tliJ7ayw5rMWVqQwAd6pjpU1pINArHw=;
        b=YXjyet8MNQ2JQUCfrp7UKKGt5gpB8ooxSYCa0QNBfVZRIUTYTtCo4xXl6bVxWeOaRj
         LLiFzXEKLEK7vVVUgDlNKqDg+kOnR25Z4nmLzou+JYtMwDMLmqmpuEEUDKCqESW5wuYe
         5i6dKzGCSeFXv7uMaNH57yqz2+m5RwsyCUdXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPMupWzHNPM6tliJ7ayw5rMWVqQwAd6pjpU1pINArHw=;
        b=2TS1dccCUjY9Zp3ZZmWlJEObXJpCi6GUKeSBcN7vb5FMf4SF4/00jMi8K6bJ1EhGBk
         N6+dE6R46SUHhKZc5am2fSoILmm7ptEhujv43SGE1Jyihqur2b4iAXcU4Almx61M80Xe
         /0vvvuJ/f4/KAwayZ0KOKMWvZJtq7r+GCLwVRLWZv4irgzD37RNG3YN26cGvsPMFnpiR
         /HjgPwqRjNN8Q64qu9A2f9uv206vtuKnWp2LEFNG3RIIWMHwoYDkkInF/+SOtc4VKLSq
         FJ27NJ1laGlsihgidv2/JgCbGvYLtt5KU836fbeEon7SM0FCBfFgkXdigXiHhO4XOIJj
         kO8g==
X-Gm-Message-State: AFqh2kptbvSARssG30K67ddgHpW7EITE8X5tzEbI8URtzU53JjRMS7yw
        3c2zYjxvTGx3u0CAOYOBoPzygQ==
X-Google-Smtp-Source: AMrXdXuM910sA8krtlGCRk7bXLXQVDHtbL3ipS+GLem6e3saTcMoMX+cK05cfi29sMNpAMMw8rAQ4A==
X-Received: by 2002:ad4:51ce:0:b0:532:2112:69fc with SMTP id p14-20020ad451ce000000b00532211269fcmr29637646qvq.0.1673585356939;
        Thu, 12 Jan 2023 20:49:16 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b00704a9942708sm12099472qki.73.2023.01.12.20.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:49:16 -0800 (PST)
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Thu, 12 Jan 2023 23:49:10 -0500
Subject: [PATCH 4/4] um: Use CFLAGS_vmlinux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230112-um-v1-4-6bec9e97ad13@pefoley.com>
References: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
In-Reply-To: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673585354; l=1469;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=Vga2hFswscRKGQdpjgKxlTRwGsFMXJP0qX9HRn8ewW0=;
 b=0LeNmvxk7JUmCA7g5p1WH5uLkngDkEtMpHqFTr3iIMnkJ3t8F/K1s88I2n29F1YUYOP5mVtHiTv6
 DCHga229B6V+hXzhodm0o4DHuW143R7+9NcGBTQj8+35ZTkVzrJZ
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

link-vmlinux.sh doesn't use LDFLAGS_vmlinux when linking the kernel for
UML. Move the LDFLAGS_EXESTACK options into CFLAGS_vmlinux so they're
actually respected.

e.g.
/usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: warning: .tmp_vmlinux.kallsyms3.o: missing .note.GNU-stack section implies executable stack
/usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
/usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions
---
 arch/um/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index f1d4d67157be..93dfb23bd263 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -139,11 +139,10 @@ ifeq ($(CONFIG_LD_IS_BFD),y)
 LDFLAGS_EXECSTACK += $(call ld-option,--no-warn-rwx-segments)
 endif
 
-LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS),-Wl,$(opt))
+LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS) $(LDFLAGS_EXECSTACK),-Wl,$(opt))
 
 # Used by link-vmlinux.sh which has special support for um link
 export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
-export LDFLAGS_vmlinux := $(LDFLAGS_EXECSTACK)
 
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.

-- 
2.39.0
