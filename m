Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAC972236D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjFEK3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFEK3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:29:01 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46A3EC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1685960939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XEJd+pAzFKvWLgVbLt0nvjffQxQGFvnEOlIKj5Xp5WM=;
  b=Ao5p9ZCsPFPf+kKsCOBhIORQVwQKBNC9vsiTHHbH2FxUkB+HYvAHeG4I
   ZfenGBLwriGGAlA5RSZXMvOJYp3YrNaXmQn/vuFJTLVagQRYANSeR/Akq
   npJDBn4tutvrnMOW18QEe0SvD/Q//cWgIGR6bzYzzWmau+eTZugj40y0b
   k=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 112017684
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:uLecbqxMDsqY+lKL2Nl6t+drwSrEfRIJ4+MujC+fZmUNrF6WrkVSz
 DFJDDiPPqrcYmTyKNl0b42w8BwGvJ6HnddrHlM4+CAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTrafYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8EsHUMja4mtC5QRgPawT5TcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KX9Nx
 eEFdHMWVR28oM2nzeP8EOZzrMt2eaEHPKtH0p1h5TTQDPJgSpHfWaTao9Rf2V/chOgXQ6yYP
 ZBAL2MyMlKZOUYn1lQ/UfrSmM+ygWLkNTlRp1+PuqMz50DYzRBr0airO93QEjCPbZwMxB7B+
 TyWowwVBDkhN9unyWeowEiAm+n/rw/Rf441RLeBo6sCbFq7mTVIVUx+uUGAif24jFOuHtFSM
 UoZ/gIwoqUosk+mVN/wW1u/unHslg4RXZ9cHvM37CmJy7HI+ECJC24cVDlDZdc68sgsSlQCy
 lCNj/vtBDpyrKeST3ONsLuZxRu4IQAcKW4PY39CQQZty9Xqvox1jhvJVdtlOKq0iMDlXzD23
 z2O6iM5gt07j8QGyqG69lDvmC+3q97CSQtdzgfYRGW+9StieZWoIYev7DDz5/FaLZ3fSUKdp
 n8agMuPxOcUBJqJmWqGR+BlNLSo4fmCGCfRjV5mA98q8DHF02aheoZd+xlkKUtpO9pCcjjsC
 GfD6V1555JJOnauK6htbOqZCMMs16HsPdfoTPbZapxJeJcZSeOc1HgwPwjKhTmryRVy1/hlY
 v93bPpAE14ECpR60Wb1XNwQ7pgE1y1vgjncWrr0mkHPPaWlWFaZTrIMMV2rZ+8/7b+ZrAi9z
 +uzJ/dm2D0EDrSgP3C/HZo7aAlTcCNlXcyeR9l/LLbrH+ZwJI025xY9K5sFcpctoalan/ygE
 pqVCh4BkwqXaZEqxGy3hpFfhFHHB80XQZETZ3ZE0bOUN58LP+6SAF83LcdfQFXe3LULIQRIZ
 /cEYd6cJf9EVy7K/T8QBbGk8tw/JUzw2FLSYXX7CNTaQ3KHb1aQkuIIgyO1rHVeZsZJnZVWT
 0KcOvPzHsNYGlUK4Df+Y/Oz1VKh1UXxa8orN3Yk1uJ7IR22mKAzcnyZsxPCC51UQfk17mfAh
 ln+7NZxjbWlnrLZB/GV3f7b8972T7MldqeYdkGChYuL2eDh1jLL6ed9vCygJFgxiEucFH2eW
 Nho
IronPort-HdrOrdr: A9a23:/i0o6aisV0riEfwQ7+rUAaDqj3BQXwh13DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03I+OrwXpVoJEmxyXcb2/h0AV7PZniFhILKFvAA0WKB+UyYJ8SWzIc0us
 kBT0EXMqyJMbEQt7ec3ODXKadE/DCyytHSuQ6S9QYfcShaL4VbqytpAAeSFUN7ACFAGJoCDZ
 KZou5KvSCpd3g7ZtmyQiBtZZm3m/T70LbdJTIWDR8u7weDyRuu9b7BChCdmjMTSSlGz7sO+X
 XM1yb5+qKgmfemzQK07R6g071m3P/ajvdTDs2FjcYYbh3qlwaTfYxkH4aPuTgkydvflmrDxL
 P3wisIDoBW0Tf8b2u1qRzi103LyzA18ULvzleenD/KvdH5bChSMbsKuatpNj/ir2YwttB116
 xGm0iDsYBMMB/GlCPho/DVShBRkFauq3ZKq59Zs5Vma/pSVFZtl/1XwKoVKuZ3IMvC0vFRLA
 C6NrCV2B5UGWnqEEwx8FMfjOBEZU5DYitucnJyx/B97AIm5kyR73FotfD3zU1whK7VDaM0k9
 j5Dg==
X-Talos-CUID: =?us-ascii?q?9a23=3A8yOmEWu6MrXKNusv1yAW4XxD6Is7cU3A0SuTOHS?=
 =?us-ascii?q?1NkFGWbDEDgWf54lrxp8=3D?=
X-Talos-MUID: 9a23:ikk9dwZgOXPQXuBTjDzrvDE/GfVSz7moOHIhu7IKnJmODHkl
X-IronPort-AV: E=Sophos;i="6.00,217,1681185600"; 
   d="scan'208";a="112017684"
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>
CC:     Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        "Ross Lagerwall" <ross.lagerwall@citrix.com>
Subject: [PATCH v3] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
Date:   Mon, 5 Jun 2023 11:28:40 +0100
Message-ID: <20230605102840.1521549-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To facilitate diskless iSCSI boot, the firmware can place a table of
configuration details in memory called the iBFT. The presence of this
table is not specified, nor is the precise location (and it's not in the
E820) so the kernel has to search for a magic marker to find it.

When running under Xen, Dom 0 does not have access to the entire host's
memory, only certain regions which are identity-mapped which means that
the pseudo-physical address in Dom0 == real host physical address.
Add the iBFT search bounds as a reserved region which causes it to be
identity-mapped in xen_set_identity_and_remap_chunk() which allows Dom0
access to the specific physical memory to correctly search for the iBFT
magic marker (and later access the full table).

This necessitates moving the call to reserve_ibft_region() somewhat
later so that it is called after e820__memory_setup() which is when the
Xen identity mapping adjustments are applied. The precise location of
the call is not too important so I've put it alongside dmi_setup() which
does similar scanning of memory for configuration tables.

Finally in the iBFT find code, instead of using isa_bus_to_virt() which
doesn't do the right thing under Xen, use early_memremap() like the
dmi_setup() code does.

The result of these changes is that it is possible to boot a diskless
Xen + Dom0 running off an iSCSI disk whereas previously it would fail to
find the iBFT and consequently, the iSCSI root disk.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---

In v3:
* Expanded commit message.
* Used IBFT_ constants.

 arch/x86/kernel/setup.c            |  2 +-
 arch/x86/xen/setup.c               | 28 +++++++++++++++++++---------
 drivers/firmware/iscsi_ibft_find.c | 26 +++++++++++++++++---------
 include/linux/iscsi_ibft.h         | 10 +++++++++-
 4 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 16babff771bd..616b80507abd 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -796,7 +796,6 @@ static void __init early_reserve_memory(void)
 
 	memblock_x86_reserve_range_setup_data();
 
-	reserve_ibft_region();
 	reserve_bios_regions();
 	trim_snb_memory();
 }
@@ -1032,6 +1031,7 @@ void __init setup_arch(char **cmdline_p)
 	if (efi_enabled(EFI_BOOT))
 		efi_init();
 
+	reserve_ibft_region();
 	dmi_setup();
 
 	/*
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index c2be3efb2ba0..8b5cf7bb1f47 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/iscsi_ibft.h>
 #include <linux/sched.h>
 #include <linux/kstrtox.h>
 #include <linux/mm.h>
@@ -764,17 +765,26 @@ char * __init xen_memory_setup(void)
 	BUG_ON(memmap.nr_entries == 0);
 	xen_e820_table.nr_entries = memmap.nr_entries;
 
-	/*
-	 * Xen won't allow a 1:1 mapping to be created to UNUSABLE
-	 * regions, so if we're using the machine memory map leave the
-	 * region as RAM as it is in the pseudo-physical map.
-	 *
-	 * UNUSABLE regions in domUs are not handled and will need
-	 * a patch in the future.
-	 */
-	if (xen_initial_domain())
+	if (xen_initial_domain()) {
+		/*
+		 * Xen won't allow a 1:1 mapping to be created to UNUSABLE
+		 * regions, so if we're using the machine memory map leave the
+		 * region as RAM as it is in the pseudo-physical map.
+		 *
+		 * UNUSABLE regions in domUs are not handled and will need
+		 * a patch in the future.
+		 */
 		xen_ignore_unusable();
 
+#ifdef CONFIG_ISCSI_IBFT_FIND
+		/* Reserve 0.5 MiB to 1 MiB region so iBFT can be found */
+		xen_e820_table.entries[xen_e820_table.nr_entries].addr = IBFT_START;
+		xen_e820_table.entries[xen_e820_table.nr_entries].size = IBFT_END - IBFT_START;
+		xen_e820_table.entries[xen_e820_table.nr_entries].type = E820_TYPE_RESERVED;
+		xen_e820_table.nr_entries++;
+#endif
+	}
+
 	/* Make sure the Xen-supplied memory map is well-ordered. */
 	e820__update_table(&xen_e820_table);
 
diff --git a/drivers/firmware/iscsi_ibft_find.c b/drivers/firmware/iscsi_ibft_find.c
index 94b49ccd23ac..71f51303c2ba 100644
--- a/drivers/firmware/iscsi_ibft_find.c
+++ b/drivers/firmware/iscsi_ibft_find.c
@@ -42,8 +42,6 @@ static const struct {
 };
 
 #define IBFT_SIGN_LEN 4
-#define IBFT_START 0x80000 /* 512kB */
-#define IBFT_END 0x100000 /* 1MB */
 #define VGA_MEM 0xA0000 /* VGA buffer */
 #define VGA_SIZE 0x20000 /* 128kB */
 
@@ -52,9 +50,9 @@ static const struct {
  */
 void __init reserve_ibft_region(void)
 {
-	unsigned long pos;
+	unsigned long pos, virt_pos = 0;
 	unsigned int len = 0;
-	void *virt;
+	void *virt = NULL;
 	int i;
 
 	ibft_phys_addr = 0;
@@ -70,13 +68,20 @@ void __init reserve_ibft_region(void)
 		 * so skip that area */
 		if (pos == VGA_MEM)
 			pos += VGA_SIZE;
-		virt = isa_bus_to_virt(pos);
+
+		/* Map page by page */
+		if (offset_in_page(pos) == 0) {
+			if (virt)
+				early_memunmap(virt, PAGE_SIZE);
+			virt = early_memremap_ro(pos, PAGE_SIZE);
+			virt_pos = pos;
+		}
 
 		for (i = 0; i < ARRAY_SIZE(ibft_signs); i++) {
-			if (memcmp(virt, ibft_signs[i].sign, IBFT_SIGN_LEN) ==
-			    0) {
+			if (memcmp(virt + (pos - virt_pos), ibft_signs[i].sign,
+				   IBFT_SIGN_LEN) == 0) {
 				unsigned long *addr =
-				    (unsigned long *)isa_bus_to_virt(pos + 4);
+				    (unsigned long *)(virt + pos - virt_pos + 4);
 				len = *addr;
 				/* if the length of the table extends past 1M,
 				 * the table cannot be valid. */
@@ -84,9 +89,12 @@ void __init reserve_ibft_region(void)
 					ibft_phys_addr = pos;
 					memblock_reserve(ibft_phys_addr, PAGE_ALIGN(len));
 					pr_info("iBFT found at %pa.\n", &ibft_phys_addr);
-					return;
+					goto out;
 				}
 			}
 		}
 	}
+
+out:
+	early_memunmap(virt, PAGE_SIZE);
 }
diff --git a/include/linux/iscsi_ibft.h b/include/linux/iscsi_ibft.h
index 790e7fcfc1a6..e2742748104d 100644
--- a/include/linux/iscsi_ibft.h
+++ b/include/linux/iscsi_ibft.h
@@ -21,12 +21,20 @@
  */
 extern phys_addr_t ibft_phys_addr;
 
+#ifdef CONFIG_ISCSI_IBFT_FIND
+
 /*
  * Routine used to find and reserve the iSCSI Boot Format Table. The
  * physical address is set in the ibft_phys_addr variable.
  */
-#ifdef CONFIG_ISCSI_IBFT_FIND
 void reserve_ibft_region(void);
+
+/*
+ * Physical bounds to search for the iSCSI Boot Format Table.
+ */
+#define IBFT_START 0x80000 /* 512kB */
+#define IBFT_END 0x100000 /* 1MB */
+
 #else
 static inline void reserve_ibft_region(void) {}
 #endif
-- 
2.31.1

