Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E72470B3B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 05:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjEVDPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 23:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEVDMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 23:12:37 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8127E118;
        Sun, 21 May 2023 20:12:33 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8Cxd+mg3WpkMswKAA--.18526S3;
        Mon, 22 May 2023 11:12:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxMMiR3WpkJIFuAA--.54000S32;
        Mon, 22 May 2023 11:12:30 +0800 (CST)
From:   Tianrui Zhao <zhaotianrui@loongson.cn>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>, zhaotianrui@loongson.cn
Subject: [PATCH v11 30/31] LoongArch: KVM: Supplement kvm document about LoongArch-specific part
Date:   Mon, 22 May 2023 11:12:16 +0800
Message-Id: <20230522031217.956464-31-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230522031217.956464-1-zhaotianrui@loongson.cn>
References: <20230522031217.956464-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxMMiR3WpkJIFuAA--.54000S32
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3AFyUuF4rtFW3Aw4UWFy5twb_yoW7Cw4DpF
        sxC3yfKr48try7J347J34jgFy3GFyxtFW7Ca4ftr1xG3Wjyw1kJrnFvrW8GFWUCry8AF18
        AFy0yw4UCFyUAw7anT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bx8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aV
        CY1x0267AKxVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaV
        Av8VWrMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWU
        tVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2z280aV
        CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0zRfuc_UUUUU=
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supplement kvm document about LoongArch-specific part, such as add
api introduction for GET/SET_ONE_REG, GET/SET_FPU, GET/SET_MP_STATE,
etc.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 Documentation/virt/kvm/api.rst | 71 +++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 9 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index add067793b90..ad8e13eab48d 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -416,6 +416,12 @@ Reads the general purpose registers from the vcpu.
 	__u64 pc;
   };
 
+  /* LoongArch */
+  struct kvm_regs {
+        unsigned long gpr[32];
+        unsigned long pc;
+  };
+
 
 4.12 KVM_SET_REGS
 -----------------
@@ -506,7 +512,7 @@ translation mode.
 ------------------
 
 :Capability: basic
-:Architectures: x86, ppc, mips, riscv
+:Architectures: x86, ppc, mips, riscv, loongarch
 :Type: vcpu ioctl
 :Parameters: struct kvm_interrupt (in)
 :Returns: 0 on success, negative on failure.
@@ -592,6 +598,14 @@ b) KVM_INTERRUPT_UNSET
 
 This is an asynchronous vcpu ioctl and can be invoked from any thread.
 
+LOONGARCH:
+^^^^^^^^^^
+
+Queues an external interrupt to be injected into the virtual CPU. A negative
+interrupt number dequeues the interrupt.
+
+This is an asynchronous vcpu ioctl and can be invoked from any thread.
+
 
 4.17 KVM_DEBUG_GUEST
 --------------------
@@ -737,7 +751,7 @@ signal mask.
 ----------------
 
 :Capability: basic
-:Architectures: x86
+:Architectures: x86, loongarch
 :Type: vcpu ioctl
 :Parameters: struct kvm_fpu (out)
 :Returns: 0 on success, -1 on error
@@ -746,7 +760,7 @@ Reads the floating point state from the vcpu.
 
 ::
 
-  /* for KVM_GET_FPU and KVM_SET_FPU */
+  /* x86: for KVM_GET_FPU and KVM_SET_FPU */
   struct kvm_fpu {
 	__u8  fpr[8][16];
 	__u16 fcw;
@@ -761,12 +775,22 @@ Reads the floating point state from the vcpu.
 	__u32 pad2;
   };
 
+  /* LoongArch: for KVM_GET_FPU and KVM_SET_FPU */
+  struct kvm_fpu {
+        __u32 fcsr;
+        __u32 none;
+        __u64 fcc;
+        struct kvm_fpureg {
+                __u64 val64[4];
+        }fpr[32];
+  };
+
 
 4.23 KVM_SET_FPU
 ----------------
 
 :Capability: basic
-:Architectures: x86
+:Architectures: x86, loongarch
 :Type: vcpu ioctl
 :Parameters: struct kvm_fpu (in)
 :Returns: 0 on success, -1 on error
@@ -775,7 +799,7 @@ Writes the floating point state to the vcpu.
 
 ::
 
-  /* for KVM_GET_FPU and KVM_SET_FPU */
+  /* x86: for KVM_GET_FPU and KVM_SET_FPU */
   struct kvm_fpu {
 	__u8  fpr[8][16];
 	__u16 fcw;
@@ -790,6 +814,16 @@ Writes the floating point state to the vcpu.
 	__u32 pad2;
   };
 
+  /* LoongArch: for KVM_GET_FPU and KVM_SET_FPU */
+  struct kvm_fpu {
+        __u32 fcsr;
+        __u32 none;
+        __u64 fcc;
+        struct kvm_fpureg {
+                __u64 val64[4];
+        }fpr[32];
+  };
+
 
 4.24 KVM_CREATE_IRQCHIP
 -----------------------
@@ -1387,7 +1421,7 @@ documentation when it pops into existence).
 -------------------
 
 :Capability: KVM_CAP_ENABLE_CAP
-:Architectures: mips, ppc, s390, x86
+:Architectures: mips, ppc, s390, x86, loongarch
 :Type: vcpu ioctl
 :Parameters: struct kvm_enable_cap (in)
 :Returns: 0 on success; -1 on error
@@ -1442,7 +1476,7 @@ for vm-wide capabilities.
 ---------------------
 
 :Capability: KVM_CAP_MP_STATE
-:Architectures: x86, s390, arm64, riscv
+:Architectures: x86, s390, arm64, riscv, loongarch
 :Type: vcpu ioctl
 :Parameters: struct kvm_mp_state (out)
 :Returns: 0 on success; -1 on error
@@ -1460,7 +1494,7 @@ Possible values are:
 
    ==========================    ===============================================
    KVM_MP_STATE_RUNNABLE         the vcpu is currently running
-                                 [x86,arm64,riscv]
+                                 [x86,arm64,riscv,loongarch]
    KVM_MP_STATE_UNINITIALIZED    the vcpu is an application processor (AP)
                                  which has not yet received an INIT signal [x86]
    KVM_MP_STATE_INIT_RECEIVED    the vcpu has received an INIT signal, and is
@@ -1516,11 +1550,14 @@ For riscv:
 The only states that are valid are KVM_MP_STATE_STOPPED and
 KVM_MP_STATE_RUNNABLE which reflect if the vcpu is paused or not.
 
+On LoongArch, only the KVM_MP_STATE_RUNNABLE state is used to reflect
+whether the vcpu is runnable.
+
 4.39 KVM_SET_MP_STATE
 ---------------------
 
 :Capability: KVM_CAP_MP_STATE
-:Architectures: x86, s390, arm64, riscv
+:Architectures: x86, s390, arm64, riscv, loongarch
 :Type: vcpu ioctl
 :Parameters: struct kvm_mp_state (in)
 :Returns: 0 on success; -1 on error
@@ -1538,6 +1575,9 @@ For arm64/riscv:
 The only states that are valid are KVM_MP_STATE_STOPPED and
 KVM_MP_STATE_RUNNABLE which reflect if the vcpu should be paused or not.
 
+On LoongArch, only the KVM_MP_STATE_RUNNABLE state is used to reflect
+whether the vcpu is runnable.
+
 4.40 KVM_SET_IDENTITY_MAP_ADDR
 ------------------------------
 
@@ -2839,6 +2879,19 @@ Following are the RISC-V D-extension registers:
   0x8020 0000 0600 0020 fcsr      Floating point control and status register
 ======================= ========= =============================================
 
+LoongArch registers are mapped using the lower 32 bits. The upper 16 bits of
+that is the register group type.
+
+LoongArch csr registers are used to control guest cpu or get status of guest
+cpu, and they have the following id bit patterns::
+
+  0x9030 0000 0001 00 <reg:5> <sel:3>   (64-bit)
+
+LoongArch KVM control registers are used to implement some new defined functions
+such as set vcpu counter or reset vcpu, and they have the following id bit patterns::
+
+  0x9030 0000 0002 <reg:16>
+
 
 4.69 KVM_GET_ONE_REG
 --------------------
-- 
2.39.1

