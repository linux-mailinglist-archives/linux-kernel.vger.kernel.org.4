Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3DE6492E0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 07:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiLKGUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 01:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiLKGT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 01:19:26 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D3613CC4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:57 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gt4so7197884pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIHqc0iqU86l/ddys5zrtTqIDUjH9EKt9xGg3rtkr0M=;
        b=fRHx10v6REyRA8T1JueEb87Kb6oXMtD5G87vNS6fHLS5J8lheEMTWQk00du37ehGkT
         AiJZC98LKsDJG/l10XEArBdl/WqAyaJacVUXway4zy+8GGqYszJkiVU0h4Vi54yPP1M9
         Ab4Jit4AzkDUP1u42p4P11Lz6E4/mXASEF63Yu48/lyEWGpacQlOmher2SJFpXkoXTnM
         4ZBEpsaWfOdj/e5J43qIkTVgbeYPRYv4OjibYXNDKNTwyhNh1eHxpoo7pKioOcCL5md1
         ZNPY+Qa9oRcBuAJ/HWa00QgidLdiWwDzlHhGyxKtcPLcOyxJh+1OUPZLmKR5gEfIjVDr
         JWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIHqc0iqU86l/ddys5zrtTqIDUjH9EKt9xGg3rtkr0M=;
        b=NFj23vJx9T+0YU+pzgEZtefgjOOdMzJNtl56LLaU9ewXfhSKBubwIxYlLf7fHHONNi
         gYj/H0nesNu0ktg/7YDQUPwasSsHFcTIqQIWPJEEIqNCx1pGYTGIs9dnJM5M617qkbQx
         QC3IqK+G136lKFaTSfMOXKIKiM+C9TGoIXkTuTmIv1Tkr3LSzwNikcURPb6moa3LJxzC
         AcKNQ7C0PH721rU5fnUNGWl4L6ewOmXO/4KJ6MdGf/rFDiuY1Vl1WT3LBSBNmuT0LFI6
         A+ZcfyMTeiVE+wvkZzdH5ZirRSV3NWSStdA89h3JlhMDDVDVuv5QqdbZfSKmtwj5b/h/
         ywew==
X-Gm-Message-State: ANoB5pn1OZhBbw9hFKuBBRRLjZAey+UoyDZVRk3javnqxxzpWz4OIP5H
        6u21aaKGos9QjLYGxbV68mniZg==
X-Google-Smtp-Source: AA0mqf6ZXYhK8hyGCmV4B6f1iJi/S1sk5X/jaYcDz5V1ZDviKlFPs+T8yD+aP2Q68aTzmOE/N6WWTg==
X-Received: by 2002:a05:6a21:788f:b0:a4:b885:78d4 with SMTP id bf15-20020a056a21788f00b000a4b88578d4mr18173531pzc.43.1670739476766;
        Sat, 10 Dec 2022 22:17:56 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id g9-20020a17090a290900b00212daa68b7csm3320077pjd.44.2022.12.10.22.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:56 -0800 (PST)
Subject: [PATCH v2 23/24] x86: Remove empty <uapi/asm/setup.h>
Date:   Sat, 10 Dec 2022 22:13:57 -0800
Message-Id: <20221211061358.28035-24-palmer@rivosinc.com>
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
 arch/x86/include/asm/setup.h      | 2 --
 arch/x86/include/uapi/asm/setup.h | 1 -
 2 files changed, 3 deletions(-)
 delete mode 100644 arch/x86/include/uapi/asm/setup.h

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index f37cbff7354c..449b50a2f390 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_SETUP_H
 #define _ASM_X86_SETUP_H
 
-#include <uapi/asm/setup.h>
-
 #define COMMAND_LINE_SIZE 2048
 
 #include <linux/linkage.h>
diff --git a/arch/x86/include/uapi/asm/setup.h b/arch/x86/include/uapi/asm/setup.h
deleted file mode 100644
index 79a9626b5500..000000000000
--- a/arch/x86/include/uapi/asm/setup.h
+++ /dev/null
@@ -1 +0,0 @@
-/* */
-- 
2.38.1

