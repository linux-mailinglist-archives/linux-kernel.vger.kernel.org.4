Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AB46C1CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjCTQvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjCTQu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:50:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCDC1114E;
        Mon, 20 Mar 2023 09:42:49 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Qtbmj0GS1d2p9M+xquKGfazKMptEwJhPhvUVAC35WoA=;
        b=x0YG5Tt8nb/Pfya/OnMUbeD/gO3WUdi6U26UI9iqkvHFeymH3gGRVCTJJx84/fVNiYjE61
        lruvtA9eFuLVVWaBifgTIxaY3940Uibsgep0Gvs2x9xi6m/SGRZAMHLlopjj8oyxlw19bF
        RuTx660OLuXNSxI9n2XRqqFd6oAUlIIkLPjaMoVlMaxjK8S7/1JGhgy71Xr8pxPl65uRgN
        V6uKg8Hvcsv4c1tHomdqQYUPYpBJU99bFpzjWRBR1bafrxJuzoUQrxEuJdBK7RH2iQIoyq
        tgy6bLjtNCLobvaexHEzojT0mKjaEI5Sf8NdGMeXyhV4JStWsUVo1zG0wsSU4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Qtbmj0GS1d2p9M+xquKGfazKMptEwJhPhvUVAC35WoA=;
        b=+8uUvyfoDOX+caWjroDKwC+e9RAmzhV296NTOdro/Sm/VdBtS+b3gWGQtM6godF0O2yKgA
        yo+/Hu/Dx3DQFfAg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] Documentation/x86: Add CET shadow stack description
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933037124.5837.7096167353452702440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     54759b257eadb05fc01f34266a0c55ce0fd10e06
Gitweb:        https://git.kernel.org/tip/54759b257eadb05fc01f34266a0c55ce0fd10e06
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Sat, 18 Mar 2023 17:14:56 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:07 -07:00

Documentation/x86: Add CET shadow stack description

Introduce a new document on Control-flow Enforcement Technology (CET).

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230319001535.23210-2-rick.p.edgecombe%40intel.com
---
 Documentation/x86/index.rst |   1 +-
 Documentation/x86/shstk.rst | 169 +++++++++++++++++++++++++++++++++++-
 2 files changed, 170 insertions(+)
 create mode 100644 Documentation/x86/shstk.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index c73d133..8ac64d7 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -22,6 +22,7 @@ x86-specific Documentation
    mtrr
    pat
    intel-hfi
+   shstk
    iommu
    intel_txt
    amd-memory-encryption
diff --git a/Documentation/x86/shstk.rst b/Documentation/x86/shstk.rst
new file mode 100644
index 0000000..f09afa5
--- /dev/null
+++ b/Documentation/x86/shstk.rst
@@ -0,0 +1,169 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================================
+Control-flow Enforcement Technology (CET) Shadow Stack
+======================================================
+
+CET Background
+==============
+
+Control-flow Enforcement Technology (CET) covers several related x86 processor
+features that provide protection against control flow hijacking attacks. CET
+can protect both applications and the kernel.
+
+CET introduces shadow stack and indirect branch tracking (IBT). A shadow stack
+is a secondary stack allocated from memory which cannot be directly modified by
+applications. When executing a CALL instruction, the processor pushes the
+return address to both the normal stack and the shadow stack. Upon
+function return, the processor pops the shadow stack copy and compares it
+to the normal stack copy. If the two differ, the processor raises a
+control-protection fault. IBT verifies indirect CALL/JMP targets are intended
+as marked by the compiler with 'ENDBR' opcodes. Not all CPU's have both Shadow
+Stack and Indirect Branch Tracking. Today in the 64-bit kernel, only userspace
+shadow stack and kernel IBT are supported.
+
+Requirements to use Shadow Stack
+================================
+
+To use userspace shadow stack you need HW that supports it, a kernel
+configured with it and userspace libraries compiled with it.
+
+The kernel Kconfig option is X86_USER_SHADOW_STACK.  When compiled in, shadow
+stacks can be disabled at runtime with the kernel parameter: nousershstk.
+
+To build a user shadow stack enabled kernel, Binutils v2.29 or LLVM v6 or later
+are required.
+
+At run time, /proc/cpuinfo shows CET features if the processor supports
+CET. "user_shstk" means that userspace shadow stack is supported on the current
+kernel and HW.
+
+Application Enabling
+====================
+
+An application's CET capability is marked in its ELF note and can be verified
+from readelf/llvm-readelf output::
+
+    readelf -n <application> | grep -a SHSTK
+        properties: x86 feature: SHSTK
+
+The kernel does not process these applications markers directly. Applications
+or loaders must enable CET features using the interface described in section 4.
+Typically this would be done in dynamic loader or static runtime objects, as is
+the case in GLIBC.
+
+Enabling arch_prctl()'s
+=======================
+
+Elf features should be enabled by the loader using the below arch_prctl's. They
+are only supported in 64 bit user applications. These operate on the features
+on a per-thread basis. The enablement status is inherited on clone, so if the
+feature is enabled on the first thread, it will propagate to all the thread's
+in an app.
+
+arch_prctl(ARCH_SHSTK_ENABLE, unsigned long feature)
+    Enable a single feature specified in 'feature'. Can only operate on
+    one feature at a time.
+
+arch_prctl(ARCH_SHSTK_DISABLE, unsigned long feature)
+    Disable a single feature specified in 'feature'. Can only operate on
+    one feature at a time.
+
+arch_prctl(ARCH_SHSTK_LOCK, unsigned long features)
+    Lock in features at their current enabled or disabled status. 'features'
+    is a mask of all features to lock. All bits set are processed, unset bits
+    are ignored. The mask is ORed with the existing value. So any feature bits
+    set here cannot be enabled or disabled afterwards.
+
+The return values are as follows. On success, return 0. On error, errno can
+be::
+
+        -EPERM if any of the passed feature are locked.
+        -ENOTSUPP if the feature is not supported by the hardware or
+         kernel.
+        -EINVAL arguments (non existing feature, etc)
+
+The feature's bits supported are::
+
+    ARCH_SHSTK_SHSTK - Shadow stack
+    ARCH_SHSTK_WRSS  - WRSS
+
+Currently shadow stack and WRSS are supported via this interface. WRSS
+can only be enabled with shadow stack, and is automatically disabled
+if shadow stack is disabled.
+
+Proc Status
+===========
+To check if an application is actually running with shadow stack, the
+user can read the /proc/$PID/status. It will report "wrss" or "shstk"
+depending on what is enabled. The lines look like this::
+
+    x86_Thread_features: shstk wrss
+    x86_Thread_features_locked: shstk wrss
+
+Implementation of the Shadow Stack
+==================================
+
+Shadow Stack Size
+-----------------
+
+A task's shadow stack is allocated from memory to a fixed size of
+MIN(RLIMIT_STACK, 4 GB). In other words, the shadow stack is allocated to
+the maximum size of the normal stack, but capped to 4 GB. In the case
+of the clone3 syscall, there is a stack size passed in and shadow stack
+uses this instead of the rlimit.
+
+Signal
+------
+
+The main program and its signal handlers use the same shadow stack. Because
+the shadow stack stores only return addresses, a large shadow stack covers
+the condition that both the program stack and the signal alternate stack run
+out.
+
+When a signal happens, the old pre-signal state is pushed on the stack. When
+shadow stack is enabled, the shadow stack specific state is pushed onto the
+shadow stack. Today this is only the old SSP (shadow stack pointer), pushed
+in a special format with bit 63 set. On sigreturn this old SSP token is
+verified and restored by the kernel. The kernel will also push the normal
+restorer address to the shadow stack to help userspace avoid a shadow stack
+violation on the sigreturn path that goes through the restorer.
+
+So the shadow stack signal frame format is as follows::
+
+    |1...old SSP| - Pointer to old pre-signal ssp in sigframe token format
+                    (bit 63 set to 1)
+    |        ...| - Other state may be added in the future
+
+
+32 bit ABI signals are not supported in shadow stack processes. Linux prevents
+32 bit execution while shadow stack is enabled by the allocating shadow stacks
+outside of the 32 bit address space. When execution enters 32 bit mode, either
+via far call or returning to userspace, a #GP is generated by the hardware
+which, will be delivered to the process as a segfault. When transitioning to
+userspace the register's state will be as if the userspace ip being returned to
+caused the segfault.
+
+Fork
+----
+
+The shadow stack's vma has VM_SHADOW_STACK flag set; its PTEs are required
+to be read-only and dirty. When a shadow stack PTE is not RO and dirty, a
+shadow access triggers a page fault with the shadow stack access bit set
+in the page fault error code.
+
+When a task forks a child, its shadow stack PTEs are copied and both the
+parent's and the child's shadow stack PTEs are cleared of the dirty bit.
+Upon the next shadow stack access, the resulting shadow stack page fault
+is handled by page copy/re-use.
+
+When a pthread child is created, the kernel allocates a new shadow stack
+for the new thread. New shadow stack creation behaves like mmap() with respect
+to ASLR behavior. Similarly, on thread exit the thread's shadow stack is
+disabled.
+
+Exec
+----
+
+On exec, shadow stack features are disabled by the kernel. At which point,
+userspace can choose to re-enable, or lock them.
