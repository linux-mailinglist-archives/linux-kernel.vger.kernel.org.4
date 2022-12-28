Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EF56573AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiL1HbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiL1Hal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:30:41 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088B2F58C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 23:30:41 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C98BA320092B;
        Wed, 28 Dec 2022 02:30:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 28 Dec 2022 02:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672212639; x=1672299039; bh=Br
        FC+57y08hRIR+Z3gCskLpXrFWtKi5jsyNeZhcK7F0=; b=MzHkDSTeWqYBp25vS1
        T2Dw05oAOs4l89qU0oLHNXQQDp+x5IobZkCLYBXW0xRhR5E3qG4WC/jiBGRVdaoa
        FvbjAB6S0/kvsqZUoTDfHjWQTWNMELVxvNMwb75ESsSSEMrpmTVCcGKxiagGRsir
        KPxwILrYE6z+2ZTkjGKeVTGrNQeLAU90x3DF+EDBqS0qfJltJmuexrhbU0nhKAUj
        cmxvt7X5/n5P0PcUoqHSuSd2PVgOWgMIP8YyCp7UVsYk++yDqKPIYSIpxz5KxVDT
        zwAV9efRGy6szHKa3P7UTtYUtpIoVXX7l2KYMz3UJn77052PuhfRJNkWMsXjAQms
        KC8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672212639; x=1672299039; bh=BrFC+57y08hRI
        R+Z3gCskLpXrFWtKi5jsyNeZhcK7F0=; b=NWs1T5Nzd557sJFnJxB+8HVaZ/gY5
        7ELJ2ZzgnPPfAjRgqQF5HNt3Wy1ub5ywFVFHOoCtlkg5n/DrzWi7WWENYY1cVKgq
        psqWiPliuieZaWfBbQ0VuxzAzWcpU+LM73Xwi1SxQrSx2/KLrGfZR3/JdlbbaPNr
        8G/2B8r7w5wvfqTKA2rlRrPAiAeXsrsR1kFRvSsgYxCkeoOD7gNahTzVmtdNyg/8
        Tyo1g5lwve0GD3DB69TyEox1n8hyhBvCEwBFZ2f75yVK3D1FVgPK5QtJNt1ABo/L
        hP1q4qFLOSOiW/pq3Ohz8P7K/IYHm3jwL16JAE/Qob+SlwJNyXFBhoL4w==
X-ME-Sender: <xms:n_CrY28Y3chqol6WgZlbAoD26iiCHAnH4_VucletNcUgPlFpMitNqQ>
    <xme:n_CrY2s9YTr1TYIHGVU62SixdwPVFA4THhhb2qfziaS01EndBni4GrPlbhNQGyJTx
    ZuJQAjLGVzSeO014A>
X-ME-Received: <xmr:n_CrY8CgmZiPMSAIFjVFigPzkfkb2h3a5vOCKWeF01vumvmkPfarRaInioBYmrEoi4tLV6gE6j1ozL8AZcZQxdu9NiLKwKNmYTnP7UhQWo9sqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedugdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftuhhsshgvlhhlucevuhhr
    rhgvhicuoehruhhstghurhesrhhushhsvghllhdrtggtqeenucggtffrrghtthgvrhhnpe
    fhvdeugfdtvdeiieegffefffekieegvdfgiedtjeetffevfefhtdehjeffieeivdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurh
    esrhhushhsvghllhdrtggt
X-ME-Proxy: <xmx:n_CrY-ddufXFNgERDYpXR2wObuvj8xZaipdDSqRrHuFebHuCZt1QcA>
    <xmx:n_CrY7NJgklVj_XXHjziU_7Qa8eUnsftP4aV90-Ys69OuvHlEsYr3w>
    <xmx:n_CrY4nPmgbYhlkCWaPVHKcBlRP922Up2oHUf7OQqSa8GSn_NC6hkA>
    <xmx:n_CrY2f4EHx8ZWL8M5y_Ll8IahdrYZrG2E-EvU6HxpvplTcY6weuUg>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 02:30:36 -0500 (EST)
From:   Russell Currey <ruscur@russell.cc>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ajd@linux.ibm.com, zohar@linux.ibm.com, mpe@ellerman.id.au,
        Russell Currey <ruscur@russell.cc>
Subject: [PATCH 4/6] powerpc/secvar: Handle max object size in the consumer
Date:   Wed, 28 Dec 2022 18:29:41 +1100
Message-Id: <20221228072943.429266-5-ruscur@russell.cc>
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
index daf28b11866f..ea408763dc78 100644
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
index cd5b5c06c091..3ef6b9afd129 100644
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

