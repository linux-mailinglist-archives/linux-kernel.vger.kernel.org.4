Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47C45E6D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiIVUmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiIVUmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:42:03 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43992BE06;
        Thu, 22 Sep 2022 13:42:02 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id E4A6D993;
        Thu, 22 Sep 2022 20:42:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E4A6D993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663879322; bh=l41J3Gn2aG8FufC8JDRIT1b+hjiJuDa/+pmymj285Ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+52tmkEcObgXX8PdkIzUtGU7ekOSAPpnBTJEUMzxyX+4ymLnthU7C9qS4BkQDsvh
         UpQwMIKQ0MYQgWKeQ6SrgziqkLYr+rkK54O50vxlR13bwSeKRqVwXALY7Wpu6hRH+5
         jkpmjCgH2f0+8DRer9MiT0xvJdct3albmeg76Xb41VTbJIwqTQdsgPmj/0u4wCak2q
         kRppjPSQVvhmbMWdQ380vF/pGgzDBOmFqzHquqkoBR4jl3GuCO0Yw0uEESKjPqJZiw
         0U41+sVBjgnmRNbEcA8mcaF1JdlXq3mXC3V3dRAtFmvORpHCj/HpwmercWWBgIQ+yo
         u5tAiG2oTJanQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 5/7] docs: move asm-annotations.rst into core-api
Date:   Thu, 22 Sep 2022 14:41:36 -0600
Message-Id: <20220922204138.153146-6-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220922204138.153146-1-corbet@lwn.net>
References: <20220922204138.153146-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one file should not really be in the top-level documentation
directory.  core-api/ may not be a perfect fit but seems to be best, so
move it there.  Adjust a couple of internal document references to make
them location-independent.

Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/{ => core-api}/asm-annotations.rst | 7 ++++---
 Documentation/core-api/index.rst                 | 1 +
 Documentation/index.rst                          | 8 --------
 3 files changed, 5 insertions(+), 11 deletions(-)
 rename Documentation/{ => core-api}/asm-annotations.rst (97%)

diff --git a/Documentation/asm-annotations.rst b/Documentation/core-api/asm-annotations.rst
similarity index 97%
rename from Documentation/asm-annotations.rst
rename to Documentation/core-api/asm-annotations.rst
index a64f2ca469d4..bc514ed59887 100644
--- a/Documentation/asm-annotations.rst
+++ b/Documentation/core-api/asm-annotations.rst
@@ -43,10 +43,11 @@ annotated objects like this, tools can be run on them to generate more useful
 information. In particular, on properly annotated objects, ``objtool`` can be
 run to check and fix the object if needed. Currently, ``objtool`` can report
 missing frame pointer setup/destruction in functions. It can also
-automatically generate annotations for :doc:`ORC unwinder <x86/orc-unwinder>`
+automatically generate annotations for the ORC unwinder
+(Documentation/x86/orc-unwinder.rst)
 for most code. Both of these are especially important to support reliable
-stack traces which are in turn necessary for :doc:`Kernel live patching
-<livepatch/livepatch>`.
+stack traces which are in turn necessary for kernel live patching
+(Documentation/livepatch/livepatch.rst).
 
 Caveat and Discussion
 ---------------------
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index dc95df462eea..f5d8e3779fe8 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -23,6 +23,7 @@ it.
    printk-formats
    printk-index
    symbol-namespaces
+   asm-annotations
 
 Data structures and low-level utilities
 =======================================
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 7f63f70bb8d6..6d01c2e38573 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -89,14 +89,6 @@ platform firmwares.
    devicetree/index
 
 
-Architecture-agnostic documentation
------------------------------------
-
-.. toctree::
-   :maxdepth: 1
-
-   asm-annotations
-
 Architecture-specific documentation
 -----------------------------------
 
-- 
2.37.2

