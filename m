Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620C361E177
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiKFKDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiKFKDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:03:14 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD4CDF52;
        Sun,  6 Nov 2022 02:03:13 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q1so8004296pgl.11;
        Sun, 06 Nov 2022 02:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BU/GEX7oGTrvEjxodaV3U4uYUl5yeLKJDVZ9b6saoY=;
        b=Kno/QC2ZKL9BcYH+lP3M0AqqYhOtAKS0FVBDBaPnqg5xd31e/3D430yc/RwAqyPKNA
         aF52b3NCHQiXwq8Aywu3LZdUhwOGbvI79QDIGHJur5iqHXUIPU21rGBu8EenlfBaPFiA
         hsp/rej9ZgNeZojPbvarbK/z/zrRmom6plT8MN/zpuDb48uxmcLhdN0cyZboa65kQ+m4
         BHZhQsbYlcaK1f85xNjmn5lOiCge/BOBQb6Gltf23lxAUdDygWatDQMyyqiQzgtTenJe
         +LuU9/rGLtNDqTAhCMOXyYF9fZxerhlxLxor4HPMdmNBMFQsyEAmUugVVqOBJgphMn/G
         iVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BU/GEX7oGTrvEjxodaV3U4uYUl5yeLKJDVZ9b6saoY=;
        b=s3/1eKRYziLKMjuy8ScUAtrUrXD7fkBLH50eHyk7SxPCFvWs13I4O+Hk7R82Orwr/O
         N16Sa089X1OTnxBjbISCkctl5Ta8nKOBAJgXTmEEe6Wf9dXoUycHas36BZpDdYUj+wrK
         WPSq18mawc/Z05sCsHPA1eS+TZHuiTl+Sm6FuczhHSt+g+Lg/9wp753I36+dLMEKjTDt
         04v7R8hMJ9uf3BNsL5oA0uY+J3uS6PtbnwAjP/jiPBPZKmbfPbs6H2RVBBQg9eswfI3d
         8RYO12IXSkH6/+pCz4N6xXgu6iLm/ctojwgZLsKy3nW45QtApm+fcS+3z+QOwyvp6PRJ
         x58A==
X-Gm-Message-State: ACrzQf03wGoS2KzDUT2+GkuRbBAIX6GGEe1dpyRbNDxI2uqMgpPbZYUf
        PDo5a3MBV6+t0zKljVCEMk531S1p1SsdNw==
X-Google-Smtp-Source: AMsMyM70O2q+4fIAYpvGU7bMSturp7FQUBo+pb4Y9kjdXowomrHLvtMAiVgvPjakgfAW1bk8mY0CmQ==
X-Received: by 2002:a62:1e04:0:b0:56d:a2cf:e7fb with SMTP id e4-20020a621e04000000b0056da2cfe7fbmr31601371pfe.48.1667728992801;
        Sun, 06 Nov 2022 02:03:12 -0800 (PST)
Received: from debian.. (subs02-180-214-232-28.three.co.id. [180.214.232.28])
        by smtp.gmail.com with ESMTPSA id z22-20020a630a56000000b0043c732e1536sm2333547pgk.45.2022.11.06.02.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 02:03:12 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: riscv: tableize memory layout
Date:   Sun,  6 Nov 2022 17:02:40 +0700
Message-Id: <20221106100239.53704-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13584; i=bagasdotme@gmail.com; h=from:subject; bh=HGrd3JUcYf98N1p7UhkB1UPQZR83cFVfgAcmvlNv+ek=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMnpbfZ/r8+oWNW0t3NqzJ01R0Ptl0aZ3DnBGro63ityUX+U fNuljlIWBjEOBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzkw3RGhutC6pHrHd8ciX8dFNpr72 gfuDbmkuBDuyWlHKXO25Y1MDP8r9JvfsRZ9uJJjuRnrlcND38st7h5Wewlk8fLN5of7jJ94gYA
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

The memory layout is written as table but it is inside literal code
block, which renders as preformatted text. Write the layout in reST
grid table instead.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/riscv/vm-layout.rst | 120 +++++++++++++++---------------
 1 file changed, 58 insertions(+), 62 deletions(-)

diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
index 5b36e45fef60bd..139320e35de81f 100644
--- a/Documentation/riscv/vm-layout.rst
+++ b/Documentation/riscv/vm-layout.rst
@@ -30,70 +30,66 @@ the RISC-V Linux Kernel resides.
 RISC-V Linux Kernel SV39
 ------------------------
 
-::
-
-  ========================================================================================================================
-      Start addr    |   Offset   |     End addr     |  Size   | VM area description
-  ========================================================================================================================
-                    |            |                  |         |
-   0000000000000000 |    0       | 0000003fffffffff |  256 GB | user-space virtual memory, different per mm
-  __________________|____________|__________________|_________|___________________________________________________________
-                    |            |                  |         |
-   0000004000000000 | +256    GB | ffffffbfffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical
-                    |            |                  |         |     virtual memory addresses up to the -256 GB
-                    |            |                  |         |     starting offset of kernel mappings.
-  __________________|____________|__________________|_________|___________________________________________________________
-                                                              |
-                                                              | Kernel-space virtual memory, shared between all processes:
-  ____________________________________________________________|___________________________________________________________
-                    |            |                  |         |
-   ffffffc6fee00000 | -228    GB | ffffffc6feffffff |    2 MB | fixmap
-   ffffffc6ff000000 | -228    GB | ffffffc6ffffffff |   16 MB | PCI io
-   ffffffc700000000 | -228    GB | ffffffc7ffffffff |    4 GB | vmemmap
-   ffffffc800000000 | -224    GB | ffffffd7ffffffff |   64 GB | vmalloc/ioremap space
-   ffffffd800000000 | -160    GB | fffffff6ffffffff |  124 GB | direct mapping of all physical memory
-   fffffff700000000 |  -36    GB | fffffffeffffffff |   32 GB | kasan
-  __________________|____________|__________________|_________|____________________________________________________________
-                                                              |
-                                                              |
-  ____________________________________________________________|____________________________________________________________
-                    |            |                  |         |
-   ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | modules, BPF
-   ffffffff80000000 |   -2    GB | ffffffffffffffff |    2 GB | kernel
-  __________________|____________|__________________|_________|____________________________________________________________
+   +------------------+---------+------------------+---------+----------------------------------------------------------+
+   |    Start addr    | Offset  |     End addr     |  Size   | VM area description                                      |
+   +==================+=========+==================+=========+==========================================================+
+   | 0000000000000000 |    0    | 0000003fffffffff | 256 GB  | user-space virtual memory, different per mm              |
+   +------------------+---------+------------------+---------+----------------------------------------------------------+
+   | 0000004000000000 | +256 GB | ffffffbfffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical      |
+   |                  |         |                  |         | virtual memory addresses up to the -256 GB               |
+   |                  |         |                  |         | starting offset of kernel mappings.                      |
+   +------------------+---------+------------------+---------+----------------------------------------------------------+
+   |                             Kernel-space virtual memory, shared between all processes:                             |
+   +------------------+---------+------------------+---------+----------------------------------------------------------+
+   | ffffffc6fee00000 | -228 GB | ffffffc6feffffff | 2 MB    | fixmap                                                   |
+   +------------------+---------+------------------+---------+----------------------------------------------------------+
+   | ffffffc6ff000000 | -228 GB | ffffffc6ffffffff | 16 MB   | PCI io                                                   |
+   +------------------+---------+------------------+---------+----------------------------------------------------------+
+   | ffffffc700000000 | -228 GB | ffffffc7ffffffff | 4 GB    | vmemmap                                                  |
+   +------------------+---------+------------------+---------+----------------------------------------------------------+
+   | ffffffc800000000 | -224 GB | ffffffd7ffffffff | 64 GB   | vmalloc/ioremap space                                    |
+   +------------------+---------+------------------+---------+----------------------------------------------------------+
+   | ffffffd800000000 | -160 GB | fffffff6ffffffff | 124 GB  | direct mapping of all physical memory                    |
+   +------------------+---------+------------------+---------+----------------------------------------------------------+
+   | fffffff700000000 | -36 GB  | fffffffeffffffff | 32 GB   | kasan                                                    |
+   +------------------+---------+------------------+---------+----------------------------------------------------------+
+   |                                  Identical layout to the 39-bit one from here on:                                  |
+   +------------------+---------+------------------+---------+----------------------------------------------------------+
+   | ffffffff00000000 | -4 GB   | ffffffff7fffffff | 2 GB    | modules, BPF                                             |
+   +------------------+---------+------------------+---------+----------------------------------------------------------+
+   | ffffffff80000000 | -2 GB   | ffffffffffffffff | 2 GB    | kernel                                                   |
+   +------------------+---------+------------------+---------+----------------------------------------------------------+
 
 
 RISC-V Linux Kernel SV48
 ------------------------
 
-::
-
- ========================================================================================================================
-      Start addr    |   Offset   |     End addr     |  Size   | VM area description
- ========================================================================================================================
-                    |            |                  |         |
-   0000000000000000 |    0       | 00007fffffffffff |  128 TB | user-space virtual memory, different per mm
-  __________________|____________|__________________|_________|___________________________________________________________
-                    |            |                  |         |
-   0000800000000000 | +128    TB | ffff7fffffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical
-                    |            |                  |         | virtual memory addresses up to the -128 TB
-                    |            |                  |         | starting offset of kernel mappings.
-  __________________|____________|__________________|_________|___________________________________________________________
-                                                              |
-                                                              | Kernel-space virtual memory, shared between all processes:
-  ____________________________________________________________|___________________________________________________________
-                    |            |                  |         |
-   ffff8d7ffee00000 |  -114.5 TB | ffff8d7ffeffffff |    2 MB | fixmap
-   ffff8d7fff000000 |  -114.5 TB | ffff8d7fffffffff |   16 MB | PCI io
-   ffff8d8000000000 |  -114.5 TB | ffff8f7fffffffff |    2 TB | vmemmap
-   ffff8f8000000000 |  -112.5 TB | ffffaf7fffffffff |   32 TB | vmalloc/ioremap space
-   ffffaf8000000000 |  -80.5  TB | ffffef7fffffffff |   64 TB | direct mapping of all physical memory
-   ffffef8000000000 |  -16.5  TB | fffffffeffffffff | 16.5 TB | kasan
-  __________________|____________|__________________|_________|____________________________________________________________
-                                                              |
-                                                              | Identical layout to the 39-bit one from here on:
-  ____________________________________________________________|____________________________________________________________
-                    |            |                  |         |
-   ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | modules, BPF
-   ffffffff80000000 |   -2    GB | ffffffffffffffff |    2 GB | kernel
-  __________________|____________|__________________|_________|____________________________________________________________
+   +------------------+-----------+------------------+---------+-------------------------------------------------------+
+   |    Start addr    |  Offset   |     End addr     |  Size   | VM area description                                   |
+   +==================+===========+==================+=========+=======================================================+
+   | 0000000000000000 |    0      | 00007fffffffffff | 128 TB  | user-space virtual memory, different per mm           |
+   +------------------+-----------+------------------+---------+-------------------------------------------------------+
+   | 0000800000000000 | +128 TB   | ffff7fffffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical   |
+   |                  |           |                  |         | virtual memory addresses up to the -128 TB            |
+   |                  |           |                  |         | starting offset of kernel mappings.                   |
+   +------------------+-----------+------------------+---------+-------------------------------------------------------+
+   |                            Kernel-space virtual memory, shared between all processes:                             |
+   +------------------+-----------+------------------+---------+-------------------------------------------------------+
+   | ffff8d7ffee00000 | -114.5 TB | ffff8d7ffeffffff | 2 MB    | fixmap                                                |
+   +------------------+-----------+------------------+---------+-------------------------------------------------------+
+   | ffff8d7fff000000 | -114.5 TB | ffff8d7fffffffff | 16 MB   | PCI io                                                |
+   +------------------+-----------+------------------+---------+-------------------------------------------------------+
+   | ffff8d8000000000 | -114.5 TB | ffff8f7fffffffff | 2 TB    | vmemmap                                               |
+   +------------------+-----------+------------------+---------+-------------------------------------------------------+
+   | ffff8f8000000000 | -112.5 TB | ffffaf7fffffffff | 32 TB   | vmalloc/ioremap space                                 |
+   +------------------+-----------+------------------+---------+-------------------------------------------------------+
+   | ffffaf8000000000 | -80.5 TB  | ffffef7fffffffff | 64 TB   | direct mapping of all physical memory                 |
+   +------------------+-----------+------------------+---------+-------------------------------------------------------+
+   | ffffef8000000000 | -16.5 TB  | fffffffeffffffff | 16.5 TB | kasan                                                 |
+   +------------------+-----------+------------------+---------+-------------------------------------------------------+
+   |                                 Identical layout to the 39-bit one from here on:                                  |
+   +------------------+-----------+------------------+---------+-------------------------------------------------------+
+   | ffffffff00000000 | -4 GB     | ffffffff7fffffff | 2 GB    | modules, BPF                                          |
+   +------------------+-----------+------------------+---------+-------------------------------------------------------+
+   | ffffffff80000000 | -2 GB     | ffffffffffffffff | 2 GB    | kernel                                                |
+   +------------------+-----------+------------------+---------+-------------------------------------------------------+

base-commit: 0cdb3579f1ee4c1e55acf8dfb0697b660067b1f8
-- 
An old man doll... just what I always wanted! - Clara

