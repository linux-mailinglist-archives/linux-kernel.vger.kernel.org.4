Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8627005AD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbjELKek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240716AbjELKea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:34:30 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01AA13293
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:33:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f41d087b24so49315935e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683887621; x=1686479621;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qIwf6Ve86JO74f1ZgVFN46e2HB9rw020mrBkzHhPWA0=;
        b=IcpEikFY3mIyVfd7wlazQMqfPbtTyZujZaD4jaySk/90clAl/sRZMmQu9+HPHvw09/
         b5jVwaQP5dcpu5ZiPjPq0O8Z2emozurnH2EuyFAi/VgapO8wlMucjUTIuVNfCf0MukVp
         gsEgjBl7ewPJsZTeREDld/FswbXPx9T7Ej7qTEpXaiI24jstuOsGl4ylAB6+5MiO4HxW
         yeZPSws8XTQVlXicRh+ndxxWo3RFGO3K/4qIhxzHqYd5QSM07OYQ2h/W7+zaupt6ZDqq
         s66vg8mgR1SgDt5FRJGfPXtapD2estnH9Buyy5cwy3V6mliSLBRmaFCHrqjsZDnEqhGM
         bn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887621; x=1686479621;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIwf6Ve86JO74f1ZgVFN46e2HB9rw020mrBkzHhPWA0=;
        b=jy/MrcRek7+m2eKElBvbxSQCz14OGirJFdtWr5MnN9QlufviuDd85+klDYkzUFvtBY
         Eu/hbHFjkWH84KmGicIDeDBqKdPQVHsdWdZ5wt0wEtFNIOKqcdSeXwLKxn+L8XSISmN0
         dMWhADvJ+vpBeAu23G6ZtEJS8PlI0zGdpasZS7XyMWcEKVkcdZph0nloChxiJKyPgo0z
         jff+qHKmaFsOrADNAZuHJjGGyNbC7CfG1Tnw5TOW9tsngiKfIkRGHSsOk8ATNOR7Qa7b
         9+2oc7j0A7s2NJa0D23feLDIYRQeacOwZpt1CtHkdDrU8jzkzwVJvUTlNSvRyOLVXGMa
         RLSg==
X-Gm-Message-State: AC+VfDyoJXdGzNbPC14/bP5DnG34wNJykR2hulhSENxsAH/w3r8Effq/
        gwgV0AFz5EQSBu37H6e/IewkkXE9pA==
X-Google-Smtp-Source: ACHHUZ6LaCVnP+ZYWNUvbqZQlBlckhAwyog/eT4n+leIY25vHU2MWb1G1M3u6wzshmQRjaLFedBEgg==
X-Received: by 2002:a05:600c:cf:b0:3f4:29c2:1cd0 with SMTP id u15-20020a05600c00cf00b003f429c21cd0mr8752311wmm.25.1683887620549;
        Fri, 12 May 2023 03:33:40 -0700 (PDT)
Received: from p183 ([46.53.254.54])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bcd08000000b003f42894ebe2sm12464689wmj.23.2023.05.12.03.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:33:40 -0700 (PDT)
Date:   Fri, 12 May 2023 13:33:38 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] add intptr_t
Message-ID: <ed66b9e4-1fb7-45be-9bb9-d4bc291c691f@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add signed intptr_t given that a) it is standard type and
b) uintptr_t is in tree.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/mips/include/asm/fw/cfe/cfe_api.h |    3 ---
 include/linux/types.h                  |    1 +
 lib/zstd/common/zstd_deps.h            |   18 ------------------
 3 files changed, 1 insertion(+), 21 deletions(-)

--- a/arch/mips/include/asm/fw/cfe/cfe_api.h
+++ b/arch/mips/include/asm/fw/cfe/cfe_api.h
@@ -17,9 +17,6 @@
 #include <linux/types.h>
 #include <linux/string.h>
 
-typedef long intptr_t;
-
-
 /*
  * Constants
  */
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -35,6 +35,7 @@ typedef __kernel_uid16_t        uid16_t;
 typedef __kernel_gid16_t        gid16_t;
 
 typedef unsigned long		uintptr_t;
+typedef long			intptr_t;
 
 #ifdef CONFIG_HAVE_UID16
 /* This is defined by include/asm-{arch}/posix_types.h */
--- a/lib/zstd/common/zstd_deps.h
+++ b/lib/zstd/common/zstd_deps.h
@@ -105,21 +105,3 @@ static uint64_t ZSTD_div64(uint64_t dividend, uint32_t divisor) {
 
 #endif /* ZSTD_DEPS_IO */
 #endif /* ZSTD_DEPS_NEED_IO */
-
-/*
- * Only requested when MSAN is enabled.
- * Need:
- * intptr_t
- */
-#ifdef ZSTD_DEPS_NEED_STDINT
-#ifndef ZSTD_DEPS_STDINT
-#define ZSTD_DEPS_STDINT
-
-/*
- * The Linux Kernel doesn't provide intptr_t, only uintptr_t, which
- * is an unsigned long.
- */
-typedef long intptr_t;
-
-#endif /* ZSTD_DEPS_STDINT */
-#endif /* ZSTD_DEPS_NEED_STDINT */
