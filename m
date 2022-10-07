Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1DC5F7994
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJGOMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJGOM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:12:27 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5AC118761;
        Fri,  7 Oct 2022 07:12:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D6EA35C0048;
        Fri,  7 Oct 2022 10:12:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 07 Oct 2022 10:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1665151944; x=1665238344; bh=mk4xjf3gmZg3rzLSnxLhmfT3y
        ziNUMfMLAV+9Oi1eds=; b=n1BFPXmJcwb4kUmZrtfB+TUTQRvUeyj5uWNA3RYwN
        YxqF9/PwBvgnp7leC8fp5I6TQhQ15ou/JfH3Wx7+FUT7hm3CCo7eXN+yW9/AFPFa
        nNSecqBAs7onGwvd1ecC4pTTcVLtpbhVBW4lndNtRKj7AnrUT+9cMANRawpr1FHS
        7O+VABmLND+tSNzT00guyhXJ9TDBPL8G6IUsJHL2hEfpG4FYJlupwMwijj8Ip/Rf
        5SQYRh2Uktm5Eqqtvfol2EhSNyxB1CKWjHstEXbk0j806bg86NgWY3wNLkAG/4PI
        zWLc/ANyxQXWgw5MP8pdr8rSkYl5U0k7PcLQOIU65mDqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1665151944; x=1665238344; bh=mk4xjf3gmZg3rzLSnxLhmfT3yziNUMfMLAV
        +9Oi1eds=; b=ncZgtoLt619jJWNh8598q3GzjEWw+jItyFuYDNESy/79gZwivSp
        1WjcWpmhGIAlsDdiWMamqXjREwt+BKOLaFu3aVyE0bs6wyDH8G2zpu5JSNCDu2yh
        OkCee7RcuounucErps2dXd2cQw7rqYlzakFs3V+miI2FV4/WSNZXWhxavoU2NFmB
        dQ9xo4d0TPcijUcJjxup9P6Js34dyZbkTXlzBBB7RYOtXBHi8wzGhyJ4kU7Cpnlc
        bTAa9lLWJVOe5pYDB9fSngBmYS/fMdA7Fcn1Ba3BeatzhMBxMTd3r5pemyd/1nD0
        XcyYE3LTKlCuAGhUSizwNQysIL+U6ntjGzw==
X-ME-Sender: <xms:xzNAY3XQ6lv3OidM93C1kqGDvVzSfcpBxDYyguxzBCL5ZzX6MsAh6A>
    <xme:xzNAY_n7FQRLOuN3U1xF2oieTwPBJaLgjKFij23wX0lDJpUh7dLPq7foMaRCXrXtG
    GEabDV8yRYRLvzpWZo>
X-ME-Received: <xmr:xzNAYzZXqqzSUPkT-6hdWdjg_fQgxYIIqKUK1zFL3wOiM89s5ERp510fIgOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeijedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:yDNAYyUSjQ2kPRtv4fvz48r2rVKrwVrrzqV1Vusoicsh5hDXmpJJ0g>
    <xmx:yDNAYxm8vY8ysKC60L6hjadtkIh-oPOBK8aSP_Z8kLD7V3VOMjO3sQ>
    <xmx:yDNAY_coukBrlivTWVprhsQ3d_DyNLQWuc8obE0UaMvJkXZhcN7Ngw>
    <xmx:yDNAY0v6bUA0UnqTNuQZcVFlg-GdFBaB9C_TN8ejgni26aQ1SgHe9Q>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Oct 2022 10:12:22 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-api@vger.kernel.org, greg@kroah.com, f.fainelli@gmail.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v5] MIPS: Expose prid and globalnumber to sysfs
Date:   Fri,  7 Oct 2022 15:12:07 +0100
Message-Id: <20221007141207.30635-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some application would like to know precise model and rev of processor
to do errata workaround or optimization.

Expose them in sysfs as:
/sys/devices/system/cpu/cpuX/regs/identification/prid
/sys/devices/system/cpu/cpuX/regs/identification/globalnumber

Reusing AArch64 CPU registers directory.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Drop static qualifier for kobj (gregkh)
v3: Use kzalloc to allocate struct cpuregs.
    note: When Greg mentioned about static I was thinking about
    static qualifier of percpu variable. After reading documents
    again it turns out kobjs should be allocated at runtime. Arm64's
    cpuinfo kobj is also on a percpu variable... I guess that was a
    intentional use?
v4: Properly handle err of kobj creation. (gregkh)
v5: Drop invalid kfree
---
 .../ABI/testing/sysfs-devices-system-cpu      | 11 +++
 arch/mips/kernel/topology.c                   | 99 +++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 5bf61881f012..9fdfe2de0f76 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -512,6 +512,17 @@ Description:	information about CPUs heterogeneity.
 
 		cpu_capacity: capacity of cpuX.
 
+What:		/sys/devices/system/cpu/cpuX/regs/
+		/sys/devices/system/cpu/cpuX/regs/identification/
+		/sys/devices/system/cpu/cpuX/regs/identification/prid
+		/sys/devices/system/cpu/cpuX/regs/identification/globalnumber
+Date:		October 2022
+Contact:	Linux MIPS Kernel Mailing list <linux-mips@vger.kernel.org>
+Description:	MIPS CPU registers
+
+		'identification' directory exposes the Processor ID and Global Number
+		registers for identifying model and revision of the CPU.
+
 What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/meltdown
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
diff --git a/arch/mips/kernel/topology.c b/arch/mips/kernel/topology.c
index 9429d85a4703..80aaaca3cfbc 100644
--- a/arch/mips/kernel/topology.c
+++ b/arch/mips/kernel/topology.c
@@ -5,6 +5,8 @@
 #include <linux/node.h>
 #include <linux/nodemask.h>
 #include <linux/percpu.h>
+#include <linux/seq_file.h>
+#include <linux/smp.h>
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
@@ -26,3 +28,100 @@ static int __init topology_init(void)
 }
 
 subsys_initcall(topology_init);
+
+static struct kobj_type cpuregs_kobj_type = {
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+struct cpureg {
+	struct kobject kobj;
+	struct cpuinfo_mips *info;
+};
+static DEFINE_PER_CPU(struct cpureg *, cpuregs);
+
+#define kobj_to_cpureg(kobj)	container_of(kobj, struct cpureg, kobj)
+#define CPUREGS_ATTR_RO(_name, _field)						\
+	static ssize_t _name##_show(struct kobject *kobj,			\
+			struct kobj_attribute *attr, char *buf)			\
+	{									\
+		struct cpuinfo_mips *info = kobj_to_cpureg(kobj)->info;		\
+										\
+		return sprintf(buf, "0x%08x\n", info->_field);	\
+	}									\
+	static struct kobj_attribute cpuregs_attr_##_name = __ATTR_RO(_name)
+
+CPUREGS_ATTR_RO(prid, processor_id);
+CPUREGS_ATTR_RO(globalnumber, globalnumber);
+
+static struct attribute *cpuregs_id_attrs[] = {
+	&cpuregs_attr_prid.attr,
+	&cpuregs_attr_globalnumber.attr,
+	NULL
+};
+
+static const struct attribute_group cpuregs_attr_group = {
+	.attrs = cpuregs_id_attrs,
+	.name = "identification"
+};
+
+static int cpuregs_cpu_online(unsigned int cpu)
+{
+	int rc;
+	struct device *dev;
+	struct cpureg *reg;
+
+	dev = get_cpu_device(cpu);
+	if (!dev) {
+		rc = -ENODEV;
+		goto out;
+	}
+	reg = kzalloc(sizeof(struct cpureg), GFP_KERNEL);
+	if (!reg) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	rc = kobject_init_and_add(&reg->kobj, &cpuregs_kobj_type,
+					&dev->kobj, "regs");
+	if (rc)
+		goto out_kobj;
+	rc = sysfs_create_group(&reg->kobj, &cpuregs_attr_group);
+	if (rc)
+		goto out_kobj;
+
+	return 0;
+out_kobj:
+	kobject_put(&reg->kobj);
+out:
+	return rc;
+}
+
+static int cpuregs_cpu_offline(unsigned int cpu)
+{
+	struct device *dev;
+	struct cpureg *reg = per_cpu(cpuregs, cpu);
+
+	dev = get_cpu_device(cpu);
+	if (!dev || !reg)
+		return -ENODEV;
+	if (reg->kobj.parent) {
+		sysfs_remove_group(&reg->kobj, &cpuregs_attr_group);
+		kobject_put(&reg->kobj);
+	}
+
+	return 0;
+}
+
+static int __init cpuinfo_regs_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mips/topology:online",
+				cpuregs_cpu_online, cpuregs_cpu_offline);
+	if (ret < 0) {
+		pr_err("cpuinfo: failed to register hotplug callbacks.\n");
+		return ret;
+	}
+	return 0;
+}
+
+device_initcall(cpuinfo_regs_init);
-- 
2.37.0 (Apple Git-136)

