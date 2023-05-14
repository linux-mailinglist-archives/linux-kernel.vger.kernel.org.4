Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AEA701C65
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjENJEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjENJEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:04:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECE01BE5;
        Sun, 14 May 2023 02:04:43 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6439b410679so7643161b3a.0;
        Sun, 14 May 2023 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684055083; x=1686647083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWsNucItL3Ir8RVSxlrmAT54pJTVw6Lt+rodKw+CzPs=;
        b=FvWwMcL2+nO561GFgxSm3hIVvRbDWjclyM+XprkVWb53HMSCvWLBbQ6PJDhWTynSgt
         539bfRSH3T9xgYyZfPFiyfxmPfGmqYfdDy6RqsGwy16PcE7Qny9NesyE40zqGYBxffkh
         g2rSdN3GY7H//g+gBOEvduXkznoyHpiRX8U7JjejquImPn69mKZxY/OCU1u9zgo4rxag
         OYr2kbUB6kRu8QVgvKwCkJqMsBN+nrIIrTKV5uxHJ4A0zUzScsPlYt7Erhkm9vbAJWGP
         4K1rwJSlcClcCmSJqpyAYqK/2u6hLNklJeGwvEvGIQuNk/wH3pU9qSuOCMinEgr8/0Lv
         huoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684055083; x=1686647083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWsNucItL3Ir8RVSxlrmAT54pJTVw6Lt+rodKw+CzPs=;
        b=d+Rcvp0AGtFx12UTV+ocm/817rItOMXWu+zNtGyPJvDiq0tIi+zbAww1JGomopHeg4
         IYnCUBowbwqz069e9zhiDE6npRK4CDC09TECFCsnqmsBDh5/0BOqJ1Nk0aE69y881MpD
         C70Ia31L+Bi18VXDNgz5xi1ClDr1rcTHw7lok+gmpaCNV3BrzibEhyi28FWev4mBVqub
         M/Fjfw0yEIJd2BmYvdlH5RXktem+RO8PNoVLFTwKhGqK3Xe9HvPKQ4K4Ss4+CEQrXItr
         uHzJamPI6+D3IxgZGkzMmkMZHWKIK8pWl6bFfmzn4PE5Vu0zzYhmcaA5zGmDt1tr8yVh
         qebA==
X-Gm-Message-State: AC+VfDymO/HxFwjUnRkO+9T3IK6chZuPQ8jqJAzePWsuZKLIJz8yPSwr
        A1tkBeGjEpChMan1swi/HHM=
X-Google-Smtp-Source: ACHHUZ4h2oq0sD6DW1Jn3SJpVqz/5hks4ikFzYyfoO/TD8NhBqG3iYXTurrqa+0pLQikvgf1idsRIA==
X-Received: by 2002:a17:903:2092:b0:1ac:8e0b:282c with SMTP id d18-20020a170903209200b001ac8e0b282cmr18318011plc.1.1684055082739;
        Sun, 14 May 2023 02:04:42 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709026b4b00b001acae973449sm9287867plt.162.2023.05.14.02.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 02:04:41 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 490BD1061D7; Sun, 14 May 2023 16:04:36 +0700 (WIB)
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
        Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH 5/5] Documentation: riscv: vector: Fix bullet list usage on sysctl section
Date:   Sun, 14 May 2023 16:04:32 +0700
Message-Id: <20230514090432.78217-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230514090432.78217-1-bagasdotme@gmail.com>
References: <20230514090432.78217-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2953; i=bagasdotme@gmail.com; h=from:subject; bh=GHK5dRGPQCAuWJZz8ukbYwsZAgNOSpPJq12ZuI55/8M=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkJSxT0N3SHmsulmgt2i2dWNdX237yubfG1afKdzP3vo uclfZvSUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIlEhTEyzObe0dG9/OjsqQwy s3Pe3eVmbGUWEONcc9NrpTFrR1HdY4a/4g/fzL8wYbforvQTN69G7p6xbe3v1Z+v+Maf0z34yXK PBxcA
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

Prose sentences are better written as normal paragraph instead of
using bullet lists.

Also, use bullet list for list of riscv_v_default_allow values.

Fixes: 412c68cfeeb178 ("riscv: Add documentation for Vector")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/riscv/vector.rst | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/Documentation/riscv/vector.rst b/Documentation/riscv/vector.rst
index 4624e5b9bef4cc..f752826871b0e2 100644
--- a/Documentation/riscv/vector.rst
+++ b/Documentation/riscv/vector.rst
@@ -102,25 +102,24 @@ status for the use of Vector in userspace:
 2.  System runtime configuration (sysctl)
 -----------------------------------------
 
- * To mitigate the ABI impact of expansion of the signal stack, a
-   policy mechanism is provided to the administrators, distro maintainers, and
-   developers to control the default Vector enablement status for userspace
-   processes:
+To mitigate the ABI impact of expansion of the signal stack, a
+policy mechanism is provided to the administrators, distro maintainers, and
+developers to control the default Vector enablement status for userspace
+processes in form of sysctl knob:
 
-/proc/sys/abi/riscv_v_default_allow
+* /proc/sys/abi/riscv_v_default_allow
 
     Writing the text representation of 0 or 1 to this file sets the default
-    system enablement status for new starting userspace programs. A valid value
-    should be:
+    system enablement status for new starting userspace programs. Valid values
+    are:
 
-    0: Do not allow Vector code to be executed as the default for new processes.
-
-    1: Allow Vector code to be executed as the default for new processes.
+    * 0: Do not allow Vector code to be executed as the default for new processes.
+    * 1: Allow Vector code to be executed as the default for new processes.
 
     Reading this file returns the current system default enablement status.
 
-* At every execve() call, a new enablement status of the new process is set to
-  the system default, unless:
+    At every execve() call, a new enablement status of the new process is set to
+    the system default, unless:
 
       * PR_RISCV_V_VSTATE_CTRL_INHERIT is set for the calling process, and the
         setting in PR_RISCV_V_VSTATE_CTRL_NEXT_MASK is not
@@ -129,5 +128,5 @@ status for the use of Vector in userspace:
       * The setting in PR_RISCV_V_VSTATE_CTRL_NEXT_MASK is not
         PR_RISCV_V_VSTATE_CTRL_DEFAULT.
 
-* Modifying the system default enablement status does not affect the enablement
-  status of any existing process of thread that do not make an execve() call.
+    Modifying the system default enablement status does not affect the enablement
+    status of any existing process of thread that do not make an execve() call.
-- 
An old man doll... just what I always wanted! - Clara

