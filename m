Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5173D662226
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbjAIJw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjAIJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:51:54 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9733512AB1;
        Mon,  9 Jan 2023 01:51:17 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n12so8188503pjp.1;
        Mon, 09 Jan 2023 01:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUG0nLtQB6P5zProz1JDKrAjCmBPnDpqf8FSn3aupzA=;
        b=BZo+1+WiGZ7t0/rm/CrPMlGsu1LFG+WfohRTzQsQ9C3d7xAVU6Yz3uhSx8Zpops8f9
         F+Ls+b2DIfbT9jKyyX7f3g6fSA5LXxok0mmqpN2Xld293zdSkq5KBcZFEImwSFnwK5u4
         +j/HpAiNUJIFGc4NvA81bXTWXWFV129HUkkDIQpQ4rv7or0Hxr9OmGf0eLO1pNhBINo9
         7Y9mvl5iWwapYHQl8tZb+x8C44stNANqRwOWd3gFzR1Z9R6UJoM8GSl+9+x1B/1aRJVi
         yuLKeTN26xTXQCChqFym/opF1Q17zJI/FfMDQmAO2gRVDplNqczIpo+Syr7u6ONn47zX
         7SNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUG0nLtQB6P5zProz1JDKrAjCmBPnDpqf8FSn3aupzA=;
        b=0W737gaZARmCyoX+aJ30tgNpjSC8CywsZ+HN7Xs/E2yZhM+FMy8MrBmH6X55Pglglv
         wkY1l+q8KkU9l/apOk2rdUqPXluwiky53yy1nN1easb/wH9IhnZaTdprVXnE7djB8f0Z
         R5Zi7OAQk/tu8EXxoXdWPRMBzxUJvih84v6aNIdBO5GGJrQMfJEml11a7cW+5+48z1kk
         g0KIv6+n4AH9ti/IBknSTyjNp1ofuLAT+SlE3j27sQVAUjlciw6kJ2YUiPM1DWt4qpeU
         ntD0e6HW0rOyUEs7+I1Hw1bsZqalDVaHqR18yvUZKfUzh7lEBIhjcvkUft7L1e+7tnC6
         Pasw==
X-Gm-Message-State: AFqh2koCOW5AaBdAbI9GLmh7efiAkCoWkBoL0LQKrVZr3Vu4xAlSwWRd
        MlGAdra/IxgpAlDoiDprzxA=
X-Google-Smtp-Source: AMrXdXv2dX/tQ4prvd6UKKeV1RbXcBEIjVDw3k01xjt9cQU4bwyNwOIPcnJaS1FU4KLUMCZPHZ7JWQ==
X-Received: by 2002:a17:90a:6a4f:b0:226:ed1b:c7b7 with SMTP id d15-20020a17090a6a4f00b00226ed1bc7b7mr8011521pjm.13.1673257876902;
        Mon, 09 Jan 2023 01:51:16 -0800 (PST)
Received: from debian.me (subs03-180-214-233-26.three.co.id. [180.214.233.26])
        by smtp.gmail.com with ESMTPSA id js8-20020a17090b148800b002191e769546sm5080794pjb.4.2023.01.09.01.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:51:15 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 534AE105010; Mon,  9 Jan 2023 16:51:10 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/8] Documentation: kvx: Convert to reST
Date:   Mon,  9 Jan 2023 16:51:01 +0700
Message-Id: <20230109095108.21229-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109095108.21229-1-bagasdotme@gmail.com>
References: <874jt7fqxt.fsf@meer.lwn.net>
 <20230109095108.21229-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6354; i=bagasdotme@gmail.com; h=from:subject; bh=Rgiw2ouxNaRHWfF14VFJtoFdUTFNcf56RZ4yVFbA528=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMm7H3cVnV4yyXu/9rfFBunxd9cH1ycbmOQ9K9OKbrw46abu Go6UjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEyEczfD/1S7c8sc79kvauvUva9549 bvpSedvyQaNPbLTtu2+PfCOCdGhmdm78q+Mhhs3rXI4oKBe/DHP8+Yft2QUt6rvH/7fUeVl/wA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert kvx documentation to reST format. While at it, fix constructs
that cause Sphinx to confuse with section markup.

Note that 101 warnings are generated due to markup syntax issues. These
will be addressed in subsequent patches.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/arch.rst                        |  1 +
 Documentation/kvx/index.rst                   | 12 ++++++++
 ...{kvx-exceptions.txt => kvx-exceptions.rst} | 10 +++----
 .../kvx/{kvx-iommu.txt => kvx-iommu.rst}      |  0
 .../kvx/{kvx-mmu.txt => kvx-mmu.rst}          | 28 +++++++++++--------
 .../kvx/{kvx-smp.txt => kvx-smp.rst}          |  0
 Documentation/kvx/{kvx.txt => kvx.rst}        |  0
 7 files changed, 35 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/kvx/index.rst
 rename Documentation/kvx/{kvx-exceptions.txt => kvx-exceptions.rst} (98%)
 rename Documentation/kvx/{kvx-iommu.txt => kvx-iommu.rst} (100%)
 rename Documentation/kvx/{kvx-mmu.txt => kvx-mmu.rst} (88%)
 rename Documentation/kvx/{kvx-smp.txt => kvx-smp.rst} (100%)
 rename Documentation/kvx/{kvx.txt => kvx.rst} (100%)

diff --git a/Documentation/arch.rst b/Documentation/arch.rst
index 41a66a8b38e424..1ccda8ef6eefb3 100644
--- a/Documentation/arch.rst
+++ b/Documentation/arch.rst
@@ -13,6 +13,7 @@ implementation.
    arm/index
    arm64/index
    ia64/index
+   kvx/index
    loongarch/index
    m68k/index
    mips/index
diff --git a/Documentation/kvx/index.rst b/Documentation/kvx/index.rst
new file mode 100644
index 00000000000000..19a8e0865c82f3
--- /dev/null
+++ b/Documentation/kvx/index.rst
@@ -0,0 +1,12 @@
+================
+KVX Architecture
+================
+
+.. toctree::
+   :maxdepth: 1
+
+   kvx-exceptions
+   kvx-iommu
+   kvx-mmu
+   kvx-smp
+   kvx
diff --git a/Documentation/kvx/kvx-exceptions.txt b/Documentation/kvx/kvx-exceptions.rst
similarity index 98%
rename from Documentation/kvx/kvx-exceptions.txt
rename to Documentation/kvx/kvx-exceptions.rst
index 11368287bd4895..d3e52f30285223 100644
--- a/Documentation/kvx/kvx-exceptions.txt
+++ b/Documentation/kvx/kvx-exceptions.rst
@@ -12,19 +12,19 @@ The offset depends on which exception vector the cpu wants to jump to:
 
 Then, handlers are laid in the following order:
 
-         _____________
+        +-------------+
         |             |
         |   Syscall   |
-        |_____________|
+        +-------------+
         |             |
         |  Interrupts |
-        |_____________|
+        +-------------+
         |             |
         |    Traps    |
-        |_____________|
+        +-------------+
         |             | ^
         |    Debug    | | Stride
-BASE -> |_____________| v
+BASE -> +-------------+ v
 
 
 Interrupts, and traps are serviced similarly, ie:
diff --git a/Documentation/kvx/kvx-iommu.txt b/Documentation/kvx/kvx-iommu.rst
similarity index 100%
rename from Documentation/kvx/kvx-iommu.txt
rename to Documentation/kvx/kvx-iommu.rst
diff --git a/Documentation/kvx/kvx-mmu.txt b/Documentation/kvx/kvx-mmu.rst
similarity index 88%
rename from Documentation/kvx/kvx-mmu.txt
rename to Documentation/kvx/kvx-mmu.rst
index a3ebbef3698129..59bda2afc9abde 100644
--- a/Documentation/kvx/kvx-mmu.txt
+++ b/Documentation/kvx/kvx-mmu.rst
@@ -24,17 +24,23 @@ only one ZONE_NORMAL. This will be updated if DMA cannot access all memory.
 
 Currently, the memory mapping is the following for 4KB page:
 
-+-----------------------+-----------------------+------+-------+--------------+
-| Start                 | End                   | Attr | Size  | Name         |
-+-----------------------+-----------------------+------+-------+--------------+
-| 0000 0000 0000 0000   | 0000 003F FFFF FFFF   | ---  | 256GB | User         |
-| 0000 0040 0000 0000   | 0000 007F FFFF FFFF   | ---  | 256GB |   MMAP       |
-| 0000 0080 0000 0000   | FFFF FF7F FFFF FFFF   | ---  | ---   | Gap          |
-| FFFF FF80 0000 0000   | FFFF FFFF FFFF FFFF   | ---  | 512GB | Kernel       |
-|   FFFF FF80 0000 0000 |   FFFF FF8F FFFF FFFF | RWX  | 64GB  |   Direct Map |
-|   FFFF FF90 0000 0000 |   FFFF FF90 3FFF FFFF | RWX  | 1GB   |   Vmalloc    |
-|   FFFF FF90 4000 0000 |   FFFF FFFF FFFF FFFF | RW   | 447GB |   Free area  |
-+-----------------------+-----------------------+------+-------+--------------+
++-----------------------+-----------------------+---------+----------+--------------+
+| Start                 | End                   | Attr    | Size     | Name         |
++=======================+=======================+=========+==========+==============+
+| 0000 0000 0000 0000   | 0000 003F FFFF FFFF   | \-\-\-  | 256GB    | User         |
++-----------------------+-----------------------+---------+----------+--------------+
+| 0000 0040 0000 0000   | 0000 007F FFFF FFFF   | \-\-\-  | 256GB    |   MMAP       |
++-----------------------+-----------------------+---------+----------+--------------+
+| 0000 0080 0000 0000   | FFFF FF7F FFFF FFFF   | \-\-\-  | \-\-\-   | Gap          |
++-----------------------+-----------------------+---------+----------+--------------+
+| FFFF FF80 0000 0000   | FFFF FFFF FFFF FFFF   | \-\-\-  | 512GB    | Kernel       |
++-----------------------+-----------------------+---------+----------+--------------+
+|   FFFF FF80 0000 0000 |   FFFF FF8F FFFF FFFF | RWX     | 64GB     |   Direct Map |
++-----------------------+-----------------------+---------+----------+--------------+
+|   FFFF FF90 0000 0000 |   FFFF FF90 3FFF FFFF | RWX     | 1GB      |   Vmalloc    |
++-----------------------+-----------------------+---------+----------+--------------+
+|   FFFF FF90 4000 0000 |   FFFF FFFF FFFF FFFF | RW      | 447GB    |   Free area  |
++-----------------------+-----------------------+---------+----------+--------------+
 
 Enable the MMU
 ==============
diff --git a/Documentation/kvx/kvx-smp.txt b/Documentation/kvx/kvx-smp.rst
similarity index 100%
rename from Documentation/kvx/kvx-smp.txt
rename to Documentation/kvx/kvx-smp.rst
diff --git a/Documentation/kvx/kvx.txt b/Documentation/kvx/kvx.rst
similarity index 100%
rename from Documentation/kvx/kvx.txt
rename to Documentation/kvx/kvx.rst
-- 
An old man doll... just what I always wanted! - Clara

