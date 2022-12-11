Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5B86492C4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 07:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiLKGS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 01:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiLKGRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 01:17:53 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA164D8D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:39 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m4so8965903pls.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vR/XlxAln7YILs61julFaHT07WwhU1Gz2ivq87X9vTY=;
        b=JHgW2dQERvNatw6PABxfEFODOx1iy0OJOJaIDmbaCwtUQBe4lYiN5U3EqcXeftWB1h
         v7BQcDO4LSvxKDHxqUduMZR+uc7iRGUVyGrmHvLwnDyzG29RqZldAC3sv1ePTl4outb+
         ix6zzQVXSOyfllS9wfuTp1sRsdgxUJuKBhVqb2ov/k/O578oyWjKV+NYDVmqlFwkaxyp
         LxzUogs081tWE5Jisgzl/UXOJ9WX8ejlWcLyb1L7IRlMmhmwszyhiffQDzovE09VleAl
         noIUYhjDR/n75D0W4tDpLwUuBLG5zias+8yKCIMH07Z/Y7zBcJZryoTzdSAtd4j5EfB3
         OFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vR/XlxAln7YILs61julFaHT07WwhU1Gz2ivq87X9vTY=;
        b=rWofYLSwhF8WfGIFkiRfpv3VLNu0SljzVpaMKrVh2ACi1DtNCMb7b/bRklPz7IQ7KF
         6pesWpDpYD/lwshTBthcvlUiXBK0HGP26S4mnZeaDU832MMVKl/D/iwQUJOntsgZj3Ic
         9mtOXaGhvc3etZSSQtqBEwCuA2EhES+bxPyUnsbbBzdRInMyAlm679e8VdDN7/yG78+R
         0hDZB08s6gspmTGw8s0v/qqDkQJkOatiDVadISmp24AOIkfOvOlLihA0sWQGc0H+alwi
         iRUIkaTMH+3FYEuzr27n6kjOk20BJW72HDpkPeMGmG4KcTlICFtPcKYb5AwMljVZnmYE
         xW3w==
X-Gm-Message-State: ANoB5pmVmwu9hJcUfUPxsgXFqrI3xqU0q+4++nbaYkhuXa2ayHbRSZz6
        4WWkORM/Kg3lJNAMm1tvUAbESIk0FZP4BMDD
X-Google-Smtp-Source: AA0mqf7Y2Y+oqmyjrd60hDKlYr+fh7+hDs4WLdynvmPteVpVz/T9Pu8yiEMYqXpU2jQBponGqgHmdA==
X-Received: by 2002:a17:903:40cb:b0:189:b4d0:aee with SMTP id t11-20020a17090340cb00b00189b4d00aeemr13628445pld.67.1670739458729;
        Sat, 10 Dec 2022 22:17:38 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902d4c200b001899c2a0ae0sm3829667plg.40.2022.12.10.22.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:38 -0800 (PST)
Subject: [PATCH v2 08/24] parisc: Remove COMMAND_LINE_SIZE from uapi
Date:   Sat, 10 Dec 2022 22:13:42 -0800
Message-Id: <20221211061358.28035-9-palmer@rivosinc.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/parisc/include/asm/setup.h      | 7 +++++++
 arch/parisc/include/uapi/asm/setup.h | 2 --
 2 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 arch/parisc/include/asm/setup.h

diff --git a/arch/parisc/include/asm/setup.h b/arch/parisc/include/asm/setup.h
new file mode 100644
index 000000000000..78b2f4ec7d65
--- /dev/null
+++ b/arch/parisc/include/asm/setup.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _PARISC_SETUP_H
+#define _PARISC_SETUP_H
+
+#define COMMAND_LINE_SIZE	1024
+
+#endif /* _PARISC_SETUP_H */
diff --git a/arch/parisc/include/uapi/asm/setup.h b/arch/parisc/include/uapi/asm/setup.h
index 78b2f4ec7d65..bfad89428e47 100644
--- a/arch/parisc/include/uapi/asm/setup.h
+++ b/arch/parisc/include/uapi/asm/setup.h
@@ -2,6 +2,4 @@
 #ifndef _PARISC_SETUP_H
 #define _PARISC_SETUP_H
 
-#define COMMAND_LINE_SIZE	1024
-
 #endif /* _PARISC_SETUP_H */
-- 
2.38.1

