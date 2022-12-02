Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FF3640D03
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiLBSXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiLBSXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:23:10 -0500
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED76FC2D24
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1670005389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gAOD2HLW+FgGkXa1Ue6HVdt4qLdq0575m3Oy0nWGWHU=;
  b=DSiAbTmpBEZx4wNUsPNiQX9QtJPoa6vii+ZYwi1MAVbLG9xWbNvtp9T7
   GB0mkHjrq+uTotR6kH1UkAb9wWjZfgCDib5sR7c/2xD+0zrYt8oCXbOzm
   o1e+3gwVqqoxXdS+yJRyj7q3RLGm7kPJVPjTqwYgEXdXAv3MvEfLp7Si9
   s=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 86327926
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:Q+OIaqJISpxqNqPwFE+RBpUlxSXFcZb7ZxGr2PjKsXjdYENSgmcPn
 GsZX2GHPKqIYjTwc49xYdi2pE5V7JLczYcyQAZlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHv+kUrWs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpJrfPdwP9TlK6q4mlB5ARkPasjUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c5pG0Bgz
 qdCLgsjSS+fv+7vwLyCaeRj05FLwMnDZOvzu1llxDDdS/0nXYrCU+PB4towMDUY354UW6yEP
 oxANGQpPE+ojx5nYz/7DLoGkf3urHj7aDBwo1OJv6snpWPUyWSd1ZC9boGPJY3QG625mG6lp
 TnG4T3GHyhdE8LF0yW4/3WAnN7AyHaTtIU6S+Tjq68CbEeo7ncIFBQcWF+/oP+4ok2zQdRSL
 woT4CVGha82+U+wR9/xRSqksWWEtR4RXdlXO+Ai4QTLwa3Riy6JC25BQjNfZdgOsM4tWSdsx
 lKPh8nuBzFkrPuSU3313rOVqy6ifCsYN2kPYQcaQgYfpdruuoc+ilTIVNkLOKy6lNruAhnr3
 iuH6iM5gt0uYdUjjvvhuwqd2nT1+8aPHlVdChjrsnyN8BlYSrX+PYqTx3/k8c5MdYaXd3qMs
 y1R8ySB19wmAZaInS2LZewCGrC1+vqIWAHhbU5T84oJrGr0pSP6FWxEyHQnfRoybJ5YEdP8S
 BWL0T698qO/K5dDgUVfR4uqQ/onwqH7fTgOfqCFN4EeCnSdmeLuwc2PWaJy9zq1+KTPuftlU
 Xt+TSpLJShyNEif5GDqL9rxKJdyrszE+UvdRIrg0zOs2qeEaXieRN8taQXQP7Fgvf3d+1uMr
 r6z0vdmLD0GAIXDjtT/q9ZPfTjm01BkbXwJlyCnXrHaeVc3cI3QI/TQ3akga+RYc1d9z4/1E
 oWGchYAkjLX3CSXQThmn1g/MNsDq74j9yNkVcHtVH70s0UejXGHtfZGJ8RpIOh/pISOD5dcF
 pE4RilJOdwXIhyvxtjXRcCVQFBKHPhzuT+zAg==
IronPort-HdrOrdr: A9a23:UAKW7KhXLCEgjmdBWDdH9M2+DHBQXssji2hC6mlwRA09TyX4rb
 HMoB1/73SftN9/YhwdcK+7Scu9qB/nmaKdgrNwAV7BZmfbUQKTRelfBODZogEIdReQygdV79
 YET5RD
X-IronPort-AV: E=Sophos;i="5.96,213,1665460800"; 
   d="scan'208";a="86327926"
From:   Per Bilse <per.bilse@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Per Bilse <per.bilse@citrix.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: [PATCH] drivers/xen/hypervisor: Expose Xen SIF flags to userspace
Date:   Fri, 2 Dec 2022 18:22:54 +0000
Message-ID: <20221202182254.784808-1-per.bilse@citrix.com>
X-Mailer: git-send-email 2.30.2
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

This patch exposes all SIF flags in /sys/hypervisor/start_flags/ as
boolean files, one for each bit, returning '1' if set, '0' otherwise.
Two known flags, 'privileged' and 'initdomain', are explicitly named,
and all remaining flags can be accessed via generically named files,
as suggested by Andrew Cooper.

This patch replaces previous suggestion for SIF flags exposure in its
entirety.

Signed-off-by: Per Bilse <per.bilse@citrix.com>
---
 Documentation/ABI/stable/sysfs-hypervisor-xen |  8 +++
 drivers/xen/sys-hypervisor.c                  | 70 +++++++++++++++++--
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-hypervisor-xen b/Documentation/ABI/stable/sysfs-hypervisor-xen
index 748593c64568..f52f98548184 100644
--- a/Documentation/ABI/stable/sysfs-hypervisor-xen
+++ b/Documentation/ABI/stable/sysfs-hypervisor-xen
@@ -120,3 +120,11 @@ Contact:	xen-devel@lists.xenproject.org
 Description:	If running under Xen:
 		The Xen version is in the format <major>.<minor><extra>
 		This is the <minor> part of it.
+
+What:		/sys/hypervisor/start_flags/*
+Date:		December 2022
+KernelVersion:	6.1.0
+Contact:	xen-devel@lists.xenproject.org
+Description:	If running under Xen:
+		All bits in Xen's start-flags are represented as
+		boolean files, returning '1' if set, '0' otherwise.
diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index fcb0792f090e..e15d3ff2c56f 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -31,7 +31,10 @@ struct hyp_sysfs_attr {
 	struct attribute attr;
 	ssize_t (*show)(struct hyp_sysfs_attr *, char *);
 	ssize_t (*store)(struct hyp_sysfs_attr *, const char *, size_t);
-	void *hyp_attr_data;
+	union {
+		void *hyp_attr_data;
+		unsigned long hyp_attr_value;
+	};
 };
 
 static ssize_t type_show(struct hyp_sysfs_attr *attr, char *buffer)
@@ -399,6 +402,61 @@ static int __init xen_sysfs_properties_init(void)
 	return sysfs_create_group(hypervisor_kobj, &xen_properties_group);
 }
 
+#define FLAG_UNAME "unknown"
+#define FLAG_UNAME_FMT FLAG_UNAME "%02u"
+#define FLAG_UNAME_MAX sizeof(FLAG_UNAME "XX")
+#define FLAG_COUNT (sizeof(xen_start_flags) * BITS_PER_BYTE)
+static_assert(sizeof(xen_start_flags) 
+		<= sizeof_field(struct hyp_sysfs_attr, hyp_attr_value));
+
+static ssize_t flag_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	char *p = buffer;
+
+	*p++ = '0' + ((xen_start_flags & attr->hyp_attr_value) != 0);
+	*p++ = '\n';
+	return p - buffer;
+}
+
+/*
+* Add new, known flags here.  No other changes are required, but
+* note that each known flag wastes one entry in flag_unames[].
+* The code/complexity machinations to avoid this isn't worth it
+* for a few entries, but keep it in mind.
+*/
+static struct hyp_sysfs_attr flag_attrs[FLAG_COUNT] = {
+	[ilog2(SIF_PRIVILEGED)] = {
+		.attr = { .name = "privileged", .mode = 0444 },
+		.show = flag_show,
+		.hyp_attr_value = SIF_PRIVILEGED
+	},
+	[ilog2(SIF_INITDOMAIN)] = {
+		.attr = { .name = "initdomain", .mode = 0444 },
+		.show = flag_show,
+		.hyp_attr_value = SIF_INITDOMAIN
+	}
+};
+static struct attribute_group xen_flags_group = {
+	.name = "start_flags",
+	.attrs = (struct attribute *[FLAG_COUNT + 1]){}
+};
+static char flag_unames[FLAG_COUNT][FLAG_UNAME_MAX];
+
+static int __init xen_sysfs_flags_init(void)
+{
+	for (unsigned fnum = 0; fnum != FLAG_COUNT; fnum++) {
+		if (likely(flag_attrs[fnum].attr.name == NULL)) {
+			sprintf(flag_unames[fnum], FLAG_UNAME_FMT, fnum);
+			flag_attrs[fnum].attr.name = flag_unames[fnum];
+			flag_attrs[fnum].attr.mode = 0444;
+			flag_attrs[fnum].show = flag_show;
+			flag_attrs[fnum].hyp_attr_value = 1 << fnum;
+		}
+		xen_flags_group.attrs[fnum] = &flag_attrs[fnum].attr;
+	}
+	return sysfs_create_group(hypervisor_kobj, &xen_flags_group);
+}
+
 #ifdef CONFIG_XEN_HAVE_VPMU
 struct pmu_mode {
 	const char *name;
@@ -539,18 +597,22 @@ static int __init hyper_sysfs_init(void)
 	ret = xen_sysfs_properties_init();
 	if (ret)
 		goto prop_out;
+	ret = xen_sysfs_flags_init();
+	if (ret)
+		goto flags_out;
 #ifdef CONFIG_XEN_HAVE_VPMU
 	if (xen_initial_domain()) {
 		ret = xen_sysfs_pmu_init();
 		if (ret) {
-			sysfs_remove_group(hypervisor_kobj,
-					   &xen_properties_group);
-			goto prop_out;
+			sysfs_remove_group(hypervisor_kobj, &xen_flags_group);
+			goto flags_out;
 		}
 	}
 #endif
 	goto out;
 
+flags_out:
+	sysfs_remove_group(hypervisor_kobj, &xen_properties_group);
 prop_out:
 	sysfs_remove_file(hypervisor_kobj, &uuid_attr.attr);
 uuid_out:
-- 
2.30.2

