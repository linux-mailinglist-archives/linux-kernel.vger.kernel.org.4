Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9086CBF2A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjC1McF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjC1Mbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:31:46 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76A3D9ED8;
        Tue, 28 Mar 2023 05:31:23 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8Axrtoa3iJk3xgTAA--.17582S3;
        Tue, 28 Mar 2023 20:31:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxPL4X3iJku2cPAA--.12046S7;
        Tue, 28 Mar 2023 20:31:21 +0800 (CST)
From:   Tianrui Zhao <zhaotianrui@loongson.cn>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>, zhaotianrui@loongson.cn
Subject: [PING PATCH v4 05/29] LoongArch: KVM: Add vcpu related header files
Date:   Tue, 28 Mar 2023 20:30:55 +0800
Message-Id: <20230328123119.3649361-6-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230328123119.3649361-1-zhaotianrui@loongson.cn>
References: <20230328123119.3649361-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxPL4X3iJku2cPAA--.12046S7
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvAXoWfCF4xGr4kCF43CFy8JF17Awb_yoW5JFyDZo
        W3Ja13G3Z5Jw4Iya1q9a47XayDZr9YkFs8Zr1YyryrZ34DJrn8Ww47tayrXr13Xryqg343
        CF92gan5CF9YyryDn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUkl1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64
        kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY
        1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6x
        kF7I0E14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6c
        x26rWlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r12
        6r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7xRiTKZJUUUUU==
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LoongArch vcpu related header files, including vcpu csr
information, irq number defines, and some vcpu interfaces.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 arch/loongarch/include/asm/cpu-info.h  |  13 ++
 arch/loongarch/include/asm/kvm_vcpu.h  | 114 ++++++++++++++
 arch/loongarch/include/asm/loongarch.h | 209 ++++++++++++++++++++++++-
 arch/loongarch/kvm/trace.h             | 169 ++++++++++++++++++++
 4 files changed, 499 insertions(+), 6 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kvm_vcpu.h
 create mode 100644 arch/loongarch/kvm/trace.h

diff --git a/arch/loongarch/include/asm/cpu-info.h b/arch/loongarch/include/asm/cpu-info.h
index cd73a6f57..1b426a2ca 100644
--- a/arch/loongarch/include/asm/cpu-info.h
+++ b/arch/loongarch/include/asm/cpu-info.h
@@ -32,6 +32,15 @@ struct cache_desc {
 #define CACHE_LEVEL_MAX		3
 #define CACHE_LEAVES_MAX	6
 
+struct guest_info {
+	unsigned long		ases;
+	unsigned long		ases_dyn;
+	unsigned long		options;
+	unsigned long		options_dyn;
+	unsigned char		conf;
+	unsigned int		kscratch_mask;
+};
+
 struct cpuinfo_loongarch {
 	u64			asid_cache;
 	unsigned long		asid_mask;
@@ -60,6 +69,10 @@ struct cpuinfo_loongarch {
 	unsigned int		watch_dreg_count;   /* Number data breakpoints */
 	unsigned int		watch_ireg_count;   /* Number instruction breakpoints */
 	unsigned int		watch_reg_use_cnt; /* min(NUM_WATCH_REGS, watch_dreg_count + watch_ireg_count), Usable by ptrace */
+
+	/* VZ & Guest features */
+	struct guest_info	guest;
+	unsigned long		guest_cfg;
 } __aligned(SMP_CACHE_BYTES);
 
 extern struct cpuinfo_loongarch cpu_data[];
diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
new file mode 100644
index 000000000..5a53cfcb3
--- /dev/null
+++ b/arch/loongarch/include/asm/kvm_vcpu.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef __ASM_LOONGARCH_KVM_VCPU_H__
+#define __ASM_LOONGARCH_KVM_VCPU_H__
+
+#include <linux/kvm_host.h>
+#include <asm/loongarch.h>
+#include <asm/kvm_host.h>
+
+#define LARCH_INT_SIP0			(EXCCODE_SIP0  - EXCCODE_INT_START)
+#define LARCH_INT_SIP1			(EXCCODE_SIP1  - EXCCODE_INT_START)
+#define LARCH_INT_IP0			(EXCCODE_IP0   - EXCCODE_INT_START)
+#define LARCH_INT_IP1			(EXCCODE_IP1   - EXCCODE_INT_START)
+#define LARCH_INT_IP2			(EXCCODE_IP2   - EXCCODE_INT_START)
+#define LARCH_INT_IP3			(EXCCODE_IP3   - EXCCODE_INT_START)
+#define LARCH_INT_IP4			(EXCCODE_IP4   - EXCCODE_INT_START)
+#define LARCH_INT_IP5			(EXCCODE_IP5   - EXCCODE_INT_START)
+#define LARCH_INT_IP6			(EXCCODE_IP6   - EXCCODE_INT_START)
+#define LARCH_INT_IP7			(EXCCODE_IP7   - EXCCODE_INT_START)
+#define LARCH_INT_PMU			(EXCCODE_PMC   - EXCCODE_INT_START)
+#define LARCH_INT_TIMER			(EXCCODE_TIMER - EXCCODE_INT_START)
+#define LARCH_INT_IPI			(EXCCODE_IPI   - EXCCODE_INT_START)
+#define LOONGARCH_EXC_MAX		(LARCH_INT_IPI + 1)
+#define LOONGARCH_EXC_IPNUM		(LOONGARCH_EXC_MAX)
+
+/* Controlled by 0x5 guest exst */
+#define CPU_SIP0			(_ULCAST_(1))
+#define CPU_SIP1			(_ULCAST_(1) << 1)
+#define CPU_PMU				(_ULCAST_(1) << 10)
+#define CPU_TIMER			(_ULCAST_(1) << 11)
+#define CPU_IPI				(_ULCAST_(1) << 12)
+
+/* Controlled by 0x52 guest exception VIP
+ * aligned to exst bit 5~12
+ */
+#define CPU_IP0				(_ULCAST_(1))
+#define CPU_IP1				(_ULCAST_(1) << 1)
+#define CPU_IP2				(_ULCAST_(1) << 2)
+#define CPU_IP3				(_ULCAST_(1) << 3)
+#define CPU_IP4				(_ULCAST_(1) << 4)
+#define CPU_IP5				(_ULCAST_(1) << 5)
+#define CPU_IP6				(_ULCAST_(1) << 6)
+#define CPU_IP7				(_ULCAST_(1) << 7)
+
+#define MNSEC_PER_SEC			(NSEC_PER_SEC >> 20)
+
+/* KVM_IRQ_LINE irq field index values */
+#define KVM_LOONGSON_IRQ_TYPE_SHIFT	24
+#define KVM_LOONGSON_IRQ_TYPE_MASK	0xff
+#define KVM_LOONGSON_IRQ_VCPU_SHIFT	16
+#define KVM_LOONGSON_IRQ_VCPU_MASK	0xff
+#define KVM_LOONGSON_IRQ_NUM_SHIFT	0
+#define KVM_LOONGSON_IRQ_NUM_MASK	0xffff
+
+/* irq_type field */
+#define KVM_LOONGSON_IRQ_TYPE_CPU_IP	0
+#define KVM_LOONGSON_IRQ_TYPE_CPU_IO	1
+#define KVM_LOONGSON_IRQ_TYPE_HT	2
+#define KVM_LOONGSON_IRQ_TYPE_MSI	3
+#define KVM_LOONGSON_IRQ_TYPE_IOAPIC	4
+#define KVM_LOONGSON_IRQ_TYPE_ROUTE	5
+
+/* out-of-kernel GIC cpu interrupt injection irq_number field */
+#define KVM_LOONGSON_IRQ_CPU_IRQ	0
+#define KVM_LOONGSON_IRQ_CPU_FIQ	1
+#define KVM_LOONGSON_CPU_IP_NUM		8
+
+typedef union loongarch_instruction  larch_inst;
+typedef int (*exit_handle_fn)(struct kvm_vcpu *);
+
+int  _kvm_emu_mmio_write(struct kvm_vcpu *vcpu, larch_inst inst);
+int  _kvm_emu_mmio_read(struct kvm_vcpu *vcpu, larch_inst inst);
+int  _kvm_complete_mmio_read(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int  _kvm_complete_iocsr_read(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int  _kvm_emu_idle(struct kvm_vcpu *vcpu);
+int  _kvm_handle_pv_hcall(struct kvm_vcpu *vcpu);
+int  _kvm_pending_timer(struct kvm_vcpu *vcpu);
+int  _kvm_handle_fault(struct kvm_vcpu *vcpu, int fault);
+void _kvm_deliver_intr(struct kvm_vcpu *vcpu);
+
+void kvm_own_fpu(struct kvm_vcpu *vcpu);
+void kvm_lose_fpu(struct kvm_vcpu *vcpu);
+void kvm_save_fpu(struct loongarch_fpu *fpu);
+void kvm_restore_fpu(struct loongarch_fpu *fpu);
+void kvm_restore_fcsr(struct loongarch_fpu *fpu);
+
+void kvm_acquire_timer(struct kvm_vcpu *vcpu);
+void kvm_reset_timer(struct kvm_vcpu *vcpu);
+enum hrtimer_restart kvm_count_timeout(struct kvm_vcpu *vcpu);
+void kvm_init_timer(struct kvm_vcpu *vcpu, unsigned long hz);
+void kvm_restore_timer(struct kvm_vcpu *vcpu);
+void kvm_save_timer(struct kvm_vcpu *vcpu);
+
+int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
+			struct kvm_loongarch_interrupt *irq);
+/*
+ * Loongarch KVM guest interrupt handling.
+ */
+static inline void _kvm_queue_irq(struct kvm_vcpu *vcpu, unsigned int irq)
+{
+	set_bit(irq, &vcpu->arch.irq_pending);
+	clear_bit(irq, &vcpu->arch.irq_clear);
+}
+
+static inline void _kvm_dequeue_irq(struct kvm_vcpu *vcpu, unsigned int irq)
+{
+	clear_bit(irq, &vcpu->arch.irq_pending);
+	set_bit(irq, &vcpu->arch.irq_clear);
+}
+
+#endif /* __ASM_LOONGARCH_KVM_VCPU_H__ */
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 65b7dcdea..aa8e14acd 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -236,6 +236,58 @@ static __always_inline u64 csr_xchg64(u64 val, u64 mask, u32 reg)
 	return __csrxchg_d(val, mask, reg);
 }
 
+/* GCSR */
+static inline u64 gcsr_read(u32 reg)
+{
+	u64 val = 0;
+	/* Instructions will be available in binutils later */
+	asm volatile (
+		"parse_r __reg, %[val]\n\t"
+		/*
+		 * read val from guest csr register %[reg]
+		 * gcsrrd %[val], %[reg]
+		 */
+		".word 0x5 << 24 | %[reg] << 10 | 0 << 5 | __reg\n\t"
+		: [val] "+r" (val)
+		: [reg] "i" (reg)
+		: "memory");
+
+	return val;
+}
+
+static inline void gcsr_write(u64 val, u32 reg)
+{
+	/* Instructions will be available in binutils later */
+	asm volatile (
+		"parse_r __reg, %[val]\n\t"
+		/*
+		 * write val to guest csr register %[reg]
+		 * gcsrwr %[val], %[reg]
+		 */
+		".word 0x5 << 24 | %[reg] << 10 | 1 << 5 | __reg\n\t"
+		: [val] "+r" (val)
+		: [reg] "i" (reg)
+		: "memory");
+}
+
+static inline u64 gcsr_xchg(u64 val, u64 mask, u32 reg)
+{
+	/* Instructions will be available in binutils later */
+	asm volatile (
+		"parse_r __rd, %[val]\n\t"
+		"parse_r __rj, %[mask]\n\t"
+		/*
+		 * replace masked bits of guest csr register %[reg] with val
+		 * gcsrxchg %[val], %[mask], %[reg]
+		 */
+		".word 0x5 << 24 | %[reg] << 10 | __rj << 5 | __rd\n\t"
+		: [val] "+r" (val)
+		: [mask] "r" (mask), [reg] "i" (reg)
+		: "memory");
+
+	return val;
+}
+
 /* IOCSR */
 static __always_inline u32 iocsr_read32(u32 reg)
 {
@@ -309,6 +361,7 @@ static __always_inline void iocsr_write64(u64 val, u32 reg)
 #define LOONGARCH_CSR_ECFG		0x4	/* Exception config */
 #define  CSR_ECFG_VS_SHIFT		16
 #define  CSR_ECFG_VS_WIDTH		3
+#define  CSR_ECFG_VS_SHIFT_END		(CSR_ECFG_VS_SHIFT + CSR_ECFG_VS_WIDTH - 1)
 #define  CSR_ECFG_VS			(_ULCAST_(0x7) << CSR_ECFG_VS_SHIFT)
 #define  CSR_ECFG_IM_SHIFT		0
 #define  CSR_ECFG_IM_WIDTH		13
@@ -397,13 +450,14 @@ static __always_inline void iocsr_write64(u64 val, u32 reg)
 #define  CSR_TLBLO1_V			(_ULCAST_(0x1) << CSR_TLBLO1_V_SHIFT)
 
 #define LOONGARCH_CSR_GTLBC		0x15	/* Guest TLB control */
-#define  CSR_GTLBC_RID_SHIFT		16
-#define  CSR_GTLBC_RID_WIDTH		8
-#define  CSR_GTLBC_RID			(_ULCAST_(0xff) << CSR_GTLBC_RID_SHIFT)
+#define  CSR_GTLBC_TGID_SHIFT		16
+#define  CSR_GTLBC_TGID_WIDTH		8
+#define  CSR_GTLBC_TGID_SHIFT_END	(CSR_GTLBC_TGID_SHIFT + CSR_GTLBC_TGID_WIDTH - 1)
+#define  CSR_GTLBC_TGID			(_ULCAST_(0xff) << CSR_GTLBC_TGID_SHIFT)
 #define  CSR_GTLBC_TOTI_SHIFT		13
 #define  CSR_GTLBC_TOTI			(_ULCAST_(0x1) << CSR_GTLBC_TOTI_SHIFT)
-#define  CSR_GTLBC_USERID_SHIFT		12
-#define  CSR_GTLBC_USERID		(_ULCAST_(0x1) << CSR_GTLBC_USERID_SHIFT)
+#define  CSR_GTLBC_USETGID_SHIFT	12
+#define  CSR_GTLBC_USETGID		(_ULCAST_(0x1) << CSR_GTLBC_USETGID_SHIFT)
 #define  CSR_GTLBC_GMTLBSZ_SHIFT	0
 #define  CSR_GTLBC_GMTLBSZ_WIDTH	6
 #define  CSR_GTLBC_GMTLBSZ		(_ULCAST_(0x3f) << CSR_GTLBC_GMTLBSZ_SHIFT)
@@ -555,6 +609,7 @@ static __always_inline void iocsr_write64(u64 val, u32 reg)
 #define LOONGARCH_CSR_GSTAT		0x50	/* Guest status */
 #define  CSR_GSTAT_GID_SHIFT		16
 #define  CSR_GSTAT_GID_WIDTH		8
+#define  CSR_GSTAT_GID_SHIFT_END	(CSR_GSTAT_GID_SHIFT + CSR_GSTAT_GID_WIDTH - 1)
 #define  CSR_GSTAT_GID			(_ULCAST_(0xff) << CSR_GSTAT_GID_SHIFT)
 #define  CSR_GSTAT_GIDBIT_SHIFT		4
 #define  CSR_GSTAT_GIDBIT_WIDTH		6
@@ -605,6 +660,12 @@ static __always_inline void iocsr_write64(u64 val, u32 reg)
 #define  CSR_GCFG_MATC_GUEST		(_ULCAST_(0x0) << CSR_GCFG_MATC_SHITF)
 #define  CSR_GCFG_MATC_ROOT		(_ULCAST_(0x1) << CSR_GCFG_MATC_SHITF)
 #define  CSR_GCFG_MATC_NEST		(_ULCAST_(0x2) << CSR_GCFG_MATC_SHITF)
+#define  CSR_GCFG_MATP_SHITF		0
+#define  CSR_GCFG_MATP_WIDTH		4
+#define  CSR_GCFG_MATP_MASK		(_ULCAST_(0x3) << CSR_GCFG_MATP_SHITF)
+#define  CSR_GCFG_MATP_GUEST		(_ULCAST_(0x0) << CSR_GCFG_MATP_SHITF)
+#define  CSR_GCFG_MATP_ROOT		(_ULCAST_(0x1) << CSR_GCFG_MATP_SHITF)
+#define  CSR_GCFG_MATP_NEST		(_ULCAST_(0x2) << CSR_GCFG_MATP_SHITF)
 
 #define LOONGARCH_CSR_GINTC		0x52	/* Guest interrupt control */
 #define  CSR_GINTC_HC_SHIFT		16
@@ -1276,6 +1337,131 @@ static inline void write_csr_tlbrefill_pagesize(unsigned int size)
 #define write_csr_perfctrl3(val)	csr_write64(val, LOONGARCH_CSR_PERFCTRL3)
 #define write_csr_perfcntr3(val)	csr_write64(val, LOONGARCH_CSR_PERFCNTR3)
 
+/* Guest related CSRS */
+#define read_csr_gtlbc()		csr_read64(LOONGARCH_CSR_GTLBC)
+#define write_csr_gtlbc(val)		csr_write64(val, LOONGARCH_CSR_GTLBC)
+#define read_csr_trgp()			csr_read64(LOONGARCH_CSR_TRGP)
+#define read_csr_gcfg()			csr_read64(LOONGARCH_CSR_GCFG)
+#define write_csr_gcfg(val)		csr_write64(val, LOONGARCH_CSR_GCFG)
+#define read_csr_gstat()		csr_read64(LOONGARCH_CSR_GSTAT)
+#define write_csr_gstat(val)		csr_write64(val, LOONGARCH_CSR_GSTAT)
+#define read_csr_gintc()		csr_read64(LOONGARCH_CSR_GINTC)
+#define write_csr_gintc(val)		csr_write64(val, LOONGARCH_CSR_GINTC)
+#define read_csr_gcntc()		csr_read64(LOONGARCH_CSR_GCNTC)
+#define write_csr_gcntc(val)		csr_write64(val, LOONGARCH_CSR_GCNTC)
+
+/* Guest CSRS read and write */
+#define read_gcsr_crmd()		gcsr_read(LOONGARCH_CSR_CRMD)
+#define write_gcsr_crmd(val)		gcsr_write(val, LOONGARCH_CSR_CRMD)
+#define read_gcsr_prmd()		gcsr_read(LOONGARCH_CSR_PRMD)
+#define write_gcsr_prmd(val)		gcsr_write(val, LOONGARCH_CSR_PRMD)
+#define read_gcsr_euen()		gcsr_read(LOONGARCH_CSR_EUEN)
+#define write_gcsr_euen(val)		gcsr_write(val, LOONGARCH_CSR_EUEN)
+#define read_gcsr_misc()		gcsr_read(LOONGARCH_CSR_MISC)
+#define write_gcsr_misc(val)		gcsr_write(val, LOONGARCH_CSR_MISC)
+#define read_gcsr_ecfg()		gcsr_read(LOONGARCH_CSR_ECFG)
+#define write_gcsr_ecfg(val)		gcsr_write(val, LOONGARCH_CSR_ECFG)
+#define read_gcsr_estat()		gcsr_read(LOONGARCH_CSR_ESTAT)
+#define write_gcsr_estat(val)		gcsr_write(val, LOONGARCH_CSR_ESTAT)
+#define read_gcsr_era()			gcsr_read(LOONGARCH_CSR_ERA)
+#define write_gcsr_era(val)		gcsr_write(val, LOONGARCH_CSR_ERA)
+#define read_gcsr_badv()		gcsr_read(LOONGARCH_CSR_BADV)
+#define write_gcsr_badv(val)		gcsr_write(val, LOONGARCH_CSR_BADV)
+#define read_gcsr_badi()		gcsr_read(LOONGARCH_CSR_BADI)
+#define write_gcsr_badi(val)		gcsr_write(val, LOONGARCH_CSR_BADI)
+#define read_gcsr_eentry()		gcsr_read(LOONGARCH_CSR_EENTRY)
+#define write_gcsr_eentry(val)		gcsr_write(val, LOONGARCH_CSR_EENTRY)
+
+#define read_gcsr_tlbidx()		gcsr_read(LOONGARCH_CSR_TLBIDX)
+#define write_gcsr_tlbidx(val)		gcsr_write(val, LOONGARCH_CSR_TLBIDX)
+#define read_gcsr_tlbhi()		gcsr_read(LOONGARCH_CSR_TLBEHI)
+#define write_gcsr_tlbhi(val)		gcsr_write(val, LOONGARCH_CSR_TLBEHI)
+#define read_gcsr_tlblo0()		gcsr_read(LOONGARCH_CSR_TLBELO0)
+#define write_gcsr_tlblo0(val)		gcsr_write(val, LOONGARCH_CSR_TLBELO0)
+#define read_gcsr_tlblo1()		gcsr_read(LOONGARCH_CSR_TLBELO1)
+#define write_gcsr_tlblo1(val)		gcsr_write(val, LOONGARCH_CSR_TLBELO1)
+
+#define read_gcsr_asid()		gcsr_read(LOONGARCH_CSR_ASID)
+#define write_gcsr_asid(val)		gcsr_write(val, LOONGARCH_CSR_ASID)
+#define read_gcsr_pgdl()		gcsr_read(LOONGARCH_CSR_PGDL)
+#define write_gcsr_pgdl(val)		gcsr_write(val, LOONGARCH_CSR_PGDL)
+#define read_gcsr_pgdh()		gcsr_read(LOONGARCH_CSR_PGDH)
+#define write_gcsr_pgdh(val)		gcsr_write(val, LOONGARCH_CSR_PGDH)
+#define write_gcsr_pgd(val)		gcsr_write(val, LOONGARCH_CSR_PGD)
+#define read_gcsr_pgd()			gcsr_read(LOONGARCH_CSR_PGD)
+#define read_gcsr_pwctl0()		gcsr_read(LOONGARCH_CSR_PWCTL0)
+#define write_gcsr_pwctl0(val)		gcsr_write(val, LOONGARCH_CSR_PWCTL0)
+#define read_gcsr_pwctl1()		gcsr_read(LOONGARCH_CSR_PWCTL1)
+#define write_gcsr_pwctl1(val)		gcsr_write(val, LOONGARCH_CSR_PWCTL1)
+#define read_gcsr_stlbpgsize()		gcsr_read(LOONGARCH_CSR_STLBPGSIZE)
+#define write_gcsr_stlbpgsize(val)	gcsr_write(val, LOONGARCH_CSR_STLBPGSIZE)
+#define read_gcsr_rvacfg()		gcsr_read(LOONGARCH_CSR_RVACFG)
+#define write_gcsr_rvacfg(val)		gcsr_write(val, LOONGARCH_CSR_RVACFG)
+
+#define read_gcsr_cpuid()		gcsr_read(LOONGARCH_CSR_CPUID)
+#define write_gcsr_cpuid(val)		gcsr_write(val, LOONGARCH_CSR_CPUID)
+#define read_gcsr_prcfg1()		gcsr_read(LOONGARCH_CSR_PRCFG1)
+#define write_gcsr_prcfg1(val)		gcsr_write(val, LOONGARCH_CSR_PRCFG1)
+#define read_gcsr_prcfg2()		gcsr_read(LOONGARCH_CSR_PRCFG2)
+#define write_gcsr_prcfg2(val)		gcsr_write(val, LOONGARCH_CSR_PRCFG2)
+#define read_gcsr_prcfg3()		gcsr_read(LOONGARCH_CSR_PRCFG3)
+#define write_gcsr_prcfg3(val)		gcsr_write(val, LOONGARCH_CSR_PRCFG3)
+
+#define read_gcsr_kscratch0()		gcsr_read(LOONGARCH_CSR_KS0)
+#define write_gcsr_kscratch0(val)	gcsr_write(val, LOONGARCH_CSR_KS0)
+#define read_gcsr_kscratch1()		gcsr_read(LOONGARCH_CSR_KS1)
+#define write_gcsr_kscratch1(val)	gcsr_write(val, LOONGARCH_CSR_KS1)
+#define read_gcsr_kscratch2()		gcsr_read(LOONGARCH_CSR_KS2)
+#define write_gcsr_kscratch2(val)	gcsr_write(val, LOONGARCH_CSR_KS2)
+#define read_gcsr_kscratch3()		gcsr_read(LOONGARCH_CSR_KS3)
+#define write_gcsr_kscratch3(val)	gcsr_write(val, LOONGARCH_CSR_KS3)
+#define read_gcsr_kscratch4()		gcsr_read(LOONGARCH_CSR_KS4)
+#define write_gcsr_kscratch4(val)	gcsr_write(val, LOONGARCH_CSR_KS4)
+#define read_gcsr_kscratch5()		gcsr_read(LOONGARCH_CSR_KS5)
+#define write_gcsr_kscratch5(val)	gcsr_write(val, LOONGARCH_CSR_KS5)
+#define read_gcsr_kscratch6()		gcsr_read(LOONGARCH_CSR_KS6)
+#define write_gcsr_kscratch6(val)	gcsr_write(val, LOONGARCH_CSR_KS6)
+#define read_gcsr_kscratch7()		gcsr_read(LOONGARCH_CSR_KS7)
+#define write_gcsr_kscratch7(val)	gcsr_write(val, LOONGARCH_CSR_KS7)
+
+#define read_gcsr_timerid()		gcsr_read(LOONGARCH_CSR_TMID)
+#define write_gcsr_timerid(val)		gcsr_write(val, LOONGARCH_CSR_TMID)
+#define read_gcsr_timercfg()		gcsr_read(LOONGARCH_CSR_TCFG)
+#define write_gcsr_timercfg(val)	gcsr_write(val, LOONGARCH_CSR_TCFG)
+#define read_gcsr_timertick()		gcsr_read(LOONGARCH_CSR_TVAL)
+#define write_gcsr_timertick(val)	gcsr_write(val, LOONGARCH_CSR_TVAL)
+#define read_gcsr_timeroffset()		gcsr_read(LOONGARCH_CSR_CNTC)
+#define write_gcsr_timeroffset(val)	gcsr_write(val, LOONGARCH_CSR_CNTC)
+
+#define read_gcsr_llbctl()		gcsr_read(LOONGARCH_CSR_LLBCTL)
+#define write_gcsr_llbctl(val)		gcsr_write(val, LOONGARCH_CSR_LLBCTL)
+
+#define read_gcsr_tlbrentry()		gcsr_read(LOONGARCH_CSR_TLBRENTRY)
+#define write_gcsr_tlbrentry(val)	gcsr_write(val, LOONGARCH_CSR_TLBRENTRY)
+#define read_gcsr_tlbrbadv()		gcsr_read(LOONGARCH_CSR_TLBRBADV)
+#define write_gcsr_tlbrbadv(val)	gcsr_write(val, LOONGARCH_CSR_TLBRBADV)
+#define read_gcsr_tlbrera()		gcsr_read(LOONGARCH_CSR_TLBRERA)
+#define write_gcsr_tlbrera(val)		gcsr_write(val, LOONGARCH_CSR_TLBRERA)
+#define read_gcsr_tlbrsave()		gcsr_read(LOONGARCH_CSR_TLBRSAVE)
+#define write_gcsr_tlbrsave(val)	gcsr_write(val, LOONGARCH_CSR_TLBRSAVE)
+#define read_gcsr_tlbrelo0()		gcsr_read(LOONGARCH_CSR_TLBRELO0)
+#define write_gcsr_tlbrelo0(val)	gcsr_write(val, LOONGARCH_CSR_TLBRELO0)
+#define read_gcsr_tlbrelo1()		gcsr_read(LOONGARCH_CSR_TLBRELO1)
+#define write_gcsr_tlbrelo1(val)	gcsr_write(val, LOONGARCH_CSR_TLBRELO1)
+#define read_gcsr_tlbrehi()		gcsr_read(LOONGARCH_CSR_TLBREHI)
+#define write_gcsr_tlbrehi(val)		gcsr_write(val, LOONGARCH_CSR_TLBREHI)
+#define read_gcsr_tlbrprmd()		gcsr_read(LOONGARCH_CSR_TLBRPRMD)
+#define write_gcsr_tlbrprmd(val)	gcsr_write(val, LOONGARCH_CSR_TLBRPRMD)
+
+#define read_gcsr_directwin0()		gcsr_read(LOONGARCH_CSR_DMWIN0)
+#define write_gcsr_directwin0(val)	gcsr_write(val, LOONGARCH_CSR_DMWIN0)
+#define read_gcsr_directwin1()		gcsr_read(LOONGARCH_CSR_DMWIN1)
+#define write_gcsr_directwin1(val)	gcsr_write(val, LOONGARCH_CSR_DMWIN1)
+#define read_gcsr_directwin2()		gcsr_read(LOONGARCH_CSR_DMWIN2)
+#define write_gcsr_directwin2(val)	gcsr_write(val, LOONGARCH_CSR_DMWIN2)
+#define read_gcsr_directwin3()		gcsr_read(LOONGARCH_CSR_DMWIN3)
+#define write_gcsr_directwin3(val)	gcsr_write(val, LOONGARCH_CSR_DMWIN3)
+
 /*
  * Manipulate bits in a register.
  */
@@ -1318,15 +1504,26 @@ change_##name(unsigned long change, unsigned long val)		\
 }
 
 #define __BUILD_CSR_OP(name)	__BUILD_CSR_COMMON(csr_##name)
+#define __BUILD_GCSR_OP(name)	__BUILD_CSR_COMMON(gcsr_##name)
 
 __BUILD_CSR_OP(euen)
 __BUILD_CSR_OP(ecfg)
 __BUILD_CSR_OP(tlbidx)
+__BUILD_CSR_OP(gcfg)
+__BUILD_CSR_OP(gstat)
+__BUILD_CSR_OP(gtlbc)
+__BUILD_CSR_OP(gintc)
+__BUILD_GCSR_OP(llbctl)
+__BUILD_GCSR_OP(tlbidx)
 
 #define set_csr_estat(val)	\
 	csr_xchg32(val, val, LOONGARCH_CSR_ESTAT)
 #define clear_csr_estat(val)	\
 	csr_xchg32(~(val), val, LOONGARCH_CSR_ESTAT)
+#define set_gcsr_estat(val)	\
+	gcsr_xchg(val, val, LOONGARCH_CSR_ESTAT)
+#define clear_gcsr_estat(val)	\
+	gcsr_xchg(~(val), val, LOONGARCH_CSR_ESTAT)
 
 #endif /* __ASSEMBLY__ */
 
@@ -1411,7 +1608,7 @@ __BUILD_CSR_OP(tlbidx)
 #define EXCCODE_WATCH		19	/* Watch address reference */
 #define EXCCODE_BTDIS		20	/* Binary Trans. Disabled */
 #define EXCCODE_BTE		21	/* Binary Trans. Exception */
-#define EXCCODE_PSI		22	/* Guest Privileged Error */
+#define EXCCODE_GSPR		22	/* Guest Privileged Error */
 #define EXCCODE_HYP		23	/* Hypercall */
 #define EXCCODE_GCM		24	/* Guest CSR modified */
 	#define EXCSUBCODE_GCSC		0	/* Software caused */
diff --git a/arch/loongarch/kvm/trace.h b/arch/loongarch/kvm/trace.h
new file mode 100644
index 000000000..0fbe70024
--- /dev/null
+++ b/arch/loongarch/kvm/trace.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+#if !defined(_TRACE_KVM_H)
+#define _TRACE_KVM_H
+
+#include <linux/tracepoint.h>
+#include <asm/kvm_csr.h>
+
+#undef	TRACE_SYSTEM
+#define TRACE_SYSTEM		kvm
+#define TRACE_INCLUDE_PATH	.
+#define TRACE_INCLUDE_FILE	trace
+
+/*
+ * Tracepoints for VM enters
+ */
+DECLARE_EVENT_CLASS(kvm_transition,
+	TP_PROTO(struct kvm_vcpu *vcpu),
+	TP_ARGS(vcpu),
+	TP_STRUCT__entry(
+		__field(unsigned long, pc)
+	),
+
+	TP_fast_assign(
+		__entry->pc = vcpu->arch.pc;
+	),
+
+	TP_printk("PC: 0x%08lx",
+		  __entry->pc)
+);
+
+DEFINE_EVENT(kvm_transition, kvm_enter,
+	     TP_PROTO(struct kvm_vcpu *vcpu),
+	     TP_ARGS(vcpu));
+
+DEFINE_EVENT(kvm_transition, kvm_reenter,
+	     TP_PROTO(struct kvm_vcpu *vcpu),
+	     TP_ARGS(vcpu));
+
+DEFINE_EVENT(kvm_transition, kvm_out,
+	     TP_PROTO(struct kvm_vcpu *vcpu),
+	     TP_ARGS(vcpu));
+
+/* Further exit reasons */
+#define KVM_TRACE_EXIT_IDLE		64
+#define KVM_TRACE_EXIT_CACHE		65
+#define KVM_TRACE_EXIT_SIGNAL		66
+
+/* Tracepoints for VM exits */
+#define kvm_trace_symbol_exit_types			\
+	{ KVM_TRACE_EXIT_IDLE,		"IDLE" },	\
+	{ KVM_TRACE_EXIT_CACHE,		"CACHE" },	\
+	{ KVM_TRACE_EXIT_SIGNAL,	"Signal" }
+
+TRACE_EVENT(kvm_exit_gspr,
+	    TP_PROTO(struct kvm_vcpu *vcpu, unsigned int inst_word),
+	    TP_ARGS(vcpu, inst_word),
+	    TP_STRUCT__entry(
+			__field(unsigned int, inst_word)
+	    ),
+
+	    TP_fast_assign(
+			__entry->inst_word = inst_word;
+	    ),
+
+	    TP_printk("inst word: 0x%08x",
+		      __entry->inst_word)
+);
+
+
+DECLARE_EVENT_CLASS(kvm_exit,
+	    TP_PROTO(struct kvm_vcpu *vcpu, unsigned int reason),
+	    TP_ARGS(vcpu, reason),
+	    TP_STRUCT__entry(
+			__field(unsigned long, pc)
+			__field(unsigned int, reason)
+	    ),
+
+	    TP_fast_assign(
+			__entry->pc = vcpu->arch.pc;
+			__entry->reason = reason;
+	    ),
+
+	    TP_printk("[%s]PC: 0x%08lx",
+		      __print_symbolic(__entry->reason,
+				       kvm_trace_symbol_exit_types),
+		      __entry->pc)
+);
+
+DEFINE_EVENT(kvm_exit, kvm_exit_idle,
+	     TP_PROTO(struct kvm_vcpu *vcpu, unsigned int reason),
+	     TP_ARGS(vcpu, reason));
+
+DEFINE_EVENT(kvm_exit, kvm_exit_cache,
+	     TP_PROTO(struct kvm_vcpu *vcpu, unsigned int reason),
+	     TP_ARGS(vcpu, reason));
+
+DEFINE_EVENT(kvm_exit, kvm_exit_signal,
+	     TP_PROTO(struct kvm_vcpu *vcpu, unsigned int reason),
+	     TP_ARGS(vcpu, reason));
+
+DEFINE_EVENT(kvm_exit, kvm_exit,
+	     TP_PROTO(struct kvm_vcpu *vcpu, unsigned int reason),
+	     TP_ARGS(vcpu, reason));
+
+#define KVM_TRACE_AUX_RESTORE		0
+#define KVM_TRACE_AUX_SAVE		1
+#define KVM_TRACE_AUX_ENABLE		2
+#define KVM_TRACE_AUX_DISABLE		3
+#define KVM_TRACE_AUX_DISCARD		4
+
+#define KVM_TRACE_AUX_FPU		1
+
+#define kvm_trace_symbol_aux_op				\
+	{ KVM_TRACE_AUX_RESTORE,	"restore" },	\
+	{ KVM_TRACE_AUX_SAVE,		"save" },	\
+	{ KVM_TRACE_AUX_ENABLE,		"enable" },	\
+	{ KVM_TRACE_AUX_DISABLE,	"disable" },	\
+	{ KVM_TRACE_AUX_DISCARD,	"discard" }
+
+#define kvm_trace_symbol_aux_state			\
+	{ KVM_TRACE_AUX_FPU,     "FPU" }
+
+TRACE_EVENT(kvm_aux,
+	    TP_PROTO(struct kvm_vcpu *vcpu, unsigned int op,
+		     unsigned int state),
+	    TP_ARGS(vcpu, op, state),
+	    TP_STRUCT__entry(
+			__field(unsigned long, pc)
+			__field(u8, op)
+			__field(u8, state)
+	    ),
+
+	    TP_fast_assign(
+			__entry->pc = vcpu->arch.pc;
+			__entry->op = op;
+			__entry->state = state;
+	    ),
+
+	    TP_printk("%s %s PC: 0x%08lx",
+		      __print_symbolic(__entry->op,
+				       kvm_trace_symbol_aux_op),
+		      __print_symbolic(__entry->state,
+				       kvm_trace_symbol_aux_state),
+		      __entry->pc)
+);
+
+TRACE_EVENT(kvm_vpid_change,
+	    TP_PROTO(struct kvm_vcpu *vcpu, unsigned long vpid),
+	    TP_ARGS(vcpu, vpid),
+	    TP_STRUCT__entry(
+			__field(unsigned long, vpid)
+	    ),
+
+	    TP_fast_assign(
+			__entry->vpid = vpid;
+	    ),
+
+	    TP_printk("vpid: 0x%08lx",
+		      __entry->vpid)
+);
+
+#endif /* _TRACE_KVM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.31.1

