Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2DC6492BC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 07:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiLKGRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 01:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiLKGRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 01:17:36 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B587E13CCB
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:34 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso12384450pjt.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwyYiFcRsjmX6zCX8NLBJ5b8ChthtpnvjsyMaVpr40U=;
        b=Ltz5b/ttpkf0F/fmmQs4lgqoncjlikqfqixnebILoI0nGAu8o0Dk2BvoOSMNY3zAAa
         hSuF16fMwsfhyQ5Fqg4BxO8IAOMY0gjFReVmPXhDQpC6NMQLTYLmW3/uldpK97kb3lH3
         28ZrSAX43FIPIgfv8iRS+AJNDBVxgPlVoDtj92Z8+yOo8gpvaixsR5g1uU28DdR/s9F3
         ndMMZbdAWlpb7I2bY3SX2nQCfVEPVCIySJSc+O9H0ZVMyPDoONuL8nZ9vN+SpRVNjZxZ
         Qdi1D4q1oz/V6t2nzVDIrzIhR/dlDculHPJ1XWu5+P7B3lULyRnuzxdOel27wQPLLf8z
         lOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwyYiFcRsjmX6zCX8NLBJ5b8ChthtpnvjsyMaVpr40U=;
        b=HooNi07/+yQPxgKVy2HnQuN2oVGaRaWX8BSEMliLAqp+WkBbOUjyisUsd/mMQxDqmU
         vhhFS+6UYk3TMqlihyzSUeyyG1IYo7Y50htHH245NcTEquLgG4mPpGjKqQKz9iy4O1YK
         udd7AGWdA/2Ybo03NXU15/aXSp+VtDHR7TGuNzY4eYFDrkGY2BLMHr07lT7FXW2hw0iJ
         ut9UqoFOL1NLGzb2TUAJ4Y1AUMMElULV+5Oym15l3lFWshqGI4Vut9wSMyKgNg02Vqty
         NSBFmB0lCBQIl6TlVWuPqKwt0VQjpI/3/x1cfEt8eMIcrzfbOl7Nf1ircjjZq5/rASbP
         NOQw==
X-Gm-Message-State: ANoB5pmUHTpQHGradQUsDuzpgD4OUtxGSeDZk+8QvHh75U7W5gdrjUkS
        FSclplfReuOXT+tVRs9gjRGWmg==
X-Google-Smtp-Source: AA0mqf5ieqzOjEVSZd3sKLcQkNQyEBa4YxDWUVuioCdshPhv+YJR6fEbkPsUKg8QyKn0R/3ssTkadQ==
X-Received: by 2002:a17:90a:d347:b0:219:9676:fef5 with SMTP id i7-20020a17090ad34700b002199676fef5mr11448796pjx.12.1670739454184;
        Sat, 10 Dec 2022 22:17:34 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id nd17-20020a17090b4cd100b002135de3013fsm3257566pjb.32.2022.12.10.22.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:33 -0800 (PST)
Subject: [PATCH v2 04/24] ia64: Remove COMMAND_LINE_SIZE from uapi
Date:   Sat, 10 Dec 2022 22:13:38 -0800
Message-Id: <20221211061358.28035-5-palmer@rivosinc.com>
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
 arch/ia64/include/asm/setup.h      | 8 ++++++++
 arch/ia64/include/uapi/asm/setup.h | 6 ++----
 2 files changed, 10 insertions(+), 4 deletions(-)
 create mode 100644 arch/ia64/include/asm/setup.h

diff --git a/arch/ia64/include/asm/setup.h b/arch/ia64/include/asm/setup.h
new file mode 100644
index 000000000000..5625a17ddbe4
--- /dev/null
+++ b/arch/ia64/include/asm/setup.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef __IA64_SETUP_H
+#define __IA64_SETUP_H
+
+#define COMMAND_LINE_SIZE	2048
+
+#endif
diff --git a/arch/ia64/include/uapi/asm/setup.h b/arch/ia64/include/uapi/asm/setup.h
index 8d13ce8fb03a..bcbb2b242ded 100644
--- a/arch/ia64/include/uapi/asm/setup.h
+++ b/arch/ia64/include/uapi/asm/setup.h
@@ -1,8 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __IA64_SETUP_H
-#define __IA64_SETUP_H
-
-#define COMMAND_LINE_SIZE	2048
+#ifndef __UAPI_IA64_SETUP_H
+#define __UAPI_IA64_SETUP_H
 
 extern struct ia64_boot_param {
 	__u64 command_line;		/* physical address of command line arguments */
-- 
2.38.1

