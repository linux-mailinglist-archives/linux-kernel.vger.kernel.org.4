Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6B867DDF2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjA0GmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjA0Gka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F277751A8;
        Thu, 26 Jan 2023 22:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RabzW2onkbK88Jry4X6k/vy1HM1YZdyLqoiuOttw51A=; b=kNDwnnuXkhvoQdYEJI6kdc4LS5
        ZGwL/ehZkHYq5TO1Z2c8XfREfcaK/RM8a0TOIlF+sY5KTOCfrrYwBRr81jUbQk9a3tudg2Kgx0Ar9
        d+63Eeste5xjtUQYwS+oRnVH8+zQiHNBUFOb4AxDUQd+yOqtkOd+V5VEd2cEmk9VevHvYfZAxY8MK
        apT69YJdcdZZCgWeFYIpjDMdykMEhs44nloeM5WH8WhAHw25xC+wv6mqA5S9ag28yvefjEIQF1J+/
        Z5ftzpL6VIX7TJoxygUzts12Ev9WIrWT06VaafGKEXJhbhByUKwf9gpIse7QP0Lrvz+45HbsNsdAT
        LKgyTcNw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPR-00DM0u-Us; Fri, 27 Jan 2023 06:40:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 34/35] Documentation: x86: correct spelling
Date:   Thu, 26 Jan 2023 22:40:04 -0800
Message-Id: <20230127064005.1558-35-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/x86/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-sgx@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/x86/boot.rst    |    2 +-
 Documentation/x86/buslock.rst |    2 +-
 Documentation/x86/mds.rst     |    2 +-
 Documentation/x86/resctrl.rst |    2 +-
 Documentation/x86/sgx.rst     |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff -- a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -1105,7 +1105,7 @@ The kernel command line should not be lo
 code, nor should it be located in high memory.
 
 
-Sample Boot Configuartion
+Sample Boot Configuration
 =========================
 
 As a sample configuration, assume the following layout of the real
diff -- a/Documentation/x86/buslock.rst b/Documentation/x86/buslock.rst
--- a/Documentation/x86/buslock.rst
+++ b/Documentation/x86/buslock.rst
@@ -32,7 +32,7 @@ mechanisms to detect split locks and bus
 --------------------------------------
 
 Beginning with the Tremont Atom CPU split lock operations may raise an
-Alignment Check (#AC) exception when a split lock operation is attemped.
+Alignment Check (#AC) exception when a split lock operation is attempted.
 
 #DB exception for bus lock detection
 ------------------------------------
diff -- a/Documentation/x86/mds.rst b/Documentation/x86/mds.rst
--- a/Documentation/x86/mds.rst
+++ b/Documentation/x86/mds.rst
@@ -60,7 +60,7 @@ needed for exploiting MDS requires:
    data
 
 The existence of such a construct in the kernel cannot be excluded with
-100% certainty, but the complexity involved makes it extremly unlikely.
+100% certainty, but the complexity involved makes it extremely unlikely.
 
 There is one exception, which is untrusted BPF. The functionality of
 untrusted BPF is limited, but it needs to be thoroughly investigated
diff -- a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
--- a/Documentation/x86/resctrl.rst
+++ b/Documentation/x86/resctrl.rst
@@ -487,7 +487,7 @@ this would be dependent on number of cor
    depending on # of threads:
 
 For the same SKU in #1, a 'single thread, with 10% bandwidth' and '4
-thread, with 10% bandwidth' can consume upto 10GBps and 40GBps although
+thread, with 10% bandwidth' can consume up to 10GBps and 40GBps although
 they have same percentage bandwidth of 10%. This is simply because as
 threads start using more cores in an rdtgroup, the actual bandwidth may
 increase or vary although user specified bandwidth percentage is same.
diff -- a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -245,7 +245,7 @@ SGX will likely become unusable because
 limited. However, while this may be fatal to SGX, the rest of the kernel
 is unlikely to be impacted and should continue to work.
 
-As a result, when this happpens, user should stop running any new
+As a result, when this happens, the user should stop running any new
 SGX workloads, (or just any new workloads), and migrate all valuable
 workloads. Although a machine reboot can recover all EPC memory, the bug
 should be reported to Linux developers.
