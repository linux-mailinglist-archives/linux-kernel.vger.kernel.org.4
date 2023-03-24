Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8836C7A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjCXIx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjCXIx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:53:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03016FF25;
        Fri, 24 Mar 2023 01:53:18 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so943622pjl.4;
        Fri, 24 Mar 2023 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679647998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2wCeYFtBtVFFjbrQKd5bVQe/xPH9s5fs+XzpW6BquM=;
        b=NPhxC+IoIXGfPbBahfpsmb4vDVMSpacSCyo+mKt0P8qdbs4rRv1URZGQ7FIHSPLFLr
         Fm3cJ68m6H1QPNMpMfKwNVW78kXCHMaUvgv0vvL8KsCvhoA6h5BplwLZNpfWIljDsrCt
         lnza+yfn2K95yYWafw9e35X9hD1tisZnW11Mi9fFGdOCfZaCEc9ehTC0KyDLW47S9KKL
         e5wNaRMWycK18rYYxZsV2IK9WZqSh+xLmq1XMgpPCI0jwgkOiN1RX4F4VtjMMYisVsux
         MIDVmhQAPjjrkUWJ5AKprC7nz7GowyKueXpdtmZWCI5301ubPLM/2vIpc+ykIKowSqN0
         NVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679647998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2wCeYFtBtVFFjbrQKd5bVQe/xPH9s5fs+XzpW6BquM=;
        b=fqA4bWenHWRJcGaFq7Ep8TgurvFT7MQsBkbfCQgTw37T6Rv7S7hygZSc00W6VYb9M7
         KhTUKHPFHvQoykxVizhdHdCvBeeGnxjcfYgDFs1wZ7ZtfY/j8SjUh4nW4GfeaEbvryPj
         laHXDB6xOOWOc74Njkp+v6KLgSdZ4Z54NNFMU2JlWKw9odzlGq9dq/A6S1HUp3K0zpIA
         1i1YrWasmPNl2A5wRVu674BIFy2WMRLPqrA3k34Ar3ctXp3k/SF3gWL4x5SJWA/gs6VS
         qTzrXQjLmIkMuEhN3xOVgkJ8grtM7HvRh0+GC7hMN1MAIcfRrW5kTaWoYCcdFDNi4xGf
         ANjw==
X-Gm-Message-State: AAQBX9fDZ8PAuNedLjCWJsuI8Jf0os7Jw2d62v2aP4cqLGl1vcUoE6En
        CgaAKaSXI0ctm9dxVjWL/EQ=
X-Google-Smtp-Source: AKy350Yjvm7N7usqb6wO7/+lzMdj9ds9txp8j8b3xIKau1VP1pE3sFLQXGQ50fBXOzvFp5HaMbkpng==
X-Received: by 2002:a17:902:da82:b0:1a1:a996:feb3 with SMTP id j2-20020a170902da8200b001a1a996feb3mr2482378plx.26.1679647998376;
        Fri, 24 Mar 2023 01:53:18 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-7.three.co.id. [116.206.28.7])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b00198d7b52eefsm13578857plk.257.2023.03.24.01.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 01:53:18 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 32CED106663; Fri, 24 Mar 2023 15:53:15 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Kees Cook <keescook@chromium.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] Documentation: core-api: update kernel-doc reference to kmod.c
Date:   Fri, 24 Mar 2023 15:53:10 +0700
Message-Id: <20230324085310.20571-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=bagasdotme@gmail.com; h=from:subject; bh=Me3JNlJF/gyC1zirkQfo80NfkhNEx6l6MSCo068BIJ0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCmyKR9bd28Lj9B5ab91pYlslqbN3Nuffp6JeSjU8v+yw qzWVdx2HaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZhIsycjQ//Foh/tzfKn43y7 TUJKTLV/L96g/lFC/fknv4xzvz7v+8nIsEP9S8yb+Nh7/Zs5WXoOFy443Dl761rTX4FmltkVT11 D+QE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d6f819908f8aac ("module: fold usermode helper kmod into modules
directory") moves kmod helper implementation (kmod.c) to kernel/module/
directory but forgets to update its reference on kernel api doc, hence:

WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -sphinx-version 2.4.4 -export ./kernel/kmod.c' failed with return code 2

Update the reference.

Fixes: d6f819908f8aac ("module: fold usermode helper kmod into modules directory")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/linux-next/20230324154413.19cc78be@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/core-api/kernel-api.rst                    | 2 +-
 Documentation/translations/zh_CN/core-api/kernel-api.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 62f961610773d6..e2772859600801 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -223,7 +223,7 @@ Module Support
 Module Loading
 --------------
 
-.. kernel-doc:: kernel/kmod.c
+.. kernel-doc:: kernel/module/kmod.c
    :export:
 
 Inter Module support
diff --git a/Documentation/translations/zh_CN/core-api/kernel-api.rst b/Documentation/translations/zh_CN/core-api/kernel-api.rst
index a4b373c48c0c9b..a1ea7081077cee 100644
--- a/Documentation/translations/zh_CN/core-api/kernel-api.rst
+++ b/Documentation/translations/zh_CN/core-api/kernel-api.rst
@@ -226,7 +226,7 @@ kernel/relay.c
 
 该API在以下内核代码中:
 
-kernel/kmod.c
+kernel/module/kmod.c
 
 模块接口支持
 ------------

base-commit: 6e82310365bade624ff38dd11a8467739adab6cc
-- 
An old man doll... just what I always wanted! - Clara

