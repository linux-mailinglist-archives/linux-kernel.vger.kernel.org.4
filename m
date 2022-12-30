Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7C6594A4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 05:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiL3EWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 23:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbiL3EVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 23:21:24 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DB62DE1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 20:21:23 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B1CE5C0327;
        Thu, 29 Dec 2022 23:21:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 29 Dec 2022 23:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672374083; x=1672460483; bh=72
        W0OI05DA+JHi5r5u4GIP3geuabyTmRWs9HRRGhXa4=; b=noEHZLOKfwEayFpy7M
        Lkdjv+FpOghAHpvBwzQPIa8ccbfOKptS5Wnjs+4nOGuv47qIiEw36sy51OFa1opb
        1rvbtnNuyBjxB2jstDY6n9DCbYjdjbS53JfPIuq1a/YHgj6TYmIecADVZ+4f8Vfx
        6oMOA+i38bRlYTeGCm1v/7DEr4Vmw521r1Pq2hESaHXysM+Y/aXhrp2CfE5vcNrc
        24DPcgUD7rKm4BO3l2U8ZwD2QlvPFSmVZ337G7tpUMCNha++2jCjoIqarcMLVEfZ
        3TERlqEwylm+eiFBisyLBLhRLsf6LB7OfhvXxF7yrJg00eSzOHA4//KqSSYLTrKb
        g1uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672374083; x=1672460483; bh=72W0OI05DA+JH
        i5r5u4GIP3geuabyTmRWs9HRRGhXa4=; b=oz6/6eAjEPtOxB4ASiBh7l7sn2emL
        EpEoznL1UlztE9eK540gu9Qa4SBYAUgh/rQdl4jPrj7MXjcTR1Rm2x5O99rOIzP8
        K1B6LTZdWdAB/GfZqS0sr81sCKSg/xs744aTcTU354vPb7Pw6ccJgGO/XRIdtvzf
        6kB0vfGXrxt/5VpnK0bnpkABen4A0uV2kXEf6q/pn9eVqajkU2B4RfFy4Rci29r8
        aZIroLEXNYmvZB8l3wTKN9nu16XDLdmsYxjhXXCvLhoQCkWsDAGovRwGOCuqPLhx
        PrZvaFCzBs1J/BXxtW7rLIagvc/tig5XAKOqvfMhuEQ+s01onzgV0GkMw==
X-ME-Sender: <xms:QmeuYxd6P4yn9awaV5RDaUyNfYKKObn1IJfIGiULnvlnp1M4xuyYmg>
    <xme:QmeuY_PB4YXff6a230p3HiipuKEsJwnBqypeRTj1D0670elmtRLVRiEkPXKm_tD8O
    e5X-eS84ksJgTTISg>
X-ME-Received: <xmr:QmeuY6g-xFKVnbhx1CTxOD_9YTf86sQEBSEcwKG_VYOerLfY74fEGpgVLhOEHT4IAT9si5Rw-09rR0fXw9NwIxALQfb7ndLjiuJD36UDAf-t8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieehgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdeftddmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhr
    vgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecuggftrfgrthhtvghrnhephf
    dvuefgtddvieeigefffeffkeeigedvgfeitdejteffveefhfdtheejffeiiedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrse
    hruhhsshgvlhhlrdgttg
X-ME-Proxy: <xmx:QmeuY68JnUVLZK1m9O0fq6gTT5FBqMaz0She9V8JYbIGTPvwKGq3Zw>
    <xmx:QmeuY9sdKKZPsRF6TApoSKsKrjDYSZLN5EbBGw9AYBP9CtBFxWm3aQ>
    <xmx:QmeuY5EUsrqBHughV-D0dCzOjhSaHSb10OzAUf6O7HqOnuSzV7u76g>
    <xmx:Q2euY--uW7ac7LNMpW5thOBcxfqRnfgabKQIdC38ykywP85C3rrhbA>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 23:21:19 -0500 (EST)
From:   Russell Currey <ruscur@russell.cc>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ajd@linux.ibm.com, zohar@linux.ibm.com, mpe@ellerman.id.au,
        Russell Currey <ruscur@russell.cc>
Subject: [PATCH v2 5/7] powerpc/secvar: Handle max object size in the consumer
Date:   Fri, 30 Dec 2022 15:20:12 +1100
Message-Id: <20221230042014.154483-6-ruscur@russell.cc>
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

Currently the max object size is handled in the core secvar code with an
entirely OPAL-specific implementation, so create a new max_size() op and
move the existing implementation into the powernv platform.  Should be
no functional change.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/include/asm/secvar.h            |  1 +
 arch/powerpc/kernel/secvar-sysfs.c           | 17 +++--------------
 arch/powerpc/platforms/powernv/opal-secvar.c | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
index 3b7e5a3625bd..92d2c051918b 100644
--- a/arch/powerpc/include/asm/secvar.h
+++ b/arch/powerpc/include/asm/secvar.h
@@ -21,6 +21,7 @@ struct secvar_operations {
 	int (*set)(const char *key, uint64_t key_len, u8 *data,
 		   uint64_t data_size);
 	ssize_t (*format)(char *buf);
+	int (*max_size)(uint64_t *max_size);
 };
 
 #ifdef CONFIG_PPC_SECURE_BOOT
diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 190238f51335..aa1daec480e1 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -122,27 +122,16 @@ static struct kobj_type secvar_ktype = {
 static int update_kobj_size(void)
 {
 
-	struct device_node *node;
 	u64 varsize;
-	int rc = 0;
+	int rc = secvar_ops->max_size(&varsize);
 
-	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-backend");
-	if (!of_device_is_available(node)) {
-		rc = -ENODEV;
-		goto out;
-	}
-
-	rc = of_property_read_u64(node, "max-var-size", &varsize);
 	if (rc)
-		goto out;
+		return rc;
 
 	data_attr.size = varsize;
 	update_attr.size = varsize;
 
-out:
-	of_node_put(node);
-
-	return rc;
+	return 0;
 }
 
 static int secvar_sysfs_load(void)
diff --git a/arch/powerpc/platforms/powernv/opal-secvar.c b/arch/powerpc/platforms/powernv/opal-secvar.c
index 5e9de06b2533..07260460e966 100644
--- a/arch/powerpc/platforms/powernv/opal-secvar.c
+++ b/arch/powerpc/platforms/powernv/opal-secvar.c
@@ -125,11 +125,30 @@ static ssize_t opal_secvar_format(char *buf)
 	return rc;
 }
 
+static int opal_secvar_max_size(uint64_t *max_size)
+{
+	int rc;
+	struct device_node *node;
+
+	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-backend");
+	if (!of_device_is_available(node)) {
+		rc = -ENODEV;
+		goto out;
+	}
+
+	rc = of_property_read_u64(node, "max-var-size", max_size);
+
+out:
+	of_node_put(node);
+	return rc;
+}
+
 static const struct secvar_operations opal_secvar_ops = {
 	.get = opal_get_variable,
 	.get_next = opal_get_next_variable,
 	.set = opal_set_variable,
 	.format = opal_secvar_format,
+	.max_size = opal_secvar_max_size,
 };
 
 static int opal_secvar_probe(struct platform_device *pdev)
-- 
2.38.1

