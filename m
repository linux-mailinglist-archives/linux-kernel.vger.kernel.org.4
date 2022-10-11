Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F2C5FB116
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJKLKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJKLKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:10:05 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D725C11A0A;
        Tue, 11 Oct 2022 04:10:00 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A8AD93200983;
        Tue, 11 Oct 2022 07:09:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 11 Oct 2022 07:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1665486596; x=1665572996; bh=ua7Nyh85XFVll13jSOnPQNcQr
        tUvqtku7ANNgc6cAo0=; b=oe/I9u21BBIuiWtVCHWUKd87rev3V/BYMhQiMSkvr
        BG8Txs0oU9hPsl2euGRNkWCx6uHWgxIcrZaGfgsGjZoRi1Wjo1ZN3Ee2y8HRxC29
        alh963AzBpZlhdps9Sjv1ZE5aTdcNWQFkQrPb3ltpk843FkzTh0VAN5T1eV6+pMe
        mdX4fmjgHEquemFEmJBj9XKblrlHxOAAJPziUg1VThjHOiWIPhfi7cNSyeq5wvTS
        zv0qUk3gTewDlkawmAvasrGvHApewbSlVdZPkepJZtpGipom2gUHDb1nnVhQdSae
        1pSAuUBNM4Gu7BCq3sC19dd6BgL8r17uqmJj8aFyxTOXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1665486596; x=1665572996; bh=ua7Nyh85XFVll13jSOnPQNcQrtUvqtku7AN
        Ngc6cAo0=; b=DSP6gftXA7xPjqGV4fJqddQJcoYpGW0b1LNSyiFn7bURBOeP5PQ
        lCzRWdDG76nQza9GCVC55iyq+lYBW0CrVC3YfaroIHFPVATt+MdN2XtQyPV3lD5R
        jRO7KpOjt0gbgfdIGWEDxz8vZ1upglQWcZpTfDl8xfrypRVQN2vylF2gqNqObk/B
        4XkM2ag73RxpDdLo0aZbBla+DF5D2uXg/00m2rUDPBAboe3iFUeBFfldj3IS2RXn
        dUyWyJ8yNRoSj4akKDRoafJSb2/dA9wdYH/SEvOfDc5dth6BuDClC7WXJBgr/XgE
        aAnQZpfJThINwnbQco2Oqcsi9VEistMwLrw==
X-ME-Sender: <xms:A09FY6IpJqQAPBNOOfdqUhGfHubdshi2X5lEu4ZOwEJimmv2jWNp8A>
    <xme:A09FYyJi9VKDKzIkS8IIbXjQpgAgkG2S-2aGcAtGhzkO7ky7dG5sYe6oFpZDeeejk
    IO1uvUUwajxhggjACw>
X-ME-Received: <xmr:A09FY6usXbM8cdPT3-OltTQZhTWXMpPYeat3Ox9p1QmhtJm6P5BeNLPNwijK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:A09FY_aSi0SC7i1hmZvXNsKyarmvmeCD0w-4QcmJ48Tr7cc5cb2gbA>
    <xmx:A09FYxZbgqDk4C2Wd88F3YbzAkA-q7I4-3IsePnR66Uaf8IzCf4_hw>
    <xmx:A09FY7AohQLBPxDmUxsjbDylexED_oNcRE3HIzxNZHhyzy4JKisbzg>
    <xmx:BE9FY0xyhnU-0Mn10nfQuURp4U_Xp_zB2eWcayOfvmSjbAIVOfHPlQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Oct 2022 07:09:54 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-api@vger.kernel.org, greg@kroah.com, f.fainelli@gmail.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v6] MIPS: Expose prid and globalnumber to sysfs
Date:   Tue, 11 Oct 2022 12:09:51 +0100
Message-Id: <20221011110951.93404-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v6: Correct offline routine, use kobject_put
---
 .../ABI/testing/sysfs-devices-system-cpu      |  9 ++
 arch/mips/kernel/topology.c                   | 97 +++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 5bf61881f012..9dea45ad5a22 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -512,6 +512,15 @@ Description:	information about CPUs heterogeneity.
 
 		cpu_capacity: capacity of cpuX.
 
+What:		/sys/devices/system/cpu/cpuX/regs/identification/prid
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
index 9429d85a4703..85588ffd6bac 100644
--- a/arch/mips/kernel/topology.c
+++ b/arch/mips/kernel/topology.c
@@ -5,6 +5,8 @@
 #include <linux/node.h>
 #include <linux/nodemask.h>
 #include <linux/percpu.h>
+#include <linux/seq_file.h>
+#include <linux/smp.h>
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
@@ -26,3 +28,98 @@ static int __init topology_init(void)
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
+		return sysfs_emit(buf, "0x%08x\n", info->_field);	\
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
+	reg->info = &cpu_data[cpu];
+
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
+	struct cpureg *reg = per_cpu(cpuregs, cpu);
+
+	if (!reg)
+		return -ENODEV;
+	sysfs_remove_group(&reg->kobj, &cpuregs_attr_group);
+	kobject_put(&reg->kobj);
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

