Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAA5667DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbjALSVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240615AbjALSU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:20:58 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A098C8FC9;
        Thu, 12 Jan 2023 09:56:21 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CHpmYH029888;
        Thu, 12 Jan 2023 17:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=SgG9BzkX4eYPd2MronYCwrFbfeRdo2SJ/63VG2BIZy4=;
 b=SVSy9+LEg8c6SdF4tmDJTxECMaSxog5HhXoFLEHQ4TGtY+zjVpes4VvxqgA2NqILnEz2
 f3+trEzgYaTZ3UeyyjSup9fHPmvZqOz3wbPXHaaa74vjWpmsV/vVNgsry6/qmjap+Fsf
 rhfTtvSD+IZf+NTe8e4EbPeZ7SOPpIAcRsbwojVzobR7OPRny/acqhSCtj747EX5GIYn
 34GqOiQ7R6zOxTvEsXW2Uegh/dpSjtiSLTLTMWIFWbnbUsxnAmc5E9DsbvZ137Ov+7Sz
 Ehv6XRyo1fDbzjgTyCnMYnnhzRqxVyTP3ZtVLpqkk9wVzwavH+yLMfeo5YyNXtWiLRbC +w== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2pyng2s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 17:56:10 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30CG303w032022;
        Thu, 12 Jan 2023 17:56:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3n1kuc226u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 17:56:09 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30CHu5uM24379788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 17:56:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1411620043;
        Thu, 12 Jan 2023 17:56:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9313020040;
        Thu, 12 Jan 2023 17:56:04 +0000 (GMT)
Received: from osiris (unknown [9.171.95.183])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 12 Jan 2023 17:56:04 +0000 (GMT)
Date:   Thu, 12 Jan 2023 18:56:03 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.2-rc4
Message-ID: <Y8BJs/dL1gwtOtqd@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r73Hdm9miLw_h1rVyRH6YOLcGKiqGYG-
X-Proofpoint-GUID: r73Hdm9miLw_h1rVyRH6YOLcGKiqGYG-
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_10,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 updates for 6.2-rc4.

Thanks,
Heiko

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.2-2

for you to fetch changes up to 1ecf7bd9c267ab85aff3c4a17fe56bc9754a13be:

  s390: update defconfigs (2023-01-11 21:26:40 +0100)

----------------------------------------------------------------
s390 updates for 6.2-rc4

- Add various missing READ_ONCE() to cmpxchg() loops prevent the compiler
  from potentially generating incorrect code. This includes a rather large
  change to the s390 specific hardware sampling code and its current use of
  cmpxchg_double().
  Do the fix now to get it out of the way of Peter Zijlstra's cmpxchg128()
  work, and have something that can be backported. The added new code
  includes a private 128 bit cmpxchg variant which will be removed again
  after Peter's rework is available. Also note that this 128 bit cmpxchg
  variant is used to implement 128 bit READ_ONCE(), while strictly speaking
  it wouldn't be necessary, and _READ_ONCE() should also be sufficient;
  even though it isn't obvious for all converted locations that this is the
  case. Therefore use this implementation for for the sake of clarity and
  consistency for now.

- Fix ipl report address handling to avoid kdump failures/hangs.

- Fix misuse of #(el)if in kernel decompressor.

- Define RUNTIME_DISCARD_EXIT to fix link error with GNU ld < 2.36, caused
  by the recently changed discard behaviour.

- Make sure _edata and _end symbols are always page aligned.

- The current header guard DEBUG_H in one of the s390 specific header files
  is too generic and conflicts with the ath9k wireless driver. Add an
  _ASM_S390_ prefix to the guard to make it unique.

- Update defconfigs.

----------------------------------------------------------------
Alexander Egorenkov (1):
      s390/kexec: fix ipl report address for kdump

Alexander Gordeev (1):
      s390: expicitly align _edata and _end symbols on page boundary

Heiko Carstens (4):
      s390/cpum_sf: add READ_ONCE() semantics to compare and swap loops
      s390/percpu: add READ_ONCE() to arch_this_cpu_to_op_simple()
      KVM: s390: interrupt: use READ_ONCE() before cmpxchg()
      s390: update defconfigs

Masahiro Yamada (2):
      s390: define RUNTIME_DISCARD_EXIT to fix link error with GNU ld < 2.36
      s390: fix -Wundef warning for CONFIG_KERNEL_ZSTD

Niklas Schnelle (1):
      s390/debug: add _ASM_S390_ prefix to header guard

 arch/s390/boot/decompressor.c         |   4 +-
 arch/s390/configs/debug_defconfig     |   7 ++-
 arch/s390/configs/defconfig           |   6 +-
 arch/s390/configs/zfcpdump_defconfig  |   2 +-
 arch/s390/include/asm/cpu_mf.h        |  31 +++++------
 arch/s390/include/asm/debug.h         |   6 +-
 arch/s390/include/asm/percpu.h        |   2 +-
 arch/s390/kernel/machine_kexec_file.c |   5 +-
 arch/s390/kernel/perf_cpum_sf.c       | 101 +++++++++++++++++++++-------------
 arch/s390/kernel/vmlinux.lds.S        |   4 ++
 arch/s390/kvm/interrupt.c             |  12 ++--
 11 files changed, 107 insertions(+), 73 deletions(-)

diff --git a/arch/s390/boot/decompressor.c b/arch/s390/boot/decompressor.c
index e27c2140d620..8dcd7af2911a 100644
--- a/arch/s390/boot/decompressor.c
+++ b/arch/s390/boot/decompressor.c
@@ -23,9 +23,9 @@
 #define memmove memmove
 #define memzero(s, n) memset((s), 0, (n))
 
-#ifdef CONFIG_KERNEL_BZIP2
+#if defined(CONFIG_KERNEL_BZIP2)
 #define BOOT_HEAP_SIZE	0x400000
-#elif CONFIG_KERNEL_ZSTD
+#elif defined(CONFIG_KERNEL_ZSTD)
 #define BOOT_HEAP_SIZE	0x30000
 #else
 #define BOOT_HEAP_SIZE	0x10000
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index a7b4e1d82758..74b35ec2ad28 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -190,7 +190,6 @@ CONFIG_NFT_CT=m
 CONFIG_NFT_LOG=m
 CONFIG_NFT_LIMIT=m
 CONFIG_NFT_NAT=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
@@ -569,6 +568,7 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_LEGACY_PTY_COUNT=0
+# CONFIG_LEGACY_TIOCSTI is not set
 CONFIG_VIRTIO_CONSOLE=m
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_HANGCHECK_TIMER=m
@@ -660,6 +660,7 @@ CONFIG_CONFIGFS_FS=m
 CONFIG_ECRYPT_FS=m
 CONFIG_CRAMFS=m
 CONFIG_SQUASHFS=m
+CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT=y
 CONFIG_SQUASHFS_XATTR=y
 CONFIG_SQUASHFS_LZ4=y
 CONFIG_SQUASHFS_LZO=y
@@ -705,6 +706,7 @@ CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
 CONFIG_SECURITY_LANDLOCK=y
 CONFIG_INTEGRITY_SIGNATURE=y
 CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
+CONFIG_INTEGRITY_PLATFORM_KEYRING=y
 CONFIG_IMA=y
 CONFIG_IMA_DEFAULT_HASH_SHA256=y
 CONFIG_IMA_WRITE_POLICY=y
@@ -781,6 +783,7 @@ CONFIG_ZCRYPT=m
 CONFIG_PKEY=m
 CONFIG_CRYPTO_PAES_S390=m
 CONFIG_CRYPTO_DEV_VIRTIO=m
+CONFIG_SYSTEM_BLACKLIST_KEYRING=y
 CONFIG_CORDIC=m
 CONFIG_CRYPTO_LIB_CURVE25519=m
 CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
@@ -848,7 +851,6 @@ CONFIG_PREEMPT_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BLK_DEV_IO_TRACE=y
-CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_HIST_TRIGGERS=y
 CONFIG_FTRACE_STARTUP_TEST=y
 # CONFIG_EVENT_TRACE_STARTUP_TEST is not set
@@ -870,7 +872,6 @@ CONFIG_FAIL_MAKE_REQUEST=y
 CONFIG_FAIL_IO_TIMEOUT=y
 CONFIG_FAIL_FUTEX=y
 CONFIG_FAULT_INJECTION_DEBUG_FS=y
-CONFIG_FAIL_FUNCTION=y
 CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
 CONFIG_LKDTM=m
 CONFIG_TEST_MIN_HEAP=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 2bc2d0fe5774..cec71268e3bc 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -181,7 +181,6 @@ CONFIG_NFT_CT=m
 CONFIG_NFT_LOG=m
 CONFIG_NFT_LIMIT=m
 CONFIG_NFT_NAT=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
@@ -559,6 +558,7 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_LEGACY_PTY_COUNT=0
+# CONFIG_LEGACY_TIOCSTI is not set
 CONFIG_VIRTIO_CONSOLE=m
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_HANGCHECK_TIMER=m
@@ -645,6 +645,7 @@ CONFIG_CONFIGFS_FS=m
 CONFIG_ECRYPT_FS=m
 CONFIG_CRAMFS=m
 CONFIG_SQUASHFS=m
+CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT=y
 CONFIG_SQUASHFS_XATTR=y
 CONFIG_SQUASHFS_LZ4=y
 CONFIG_SQUASHFS_LZO=y
@@ -688,6 +689,7 @@ CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
 CONFIG_SECURITY_LANDLOCK=y
 CONFIG_INTEGRITY_SIGNATURE=y
 CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
+CONFIG_INTEGRITY_PLATFORM_KEYRING=y
 CONFIG_IMA=y
 CONFIG_IMA_DEFAULT_HASH_SHA256=y
 CONFIG_IMA_WRITE_POLICY=y
@@ -766,6 +768,7 @@ CONFIG_ZCRYPT=m
 CONFIG_PKEY=m
 CONFIG_CRYPTO_PAES_S390=m
 CONFIG_CRYPTO_DEV_VIRTIO=m
+CONFIG_SYSTEM_BLACKLIST_KEYRING=y
 CONFIG_CORDIC=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRYPTO_LIB_CURVE25519=m
@@ -798,7 +801,6 @@ CONFIG_STACK_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BLK_DEV_IO_TRACE=y
-CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_HIST_TRIGGERS=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_TRACE_PRINTK=m
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index ae14ab0b864d..a9c0c81d1de9 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -13,7 +13,6 @@ CONFIG_TUNE_ZEC12=y
 # CONFIG_COMPAT is not set
 CONFIG_NR_CPUS=2
 CONFIG_HZ_100=y
-# CONFIG_RELOCATABLE is not set
 # CONFIG_CHSC_SCH is not set
 # CONFIG_SCM_BUS is not set
 CONFIG_CRASH_DUMP=y
@@ -50,6 +49,7 @@ CONFIG_ZFCP=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
+# CONFIG_LEGACY_TIOCSTI is not set
 # CONFIG_HVC_IUCV is not set
 # CONFIG_HW_RANDOM_S390 is not set
 # CONFIG_HMC_DRV is not set
diff --git a/arch/s390/include/asm/cpu_mf.h b/arch/s390/include/asm/cpu_mf.h
index feaba12dbecb..efa103b52a1a 100644
--- a/arch/s390/include/asm/cpu_mf.h
+++ b/arch/s390/include/asm/cpu_mf.h
@@ -131,19 +131,21 @@ struct hws_combined_entry {
 	struct hws_diag_entry	diag;	/* Diagnostic-sampling data entry */
 } __packed;
 
-struct hws_trailer_entry {
-	union {
-		struct {
-			unsigned int f:1;	/* 0 - Block Full Indicator   */
-			unsigned int a:1;	/* 1 - Alert request control  */
-			unsigned int t:1;	/* 2 - Timestamp format	      */
-			unsigned int :29;	/* 3 - 31: Reserved	      */
-			unsigned int bsdes:16;	/* 32-47: size of basic SDE   */
-			unsigned int dsdes:16;	/* 48-63: size of diagnostic SDE */
-		};
-		unsigned long long flags;	/* 0 - 63: All indicators     */
+union hws_trailer_header {
+	struct {
+		unsigned int f:1;	/* 0 - Block Full Indicator   */
+		unsigned int a:1;	/* 1 - Alert request control  */
+		unsigned int t:1;	/* 2 - Timestamp format	      */
+		unsigned int :29;	/* 3 - 31: Reserved	      */
+		unsigned int bsdes:16;	/* 32-47: size of basic SDE   */
+		unsigned int dsdes:16;	/* 48-63: size of diagnostic SDE */
+		unsigned long long overflow; /* 64 - Overflow Count   */
 	};
-	unsigned long long overflow;	 /* 64 - sample Overflow count	      */
+	__uint128_t val;
+};
+
+struct hws_trailer_entry {
+	union hws_trailer_header header; /* 0 - 15 Flags + Overflow Count     */
 	unsigned char timestamp[16];	 /* 16 - 31 timestamp		      */
 	unsigned long long reserved1;	 /* 32 -Reserved		      */
 	unsigned long long reserved2;	 /*				      */
@@ -290,14 +292,11 @@ static inline unsigned long sample_rate_to_freq(struct hws_qsi_info_block *qsi,
 	return USEC_PER_SEC * qsi->cpu_speed / rate;
 }
 
-#define SDB_TE_ALERT_REQ_MASK	0x4000000000000000UL
-#define SDB_TE_BUFFER_FULL_MASK 0x8000000000000000UL
-
 /* Return TOD timestamp contained in an trailer entry */
 static inline unsigned long long trailer_timestamp(struct hws_trailer_entry *te)
 {
 	/* TOD in STCKE format */
-	if (te->t)
+	if (te->header.t)
 		return *((unsigned long long *) &te->timestamp[1]);
 
 	/* TOD in STCK format */
diff --git a/arch/s390/include/asm/debug.h b/arch/s390/include/asm/debug.h
index 77f24262c25c..ac665b9670c5 100644
--- a/arch/s390/include/asm/debug.h
+++ b/arch/s390/include/asm/debug.h
@@ -4,8 +4,8 @@
  *
  *    Copyright IBM Corp. 1999, 2020
  */
-#ifndef DEBUG_H
-#define DEBUG_H
+#ifndef _ASM_S390_DEBUG_H
+#define _ASM_S390_DEBUG_H
 
 #include <linux/string.h>
 #include <linux/spinlock.h>
@@ -487,4 +487,4 @@ void debug_register_static(debug_info_t *id, int pages_per_area, int nr_areas);
 
 #endif /* MODULE */
 
-#endif /* DEBUG_H */
+#endif /* _ASM_S390_DEBUG_H */
diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index cb5fc0690435..081837b391e3 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -31,7 +31,7 @@
 	pcp_op_T__ *ptr__;						\
 	preempt_disable_notrace();					\
 	ptr__ = raw_cpu_ptr(&(pcp));					\
-	prev__ = *ptr__;						\
+	prev__ = READ_ONCE(*ptr__);					\
 	do {								\
 		old__ = prev__;						\
 		new__ = old__ op (val);					\
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index fc6d5f58debe..2df94d32140c 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -187,8 +187,6 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 
 	data->memsz = ALIGN(data->memsz, PAGE_SIZE);
 	buf.mem = data->memsz;
-	if (image->type == KEXEC_TYPE_CRASH)
-		buf.mem += crashk_res.start;
 
 	ptr = (void *)ipl_cert_list_addr;
 	end = ptr + ipl_cert_list_size;
@@ -225,6 +223,9 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 		data->kernel_buf + offsetof(struct lowcore, ipl_parmblock_ptr);
 	*lc_ipl_parmblock_ptr = (__u32)buf.mem;
 
+	if (image->type == KEXEC_TYPE_CRASH)
+		buf.mem += crashk_res.start;
+
 	ret = kexec_add_buffer(&buf);
 out:
 	return ret;
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 332a49965130..ce886a03545a 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -163,14 +163,15 @@ static void free_sampling_buffer(struct sf_buffer *sfb)
 
 static int alloc_sample_data_block(unsigned long *sdbt, gfp_t gfp_flags)
 {
-	unsigned long sdb, *trailer;
+	struct hws_trailer_entry *te;
+	unsigned long sdb;
 
 	/* Allocate and initialize sample-data-block */
 	sdb = get_zeroed_page(gfp_flags);
 	if (!sdb)
 		return -ENOMEM;
-	trailer = trailer_entry_ptr(sdb);
-	*trailer = SDB_TE_ALERT_REQ_MASK;
+	te = (struct hws_trailer_entry *)trailer_entry_ptr(sdb);
+	te->header.a = 1;
 
 	/* Link SDB into the sample-data-block-table */
 	*sdbt = sdb;
@@ -1206,7 +1207,7 @@ static void hw_collect_samples(struct perf_event *event, unsigned long *sdbt,
 					    "%s: Found unknown"
 					    " sampling data entry: te->f %i"
 					    " basic.def %#4x (%p)\n", __func__,
-					    te->f, sample->def, sample);
+					    te->header.f, sample->def, sample);
 			/* Sample slot is not yet written or other record.
 			 *
 			 * This condition can occur if the buffer was reused
@@ -1217,7 +1218,7 @@ static void hw_collect_samples(struct perf_event *event, unsigned long *sdbt,
 			 * that are not full.  Stop processing if the first
 			 * invalid format was detected.
 			 */
-			if (!te->f)
+			if (!te->header.f)
 				break;
 		}
 
@@ -1227,6 +1228,16 @@ static void hw_collect_samples(struct perf_event *event, unsigned long *sdbt,
 	}
 }
 
+static inline __uint128_t __cdsg(__uint128_t *ptr, __uint128_t old, __uint128_t new)
+{
+	asm volatile(
+		"	cdsg	%[old],%[new],%[ptr]\n"
+		: [old] "+d" (old), [ptr] "+QS" (*ptr)
+		: [new] "d" (new)
+		: "memory", "cc");
+	return old;
+}
+
 /* hw_perf_event_update() - Process sampling buffer
  * @event:	The perf event
  * @flush_all:	Flag to also flush partially filled sample-data-blocks
@@ -1243,10 +1254,11 @@ static void hw_collect_samples(struct perf_event *event, unsigned long *sdbt,
  */
 static void hw_perf_event_update(struct perf_event *event, int flush_all)
 {
+	unsigned long long event_overflow, sampl_overflow, num_sdb;
+	union hws_trailer_header old, prev, new;
 	struct hw_perf_event *hwc = &event->hw;
 	struct hws_trailer_entry *te;
 	unsigned long *sdbt;
-	unsigned long long event_overflow, sampl_overflow, num_sdb, te_flags;
 	int done;
 
 	/*
@@ -1266,25 +1278,25 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
 		te = (struct hws_trailer_entry *) trailer_entry_ptr(*sdbt);
 
 		/* Leave loop if no more work to do (block full indicator) */
-		if (!te->f) {
+		if (!te->header.f) {
 			done = 1;
 			if (!flush_all)
 				break;
 		}
 
 		/* Check the sample overflow count */
-		if (te->overflow)
+		if (te->header.overflow)
 			/* Account sample overflows and, if a particular limit
 			 * is reached, extend the sampling buffer.
 			 * For details, see sfb_account_overflows().
 			 */
-			sampl_overflow += te->overflow;
+			sampl_overflow += te->header.overflow;
 
 		/* Timestamps are valid for full sample-data-blocks only */
 		debug_sprintf_event(sfdbg, 6, "%s: sdbt %#lx "
 				    "overflow %llu timestamp %#llx\n",
-				    __func__, (unsigned long)sdbt, te->overflow,
-				    (te->f) ? trailer_timestamp(te) : 0ULL);
+				    __func__, (unsigned long)sdbt, te->header.overflow,
+				    (te->header.f) ? trailer_timestamp(te) : 0ULL);
 
 		/* Collect all samples from a single sample-data-block and
 		 * flag if an (perf) event overflow happened.  If so, the PMU
@@ -1294,12 +1306,16 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
 		num_sdb++;
 
 		/* Reset trailer (using compare-double-and-swap) */
+		/* READ_ONCE() 16 byte header */
+		prev.val = __cdsg(&te->header.val, 0, 0);
 		do {
-			te_flags = te->flags & ~SDB_TE_BUFFER_FULL_MASK;
-			te_flags |= SDB_TE_ALERT_REQ_MASK;
-		} while (!cmpxchg_double(&te->flags, &te->overflow,
-					 te->flags, te->overflow,
-					 te_flags, 0ULL));
+			old.val = prev.val;
+			new.val = prev.val;
+			new.f = 0;
+			new.a = 1;
+			new.overflow = 0;
+			prev.val = __cdsg(&te->header.val, old.val, new.val);
+		} while (prev.val != old.val);
 
 		/* Advance to next sample-data-block */
 		sdbt++;
@@ -1384,7 +1400,7 @@ static void aux_output_end(struct perf_output_handle *handle)
 	range_scan = AUX_SDB_NUM_ALERT(aux);
 	for (i = 0, idx = aux->head; i < range_scan; i++, idx++) {
 		te = aux_sdb_trailer(aux, idx);
-		if (!(te->flags & SDB_TE_BUFFER_FULL_MASK))
+		if (!te->header.f)
 			break;
 	}
 	/* i is num of SDBs which are full */
@@ -1392,7 +1408,7 @@ static void aux_output_end(struct perf_output_handle *handle)
 
 	/* Remove alert indicators in the buffer */
 	te = aux_sdb_trailer(aux, aux->alert_mark);
-	te->flags &= ~SDB_TE_ALERT_REQ_MASK;
+	te->header.a = 0;
 
 	debug_sprintf_event(sfdbg, 6, "%s: SDBs %ld range %ld head %ld\n",
 			    __func__, i, range_scan, aux->head);
@@ -1437,9 +1453,9 @@ static int aux_output_begin(struct perf_output_handle *handle,
 		idx = aux->empty_mark + 1;
 		for (i = 0; i < range_scan; i++, idx++) {
 			te = aux_sdb_trailer(aux, idx);
-			te->flags &= ~(SDB_TE_BUFFER_FULL_MASK |
-				       SDB_TE_ALERT_REQ_MASK);
-			te->overflow = 0;
+			te->header.f = 0;
+			te->header.a = 0;
+			te->header.overflow = 0;
 		}
 		/* Save the position of empty SDBs */
 		aux->empty_mark = aux->head + range - 1;
@@ -1448,7 +1464,7 @@ static int aux_output_begin(struct perf_output_handle *handle,
 	/* Set alert indicator */
 	aux->alert_mark = aux->head + range/2 - 1;
 	te = aux_sdb_trailer(aux, aux->alert_mark);
-	te->flags = te->flags | SDB_TE_ALERT_REQ_MASK;
+	te->header.a = 1;
 
 	/* Reset hardware buffer head */
 	head = AUX_SDB_INDEX(aux, aux->head);
@@ -1475,14 +1491,17 @@ static int aux_output_begin(struct perf_output_handle *handle,
 static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
 			  unsigned long long *overflow)
 {
-	unsigned long long orig_overflow, orig_flags, new_flags;
+	union hws_trailer_header old, prev, new;
 	struct hws_trailer_entry *te;
 
 	te = aux_sdb_trailer(aux, alert_index);
+	/* READ_ONCE() 16 byte header */
+	prev.val = __cdsg(&te->header.val, 0, 0);
 	do {
-		orig_flags = te->flags;
-		*overflow = orig_overflow = te->overflow;
-		if (orig_flags & SDB_TE_BUFFER_FULL_MASK) {
+		old.val = prev.val;
+		new.val = prev.val;
+		*overflow = old.overflow;
+		if (old.f) {
 			/*
 			 * SDB is already set by hardware.
 			 * Abort and try to set somewhere
@@ -1490,10 +1509,10 @@ static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
 			 */
 			return false;
 		}
-		new_flags = orig_flags | SDB_TE_ALERT_REQ_MASK;
-	} while (!cmpxchg_double(&te->flags, &te->overflow,
-				 orig_flags, orig_overflow,
-				 new_flags, 0ULL));
+		new.a = 1;
+		new.overflow = 0;
+		prev.val = __cdsg(&te->header.val, old.val, new.val);
+	} while (prev.val != old.val);
 	return true;
 }
 
@@ -1522,8 +1541,9 @@ static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
 static bool aux_reset_buffer(struct aux_buffer *aux, unsigned long range,
 			     unsigned long long *overflow)
 {
-	unsigned long long orig_overflow, orig_flags, new_flags;
 	unsigned long i, range_scan, idx, idx_old;
+	union hws_trailer_header old, prev, new;
+	unsigned long long orig_overflow;
 	struct hws_trailer_entry *te;
 
 	debug_sprintf_event(sfdbg, 6, "%s: range %ld head %ld alert %ld "
@@ -1554,17 +1574,20 @@ static bool aux_reset_buffer(struct aux_buffer *aux, unsigned long range,
 	idx_old = idx = aux->empty_mark + 1;
 	for (i = 0; i < range_scan; i++, idx++) {
 		te = aux_sdb_trailer(aux, idx);
+		/* READ_ONCE() 16 byte header */
+		prev.val = __cdsg(&te->header.val, 0, 0);
 		do {
-			orig_flags = te->flags;
-			orig_overflow = te->overflow;
-			new_flags = orig_flags & ~SDB_TE_BUFFER_FULL_MASK;
+			old.val = prev.val;
+			new.val = prev.val;
+			orig_overflow = old.overflow;
+			new.f = 0;
+			new.overflow = 0;
 			if (idx == aux->alert_mark)
-				new_flags |= SDB_TE_ALERT_REQ_MASK;
+				new.a = 1;
 			else
-				new_flags &= ~SDB_TE_ALERT_REQ_MASK;
-		} while (!cmpxchg_double(&te->flags, &te->overflow,
-					 orig_flags, orig_overflow,
-					 new_flags, 0ULL));
+				new.a = 0;
+			prev.val = __cdsg(&te->header.val, old.val, new.val);
+		} while (prev.val != old.val);
 		*overflow += orig_overflow;
 	}
 
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 5ea3830af0cc..cbf9c1b0beda 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -17,6 +17,8 @@
 /* Handle ro_after_init data on our own. */
 #define RO_AFTER_INIT_DATA
 
+#define RUNTIME_DISCARD_EXIT
+
 #define EMITS_PT_NOTE
 
 #include <asm-generic/vmlinux.lds.h>
@@ -79,6 +81,7 @@ SECTIONS
 		_end_amode31_refs = .;
 	}
 
+	. = ALIGN(PAGE_SIZE);
 	_edata = .;		/* End of data section */
 
 	/* will be freed after init */
@@ -193,6 +196,7 @@ SECTIONS
 
 	BSS_SECTION(PAGE_SIZE, 4 * PAGE_SIZE, PAGE_SIZE)
 
+	. = ALIGN(PAGE_SIZE);
 	_end = . ;
 
 	/*
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 1dae78deddf2..ab26aa53ee37 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -83,8 +83,9 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 		struct esca_block *sca = vcpu->kvm->arch.sca;
 		union esca_sigp_ctrl *sigp_ctrl =
 			&(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
-		union esca_sigp_ctrl new_val = {0}, old_val = *sigp_ctrl;
+		union esca_sigp_ctrl new_val = {0}, old_val;
 
+		old_val = READ_ONCE(*sigp_ctrl);
 		new_val.scn = src_id;
 		new_val.c = 1;
 		old_val.c = 0;
@@ -95,8 +96,9 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 		struct bsca_block *sca = vcpu->kvm->arch.sca;
 		union bsca_sigp_ctrl *sigp_ctrl =
 			&(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
-		union bsca_sigp_ctrl new_val = {0}, old_val = *sigp_ctrl;
+		union bsca_sigp_ctrl new_val = {0}, old_val;
 
+		old_val = READ_ONCE(*sigp_ctrl);
 		new_val.scn = src_id;
 		new_val.c = 1;
 		old_val.c = 0;
@@ -126,16 +128,18 @@ static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
 		struct esca_block *sca = vcpu->kvm->arch.sca;
 		union esca_sigp_ctrl *sigp_ctrl =
 			&(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
-		union esca_sigp_ctrl old = *sigp_ctrl;
+		union esca_sigp_ctrl old;
 
+		old = READ_ONCE(*sigp_ctrl);
 		expect = old.value;
 		rc = cmpxchg(&sigp_ctrl->value, old.value, 0);
 	} else {
 		struct bsca_block *sca = vcpu->kvm->arch.sca;
 		union bsca_sigp_ctrl *sigp_ctrl =
 			&(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
-		union bsca_sigp_ctrl old = *sigp_ctrl;
+		union bsca_sigp_ctrl old;
 
+		old = READ_ONCE(*sigp_ctrl);
 		expect = old.value;
 		rc = cmpxchg(&sigp_ctrl->value, old.value, 0);
 	}
