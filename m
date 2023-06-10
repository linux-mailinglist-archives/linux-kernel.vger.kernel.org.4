Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954EE72A93A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 07:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjFJFnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 01:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjFJFnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 01:43:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3227F3AA3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 22:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3E3RMUEpG9p/4/pgtUAbLe6jed5Tpov9MGa9vuVYHA8=; b=Oxl7XjHxrmWf42qVYof+9N6Wf7
        JC7eJ9uHB8Bt3Hyz0awCV8sn5uARn6mzs5tj4QNBnow6urZ29s+lbe1UFURP8s6yoxjUecFNscYZa
        wkMIk7rET0QmfuDr/jJJB4dyrijWSGy5z2zX6Ogy3mjAyCbLdIysmcJjVH1+6pybhoMtvVPfQjO10
        2U9oMGWBOvonApyOEniQShJAQHGiAKg3Z629Hgo4wHZdTCdKsfVtvXSm4sAnt3vQMUht1DUJqoU3c
        jRIK6n7AyrPptS+IlYSOfs+O2FIIJdXlIoq0IEAn+2flmJfP56jloShxeQwQnh4nS/3duOACqDuJU
        OW60QsHQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7rNX-00FJ2Y-0p;
        Sat, 10 Jun 2023 05:43:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        virtualization@lists.linux-foundation.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Luke Nowakowski-Krijger" <lnowakow@eng.ucsd.edu>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] Documentation: virt: clean up paravirt_ops doc.
Date:   Fri,  9 Jun 2023 22:43:10 -0700
Message-ID: <20230610054310.6242-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify language. Clean up grammar. Hyphenate some words.

Change "low-ops" to "low-level" since "low-ops" isn't defined or even
mentioned anywhere else in the kernel source tree.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Ajay Kaher <akaher@vmware.com>
Cc: Alexey Makhalov <amakhalov@vmware.com>
Cc: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc: virtualization@lists.linux-foundation.org
Cc: x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Luke Nowakowski-Krijger" <lnowakow@eng.ucsd.edu>
Cc: Luis Chamberlain <mcgrof@kernel.org>
---
 Documentation/virt/paravirt_ops.rst |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff -- a/Documentation/virt/paravirt_ops.rst b/Documentation/virt/paravirt_ops.rst
--- a/Documentation/virt/paravirt_ops.rst
+++ b/Documentation/virt/paravirt_ops.rst
@@ -5,31 +5,31 @@ Paravirt_ops
 ============
 
 Linux provides support for different hypervisor virtualization technologies.
-Historically different binary kernels would be required in order to support
-different hypervisors, this restriction was removed with pv_ops.
+Historically, different binary kernels would be required in order to support
+different hypervisors; this restriction was removed with pv_ops.
 Linux pv_ops is a virtualization API which enables support for different
 hypervisors. It allows each hypervisor to override critical operations and
 allows a single kernel binary to run on all supported execution environments
 including native machine -- without any hypervisors.
 
 pv_ops provides a set of function pointers which represent operations
-corresponding to low level critical instructions and high level
-functionalities in various areas. pv-ops allows for optimizations at run
-time by enabling binary patching of the low-ops critical operations
+corresponding to low-level critical instructions and high-level
+functionalities in various areas. pv_ops allows for optimizations at run
+time by enabling binary patching of the low-level critical operations
 at boot time.
 
 pv_ops operations are classified into three categories:
 
 - simple indirect call
-   These operations correspond to high level functionality where it is
+   These operations correspond to high-level functionality where it is
    known that the overhead of indirect call isn't very important.
 
 - indirect call which allows optimization with binary patch
-   Usually these operations correspond to low level critical instructions. They
+   Usually these operations correspond to low-level critical instructions. They
    are called frequently and are performance critical. The overhead is
    very important.
 
 - a set of macros for hand written assembly code
    Hand written assembly codes (.S files) also need paravirtualization
-   because they include sensitive instructions or some of code paths in
+   because they include sensitive instructions or some code paths in
    them are very performance critical.
