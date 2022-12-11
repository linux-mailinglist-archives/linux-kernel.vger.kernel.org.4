Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E306492C0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 07:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiLKGSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 01:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKGRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 01:17:39 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26387292
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:37 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q71so6170717pgq.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPi1+9dd1OzGMb8V4tO32iZao04Be47mu+TCBKzmOrs=;
        b=gDe1pfAK6GlB/CWhPmT8mjMQPYR/zs1uifvQ0a/sdpY5qSuBSHqAnUudCaQDUTS70v
         KboZU92hU1wsApD3VvvkZCbEJCdjFmi/KWU4i0/B+zAKDNO67lt8S8Rs52dzNs5s34sE
         mUgiZYjeZ93ElCfXhk9XKTCpcIa+DNejHhdFdpNsRiajKJWyLG6dMPBam0FAIFomTcLv
         4OJxqXxzqYaHFq8p61P+6WAM5AD3tvA5ZW7C10RAbIsxYmqpWfqZFynQ9lD1LaTzxOKB
         8Nt79Uv2gqjnymnlERygJ7q4vbkFnnAiSTlUl88cTZdHStk1TGOQ7BGKD74YyRAqsuKH
         47/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPi1+9dd1OzGMb8V4tO32iZao04Be47mu+TCBKzmOrs=;
        b=ic669m+a0kIOO8+KtwOO/wWuzlOCsunlE0GV9SQWtkUh1oQLRbvHKiDFsm5Fy3hCO1
         0h6WMzjGAaDyjEZzPbqWryVZz7swmPwlkT3c67lLUqDIvy3Km17jlgNkktu3EjFAbp6W
         hWwS4rSpZk5JbsIx7a8Y5t0Lt+XC+QM2J4IQ2XGtkd/CROjKZOQcTE990v6x/XG0aRqC
         2p5vwUIzRw6W3pIJRk6mWkjetvm460o4tMBVDlFWlnQoxyCXROX/rc5Myz1KdhuJ6dNf
         RiVklvkmoUzlIkPoV9FslQZOEGeBXdT3VVN6+Df7IJ4cypgWLk6xVVwgi0ZzN+fEbT9A
         kqjA==
X-Gm-Message-State: ANoB5pmKcPlpz7Vdaz0/x4l8yhfDnD484jQ2nbiiBb2OYMT+hQ7GFowz
        tDXl/qUi8GtTuB2kdAKgIk2e1Q==
X-Google-Smtp-Source: AA0mqf6atZJqkHi9qVy/4Ze0hJxYK0HVKrWNCXqvjVnI2X+gMgg/z/q59xDcKKPiyvvTVIjJn67dvw==
X-Received: by 2002:aa7:9112:0:b0:574:35fd:379e with SMTP id 18-20020aa79112000000b0057435fd379emr9869544pfh.2.1670739456566;
        Sat, 10 Dec 2022 22:17:36 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id i1-20020a62c101000000b0053e62b6fd22sm3495367pfg.126.2022.12.10.22.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:36 -0800 (PST)
Subject: [PATCH v2 06/24] microblaze: Remove COMMAND_LINE_SIZE from uapi
Date:   Sat, 10 Dec 2022 22:13:40 -0800
Message-Id: <20221211061358.28035-7-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221211061358.28035-1-palmer@rivosinc.com>
References: <20221211061358.28035-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can tell this is not used by userspace and thus should not
be part of the user-visible API.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
This leaves an empty <uapi/asm/setup.h>, which will soon be cleaned up.
---
 arch/microblaze/include/asm/setup.h      | 2 +-
 arch/microblaze/include/uapi/asm/setup.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/include/asm/setup.h
index a06cc1f97aa9..2becbf3b8baf 100644
--- a/arch/microblaze/include/asm/setup.h
+++ b/arch/microblaze/include/asm/setup.h
@@ -7,7 +7,7 @@
 #ifndef _ASM_MICROBLAZE_SETUP_H
 #define _ASM_MICROBLAZE_SETUP_H
 
-#include <uapi/asm/setup.h>
+#define COMMAND_LINE_SIZE	256
 
 # ifndef __ASSEMBLY__
 extern char cmd_line[COMMAND_LINE_SIZE];
diff --git a/arch/microblaze/include/uapi/asm/setup.h b/arch/microblaze/include/uapi/asm/setup.h
index 6831794e6f2c..51aed65880e7 100644
--- a/arch/microblaze/include/uapi/asm/setup.h
+++ b/arch/microblaze/include/uapi/asm/setup.h
@@ -12,8 +12,6 @@
 #ifndef _UAPI_ASM_MICROBLAZE_SETUP_H
 #define _UAPI_ASM_MICROBLAZE_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
-
 # ifndef __ASSEMBLY__
 
 # endif /* __ASSEMBLY__ */
-- 
2.38.1

