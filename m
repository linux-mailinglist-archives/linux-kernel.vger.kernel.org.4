Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8CE6492D4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 07:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiLKGT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 01:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLKGS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 01:18:58 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0822B12AEF
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:50 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id f3so6185724pgc.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozl1nb5e3qPJNZZYf1FoV+UxOZv/dZfNJJMfpl9GbpI=;
        b=YD11nS8AOTESpXvXTxRl9i+SwhexnAIoCye4ANzaz8bmgDWDZOMWCA9xorjULkWpAO
         NjSJ8A6cBh8o2nnSVHmszC2fkx5lU9ETe9k1ReBqnR3B0A1ap6agIgQ+6+6qD9Yj1zhh
         IZZLFt1E2/+Jrr/w0zyJ9lpHl2DonRKzLkK8lAjBkyDoSMWH8fSCPF4JxK1rNAW+BP0n
         gU3BVIT7M/NnHKVD2QWwAoVzPfWusB00YaaMV4eCnvBQC79Fb1CiIEALXEazthOBnm+R
         Q4hqKDqXWnpnGKk7NSZ4kUpEbQjmRKAd7pbNqr+glI8JLlgqk0bDVk1s12IpFkdp7Omk
         YM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozl1nb5e3qPJNZZYf1FoV+UxOZv/dZfNJJMfpl9GbpI=;
        b=Fc2FdcpkBYVxu6kqhX2qfMi3ormL+d3XOu5VS1NXp98UH01BmAli0Z5yZ3eRlrCiYk
         wj2bd757hbWBA/RS+DkAZ874QRXaIW+cJTRNbNxykz9/+J/EzsIrmp6XXS40I2KiPkDZ
         AqPKevYVmInqxB2iRU79X3OgDUYek+CId9+qtFlPM+Srq9TrrJ28qzCzHiGgvYwwwdFx
         9jXiiigP6vtKx9PdL109gTZWugmQ5S/hmDH2slLinfiR2+ylRmarhyBuIbRUQvlyZEOH
         z9rPjv3NSvD0thfvZCCvFfreZaOVw3DmbqnGC0etg49JkTgiJthM3ySiZeEVodiKTYyZ
         WntQ==
X-Gm-Message-State: ANoB5pmG7FvOSJrBF4wt1kvGGQKJWHuuHJzJQfEBcc/AsNgIDvDbklki
        x8nh/Qz5Ol+FONITyqhiarxYebZOP9e80ijI
X-Google-Smtp-Source: AA0mqf7Lvyw6iVnD9Ss49+YSbRQYD5sVk3UwFFKp2v1+embf1XeX/Gesn65KSvV40q6yFMpoe7ZsKg==
X-Received: by 2002:a05:6a00:324b:b0:574:3cde:385a with SMTP id bn11-20020a056a00324b00b005743cde385amr9986745pfb.32.1670739469988;
        Sat, 10 Dec 2022 22:17:49 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id q1-20020aa79821000000b00574ee8d8779sm3528487pfl.65.2022.12.10.22.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:49 -0800 (PST)
Subject: [PATCH v2 17/24] microblaze: Remove empty <uapi/asm/setup.h>
Date:   Sat, 10 Dec 2022 22:13:51 -0800
Message-Id: <20221211061358.28035-18-palmer@rivosinc.com>
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

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/microblaze/include/uapi/asm/setup.h | 18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100644 arch/microblaze/include/uapi/asm/setup.h

diff --git a/arch/microblaze/include/uapi/asm/setup.h b/arch/microblaze/include/uapi/asm/setup.h
deleted file mode 100644
index 51aed65880e7..000000000000
--- a/arch/microblaze/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (C) 2007-2009 Michal Simek <monstr@monstr.eu>
- * Copyright (C) 2007-2009 PetaLogix
- * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _UAPI_ASM_MICROBLAZE_SETUP_H
-#define _UAPI_ASM_MICROBLAZE_SETUP_H
-
-# ifndef __ASSEMBLY__
-
-# endif /* __ASSEMBLY__ */
-#endif /* _UAPI_ASM_MICROBLAZE_SETUP_H */
-- 
2.38.1

