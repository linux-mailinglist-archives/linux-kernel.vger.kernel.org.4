Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA336A9787
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCCMtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCCMtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:49:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59657567B2;
        Fri,  3 Mar 2023 04:48:32 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323CfxuO012376;
        Fri, 3 Mar 2023 12:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=xMm3dCRWGhFOOrIjxij9tFRhNdd/t+MTbRXpn3t5ynw=;
 b=H/zehoGcSzwWgFd2ud/O3nZ8RwXQWoUCVk0z9CIPlNu1bmUkqMB4chyxHLoB1a2CP0r3
 RZwb+lbZZcr3zHgUXFmrhB2VKn23HM712lr9b0B2Gutl/gji+Vmm5G4jY+hdYwn1z176
 y9C1Wxt9HKCYja6+P6oZ7tlcqKRnzv6DgmjQ/TkV8qGrAKXBTgzmZhmXmxuULUkY/58y
 glqK6vbVLUBPnZ7xtgYAHa3NJum9w1DZokC7k4Y3V+/vwHcbF9WI6egDITMIv+sSfGk+
 QAbxCURhC3pOAR1aqRa2uGCKv/9ZnHl3KLt6WLFcJjjWfFYXAqTbpacr+mR3E0S8zfa+ 3w== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p3h4f04x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 12:48:17 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 322GWLwR023871;
        Fri, 3 Mar 2023 12:48:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3nybdfwbbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 12:48:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 323CmBBc46072260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Mar 2023 12:48:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16E082004B;
        Fri,  3 Mar 2023 12:48:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B59082004D;
        Fri,  3 Mar 2023 12:48:10 +0000 (GMT)
Received: from osiris (unknown [9.179.23.165])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  3 Mar 2023 12:48:10 +0000 (GMT)
Date:   Fri, 3 Mar 2023 13:48:09 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.3 merge window part 2
Message-ID: <ZAHsibl9k37pZLkv@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lsot4qxdfdWQBeRVPS9siFWATq7O-VU5
X-Proofpoint-ORIG-GUID: Lsot4qxdfdWQBeRVPS9siFWATq7O-VU5
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303030108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull a couple of additional updates for the 6.3 merge window.

Thanks,
Heiko

The following changes since commit f3dd0c53370e70c0f9b7e931bbec12916f3bb8cc:

  bpf: add missing header file include (2023-02-22 09:52:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.3-2

for you to fetch changes up to cd57953936f2213dfaccce10d20f396956222c7d:

  s390/kprobes: fix current_kprobe never cleared after kprobes reenter (2023-03-02 15:33:11 +0100)

----------------------------------------------------------------
s390 updates for 6.3 merge window part 2

- Add empty command line parameter handling stubs to kernel for all command
  line parameters which are handled in the decompressor. This avoids
  invalid "Unknown kernel command line parameters" messages from the
  kernel, and also avoids that these will be incorrectly passed to user
  space. This caused already confusion, therefore add the empty stubs

- Add missing phys_to_virt() handling to machine check handler

- Introduce and use a union to be used for zcrypt inline assemblies. This
  makes sure that only a register wide member of the union is passed as
  input and output parameter to inline assemblies, while usual C code uses
  other members of the union to access bit fields of it

- Add and use a READ_ONCE_ALIGNED_128() macro, which can be used to
  atomically read a 128-bit value from memory. This replaces the (mis-)use
  of the 128-bit cmpxchg operation to do the same in cpum_sf code.
  Currently gcc does not generate the used lpq instruction if __READ_ONCE()
  is used for aligned 128-bit accesses, therefore use this s390 specific
  helper

- Simplify machine check handler code if a task needs to be killed because
  of e.g. register corruption due to a machine malfunction

- Perform CPU reset to clear pending interrupts and TLB entries on an
  already stopped target CPU before delegating work to it

- Generate arch/s390/boot/vmlinux.map link map for the decompressor, when
  CONFIG_VMLINUX_MAP is enabled for debugging purposes

- Fix segment type handling for dcssblk devices. It incorrectly always
  returned type "READ/WRITE" even for read-only segements, which can result
  in a kernel panic if somebody tries to write to a read-only device

- Sort config S390 select list again

- Fix two kprobe reenter bugs revealed by a recently added kprobe kunit
  test

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/mcck: cleanup user process termination path

Gerald Schaefer (1):
      s390/extmem: return correct segment type in __segment_load()

Harald Freudenberger (1):
      s390/ap,zcrypt,vfio: introduce and use ap_queue_status_reg union

Heiko Carstens (4):
      s390/rwonce: add READ_ONCE_ALIGNED_128() macro
      s390/cpum_sf: use READ_ONCE_ALIGNED_128() instead of 128-bit cmpxchg
      s390/smp: perform cpu reset before delegating work to target cpu
      s390/Kconfig: sort config S390 select list again

Nico Boehr (1):
      s390/nmi: fix virtual-physical address confusion

Vasily Gorbik (4):
      s390/setup: do not complain about parameters handled in decompressor
      s390/decompressor: add link map saving
      s390/kprobes: fix irq mask clobbering on kprobe reenter from post_handler
      s390/kprobes: fix current_kprobe never cleared after kprobes reenter

 arch/s390/Kconfig                 |   6 +--
 arch/s390/boot/Makefile           |   4 +-
 arch/s390/include/asm/ap.h        | 100 ++++++++++++++++++++------------------
 arch/s390/include/asm/nmi.h       |   5 +-
 arch/s390/include/asm/rwonce.h    |  31 ++++++++++++
 arch/s390/kernel/early.c          |  17 +++++++
 arch/s390/kernel/entry.S          |  10 ----
 arch/s390/kernel/kprobes.c        |   4 +-
 arch/s390/kernel/nmi.c            |  26 +++-------
 arch/s390/kernel/perf_cpum_sf.c   |   9 ++--
 arch/s390/kernel/smp.c            |   3 +-
 arch/s390/mm/extmem.c             |  12 +++--
 drivers/s390/crypto/ap_queue.c    |   2 +-
 drivers/s390/crypto/vfio_ap_ops.c |   4 +-
 14 files changed, 131 insertions(+), 102 deletions(-)
 create mode 100644 arch/s390/include/asm/rwonce.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 933771b0b07a..e2c2f1516c26 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -125,8 +125,8 @@ config S390
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_DEFAULT_BPF_JIT
-	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS2
 	select DMA_OPS if PCI
@@ -187,7 +187,6 @@ config S390
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
-	select HAVE_RETHOOK
 	select HAVE_KVM
 	select HAVE_LIVEPATCH
 	select HAVE_MEMBLOCK_PHYS_MAP
@@ -200,6 +199,7 @@ config S390
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
+	select HAVE_RETHOOK
 	select HAVE_RSEQ
 	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
@@ -210,9 +210,9 @@ config S390
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
 	select IOMMU_HELPER		if PCI
 	select IOMMU_SUPPORT		if PCI
+	select MMU_GATHER_MERGE_VMAS
 	select MMU_GATHER_NO_GATHER
 	select MMU_GATHER_RCU_TABLE_FREE
-	select MMU_GATHER_MERGE_VMAS
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE	if PCI
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index 47a397da0498..cebd4ca16916 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -52,6 +52,8 @@ targets += vmlinux.bin.zst info.bin syms.bin vmlinux.syms $(obj-all)
 OBJECTS := $(addprefix $(obj)/,$(obj-y))
 OBJECTS_ALL := $(addprefix $(obj)/,$(obj-all))
 
+clean-files += vmlinux.map
+
 quiet_cmd_section_cmp = SECTCMP $*
 define cmd_section_cmp
 	s1=`$(OBJDUMP) -t -j "$*" "$<" | sort | \
@@ -71,7 +73,7 @@ $(obj)/bzImage: $(obj)/vmlinux $(obj)/section_cmp.boot.data $(obj)/section_cmp.b
 $(obj)/section_cmp%: vmlinux $(obj)/vmlinux FORCE
 	$(call if_changed,section_cmp)
 
-LDFLAGS_vmlinux := --oformat $(LD_BFD) -e startup --build-id=sha1 -T
+LDFLAGS_vmlinux := --oformat $(LD_BFD) -e startup $(if $(CONFIG_VMLINUX_MAP),-Map=$(obj)/vmlinux.map) --build-id=sha1 -T
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(OBJECTS_ALL) FORCE
 	$(call if_changed,ld)
 
diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
index 57a2d6518d27..c699f251a464 100644
--- a/arch/s390/include/asm/ap.h
+++ b/arch/s390/include/asm/ap.h
@@ -49,6 +49,19 @@ struct ap_queue_status {
 	unsigned int _pad2		: 16;
 };
 
+/*
+ * AP queue status reg union to access the reg1
+ * register with the lower 32 bits comprising the
+ * ap queue status.
+ */
+union ap_queue_status_reg {
+	unsigned long value;
+	struct {
+		u32 _pad;
+		struct ap_queue_status status;
+	};
+};
+
 /**
  * ap_intructions_available() - Test if AP instructions are available.
  *
@@ -82,7 +95,7 @@ static inline bool ap_instructions_available(void)
  */
 static inline struct ap_queue_status ap_tapq(ap_qid_t qid, unsigned long *info)
 {
-	struct ap_queue_status reg1;
+	union ap_queue_status_reg reg1;
 	unsigned long reg2;
 
 	asm volatile(
@@ -91,12 +104,12 @@ static inline struct ap_queue_status ap_tapq(ap_qid_t qid, unsigned long *info)
 		"	.insn	rre,0xb2af0000,0,0\n"	/* PQAP(TAPQ) */
 		"	lgr	%[reg1],1\n"		/* gr1 (status) into reg1 */
 		"	lgr	%[reg2],2\n"		/* gr2 into reg2 */
-		: [reg1] "=&d" (reg1), [reg2] "=&d" (reg2)
+		: [reg1] "=&d" (reg1.value), [reg2] "=&d" (reg2)
 		: [qid] "d" (qid)
 		: "cc", "0", "1", "2");
 	if (info)
 		*info = reg2;
-	return reg1;
+	return reg1.status;
 }
 
 /**
@@ -125,16 +138,16 @@ static inline struct ap_queue_status ap_test_queue(ap_qid_t qid,
 static inline struct ap_queue_status ap_rapq(ap_qid_t qid)
 {
 	unsigned long reg0 = qid | (1UL << 24);  /* fc 1UL is RAPQ */
-	struct ap_queue_status reg1;
+	union ap_queue_status_reg reg1;
 
 	asm volatile(
 		"	lgr	0,%[reg0]\n"		/* qid arg into gr0 */
 		"	.insn	rre,0xb2af0000,0,0\n"	/* PQAP(RAPQ) */
 		"	lgr	%[reg1],1\n"		/* gr1 (status) into reg1 */
-		: [reg1] "=&d" (reg1)
+		: [reg1] "=&d" (reg1.value)
 		: [reg0] "d" (reg0)
 		: "cc", "0", "1");
-	return reg1;
+	return reg1.status;
 }
 
 /**
@@ -146,16 +159,16 @@ static inline struct ap_queue_status ap_rapq(ap_qid_t qid)
 static inline struct ap_queue_status ap_zapq(ap_qid_t qid)
 {
 	unsigned long reg0 = qid | (2UL << 24);  /* fc 2UL is ZAPQ */
-	struct ap_queue_status reg1;
+	union ap_queue_status_reg reg1;
 
 	asm volatile(
 		"	lgr	0,%[reg0]\n"		/* qid arg into gr0 */
 		"	.insn	rre,0xb2af0000,0,0\n"	/* PQAP(ZAPQ) */
 		"	lgr	%[reg1],1\n"		/* gr1 (status) into reg1 */
-		: [reg1] "=&d" (reg1)
+		: [reg1] "=&d" (reg1.value)
 		: [reg0] "d" (reg0)
 		: "cc", "0", "1");
-	return reg1;
+	return reg1.status;
 }
 
 /**
@@ -209,18 +222,21 @@ static inline int ap_qci(struct ap_config_info *config)
  * parameter to the PQAP(AQIC) instruction. For details please
  * see the AR documentation.
  */
-struct ap_qirq_ctrl {
-	unsigned int _res1 : 8;
-	unsigned int zone  : 8;	/* zone info */
-	unsigned int ir    : 1;	/* ir flag: enable (1) or disable (0) irq */
-	unsigned int _res2 : 4;
-	unsigned int gisc  : 3;	/* guest isc field */
-	unsigned int _res3 : 6;
-	unsigned int gf    : 2;	/* gisa format */
-	unsigned int _res4 : 1;
-	unsigned int gisa  : 27;	/* gisa origin */
-	unsigned int _res5 : 1;
-	unsigned int isc   : 3;	/* irq sub class */
+union ap_qirq_ctrl {
+	unsigned long value;
+	struct {
+		unsigned int	   : 8;
+		unsigned int zone  : 8;	/* zone info */
+		unsigned int ir	   : 1;	/* ir flag: enable (1) or disable (0) irq */
+		unsigned int	   : 4;
+		unsigned int gisc  : 3;	/* guest isc field */
+		unsigned int	   : 6;
+		unsigned int gf	   : 2;	/* gisa format */
+		unsigned int	   : 1;
+		unsigned int gisa  : 27;	/* gisa origin */
+		unsigned int	   : 1;
+		unsigned int isc   : 3;	/* irq sub class */
+	};
 };
 
 /**
@@ -232,21 +248,14 @@ struct ap_qirq_ctrl {
  * Returns AP queue status.
  */
 static inline struct ap_queue_status ap_aqic(ap_qid_t qid,
-					     struct ap_qirq_ctrl qirqctrl,
+					     union ap_qirq_ctrl qirqctrl,
 					     phys_addr_t pa_ind)
 {
 	unsigned long reg0 = qid | (3UL << 24);  /* fc 3UL is AQIC */
-	union {
-		unsigned long value;
-		struct ap_qirq_ctrl qirqctrl;
-		struct {
-			u32 _pad;
-			struct ap_queue_status status;
-		};
-	} reg1;
+	union ap_queue_status_reg reg1;
 	unsigned long reg2 = pa_ind;
 
-	reg1.qirqctrl = qirqctrl;
+	reg1.value = qirqctrl.value;
 
 	asm volatile(
 		"	lgr	0,%[reg0]\n"		/* qid param into gr0 */
@@ -254,7 +263,7 @@ static inline struct ap_queue_status ap_aqic(ap_qid_t qid,
 		"	lgr	2,%[reg2]\n"		/* ni addr into gr2 */
 		"	.insn	rre,0xb2af0000,0,0\n"	/* PQAP(AQIC) */
 		"	lgr	%[reg1],1\n"		/* gr1 (status) into reg1 */
-		: [reg1] "+&d" (reg1)
+		: [reg1] "+&d" (reg1.value)
 		: [reg0] "d" (reg0), [reg2] "d" (reg2)
 		: "cc", "memory", "0", "1", "2");
 
@@ -291,13 +300,7 @@ static inline struct ap_queue_status ap_qact(ap_qid_t qid, int ifbit,
 					     union ap_qact_ap_info *apinfo)
 {
 	unsigned long reg0 = qid | (5UL << 24) | ((ifbit & 0x01) << 22);
-	union {
-		unsigned long value;
-		struct {
-			u32 _pad;
-			struct ap_queue_status status;
-		};
-	} reg1;
+	union ap_queue_status_reg reg1;
 	unsigned long reg2;
 
 	reg1.value = apinfo->val;
@@ -308,7 +311,7 @@ static inline struct ap_queue_status ap_qact(ap_qid_t qid, int ifbit,
 		"	.insn	rre,0xb2af0000,0,0\n"	/* PQAP(QACT) */
 		"	lgr	%[reg1],1\n"		/* gr1 (status) into reg1 */
 		"	lgr	%[reg2],2\n"		/* qact out info into reg2 */
-		: [reg1] "+&d" (reg1), [reg2] "=&d" (reg2)
+		: [reg1] "+&d" (reg1.value), [reg2] "=&d" (reg2)
 		: [reg0] "d" (reg0)
 		: "cc", "0", "1", "2");
 	apinfo->val = reg2;
@@ -333,7 +336,7 @@ static inline struct ap_queue_status ap_nqap(ap_qid_t qid,
 {
 	unsigned long reg0 = qid | 0x40000000UL;  /* 0x4... is last msg part */
 	union register_pair nqap_r1, nqap_r2;
-	struct ap_queue_status reg1;
+	union ap_queue_status_reg reg1;
 
 	nqap_r1.even = (unsigned int)(psmid >> 32);
 	nqap_r1.odd  = psmid & 0xffffffff;
@@ -345,11 +348,11 @@ static inline struct ap_queue_status ap_nqap(ap_qid_t qid,
 		"0:	.insn	rre,0xb2ad0000,%[nqap_r1],%[nqap_r2]\n"
 		"	brc	2,0b\n"       /* handle partial completion */
 		"	lgr	%[reg1],1\n"  /* gr1 (status) into reg1 */
-		: [reg0] "+&d" (reg0), [reg1] "=&d" (reg1),
+		: [reg0] "+&d" (reg0), [reg1] "=&d" (reg1.value),
 		  [nqap_r2] "+&d" (nqap_r2.pair)
 		: [nqap_r1] "d" (nqap_r1.pair)
 		: "cc", "memory", "0", "1");
-	return reg1;
+	return reg1.status;
 }
 
 /**
@@ -389,7 +392,7 @@ static inline struct ap_queue_status ap_dqap(ap_qid_t qid,
 					     unsigned long *resgr0)
 {
 	unsigned long reg0 = resgr0 && *resgr0 ? *resgr0 : qid | 0x80000000UL;
-	struct ap_queue_status reg1;
+	union ap_queue_status_reg reg1;
 	unsigned long reg2;
 	union register_pair rp1, rp2;
 
@@ -408,8 +411,9 @@ static inline struct ap_queue_status ap_dqap(ap_qid_t qid,
 		"2:	lgr	%[reg0],0\n"   /* gr0 (qid + info) into reg0 */
 		"	lgr	%[reg1],1\n"   /* gr1 (status) into reg1 */
 		"	lgr	%[reg2],2\n"   /* gr2 (res length) into reg2 */
-		: [reg0] "+&d" (reg0), [reg1] "=&d" (reg1), [reg2] "=&d" (reg2),
-		  [rp1] "+&d" (rp1.pair), [rp2] "+&d" (rp2.pair)
+		: [reg0] "+&d" (reg0), [reg1] "=&d" (reg1.value),
+		  [reg2] "=&d" (reg2), [rp1] "+&d" (rp1.pair),
+		  [rp2] "+&d" (rp2.pair)
 		:
 		: "cc", "memory", "0", "1", "2");
 
@@ -421,7 +425,7 @@ static inline struct ap_queue_status ap_dqap(ap_qid_t qid,
 		 * Signal the caller that this dqap is only partially received
 		 * with a special status response code 0xFF and *resgr0 updated
 		 */
-		reg1.response_code = 0xFF;
+		reg1.status.response_code = 0xFF;
 		if (resgr0)
 			*resgr0 = reg0;
 	} else {
@@ -430,7 +434,7 @@ static inline struct ap_queue_status ap_dqap(ap_qid_t qid,
 			*resgr0 = 0;
 	}
 
-	return reg1;
+	return reg1.status;
 }
 
 /*
diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
index af1cd3a6f406..227466ce9e41 100644
--- a/arch/s390/include/asm/nmi.h
+++ b/arch/s390/include/asm/nmi.h
@@ -101,9 +101,8 @@ void nmi_alloc_mcesa_early(u64 *mcesad);
 int nmi_alloc_mcesa(u64 *mcesad);
 void nmi_free_mcesa(u64 *mcesad);
 
-void s390_handle_mcck(struct pt_regs *regs);
-void __s390_handle_mcck(void);
-int s390_do_machine_check(struct pt_regs *regs);
+void s390_handle_mcck(void);
+void s390_do_machine_check(struct pt_regs *regs);
 
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_S390_NMI_H */
diff --git a/arch/s390/include/asm/rwonce.h b/arch/s390/include/asm/rwonce.h
new file mode 100644
index 000000000000..91fc24520e82
--- /dev/null
+++ b/arch/s390/include/asm/rwonce.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_S390_RWONCE_H
+#define __ASM_S390_RWONCE_H
+
+#include <linux/compiler_types.h>
+
+/*
+ * Use READ_ONCE_ALIGNED_128() for 128-bit block concurrent (atomic) read
+ * accesses. Note that x must be 128-bit aligned, otherwise a specification
+ * exception is generated.
+ */
+#define READ_ONCE_ALIGNED_128(x)			\
+({							\
+	union {						\
+		typeof(x) __x;				\
+		__uint128_t val;			\
+	} __u;						\
+							\
+	BUILD_BUG_ON(sizeof(x) != 16);			\
+	asm volatile(					\
+		"	lpq	%[val],%[_x]\n"		\
+		: [val] "=d" (__u.val)			\
+		: [_x] "QS" (x)				\
+		: "memory");				\
+	__u.__x;					\
+})
+
+#include <asm-generic/rwonce.h>
+
+#endif	/* __ASM_S390_RWONCE_H */
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 59eba19ae0f2..d26f02495636 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -36,6 +36,23 @@
 
 int __bootdata(is_full_image);
 
+#define decompressor_handled_param(param)			\
+static int __init ignore_decompressor_param_##param(char *s)	\
+{								\
+	return 0;						\
+}								\
+early_param(#param, ignore_decompressor_param_##param)
+
+decompressor_handled_param(mem);
+decompressor_handled_param(vmalloc);
+decompressor_handled_param(dfltcc);
+decompressor_handled_param(noexec);
+decompressor_handled_param(facilities);
+decompressor_handled_param(nokaslr);
+#if IS_ENABLED(CONFIG_KVM)
+decompressor_handled_param(prot_virt);
+#endif
+
 static void __init reset_tod_clock(void)
 {
 	union tod_clock clk;
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index c8d8c9960936..76a06f3d3671 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -562,16 +562,6 @@ ENTRY(mcck_int_handler)
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	brasl	%r14,s390_do_machine_check
-	cghi	%r2,0
-	je	.Lmcck_return
-	lg	%r1,__LC_KERNEL_STACK	# switch to kernel stack
-	mvc	STACK_FRAME_OVERHEAD(__PT_SIZE,%r1),0(%r11)
-	xc	__SF_BACKCHAIN(8,%r1),__SF_BACKCHAIN(%r1)
-	la	%r11,STACK_FRAME_OVERHEAD(%r1)
-	lgr	%r2,%r11
-	lgr	%r15,%r1
-	brasl	%r14,s390_handle_mcck
-.Lmcck_return:
 	lctlg	%c1,%c1,__PT_CR1(%r11)
 	lmg	%r0,%r10,__PT_R0(%r11)
 	mvc	__LC_RETURN_MCCK_PSW(16),__PT_PSW(%r11) # move return PSW
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 5e713f318de3..7b41ceecbb25 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -278,6 +278,7 @@ static void pop_kprobe(struct kprobe_ctlblk *kcb)
 {
 	__this_cpu_write(current_kprobe, kcb->prev_kprobe.kp);
 	kcb->kprobe_status = kcb->prev_kprobe.status;
+	kcb->prev_kprobe.kp = NULL;
 }
 NOKPROBE_SYMBOL(pop_kprobe);
 
@@ -402,12 +403,11 @@ static int post_kprobe_handler(struct pt_regs *regs)
 	if (!p)
 		return 0;
 
+	resume_execution(p, regs);
 	if (kcb->kprobe_status != KPROBE_REENTER && p->post_handler) {
 		kcb->kprobe_status = KPROBE_HIT_SSDONE;
 		p->post_handler(p, regs, 0);
 	}
-
-	resume_execution(p, regs);
 	pop_kprobe(kcb);
 	preempt_enable_no_resched();
 
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 5dbf274719a9..38ec0487521c 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -156,7 +156,7 @@ NOKPROBE_SYMBOL(s390_handle_damage);
  * Main machine check handler function. Will be called with interrupts disabled
  * and machine checks enabled.
  */
-void __s390_handle_mcck(void)
+void s390_handle_mcck(void)
 {
 	struct mcck_struct mcck;
 
@@ -192,23 +192,16 @@ void __s390_handle_mcck(void)
 	if (mcck.stp_queue)
 		stp_queue_work();
 	if (mcck.kill_task) {
-		local_irq_enable();
 		printk(KERN_EMERG "mcck: Terminating task because of machine "
 		       "malfunction (code 0x%016lx).\n", mcck.mcck_code);
 		printk(KERN_EMERG "mcck: task: %s, pid: %d.\n",
 		       current->comm, current->pid);
-		make_task_dead(SIGSEGV);
+		if (is_global_init(current))
+			panic("mcck: Attempting to kill init!\n");
+		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, current, PIDTYPE_PID);
 	}
 }
 
-void noinstr s390_handle_mcck(struct pt_regs *regs)
-{
-	trace_hardirqs_off();
-	pai_kernel_enter(regs);
-	__s390_handle_mcck();
-	pai_kernel_exit(regs);
-	trace_hardirqs_on();
-}
 /*
  * returns 0 if register contents could be validated
  * returns 1 otherwise
@@ -346,8 +339,7 @@ static void notrace s390_backup_mcck_info(struct pt_regs *regs)
 	struct sie_page *sie_page;
 
 	/* r14 contains the sie block, which was set in sie64a */
-	struct kvm_s390_sie_block *sie_block =
-			(struct kvm_s390_sie_block *) regs->gprs[14];
+	struct kvm_s390_sie_block *sie_block = phys_to_virt(regs->gprs[14]);
 
 	if (sie_block == NULL)
 		/* Something's seriously wrong, stop system. */
@@ -374,7 +366,7 @@ NOKPROBE_SYMBOL(s390_backup_mcck_info);
 /*
  * machine check handler.
  */
-int notrace s390_do_machine_check(struct pt_regs *regs)
+void notrace s390_do_machine_check(struct pt_regs *regs)
 {
 	static int ipd_count;
 	static DEFINE_SPINLOCK(ipd_lock);
@@ -504,16 +496,10 @@ int notrace s390_do_machine_check(struct pt_regs *regs)
 	}
 	clear_cpu_flag(CIF_MCCK_GUEST);
 
-	if (user_mode(regs) && mcck_pending) {
-		irqentry_nmi_exit(regs, irq_state);
-		return 1;
-	}
-
 	if (mcck_pending)
 		schedule_mcck_handler();
 
 	irqentry_nmi_exit(regs, irq_state);
-	return 0;
 }
 NOKPROBE_SYMBOL(s390_do_machine_check);
 
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 79904a839fb9..e7b867e2f73f 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1355,8 +1355,7 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
 		num_sdb++;
 
 		/* Reset trailer (using compare-double-and-swap) */
-		/* READ_ONCE() 16 byte header */
-		prev.val = __cdsg(&te->header.val, 0, 0);
+		prev.val = READ_ONCE_ALIGNED_128(te->header.val);
 		do {
 			old.val = prev.val;
 			new.val = prev.val;
@@ -1558,8 +1557,7 @@ static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
 	struct hws_trailer_entry *te;
 
 	te = aux_sdb_trailer(aux, alert_index);
-	/* READ_ONCE() 16 byte header */
-	prev.val = __cdsg(&te->header.val, 0, 0);
+	prev.val = READ_ONCE_ALIGNED_128(te->header.val);
 	do {
 		old.val = prev.val;
 		new.val = prev.val;
@@ -1637,8 +1635,7 @@ static bool aux_reset_buffer(struct aux_buffer *aux, unsigned long range,
 	idx_old = idx = aux->empty_mark + 1;
 	for (i = 0; i < range_scan; i++, idx++) {
 		te = aux_sdb_trailer(aux, idx);
-		/* READ_ONCE() 16 byte header */
-		prev.val = __cdsg(&te->header.val, 0, 0);
+		prev.val = READ_ONCE_ALIGNED_128(te->header.val);
 		do {
 			old.val = prev.val;
 			new.val = prev.val;
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 23c427284773..d4888453bbf8 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -333,6 +333,7 @@ static void pcpu_delegate(struct pcpu *pcpu,
 	}
 	/* Stop target cpu (if func returns this stops the current cpu). */
 	pcpu_sigp_retry(pcpu, SIGP_STOP, 0);
+	pcpu_sigp_retry(pcpu, SIGP_CPU_RESET, 0);
 	/* Restart func on the target cpu and stop the current cpu. */
 	if (lc) {
 		lc->restart_stack = stack;
@@ -522,7 +523,7 @@ static void smp_handle_ext_call(void)
 	if (test_bit(ec_call_function_single, &bits))
 		generic_smp_call_function_single_interrupt();
 	if (test_bit(ec_mcck_pending, &bits))
-		__s390_handle_mcck();
+		s390_handle_mcck();
 	if (test_bit(ec_irq_work, &bits))
 		irq_work_run();
 }
diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index 5060956b8e7d..1bc42ce26599 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -289,15 +289,17 @@ segment_overlaps_others (struct dcss_segment *seg)
 
 /*
  * real segment loading function, called from segment_load
+ * Must return either an error code < 0, or the segment type code >= 0
  */
 static int
 __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long *end)
 {
 	unsigned long start_addr, end_addr, dummy;
 	struct dcss_segment *seg;
-	int rc, diag_cc;
+	int rc, diag_cc, segtype;
 
 	start_addr = end_addr = 0;
+	segtype = -1;
 	seg = kmalloc(sizeof(*seg), GFP_KERNEL | GFP_DMA);
 	if (seg == NULL) {
 		rc = -ENOMEM;
@@ -326,9 +328,9 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
 	seg->res_name[8] = '\0';
 	strlcat(seg->res_name, " (DCSS)", sizeof(seg->res_name));
 	seg->res->name = seg->res_name;
-	rc = seg->vm_segtype;
-	if (rc == SEG_TYPE_SC ||
-	    ((rc == SEG_TYPE_SR || rc == SEG_TYPE_ER) && !do_nonshared))
+	segtype = seg->vm_segtype;
+	if (segtype == SEG_TYPE_SC ||
+	    ((segtype == SEG_TYPE_SR || segtype == SEG_TYPE_ER) && !do_nonshared))
 		seg->res->flags |= IORESOURCE_READONLY;
 
 	/* Check for overlapping resources before adding the mapping. */
@@ -386,7 +388,7 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
  out_free:
 	kfree(seg);
  out:
-	return rc;
+	return rc < 0 ? rc : segtype;
 }
 
 /*
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index a32457b4cbb8..2637fe1df727 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -29,8 +29,8 @@ static void __ap_flush_queue(struct ap_queue *aq);
  */
 static int ap_queue_enable_irq(struct ap_queue *aq, void *ind)
 {
+	union ap_qirq_ctrl qirqctrl = { .value = 0 };
 	struct ap_queue_status status;
-	struct ap_qirq_ctrl qirqctrl = { 0 };
 
 	qirqctrl.ir = 1;
 	qirqctrl.isc = AP_ISC;
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 28a36e016ea9..72e10abb103a 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -301,7 +301,7 @@ static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
  */
 static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 {
-	struct ap_qirq_ctrl aqic_gisa = {};
+	union ap_qirq_ctrl aqic_gisa = { .value = 0 };
 	struct ap_queue_status status;
 	int retries = 5;
 
@@ -384,7 +384,7 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 						 int isc,
 						 struct kvm_vcpu *vcpu)
 {
-	struct ap_qirq_ctrl aqic_gisa = {};
+	union ap_qirq_ctrl aqic_gisa = { .value = 0 };
 	struct ap_queue_status status = {};
 	struct kvm_s390_gisa *gisa;
 	struct page *h_page;
