Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5F4701C62
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjENJEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjENJEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:04:43 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703191BDD;
        Sun, 14 May 2023 02:04:42 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51b33c72686so7847153a12.1;
        Sun, 14 May 2023 02:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684055082; x=1686647082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VswhOVIM6N9lUQ5IbUMqB4CktfYicQQNL7zwxJA2o0=;
        b=gyDuam61cQhcYHV2PBw+v0qV4xXs/l6wEC2KCFNxFE/FegwP3dNUz5F1uZITuqHFNs
         syiVQB93aJW0sk3dLTzvIhAtFHwDUqDKv0DxfjPY2LAfiUZREKQetU0o4FtYmcZQHYIs
         SLz9bvWw+KOJZ9F58insz5q1Q/Skkb5ZBSSqQ4KzVy25ZR4TPjjpJmmxfaW5AkzGCLYU
         kyC0WR8qHm43CsElKIx+99P5bQhd5JC/WeUgHvZB+8yiE6kpC5wDiHU1qUxnNw8aFVm9
         vFQy9JA/WrL+zGvFSBJEGZp5u/gEeh+YLvR48s3C3QiNrlZmM8/gWAa2JdPSR7QH4t7v
         dtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684055082; x=1686647082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VswhOVIM6N9lUQ5IbUMqB4CktfYicQQNL7zwxJA2o0=;
        b=DMNxha7+Ibsrg6NjF1HMPCXFHi56kLfuK565DfX5rrBxS17zN5SDj3YNlhPOQagtGn
         uhyCk/jjg+/vMmPMrNwO3rFdPVmAnWgSRbEFDEkwjwgoX1U9lhcNi8JMLdQrfA2GVT03
         B37jkgVgt+UOcRqdBKLY3L5rfT/JSMUM/pZ0zLTcy28U+Y4D2NiRCVXc0NieNv7Ib1Qc
         iCnATzzF9U9Wyl+2p3aTrfwp9ZLMLUQUPpOJ3bSAa1btj1qT3R2vcQeEdMsO89/AjrrB
         8cMIRbDh80cSKTRVCXUYifIbu/YzD5td6Vz3MZVYnSo+yyTNf632h77QGLnLPPcv7e2K
         7Xaw==
X-Gm-Message-State: AC+VfDxO2APl7cCDReQLCYjPXOxcur2GVKl08fZme69VS5PwmbUHLDZi
        MKpqhXa1n5teSNfd3+GKtXA=
X-Google-Smtp-Source: ACHHUZ4pzmq3hWDHq3IlCijrOGJ+N5qc/X55K3MabPDZwyQJR3SxOAkkPZxkiTNzN5IhuNLdSkgMaA==
X-Received: by 2002:a17:903:483:b0:1aa:dba2:d155 with SMTP id jj3-20020a170903048300b001aadba2d155mr29039425plb.48.1684055081786;
        Sun, 14 May 2023 02:04:41 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b001a6d08eb054sm11043270plg.78.2023.05.14.02.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 02:04:41 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2DC2B1061DC; Sun, 14 May 2023 16:04:36 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux RISC-V <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/5] Documentation: riscv: vector: Wrap control_argument struct definition in code block
Date:   Sun, 14 May 2023 16:04:29 +0700
Message-Id: <20230514090432.78217-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230514090432.78217-1-bagasdotme@gmail.com>
References: <20230514090432.78217-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947; i=bagasdotme@gmail.com; h=from:subject; bh=S42igDCO53ZkCWTrexHErxJ8V8JjUUjsuLNH7WukgIk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkJS+RzdR/arTB/dyeC+/VO9ajKJbfWaS/eYre5au63m 9852bandZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAi14sY/kd1vNPLvh0ZLD/5 +z3mc4mLzqh4tworRzq5Tp3pp3vu1n5Ghv7++/tYF7VvFmVYUlTw9UbKt18FpXt8xcw3v5p2QmO 6JycA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reports htmldocs warning:

Documentation/riscv/vector.rst:45: WARNING: Definition list ends without a blank line; unexpected unindent.

The warning is due to definition of control_argument struct, written
unformatted. Wrap it in code block with C syntax highlighting to fix the
warning.

Fixes: 412c68cfeeb178 ("riscv: Add documentation for Vector")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305141409.bEBvlSY4-lkp@intel.com/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/riscv/vector.rst | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/riscv/vector.rst b/Documentation/riscv/vector.rst
index acc97508ccb249..178b3f3f452462 100644
--- a/Documentation/riscv/vector.rst
+++ b/Documentation/riscv/vector.rst
@@ -36,14 +36,16 @@ prctl(PR_RISCV_V_SET_CONTROL, unsigned long arg)
     be interpreted as the following structure, and accessed by 3 masks
     respectively.
 
-    struct control_argument {
-        // Located by PR_RISCV_V_VSTATE_CTRL_CUR_MASK
-        int current_enablement_status : 2;
-        // Located by PR_RISCV_V_VSTATE_CTRL_NEXT_MASK
-        int next_enablement_status : 2;
-        // Located by PR_RISCV_V_VSTATE_CTRL_INHERIT
-        bool inherit_mode : 1;
-    }
+    .. code-block:: c
+
+        struct control_argument {
+            // Located by PR_RISCV_V_VSTATE_CTRL_CUR_MASK
+            int current_enablement_status : 2;
+            // Located by PR_RISCV_V_VSTATE_CTRL_NEXT_MASK
+            int next_enablement_status : 2;
+            // Located by PR_RISCV_V_VSTATE_CTRL_INHERIT
+            bool inherit_mode : 1;
+        }
 
     The 3 masks, PR_RISCV_V_VSTATE_CTRL_CUR_MASK,
     PR_RISCV_V_VSTATE_CTRL_NEXT_MASK, and PR_RISCV_V_VSTATE_CTRL_INHERIT
-- 
An old man doll... just what I always wanted! - Clara

