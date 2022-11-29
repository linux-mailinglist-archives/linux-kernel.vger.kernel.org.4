Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A283A63C356
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiK2PMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiK2PMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:12:49 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Nov 2022 07:12:47 PST
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8DAA441
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669734767;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FKAcdCfqcGrJYFfhNECxRdqUbzNbMUCLFKQUQIe3/uU=;
  b=ECNZYwS/x7zozo+MAKpTIYpLX8Ya2Cb532Nr+VOEo0uCFpe8q+UysKLa
   VTGbwPBmTWXmw9gILRn0r+v9amg8qRhzzk08RATTLGDfUhejAkJj4nu/9
   Idzmi9AZrckLXIJOgeFfbkb8DLcUbfvaBFHQDyhvt31ap5PbvlYVaKS3H
   I=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 88308420
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:sWt9j6354+v2TVIF5/bD5VVxkn2cJEfYwER7XKvMYLTBsI5bp2ZTy
 TMcDWqHb6zZNGb8Lot/bd6zo0MFvZXcmtNnTQtkpC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK5ULSfUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8tuTS9nuDgNyo4GlC5wVkNKgQ1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfJnl/+
 +AaDA43SwGC3dqKg4iCGulRv5F2RCXrFNt3VnBIyDjYCbAtQIzZQrWM7thdtNsyrpkQR7CEP
 ZNfMGcxKkSbC/FMEg5/5JYWpOqywFP+dyZVgFmUubA28y7YywkZPL3FYIqOIozWH509ckCwq
 Wno8WX7WC0hNsHEyn3Y3nyPvtHItHauMG4VPOLhraM76LGJ/UQZDwcXTh28uuWjjVClWMN3L
 FYd8S4j66M18SSDTNPwQhm5q36spQMHVpxbFOhSwBGAzO/Y7hiUAkAATyVdc5o2uckuXzso2
 1SV2dTzClRHt7mYSmmU8LuOmi+jIigeLWIEZigsQBMM5p/op4RbphbOSMtzVa24lNv4HRnuz
 D2Q6isznbMeiYgMzarT1VLImTW3vbDSUxU4oA7QWwqN9RhlbYSoY4ip71nz7vtaKoudCF6bs
 xA5d9O2tb5US8vXzWrUHbtLTOrBC+u53CP0pkZeEYUj0wqX3m+iJ7hsowtHdEdUC5NREdP2W
 3P7tQRU7Z5VGXKla65rfo68Y/gXIbjc+cfNDa6NMIcXCnRlXErepXw1OxbMt4z4uBJ0+ZzTL
 6t3ZipF4ZwyLa18hAS7SO4GuVPA7nBvnDiDLXwXIvnO7FZ/WJJ3Ye1dWLdtRrpjhE9hnOky2
 4g3Cidy408DONASmwGOmWLpEXgELGIgGbf9oNFNe+iIL2JOQT9/WqGPmehwK9M6wcy5c9skG
 VnkCidlJKfX3yWbeW1mlFg8AF8QYXqPhS1iZnF9VbpZ83MifZyu/M8im2gfJNEaGBhY5acsF
 ZEtIpzQasmjvxybo1zxm7Gh9t09HPlq7CrSVxeYjM8XJcQ6GlSXpI+8I2MCNkAmV0KKiCf3m
 JX4viuzfHbJb1QzV646tNrHI4uNgEUg
IronPort-HdrOrdr: A9a23:2/a/mqlzZccVWZBw3+DcwPBe/xjpDfIg3DAbv31ZSRFFG/Fxl6
 iV8sjzsiWE7Ar5OUtQ/+xoV5PhfZqxz/JICOoqTNKftWvdyQiVxehZhOOIqVDd8kXFh4lgPM
 xbEpSWZueeMbEDt7eZ3DWF
X-IronPort-AV: E=Sophos;i="5.96,203,1665460800"; 
   d="scan'208";a="88308420"
From:   Per Bilse <per.bilse@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Per Bilse <per.bilse@citrix.com>, Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: [PATCH] drivers/xen/hypervisor: Expose VM SIF flags to userspace
Date:   Tue, 29 Nov 2022 15:00:57 +0000
Message-ID: <20221129150058.266943-1-per.bilse@citrix.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/xen is a legacy pseudo filesystem which predates Xen support
getting merged into Linux.  It has largely been replaced with more
normal locations for data (/sys/hypervisor/ for info, /dev/xen/ for
user devices).  We want to compile xenfs support out of the dom0 kernel.

There is one item which only exists in /proc/xen, namely
/proc/xen/capabilities with "control_d" being the signal of "you're in
the control domain".  This ultimately comes from the SIF flags provided
at VM start.

This patch exposes all SIF flags in /sys/hypervisor/properties/flags,
which will coexist with /proc/xen while dependencies are being migrated.
Possible values are "privileged", "initdomain", "multiboot",
"mod_start_pfn", and "virtmap", with "initdomain" being the equivalent
of "control_d".

Signed-off-by: Per Bilse <per.bilse@citrix.com>
---
 drivers/xen/sys-hypervisor.c | 26 ++++++++++++++++++++++++++
 include/xen/interface/xen.h  | 13 ++++++++-----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index fcb0792f090e..7393e04bdb6d 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -379,6 +379,31 @@ static ssize_t buildid_show(struct hyp_sysfs_attr *attr, char *buffer)
 
 HYPERVISOR_ATTR_RO(buildid);
 
+static ssize_t flags_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	static char const *const sifstr[SIFN_NUM_SIFN] = {
+		[SIFN_PRIV]  = "privileged",
+		[SIFN_INIT]  = "initdomain",
+		[SIFN_MULTI] = "multiboot",
+		[SIFN_PFN]   = "mod_start_pfn",
+		[SIFN_VIRT]  = "virtmap"
+	};
+	unsigned sifnum, sifmask;
+	ssize_t ret = 0;
+
+	sifmask = ~(~0U << SIFN_NUM_SIFN);  // ...0000111...
+	if (xen_domain() && (xen_start_flags & sifmask) != 0) {
+		for (sifnum = 0; sifnum != SIFN_NUM_SIFN; sifnum++) {
+			if ((xen_start_flags & (1<<sifnum)) != 0)
+				ret += sprintf(buffer+ret, "%s ", sifstr[sifnum]);
+		}
+		buffer[ret-1] = '\n';
+	}
+	return ret;
+}
+
+HYPERVISOR_ATTR_RO(flags);
+
 static struct attribute *xen_properties_attrs[] = {
 	&capabilities_attr.attr,
 	&changeset_attr.attr,
@@ -386,6 +411,7 @@ static struct attribute *xen_properties_attrs[] = {
 	&pagesize_attr.attr,
 	&features_attr.attr,
 	&buildid_attr.attr,
+	&flags_attr.attr,
 	NULL
 };
 
diff --git a/include/xen/interface/xen.h b/include/xen/interface/xen.h
index 0ca23eca2a9c..762a348abe3e 100644
--- a/include/xen/interface/xen.h
+++ b/include/xen/interface/xen.h
@@ -648,11 +648,14 @@ struct start_info {
 };
 
 /* These flags are passed in the 'flags' field of start_info_t. */
-#define SIF_PRIVILEGED      (1<<0)  /* Is the domain privileged? */
-#define SIF_INITDOMAIN      (1<<1)  /* Is this the initial control domain? */
-#define SIF_MULTIBOOT_MOD   (1<<2)  /* Is mod_start a multiboot module? */
-#define SIF_MOD_START_PFN   (1<<3)  /* Is mod_start a PFN? */
-#define SIF_VIRT_P2M_4TOOLS (1<<4)  /* Do Xen tools understand a virt. mapped */
+/* Text strings are printed out in sys-hypervisor.c, we guard   */
+/* against mix-ups and errors by enumerating the flags.         */
+enum { SIFN_PRIV, SIFN_INIT, SIFN_MULTI, SIFN_PFN, SIFN_VIRT, SIFN_NUM_SIFN };
+#define SIF_PRIVILEGED      (1<<SIFN_PRIV)  /* Is the domain privileged? */
+#define SIF_INITDOMAIN      (1<<SIFN_INIT)  /* Is this the initial control domain? */
+#define SIF_MULTIBOOT_MOD   (1<<SIFN_MULTI) /* Is mod_start a multiboot module? */
+#define SIF_MOD_START_PFN   (1<<SIFN_PFN)   /* Is mod_start a PFN? */
+#define SIF_VIRT_P2M_4TOOLS (1<<SIFN_VIRT)  /* Do Xen tools understand a virt. mapped */
 				    /* P->M making the 3 level tree obsolete? */
 #define SIF_PM_MASK       (0xFF<<8) /* reserve 1 byte for xen-pm options */
 
-- 
2.31.1

