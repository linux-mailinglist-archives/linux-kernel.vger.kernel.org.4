Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8D865C066
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbjACNC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbjACNC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:02:27 -0500
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79547EE37
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 05:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1672750946;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q3pBHOUVWnIYdWgJPflbM7j5UuiigUvRijYwk8CcALY=;
  b=gAM80Jc8Rv9TXisWS8kpmuqR7gEmRU4eU97hj3Ks4SQVdT043DqzFCoJ
   blslPHqA/8N/6hr7xi9hpb5ciy7bbE535W2PpxZFphhCjpphaiOClqNoX
   yQJ4THN04MDOiEEvYqeFO88dXV+zZcmaVHqRYnjQKcL8Sr5+0+lCZOhT7
   I=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 89911226
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:D7kuqKjbAIKAlgz3YuoRr//OX161qBAKZh0ujC45NGQN5FlHY01je
 htvWWmGM/iCN2XxedBxad+/o0xTusfSnIBnQFZs+HwwFCob9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmUpH1QMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsy+qWs0N8klgZmP6sT5QeFzyN94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQ6cmo0RCGJodirg/WHFdhIgYcFFsDCadZ3VnFIlVk1DN4jSJHHBa7L+cVZzHE7gcUm8fT2P
 pRDL2A1NVKZPkMJagx/5JEWxY9EglHHficeglORvqcf6GnP1g1hlrPqNbI5f/TaFJQMxxzC+
 Aoq+UypAi88bv6RzgDcrHGC2bCUoSChB6ANQejQGvlC3wTImz175ActfUCgvfCzh0q6WtReA
 08Z4Cwjqe417kPDZt75Uh6jqXiIpCkASsFQGO037gKK4qfM6gPfDW8BJhZRZdpjuMIoSDgC0
 l6Sg8ivFTFpqKeSS3+W6vGTtzzaESwUK3ISICwJVw0I5/H9r4wpyBHCVNBuFOiylNKdMTP/2
 TeRtwAlmq4ey8UM0s2GEUvv2mz24MKTF0hsu1uRDjnNAh5FiJCNRdby0HLq59B6McXecgawm
 H9HvfKXxbVbZX2SrxClTOIIFbCvwv+KNjzAnFJid6UcGySRF22LJt4JvmwnTKt9GoNdIGKyP
 heP0e9EzMULVEZGe5ObdG5Y5y4C6aH7XeroWfnPBjalSsggLVTXlM2CiKP54owMrKTOuftjU
 Xt4WZz2ZZr/NUiA5GTeegvl+eV3rh3SPEuKLXwB8zyp0KCFeFmeQqofPV2FY4gRtf3b+luFr
 4oBa5bVkH2ztdEShQGOqOYuwa0idyBnVfgaVeQNHgJ8HuaWMD54UKKAqV/QU4dkg75Uho/1w
 51JYWcBkACXrSSeeW23hoVLNOuHsWBX8ShqYkTB/D+AhxAeXGpYxP1PLMZvJOJ6rLELIDwdZ
 6BtRvhsy89nElzvkwnxp7GmxGC+XHxHXT6zAhc=
IronPort-HdrOrdr: A9a23:Va8EVat2YcnzdA9hxSrePiDE7skDzdV00zEX/kB9WHVpmwKj9v
 xG+85rsyMc6QxhP03I/OrrBEDuex7hHPJOjbX5eI3SPzUPVgOTXf1fBMjZskDd8xSXzJ8j6U
 4YSdkBNDSTNzhHZLfBkW2F+o0bsaC6GcmT7I+0854ud3AJV0gH1WhE422gYyhLrWd9a6bRPa
 Dsl/Zvln6PeWk3cs/+PXUMRe7Fzue77q7OUFopBwMH9ALLtj+j6Kf7Hx+Ety1uKA9n8PMN8X
 Xljwe83amos+i6xhjAk0ff4o9bgsGJ8KoyOOW8zuYUNxTxgUKTaINtV6bqhkFMnN2S
X-IronPort-AV: E=Sophos;i="5.96,297,1665460800"; 
   d="scan'208";a="89911226"
From:   Per Bilse <per.bilse@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Per Bilse <per.bilse@citrix.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: [PATCH v3] drivers/xen/hypervisor: Expose Xen SIF flags to userspace
Date:   Tue, 3 Jan 2023 13:02:13 +0000
Message-ID: <20230103130213.2129753-1-per.bilse@citrix.com>
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

This patch exposes all SIF flags in /sys/hypervisor/start_flags/ as
boolean files, one for each bit, returning '1' if set, '0' otherwise.
Two known flags, 'privileged' and 'initdomain', are explicitly named,
and all remaining flags can be accessed via generically named files,
as suggested by Andrew Cooper.

Signed-off-by: Per Bilse <per.bilse@citrix.com>
---
v2: minor fix to layout, incorporate suggestions from Juergen Gross
v3: update assumed availability in documentation
---
 Documentation/ABI/stable/sysfs-hypervisor-xen | 13 ++++
 drivers/xen/sys-hypervisor.c                  | 69 +++++++++++++++++--
 2 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-hypervisor-xen b/Documentation/ABI/stable/sysfs-hypervisor-xen
index 748593c64568..be9ca9981bb1 100644
--- a/Documentation/ABI/stable/sysfs-hypervisor-xen
+++ b/Documentation/ABI/stable/sysfs-hypervisor-xen
@@ -120,3 +120,16 @@ Contact:	xen-devel@lists.xenproject.org
 Description:	If running under Xen:
 		The Xen version is in the format <major>.<minor><extra>
 		This is the <minor> part of it.
+
+What:		/sys/hypervisor/start_flags/*
+Date:		March 2023
+KernelVersion:	6.3.0
+Contact:	xen-devel@lists.xenproject.org
+Description:	If running under Xen:
+		All bits in Xen's start-flags are represented as
+		boolean files, returning '1' if set, '0' otherwise.
+		This takes the place of the defunct /proc/xen/capabilities,
+		which would contain "control_d" on dom0, and be empty
+		otherwise.  This flag is now exposed as "initdomain" in
+		addition to the "privileged" flag; all other possible flags
+		are accessible as "unknownXX".
diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index fcb0792f090e..f5460b34ae6f 100644
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
@@ -399,6 +402,60 @@ static int __init xen_sysfs_properties_init(void)
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
+#define FLAG_NODE(flag, node)				\
+	[ilog2(flag)] = {				\
+		.attr = { .name = #node, .mode = 0444 },\
+		.show = flag_show,			\
+		.hyp_attr_value = flag			\
+	}
+
+/*
+ * Add new, known flags here.  No other changes are required, but
+ * note that each known flag wastes one entry in flag_unames[].
+ * The code/complexity machinations to avoid this isn't worth it
+ * for a few entries, but keep it in mind.
+ */
+static struct hyp_sysfs_attr flag_attrs[FLAG_COUNT] = {
+	FLAG_NODE(SIF_PRIVILEGED, privileged),
+	FLAG_NODE(SIF_INITDOMAIN, initdomain)
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
@@ -539,18 +596,22 @@ static int __init hyper_sysfs_init(void)
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
2.31.1

