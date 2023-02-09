Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E33A6900F6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBIHOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjBIHOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D2A6EBE;
        Wed,  8 Feb 2023 23:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CA1Cigbjbo5d5kU+L4D/OrisiUcoKP764Ad5A2j0x8s=; b=Dm1hm2+kdEmlKk3JkeaE5X9Xgk
        uw8iG1Vp8WcSNPNrD+dOUJf/JF1g/a7XIrsukaoKO7vUnvewjbo+dtzl45K9lBqSJh7PeBRpYDnGD
        IDjMvdk0MbECzgfqzXY3q5pIekTRqMPSlYzkxR90pO6Em9ylNFlVj8wRZiE6Xd4eCLHIF9xiFGdLj
        1Ia0ogXNT2OpwjuTrf6ILyKZqhNpM1oeQ27jQM12h+KwQVgC5tDdwi/szlRjPtZe+A6qGES6WDEhn
        J2LO1LTF0Tb/88zIu248FErA70egefYouiBj91bQB0mIfUAGj18PtKFwgPRk54zu/EGD7IkcQYpVy
        cfFB2WLg==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ18E-000LPt-Ev; Thu, 09 Feb 2023 07:14:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 14/24] Documentation: powerpc: correct spelling
Date:   Wed,  8 Feb 2023 23:13:50 -0800
Message-Id: <20230209071400.31476-15-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209071400.31476-1-rdunlap@infradead.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/powerpc/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/powerpc/kasan.txt       |    2 +-
 Documentation/powerpc/papr_hcalls.rst |    2 +-
 Documentation/powerpc/qe_firmware.rst |    4 ++--
 Documentation/powerpc/vas-api.rst     |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff -- a/Documentation/powerpc/kasan.txt b/Documentation/powerpc/kasan.txt
--- a/Documentation/powerpc/kasan.txt
+++ b/Documentation/powerpc/kasan.txt
@@ -40,7 +40,7 @@ checks can be delayed until after the MM
 instrument any code that runs with translations off after booting. This is the
 current approach.
 
-To avoid this limitiation, the KASAN shadow would have to be placed inside the
+To avoid this limitation, the KASAN shadow would have to be placed inside the
 linear mapping, using the same high-bits trick we use for the rest of the linear
 mapping. This is tricky:
 
diff -- a/Documentation/powerpc/papr_hcalls.rst b/Documentation/powerpc/papr_hcalls.rst
--- a/Documentation/powerpc/papr_hcalls.rst
+++ b/Documentation/powerpc/papr_hcalls.rst
@@ -22,7 +22,7 @@ privileged operations. Currently there a
 On PPC64 arch a guest kernel running on top of a PAPR hypervisor is called
 a *pSeries guest*. A pseries guest runs in a supervisor mode (HV=0) and must
 issue hypercalls to the hypervisor whenever it needs to perform an action
-that is hypervisor priviledged [3]_ or for other services managed by the
+that is hypervisor privileged [3]_ or for other services managed by the
 hypervisor.
 
 Hence a Hypercall (hcall) is essentially a request by the pseries guest
diff -- a/Documentation/powerpc/qe_firmware.rst b/Documentation/powerpc/qe_firmware.rst
--- a/Documentation/powerpc/qe_firmware.rst
+++ b/Documentation/powerpc/qe_firmware.rst
@@ -232,11 +232,11 @@ For example, to match the 8323, revision
 'extended_modes' is a bitfield that defines special functionality which has an
 impact on the device drivers.  Each bit has its own impact and has special
 instructions for the driver associated with it.  This field is stored in
-the QE library and available to any driver that calles qe_get_firmware_info().
+the QE library and available to any driver that calls qe_get_firmware_info().
 
 'vtraps' is an array of 8 words that contain virtual trap values for each
 virtual traps.  As with 'extended_modes', this field is stored in the QE
-library and available to any driver that calles qe_get_firmware_info().
+library and available to any driver that calls qe_get_firmware_info().
 
 'microcode' (type: struct qe_microcode):
 	For each RISC processor there is one 'microcode' structure.  The first
diff -- a/Documentation/powerpc/vas-api.rst b/Documentation/powerpc/vas-api.rst
--- a/Documentation/powerpc/vas-api.rst
+++ b/Documentation/powerpc/vas-api.rst
@@ -46,7 +46,7 @@ request queue into the application's vir
 The application can then submit one or more requests to the engine by
 using copy/paste instructions and pasting the CRBs to the virtual address
 (aka paste_address) returned by mmap(). User space can close the
-established connection or send window by closing the file descriptior
+established connection or send window by closing the file descriptor
 (close(fd)) or upon the process exit.
 
 Note that applications can send several requests with the same window or
@@ -240,7 +240,7 @@ issued. This signal returns with the fol
 	siginfo.si_signo = SIGSEGV;
 	siginfo.si_errno = EFAULT;
 	siginfo.si_code = SEGV_MAPERR;
-	siginfo.si_addr = CSB adress;
+	siginfo.si_addr = CSB address;
 
 In the case of multi-thread applications, NX send windows can be shared
 across all threads. For example, a child thread can open a send window,
