Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEB7693A0D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 21:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjBLUzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 15:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBLUzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 15:55:11 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FBAFF16
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:55:10 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id q13so11958816qtx.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Au6CyYPAK9MMu54GU8ZYr6dkPuGof5usEwyOLzycXk=;
        b=R5iDCdhKZDRcDyk6JEWeTsc3H3qiETZQnTUJtmJ7rVJMEcsUsSBA5yhUDN63euSzlh
         HHlW6D1ZkGAtKB3FEcWCEi7AeUU6SqXYGwnNkAOyEdoCu4NuZqU/NleRYmQ9CmXSTlv5
         Zc017d0fbYZ8dQhPYHvX/d1QKIOmQwQXeOZyDrhwdqhIXy6BMfSoUeFEQWTCMtCa3fa0
         9IC0+uNjJ+ZGv/dj/WgYIGF4thtFPnjmZRmg8B9kUhM5VinzObUMmmVq5IJ9yhE9JYLS
         bsu4EPDygZjMu2XYYpjt7zIJzhweyCR/XB3PCYvwFT/+6E7BZMRNHJNG+3cr5OzTpt+C
         mepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Au6CyYPAK9MMu54GU8ZYr6dkPuGof5usEwyOLzycXk=;
        b=gFEQ7S4R+IyipfjeNCkK3elUwLLDpLTLyV6m78zH61LQKBgpIzHdltwjuzTrBDTWqr
         2tjzV6WSjmQPumicOXtfRSH+qBAOcTy/Rw5gfTMWLhCDcjTtZmyFOgzt9PZa//jCLcpP
         88M17rVdGB0pZTzzoIY5TDfsUEsix6fCe+7lTO9Jw6orqzOQhsSHkD19wYdewgxVA6p4
         ZWauB4mzPV5RIwrf9LVgUrbeenEu+OCGLBRF+OsqMLl4EwuBmVlb3o63C5aYdfZiJcOu
         58C69S6sVXmsyajwp8HrRim5cmTm2p0yL5ks+76d38NxeVval0TAymptkk1MbeClgOz3
         ft7g==
X-Gm-Message-State: AO0yUKWSkVu5OhM9eayBtja7jCVzzt3WUgt4eNTQF1+HbLb1l+lZ48wJ
        p4fvuWWF5XFBbvz5+aBsRe4=
X-Google-Smtp-Source: AK7set+mdFGsW7vWxO83UMH+FHZxLgRCvHWUm7dPLycj8dlzQiwvTE/P6DPhram2BQe/Le8dmLYBvQ==
X-Received: by 2002:ac8:5e92:0:b0:3b9:bc8c:c20a with SMTP id r18-20020ac85e92000000b003b9bc8cc20amr17289416qtx.21.1676235309701;
        Sun, 12 Feb 2023 12:55:09 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id o62-20020a374141000000b0072ad54e36b2sm8289233qka.93.2023.02.12.12.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 12:55:09 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2 2/3] riscv: Kconfig: Allow RV32 to build with no MMU
Date:   Sun, 12 Feb 2023 15:55:05 -0500
Message-Id: <20230212205506.1992714-3-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230212205506.1992714-1-Mr.Bossman075@gmail.com>
References: <20230212205506.1992714-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yimin Gu <ustcymgu@gmail.com>

Some RISC-V 32bit cores do not have an MMU, and the kernel should be
able to build for them. This patch enables the RV32 to be built with
no MMU support.

Signed-off-by: Yimin Gu <ustcymgu@gmail.com>
CC: Jesse Taube <Mr.Bossman075@gmail.com>
Tested-by: Waldemar Brodkorb <wbx@openadk.org>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 arch/riscv/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 59d18881f35b..49759dbe6a8f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -163,8 +163,8 @@ config MMU
 
 config PAGE_OFFSET
 	hex
-	default 0xC0000000 if 32BIT
-	default 0x80000000 if 64BIT && !MMU
+	default 0xC0000000 if 32BIT && MMU
+	default 0x80000000 if !MMU
 	default 0xff60000000000000 if 64BIT
 
 config KASAN_SHADOW_OFFSET
@@ -262,7 +262,6 @@ config ARCH_RV32I
 	select GENERIC_LIB_ASHRDI3
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_UCMPDI2
-	select MMU
 
 config ARCH_RV64I
 	bool "RV64I"
-- 
2.39.0

