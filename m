Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D62A6573AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiL1Hb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiL1Hax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:30:53 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CA7F58C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 23:30:50 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6EB24320092F;
        Wed, 28 Dec 2022 02:30:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 28 Dec 2022 02:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672212648; x=1672299048; bh=44
        +zc9E97R2R+SFM8ijIWLMom02/6ELql1sdLwVrY1I=; b=l7UZcfnvVrgpjuqggC
        Grdzit/mHSAE89fMlshNIlrwdZeGWWDA/npS/KWuPQ91qeRAbvcG5b2eUVos4xLI
        zy5Q7NbkB52OZoZrvKsS9/sdQ0NKaQ/bgyBawS1MmK+1goOte3Aiv5Q6cVQpczGZ
        V26wyMxlZWfpNeakM571Ls2cOhBHQWuaspCWtJDKomYszY6Dpvtsf1GSDAD/C+lc
        EeV+aEj3SLNyTpbjnLqZnOUggp6cn3qmBoo6EEOg/MlNBHjCTpmvKBR55vWjvGoY
        CrEFKjGow14oT3LhVsaey6tLPEBvrB2+ZkbKBE7aAaGXlEN1KgtdycxjW/1MtSPa
        goOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672212648; x=1672299048; bh=44+zc9E97R2R+
        SFM8ijIWLMom02/6ELql1sdLwVrY1I=; b=a+FKGEmrCQDz5LdzK7YgTWJP8kHeA
        7tIm8KB81tCZ5BRzj4R8qIZxJin3Yy034f/bEGMdVpD1ZD5YXu4eApwhu+APpC5T
        SsHHxSt6mbZgPiwQ2Y5WiEaNJ2laTB4/CMXvVlMBd5NwN7ibzcwsC0pa37iERyhZ
        xfTLeXbNGe9UNDSm+7TKdsU8IxUEbw7qi6Sqk/aHxsXshMQXt+GIJlPCZjF7xwHW
        4ywcpPCY4H9n6GUbKwLt/16Plo6Uig07X+r8if6PYQBsJYmIlwj4DRnbYnBU7KbH
        KuBcZrlMy2zyOGSQ/4OdiCI7Ylb26FDOuNbpuB0lmHY+YciXsE+qY5Sbg==
X-ME-Sender: <xms:qPCrY4h-jljC3IVwVebMNIPUGPu_2bAYNmHCUnJjtcd4PpxYZ2CEZw>
    <xme:qPCrYxAssJcSnKaBklmaAu7jVm1u9zpeIulZqxFH3KPzU-mmMTR4irUHuK9yODYxB
    X02Re9S_aulxfHyjg>
X-ME-Received: <xmr:qPCrYwF7uVO00zE3EsRbB36-NdXKNvZ33yWb1m-ox0n_ExzknQwvrhzLq3Q_GMAFrXS6e99q0gbeirdFwmM69-z30xl6Q8eyuL8Luh1RFGwlxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedugddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdludehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftuhhsshgvlhhlucevuhhr
    rhgvhicuoehruhhstghurhesrhhushhsvghllhdrtggtqeenucggtffrrghtthgvrhhnpe
    fhvdeugfdtvdeiieegffefffekieegvdfgiedtjeetffevfefhtdehjeffieeivdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurh
    esrhhushhsvghllhdrtggt
X-ME-Proxy: <xmx:qPCrY5SxS9Jda83c2q42KLzZ4WfP747IoYZPkJqGKY1ow2sO3FjXkQ>
    <xmx:qPCrY1xYedSdB7NCQ5kkGCzFlU9yIiZcmkoVuLCtcOj1ujPe4CD0NA>
    <xmx:qPCrY37jwzr3pSM9kq7WPQYs5P9JQiGDaIwB9Dur3CuxU3c_u8lALQ>
    <xmx:qPCrY0zavM0npJNkXHj0dtVgw5nfjRMpCQZvWX2zGBcrQ3yKLdlPZQ>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 02:30:45 -0500 (EST)
From:   Russell Currey <ruscur@russell.cc>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ajd@linux.ibm.com, zohar@linux.ibm.com, mpe@ellerman.id.au,
        Russell Currey <ruscur@russell.cc>
Subject: [PATCH 6/6] powerpc/pseries: Implement secvars for dynamic secure boot
Date:   Wed, 28 Dec 2022 18:29:43 +1100
Message-Id: <20221228072943.429266-7-ruscur@russell.cc>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221228072943.429266-1-ruscur@russell.cc>
References: <20221228072943.429266-1-ruscur@russell.cc>
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

The pseries platform can support dynamic secure boot (i.e. secure boot
using user-defined keys) using variables contained with the PowerVM LPAR
Platform KeyStore (PLPKS).  Using the powerpc secvar API, expose the
relevant variables for pseries dynamic secure boot through the existing
secvar filesystem layout.

The relevant variables for dynamic secure boot are signed in the
keystore, and can only be modified using the H_PKS_SIGNED_UPDATE hcall.
Object labels in the keystore are encoded using ucs2 format.  With our
fixed variable names we don't have to care about encoding outside of the
necessary byte padding.

When a user writes to a variable, the first 8 bytes of data must contain
the signed update flags as defined by the hypervisor.

When a user reads a variable, the first 4 bytes of data contain the
policies defined for the object.

Limitations exist due to the underlying implementation of sysfs binary
attributes, as is the case for the OPAL secvar implementation -
partial writes are unsupported and writes cannot be larger than PAGE_SIZE.

Co-developed-by: Nayna Jain <nayna@linux.ibm.com>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Co-developed-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 Documentation/ABI/testing/sysfs-secvar        |   8 +
 arch/powerpc/platforms/pseries/Kconfig        |  13 +
 arch/powerpc/platforms/pseries/Makefile       |   4 +-
 arch/powerpc/platforms/pseries/plpks-secvar.c | 250 ++++++++++++++++++
 4 files changed, 273 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks-secvar.c

diff --git a/Documentation/ABI/testing/sysfs-secvar b/Documentation/ABI/testing/sysfs-secvar
index feebb8c57294..e6fef664c9c8 100644
--- a/Documentation/ABI/testing/sysfs-secvar
+++ b/Documentation/ABI/testing/sysfs-secvar
@@ -44,3 +44,11 @@ Contact:	Nayna Jain <nayna@linux.ibm.com>
 Description:	A write-only file that is used to submit the new value for the
 		variable. The size of the file represents the maximum size of
 		the variable data that can be written.
+
+What:		/sys/firmware/secvar/config
+Date:		December 2022
+Contact:	Nayna Jain <nayna@linux.ibm.com>
+Description:	This optional directory contains read-only config attributes as
+		defined by the secure variable implementation.  All data is in
+		ASCII format. The directory is only created if the backing
+		implementation provides variables to populate it.
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index a3b4d99567cb..94e08c405d50 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -162,6 +162,19 @@ config PSERIES_PLPKS
 
 	  If unsure, select N.
 
+config PSERIES_PLPKS_SECVAR
+	depends on PSERIES_PLPKS
+	depends on PPC_SECURE_BOOT
+	bool "Support for the PLPKS secvar interface"
+	help
+	  PowerVM can support dynamic secure boot with user-defined keys
+	  through the PLPKS. Keystore objects used in dynamic secure boot
+	  can be exposed to the kernel and userspace through the powerpc
+	  secvar infrastructure. Select this to enable the PLPKS backend
+	  for secvars for use in pseries dynamic secure boot.
+
+	  If unsure, select N.
+
 config PAPR_SCM
 	depends on PPC_PSERIES && MEMORY_HOTPLUG && LIBNVDIMM
 	tristate "Support for the PAPR Storage Class Memory interface"
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 92310202bdd7..807756991f9d 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -27,8 +27,8 @@ obj-$(CONFIG_PAPR_SCM)		+= papr_scm.o
 obj-$(CONFIG_PPC_SPLPAR)	+= vphn.o
 obj-$(CONFIG_PPC_SVM)		+= svm.o
 obj-$(CONFIG_FA_DUMP)		+= rtas-fadump.o
-obj-$(CONFIG_PSERIES_PLPKS) += plpks.o
-
+obj-$(CONFIG_PSERIES_PLPKS)	+= plpks.o
+obj-$(CONFIG_PSERIES_PLPKS_SECVAR)	+= plpks-secvar.o
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PPC_VAS)		+= vas.o vas-sysfs.o
 
diff --git a/arch/powerpc/platforms/pseries/plpks-secvar.c b/arch/powerpc/platforms/pseries/plpks-secvar.c
new file mode 100644
index 000000000000..3f9ff16c03c8
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/plpks-secvar.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Secure variable implementation using the PowerVM LPAR Platform KeyStore (PLPKS)
+ *
+ * Copyright 2022, IBM Corporation
+ * Authors: Russell Currey
+ *          Andrew Donnellan
+ *          Nayna Jain
+ */
+
+#define pr_fmt(fmt) "secvar: "fmt
+
+#include <linux/printk.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/kobject.h>
+#include <asm/secvar.h>
+#include "plpks.h"
+
+// Config attributes for sysfs
+#define PLPKS_CONFIG_ATTR(name, fmt, func)			\
+	static ssize_t name##_show(struct kobject *kobj,	\
+				   struct kobj_attribute *attr,	\
+				   char *buf)			\
+	{							\
+		return sprintf(buf, fmt, func());		\
+	}							\
+	static struct kobj_attribute attr_##name = __ATTR_RO(name)
+
+PLPKS_CONFIG_ATTR(version, "%u\n", plpks_get_version);
+PLPKS_CONFIG_ATTR(object_overhead, "%u\n", plpks_get_objoverhead);
+PLPKS_CONFIG_ATTR(max_password_size, "%u\n", plpks_get_maxpwsize);
+PLPKS_CONFIG_ATTR(max_object_size, "%u\n", plpks_get_maxobjectsize);
+PLPKS_CONFIG_ATTR(max_object_label_size, "%u\n", plpks_get_maxobjectlabelsize);
+PLPKS_CONFIG_ATTR(total_size, "%u\n", plpks_get_totalsize);
+PLPKS_CONFIG_ATTR(used_space, "%u\n", plpks_get_usedspace);
+PLPKS_CONFIG_ATTR(supported_policies, "%08x\n", plpks_get_supportedpolicies);
+PLPKS_CONFIG_ATTR(max_large_object_size, "%u\n", plpks_get_maxlargeobjectsize);
+PLPKS_CONFIG_ATTR(signed_update_algorithms, "%016llx\n", plpks_get_signedupdatealgorithms);
+
+static const struct attribute *config_attrs[] = {
+	&attr_version.attr,
+	&attr_object_overhead.attr,
+	&attr_max_password_size.attr,
+	&attr_max_object_size.attr,
+	&attr_max_object_label_size.attr,
+	&attr_total_size.attr,
+	&attr_used_space.attr,
+	&attr_supported_policies.attr,
+	&attr_max_large_object_size.attr,
+	&attr_signed_update_algorithms.attr,
+	NULL,
+};
+
+static u16 get_ucs2name(const char *name, uint8_t **ucs2_name)
+{
+	int namelen = strlen(name) * 2;
+	*ucs2_name = kzalloc(namelen, GFP_KERNEL);
+
+	if (!*ucs2_name)
+		return 0;
+
+	for (int i = 0; name[i]; i++) {
+		(*ucs2_name)[i * 2] = name[i];
+		(*ucs2_name)[i * 2 + 1] = '\0';
+	}
+
+	return namelen;
+}
+
+static u32 get_policy(const char *name)
+{
+	if ((strcmp(name, "db") == 0) ||
+	    (strcmp(name, "dbx") == 0) ||
+	    (strcmp(name, "grubdb") == 0) ||
+	    (strcmp(name, "sbat") == 0))
+		return (WORLDREADABLE | SIGNEDUPDATE);
+	else
+		return SIGNEDUPDATE;
+}
+
+#define PLPKS_SECVAR_COUNT 8
+static char *var_names[PLPKS_SECVAR_COUNT] = {
+	"PK",
+	"KEK",
+	"db",
+	"dbx",
+	"grubdb",
+	"sbat",
+	"moduledb",
+	"trustedcadb",
+};
+
+static int plpks_get_variable(const char *key, uint64_t key_len,
+			      u8 *data, uint64_t *data_size)
+{
+	struct plpks_var var = {0};
+	u16 ucs2_namelen;
+	u8 *ucs2_name;
+	int rc = 0;
+
+	ucs2_namelen = get_ucs2name(key, &ucs2_name);
+	if (!ucs2_namelen)
+		return -ENOMEM;
+
+	var.name = ucs2_name;
+	var.namelen = ucs2_namelen;
+	var.os = PLPKS_VAR_LINUX;
+	rc = plpks_read_os_var(&var);
+
+	if (rc)
+		goto err;
+
+	*data_size = var.datalen + sizeof(var.policy);
+
+	// We can be called with data = NULL to just get the object size.
+	if (data) {
+		memcpy(data, &var.policy, sizeof(var.policy));
+		memcpy(data + sizeof(var.policy), var.data, var.datalen);
+	}
+
+	kfree(var.data);
+err:
+	kfree(ucs2_name);
+	return rc;
+}
+
+static int plpks_set_variable(const char *key, uint64_t key_len,
+			      u8 *data, uint64_t data_size)
+{
+	struct plpks_var var = {0};
+	u16 ucs2_namelen;
+	u8 *ucs2_name;
+	int rc = 0;
+	u64 flags;
+
+	// Secure variables need to be prefixed with 8 bytes of flags.
+	// We only want to perform the write if we have at least one byte of data.
+	if (data_size <= sizeof(flags))
+		return -EINVAL;
+
+	ucs2_namelen = get_ucs2name(key, &ucs2_name);
+	if (!ucs2_namelen)
+		return -ENOMEM;
+
+	memcpy(&flags, data, sizeof(flags));
+
+	var.datalen = data_size - sizeof(flags);
+	var.data = kzalloc(var.datalen, GFP_KERNEL);
+	if (!var.data) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	memcpy(var.data, data + sizeof(flags), var.datalen);
+
+	var.name = ucs2_name;
+	var.namelen = ucs2_namelen;
+	var.os = PLPKS_VAR_LINUX;
+	var.policy = get_policy(key);
+
+	rc = plpks_signed_update_var(var, flags);
+
+	kfree(var.data);
+err:
+	kfree(ucs2_name);
+	return rc;
+}
+
+/*
+ * get_next() in the secvar API is designed for the OPAL API.
+ * If *key is 0, it returns the first variable in the keystore.
+ * Otherwise, you pass the name of a key and it returns next in line.
+ *
+ * We're going to cheat here - since we have fixed keys and don't care about
+ * key_len, we can just use it as an index.
+ */
+static int plpks_get_next_variable(const char *key, uint64_t *key_len, uint64_t keybufsize)
+{
+	if (!key || !key_len)
+		return -EINVAL;
+
+	if (*key_len >= PLPKS_SECVAR_COUNT)
+		return -ENOENT;
+
+	if (strscpy((char *)key, var_names[(*key_len)++], keybufsize) < 0)
+		return -E2BIG;
+
+	return 0;
+}
+
+// PLPKS dynamic secure boot doesn't give us a format string in the same way OPAL does.
+// Instead, report the format using the SB_VERSION variable in the keystore.
+static ssize_t plpks_secvar_format(char *buf)
+{
+	struct plpks_var var = {0};
+	ssize_t ret;
+
+	var.component = NULL;
+	// Only the signed variables have ucs2-encoded names, this one doesn't
+	var.name = "SB_VERSION";
+	var.namelen = 10;
+	var.datalen = 0;
+	var.data = NULL;
+
+	// Unlike the other vars, SB_VERSION is owned by firmware instead of the OS
+	ret = plpks_read_fw_var(&var);
+	if (ret) {
+		if (ret == -ENOENT)
+			return sprintf(buf, "ibm,plpks-sb-unknown\n");
+
+		pr_err("Error %ld reading SB_VERSION from firmware\n", ret);
+		return ret;
+	}
+
+	// Hypervisor defines SB_VERSION as a "1 byte unsigned integer value"
+	ret = sprintf(buf, "ibm,plpks-sb-%hhu\n", var.data[0]);
+
+	kfree(var.data);
+	return ret;
+}
+
+static int plpks_max_size(uint64_t *max_size)
+{
+	*max_size = (uint64_t)plpks_get_maxobjectsize();
+
+	return 0;
+}
+
+
+static const struct secvar_operations plpks_secvar_ops = {
+	.get = plpks_get_variable,
+	.get_next = plpks_get_next_variable,
+	.set = plpks_set_variable,
+	.format = plpks_secvar_format,
+	.max_size = plpks_max_size,
+};
+
+static int plpks_secvar_init(void)
+{
+	if (!plpks_is_available())
+		return -ENODEV;
+
+	set_secvar_ops(&plpks_secvar_ops);
+	set_secvar_config_attrs(config_attrs);
+	return 0;
+}
+device_initcall(plpks_secvar_init);
-- 
2.38.1

