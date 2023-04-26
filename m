Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F04B6EFBE8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 22:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjDZUtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 16:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239959AbjDZUtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:49:47 -0400
Received: from aer-iport-3.cisco.com (aer-iport-3.cisco.com [173.38.203.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2623C15;
        Wed, 26 Apr 2023 13:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1121; q=dns/txt; s=iport;
  t=1682542173; x=1683751773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZbVNXlIv8G5b2W+u/CXT4H6oOP5oKHIlM/cd0euePXI=;
  b=by0kjwrrhmPt/+n8NMmGFg4EhbREfEE+KG9rbO1v1UWPpN9x7oR4ePmI
   SMwm5LZ7AY3d7VMQHt4R2+xYciXMl5p0okKDDqwBNdSA/U6k0WvZWEhdL
   DpDnbtt9KF0aSd/39Ca4RZKgIEFok4jmcSCv8TFDi6soyfp5mOEp7qMEy
   A=;
X-CSE-ConnectionGUID: ZAQgjrNlTbCMw4RSGzqICw==
X-CSE-MsgGUID: 8DPdC6ZmQyCqMKY/NAvaJA==
X-IronPort-AV: E=Sophos;i="5.99,229,1677542400"; 
   d="scan'208";a="7233052"
Received: from aer-iport-nat.cisco.com (HELO aer-core-10.cisco.com) ([173.38.203.22])
  by aer-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 20:49:31 +0000
Received: from archlinux-cisco.cisco.com (ams3-vpn-dhcp2960.cisco.com [10.61.75.144])
        (authenticated bits=0)
        by aer-core-10.cisco.com (8.15.2/8.15.2) with ESMTPSA id 33QKnOPF053840
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Apr 2023 20:49:30 GMT
From:   Ariel Miculas <amiculas@cisco.com>
To:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        benno.lossin@proton.me
Cc:     Ariel Miculas <amiculas@cisco.com>
Subject: [PATCH v3] rust: helpers: sort includes alphabetically in rust/helpers.c
Date:   Wed, 26 Apr 2023 23:49:23 +0300
Message-Id: <20230426204923.16195-1-amiculas@cisco.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <CANiq72nm-tWGPHMaNF11baVRDFpk8ruvTAVDEWKfraEzADWqQQ@mail.gmail.com>
References: <CANiq72nm-tWGPHMaNF11baVRDFpk8ruvTAVDEWKfraEzADWqQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the #include directives of rust/helpers.c alphabetically and add a
comment specifying this. The reason for this is to improve readability
and to be consistent with the other files with a similar approach within
'rust/'.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1003
Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/helpers.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index 81e80261d597..73c01db0c828 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -16,15 +16,17 @@
  *
  * All symbols are exported as GPL-only to guarantee no GPL-only feature is
  * accidentally exposed.
+ *
+ * Sorted alphabetically.
  */
 
 #include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/err.h>
-#include <linux/refcount.h>
 #include <linux/mutex.h>
-#include <linux/spinlock.h>
+#include <linux/refcount.h>
 #include <linux/sched/signal.h>
+#include <linux/spinlock.h>
 #include <linux/wait.h>
 
 __noreturn void rust_helper_BUG(void)
-- 
2.40.0

