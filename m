Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF44F6594A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 05:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbiL3EWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 23:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiL3EVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 23:21:38 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27FDBC2F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 20:21:26 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F4DD5C0152;
        Thu, 29 Dec 2022 23:21:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 29 Dec 2022 23:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672374086; x=1672460486; bh=iT
        OttKbNR7xkPMRwFqFwNhSHOJKloxjRTq8OiJSL07I=; b=Vjau4z2Cjv9WSC/QJQ
        KFLCgZfn04hK/3uFBesviigBnvowu3buCYgv0sgx7NjjwJsECaqqPKb/86Gfa44X
        lENo1cQVVcnuB/a8KstSqkarlQMerhe+7tJINmbZaF21ZROZIgI3Ui2/wL25jAzn
        20mAt/VTIKxtwNWlZs2dzN6T2Tg9u7FboAcfOA81352JW4fgya4scByMB75Jdtr4
        lhX4CCxsfPblDM/kZwSvUzt+yQAPZ7EgJAzkGzjFXG/gbFCepGXpCVOzg4Dqixjx
        jYgfDLgJ+tBXj3l16zZgVfA+gGbhr1Gv+3n74aah2gQ+o28fKCHdtItsoR7lYDcj
        KHmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672374086; x=1672460486; bh=iTOttKbNR7xkP
        MRwFqFwNhSHOJKloxjRTq8OiJSL07I=; b=fYSOlDwXmFv07ShosbMAKkMWi4MJv
        gs+5tBotLlHPBvn1jnpKJKPnYq3DYfSYfvgz4aekBTvu38y2oKwaFfKZznKJhgeY
        Rs5/zuJDgL0Kudsu9/IcZCMp4fVftbSWHbRX+zX6j68Qm2OQQBm38Iiqxz/iJnHd
        JO/eKgULNoZC/805YfT/c23Ac8s9/Gy/L3oZP+qQVx04n6tZ18Fk1FdlCKs2sTA3
        xzL9L3scAHbA9v7l+pnRka+74RyRrnF7c1bhakE4Er55n5rnqa6+TnJol1z1PWf9
        BUHUvpng31kHa4eTai9cDN92poeQNBBxXVxs/cFtLQyJOdZUQsk8Y4LVw==
X-ME-Sender: <xms:RmeuY0R7EoUpzcMbsRR5WWI6qyJ7KurZSJPkqgw88uRnvwwRR-JLIw>
    <xme:RmeuYxywQyaPqqyEg5bC5r7oEHPO-BHz1bTM_OQSJ2v4OEuGSyuqSUd9LuQkHT1hv
    sSoSWi1Gmv8zTgc6g>
X-ME-Received: <xmr:RmeuYx18O7SWfQUODXag0GHPV66cN1CbWatAkomvzpFJ0TVR5PX9hHHsjnpSiZNUneP-9KgY807ujyJbjIW9ONhPvI4JRSzNBchRZwBL3_rXMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieehgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdeftddmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhr
    vgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecuggftrfgrthhtvghrnhephf
    dvuefgtddvieeigefffeffkeeigedvgfeitdejteffveefhfdtheejffeiiedvnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrse
    hruhhsshgvlhhlrdgttg
X-ME-Proxy: <xmx:RmeuY4BSdQS4zSvpcDifw5Olxe1xuIHVUDwI6gQNIIHckFzcJpMAGg>
    <xmx:RmeuY9jkVpgD_nh6tn3jp8B5nahVlKl_cL_vAUXYa6iPFaaMAvWmrQ>
    <xmx:RmeuY0ocoLb-kt96dbpqnzHKqEjIuK6JXjyR0QtJ-bX7O4Z9G0PnKg>
    <xmx:RmeuY1h5qX1rzDZ_BrQcxlcgqf40y_MeJ091R_6t3eyfLGE7UHJzPg>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 23:21:23 -0500 (EST)
From:   Russell Currey <ruscur@russell.cc>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ajd@linux.ibm.com, zohar@linux.ibm.com, mpe@ellerman.id.au,
        Russell Currey <ruscur@russell.cc>
Subject: [PATCH v2 6/7] powerpc/secvar: Extend sysfs to include config vars
Date:   Fri, 30 Dec 2022 15:20:13 +1100
Message-Id: <20221230042014.154483-7-ruscur@russell.cc>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221230042014.154483-1-ruscur@russell.cc>
References: <20221230042014.154483-1-ruscur@russell.cc>
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

The forthcoming pseries consumer of the secvar API wants to expose a
number of config variables.  Allowing secvar implementations to provide
their own sysfs attributes makes it easy for consumers to expose what
they need to.

This is not being used by the OPAL secvar implementation at present, and
the config directory will not be created if no attributes are set.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
I played around with adding an API call to facilitate a more generic
key/value interface for config variables and it seemed like unnecessary
complexity.  I think this is cleaner.  If there was ever a secvar
interface other than sysfs we'd have to rework it, though.

 arch/powerpc/include/asm/secvar.h  |  3 +++
 arch/powerpc/kernel/secvar-sysfs.c | 40 ++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
index 92d2c051918b..250e7066b6da 100644
--- a/arch/powerpc/include/asm/secvar.h
+++ b/arch/powerpc/include/asm/secvar.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/sysfs.h>
 
 extern const struct secvar_operations *secvar_ops;
 
@@ -27,10 +28,12 @@ struct secvar_operations {
 #ifdef CONFIG_PPC_SECURE_BOOT
 
 extern void set_secvar_ops(const struct secvar_operations *ops);
+extern void set_secvar_config_attrs(const struct attribute **attrs);
 
 #else
 
 static inline void set_secvar_ops(const struct secvar_operations *ops) { }
+static inline void set_secvar_config_attrs(const struct attribute **attrs) { }
 
 #endif
 
diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index aa1daec480e1..ad1e1d72d2ae 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -15,9 +15,17 @@
 
 #define NAME_MAX_SIZE	   1024
 
+const struct attribute **secvar_config_attrs __ro_after_init = NULL;
+
 static struct kobject *secvar_kobj;
 static struct kset *secvar_kset;
 
+void set_secvar_config_attrs(const struct attribute **attrs)
+{
+	WARN_ON_ONCE(secvar_config_attrs);
+	secvar_config_attrs = attrs;
+}
+
 static ssize_t format_show(struct kobject *kobj, struct kobj_attribute *attr,
 			   char *buf)
 {
@@ -134,6 +142,16 @@ static int update_kobj_size(void)
 	return 0;
 }
 
+static int secvar_sysfs_config(struct kobject *kobj)
+{
+	struct attribute_group config_group = {
+		.name = "config",
+		.attrs = (struct attribute **)secvar_config_attrs,
+	};
+
+	return sysfs_create_group(kobj, &config_group);
+}
+
 static int secvar_sysfs_load(void)
 {
 	char *name;
@@ -196,26 +214,38 @@ static int secvar_sysfs_init(void)
 
 	rc = sysfs_create_file(secvar_kobj, &format_attr.attr);
 	if (rc) {
-		kobject_put(secvar_kobj);
-		return -ENOMEM;
+		pr_err("secvar: Failed to create format object\n");
+		rc = -ENOMEM;
+		goto err;
 	}
 
 	secvar_kset = kset_create_and_add("vars", NULL, secvar_kobj);
 	if (!secvar_kset) {
 		pr_err("secvar: sysfs kobject registration failed.\n");
-		kobject_put(secvar_kobj);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto err;
 	}
 
 	rc = update_kobj_size();
 	if (rc) {
 		pr_err("Cannot read the size of the attribute\n");
-		return rc;
+		goto err;
+	}
+
+	if (secvar_config_attrs) {
+		rc = secvar_sysfs_config(secvar_kobj);
+		if (rc) {
+			pr_err("secvar: Failed to create config directory\n");
+			goto err;
+		}
 	}
 
 	secvar_sysfs_load();
 
 	return 0;
+err:
+	kobject_put(secvar_kobj);
+	return rc;
 }
 
 late_initcall(secvar_sysfs_init);
-- 
2.38.1

