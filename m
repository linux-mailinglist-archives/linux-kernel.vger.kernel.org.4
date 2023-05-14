Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD13D701C67
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbjENJEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjENJEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:04:44 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88FF1BE3;
        Sun, 14 May 2023 02:04:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaf91ae451so108644195ad.1;
        Sun, 14 May 2023 02:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684055082; x=1686647082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlYIG+wyBwHIZ6Ig5rNTc1U+7HEnxpjzPz2HnP+gqKM=;
        b=sxfLoTD0NF/Oidjt/30xAfQe77E+2H/A1Bt6TqxQY2/6VNOFb0Uyd85NQjRvs0Gag5
         ejrvn5D290RidtfydaauoUKGO4geu0N0v4EPBJVBS/2JCC7s9OlM++hFr2teuavzTW21
         ZV38a4rRNxUSnzdANrgTy8cb43irt2nrXWTxTXA1cnSswvilFYTNiRQWaUC9O94aAmVC
         lsnuAyuWfstUpgoGlSOIE7RjKzp/q39GNYDFqSYH/lHiWVVtzTldV8FA1qIHmtitgb/Z
         H1jO8rmhRdfuzZAEtY0XTyuQtKvXr1GkSahDS2V2F5V30jwmZRixBETwojLYSyVRTjYu
         EPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684055082; x=1686647082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlYIG+wyBwHIZ6Ig5rNTc1U+7HEnxpjzPz2HnP+gqKM=;
        b=If+52pfrtTrV+ky/Y3RTSAXIaki+xiROoU2TMamQhWlZaetA3mJosu+4OGM8kLtE02
         BgL/P4s57EHsZ4YIsj7T+eHt1tLK10Lv0lyq3SvDcRGI15cqUtEBmtajq/RmAvbLXbB/
         KLGuaP05NgoTthZKWv0V357+mNBTuIHXezwTlyujEsx3ljWKYZfVdFafCA/yPHwf26o5
         0wbPs1mCTQI2EPts1ugatF87dhEIByuKh9qjjGm5Xq27AlYD8hSQB5BBp+8cHuDrzqsn
         qHZyckvn0aWo6TM2+r4e/bnxftcrEP2CjfRSG0qW6bKxskwxGJHBImP7PHbNZ3UkdLi8
         0C9w==
X-Gm-Message-State: AC+VfDzOgjSTMOPVvORUnQep3mXO2F1MoJtTMnQVGdYrQxY/S1/lrXnc
        lSLhKvKZIFlWVZz+RWPIKCE=
X-Google-Smtp-Source: ACHHUZ6wCkJuuI/JM0p/RqMI5Szf/kAYaz3iNpFxdIUUUIOPWbcgZwStiNGZBZC7kIqG3LZRUx/3VQ==
X-Received: by 2002:a17:903:41d0:b0:1ac:4412:bd9 with SMTP id u16-20020a17090341d000b001ac44120bd9mr37163799ple.3.1684055082288;
        Sun, 14 May 2023 02:04:42 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902fe8b00b001ac45598b59sm11060546plm.163.2023.05.14.02.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 02:04:41 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id F099710363C; Sun, 14 May 2023 16:04:36 +0700 (WIB)
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
Subject: [PATCH 4/5] Documentation: riscv: vector: Use bullet lists for prctl() return values
Date:   Sun, 14 May 2023 16:04:31 +0700
Message-Id: <20230514090432.78217-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230514090432.78217-1-bagasdotme@gmail.com>
References: <20230514090432.78217-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108; i=bagasdotme@gmail.com; h=from:subject; bh=BIcautUtnBxQsDL0RzYa8VBmwL4oBx+HTCFWbrbAgPA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkJSxQcJVJWzP9edXyJjjEvl+urG8yqOQaHWeu6mpPXT Yh+YGbWUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIu8YvhffPhVyo3d3M3LJhep XqwySe3xXazE+X990PRcvvXXl6vcZPinqrjPJvfnzrcnWx+vfqM8q/P7tacJkhIyZemTP3yYKnC dBQA=
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

Use bullet lists on return values of prctl() calls to follow other
listings (bit lists and enablement status). This should convey purposes
of listing things.

Fixes: 412c68cfeeb178 ("riscv: Add documentation for Vector")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/riscv/vector.rst | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/riscv/vector.rst b/Documentation/riscv/vector.rst
index c7bd701c7963b6..4624e5b9bef4cc 100644
--- a/Documentation/riscv/vector.rst
+++ b/Documentation/riscv/vector.rst
@@ -74,11 +74,12 @@ status for the use of Vector in userspace:
           PR_RISCV_V_VSTATE_CTRL_NEXT_MASK and PR_RISCV_V_VSTATE_CTRL_INHERIT.
           This setting persists across changes in the system-wide default value.
 
-    Return value: return 0 on success, or a negative error value:
-        EINVAL: Vector not supported, invalid enablement status for current or
-                next mask
-        EPERM: Turning off Vector in PR_RISCV_V_VSTATE_CTRL_CUR_MASK if Vector
-                was enabled for the calling thread.
+    Return value:
+        * 0 on success;
+        * EINVAL: Vector not supported, invalid enablement status for current or
+          next mask;
+        * EPERM: Turning off Vector in PR_RISCV_V_VSTATE_CTRL_CUR_MASK if Vector
+          was enabled for the calling thread.
 
     On success:
         * A valid setting for PR_RISCV_V_VSTATE_CTRL_CUR_MASK takes place
@@ -94,8 +95,9 @@ status for the use of Vector in userspace:
     Gets the same Vector enablement status for the calling thread. Setting for
     next execve() call and the inheritance bit are all OR-ed together.
 
-    Return value: a nonnegative value on success, or a negative error value:
-        EINVAL: Vector not supported.
+    Return value:
+        * a nonnegative value on success;
+        * EINVAL: Vector not supported.
 
 2.  System runtime configuration (sysctl)
 -----------------------------------------
-- 
An old man doll... just what I always wanted! - Clara

