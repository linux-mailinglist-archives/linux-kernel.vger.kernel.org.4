Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6046D0E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjC3SwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjC3SwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:52:08 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A2DDBD1;
        Thu, 30 Mar 2023 11:51:54 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 59so14739660qva.11;
        Thu, 30 Mar 2023 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680202313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Rk65UIr0C4i2trbRSCdrFBIcKN1GftKZbdV7CSbbmE=;
        b=DJ5hAkJfMyKIeAvaaQM/gIfffqCouUCxb3rklG9urxrGo0slzdpDe1QMR5RJv0xGHn
         0F+2mdaLwNb8OZ0xaqhvcEVWKE3QH3dAAkCujvRnQzFq4ic+gpd86GcIhb6oNQ3eBZL4
         QhdKG1ykgp6UMY46v6lemuuV6UHrL7MOGc2IVsqOLfycMt94o4NLLba7BEzZIkxGm5sQ
         2QXLzgrQRc+RFd1DPQpO4O1yOK1qUNPW0s7Flsz3NVt8ttPoU2b1aFEUkfocYyLhkFs0
         +BHIjZWCJDLMRj6KcF8sTLVTh9Z2mxV0gc/1nCvwUWINGgwVWzU0cRYspDCkqdT7TnVQ
         B+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680202313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Rk65UIr0C4i2trbRSCdrFBIcKN1GftKZbdV7CSbbmE=;
        b=qSrvDyefaNdlgf89NGQi/bzAm6+SM4WG9zqQcEtjM3BWwKxqP0PWB+JJ6xKQzQnPvM
         6fvqL8zP98wu7M7kVgy1Q4XN4GPL07OkoiTYTSXbJqArgTRxAsRauFR7j6+ktd2ak4WF
         SDuDBcQ0X7cRgRgJDyngP/n/jTjRYv79v+94T0SCR6axUM2gPHbHwIRx2KMRlSSwByTm
         HRuLXdl1Of8TcZEpgAgloYRFPNgDDOJfcJAI8xoohwP0PTwSIQ7NpIwffKOK2dOWNGZQ
         ciV0BHtuCtfTBB0TuL+MIwFkqKZPp1aVbxOSXNtOOnWy3WAmr1vnK5iYjti9+9wjBMs8
         jV8A==
X-Gm-Message-State: AAQBX9etdcwKOA9D0zdXhHY7FVuK3vXr8mul5jJm/NEISPMaxRN1BuS3
        zJD5TAW+//A4r0CMLJ6UwaQ=
X-Google-Smtp-Source: AKy350YPsoLv62Sq9Cbw9fu2IRQWDnN+XU0/jjCM2Zibvipa1Nywwmrwv1SGf5wu7LujvcjohJBz/Q==
X-Received: by 2002:a05:6214:1cc2:b0:56f:154:2508 with SMTP id g2-20020a0562141cc200b0056f01542508mr37774905qvd.1.1680202313142;
        Thu, 30 Mar 2023 11:51:53 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id j14-20020a0cc34e000000b005dd8b9345fasm11464qvi.146.2023.03.30.11.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 11:51:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 38D4C27C0054;
        Thu, 30 Mar 2023 14:51:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 30 Mar 2023 14:51:52 -0400
X-ME-Sender: <xms:R9olZDLa5R7Zf86vriWUsJeuch-_igxEzC-yGBsQ-GK2Bkr3ilmA6g>
    <xme:R9olZHLv9HPkt-e549CazI0c3RlfQepjmrbBv26e6aL9Ofgh7hEmc_x5u47hzD_Na
    7W-VBOq8_I1sdn61g>
X-ME-Received: <xmr:R9olZLu34v5Rppwc8jisZJR_c40teIepruGNq5C3lajlqOga-utGaEy5_fsFaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehledgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:R9olZMao4Qb-EmriHOJ_NWFi18zBL0ttg6cuHNBFu4zayFX5Yk7TNw>
    <xmx:R9olZKaEgjJwKSxmWpP7tKn1zRqpvEmZJ2Vh6yljqG2RCpEbCbCc3w>
    <xmx:R9olZAA7roIGPfUatBS_cD6iJixpKvvc5zvuVbui0M156vCxIqKyVg>
    <xmx:SNolZMANSYVKfruB2e8aHHEtONiHTIehLG1zKe7A90M-c-p2tvB3gQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 14:51:51 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [DRAFT 1/2] locking/selftest: Add test infrastructure for Rust locking APIs
Date:   Thu, 30 Mar 2023 11:51:02 -0700
Message-Id: <20230330185103.1444086-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZCXZMNj7aOKbC7Ev@boqun-archlinux>
References: <ZCXZMNj7aOKbC7Ev@boqun-archlinux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 MAINTAINERS                  |  1 +
 lib/Makefile                 |  3 +++
 lib/locking-selftest.c       |  9 +++++++++
 lib/rust_locking_selftest.rs | 12 ++++++++++++
 4 files changed, 25 insertions(+)
 create mode 100644 lib/rust_locking_selftest.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..c1878e18f98a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12060,6 +12060,7 @@ F:	include/linux/seqlock.h
 F:	include/linux/spinlock*.h
 F:	kernel/locking/
 F:	lib/locking*.[ch]
+F:	lib/rust-locking-selftest.rs
 X:	kernel/locking/locktorture.c
 
 LOGICAL DISK MANAGER SUPPORT (LDM, Windows 2000/XP/Vista Dynamic Disks)
diff --git a/lib/Makefile b/lib/Makefile
index baf2821f7a00..940374c08edd 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -148,6 +148,9 @@ obj-$(CONFIG_GENERIC_PCI_IOMAP) += pci_iomap.o
 obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
+ifdef CONFIG_RUST
+obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += rust_locking_selftest.o
+endif
 
 lib-y += logic_pio.o
 
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 8d24279fad05..9ef3ad92bc47 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2854,6 +2854,11 @@ static void hardirq_deadlock_softirq_not_deadlock(void)
 	HARDIRQ_ENABLE();
 }
 
+#ifdef CONFIG_RUST
+void rust_locking_test(void);
+#else
+#define rust_locking_test()
+#endif
 void locking_selftest(void)
 {
 	/*
@@ -3010,6 +3015,10 @@ void locking_selftest(void)
 		printk("---------------------------------\n");
 		debug_locks = 1;
 	}
+
+	/* Rust locking API tests */
+	rust_locking_test();
+
 	lockdep_set_selftest_task(NULL);
 	debug_locks_silent = 0;
 }
diff --git a/lib/rust_locking_selftest.rs b/lib/rust_locking_selftest.rs
new file mode 100644
index 000000000000..61560a2f3c6b
--- /dev/null
+++ b/lib/rust_locking_selftest.rs
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Selftests for Rust locking APIs.
+
+use kernel::prelude::*;
+const __LOG_PREFIX: &[u8] = b"locking selftest\0";
+
+/// Entry point for tests.
+#[no_mangle]
+pub extern "C" fn rust_locking_test() {
+    pr_info!("Selftests for Rust locking APIs");
+}
-- 
2.39.2

