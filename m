Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BA462745B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiKNB51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiKNB5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:57:23 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663BC634D;
        Sun, 13 Nov 2022 17:57:22 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D02F05C00F1;
        Sun, 13 Nov 2022 20:57:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 13 Nov 2022 20:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1668391041; x=
        1668477441; bh=PZRTm9SKmJhm/oKCvtnlYbBV1VBF0I/txAL1umCTKLM=; b=A
        Ergzkv8JDylxPRp7U7Z0OJNR5id+t8U/+3XTUO3QD7JvoVuXBa4D7weSLh/IIjZD
        4XO+4ycflBtDaghylGOruvM8TLKYxxthWxMW2bYSKPKpufn3LqoJgLZ+VuiEU1yg
        B9ndYxozeKOCqPAFYRPk2BJGaDCPu1tUnBOibxhkwio1859oGsWweWanzpJsFAxa
        8q8758gqs5eEUo4urZ/Vipv5Z6eUgl86mYQGNB6hrcmsj9jGdHsaLtlCnB4Pz707
        DuV0SxHwIi1Cjr6d+gnLI+rlvPtas/KPRmlFtvb5nOfqIW+8q595Ap7G70nTmbJe
        z3ge9jMshCgqkbnZD7XAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668391041; x=1668477441; bh=PZRTm9SKmJhm/
        oKCvtnlYbBV1VBF0I/txAL1umCTKLM=; b=JRZbaQmTc9kk7yxtHioVbh5N8EVBA
        ReH0HAxxw6baNMATeBVz+sB7WlMRG9LhprMrkXRkodPtoZNV4wI/+LoSofM6j3vf
        m/z7ATVih2WJiWh1UWKL96wCnSD3BvtPd4yg/mXVAiIwq5UztuXTZyZ/5NiXX2bg
        fSr51JaT1NKaydH3f5H7tzR65svnDojMewzhmLKo905orNPES4OJvbefHqA3WZbj
        z6c9u7RvT93MFydFFUkWZB7seGQi784DbDlDemIAWcrlb96qUSNCGwYsUbvSlHvV
        SEU6/DCVSgpiRfZhbAQWHhdMvggnUsi3YtZ1pjDhvxqm5aBU6gGWhrBlQ==
X-ME-Sender: <xms:gaBxY-0e90CH0-DmVSfWAt51Vn6URznNuH9u8eKfMKb47JjvNYTR2Q>
    <xme:gaBxYxE1c_81X8sHhVKrtIHADTvccJlTyr8BRR5P8LOAwmNXtYrJ-XhHsYEWg50Il
    Ra3Cy2CptEFhKpLYQ>
X-ME-Received: <xmr:gaBxY242x-ZT-y3daQjSPkG4XFeu6ZrBziSiZWvR-L_4cIzc4FsrSrHBidU-b2yqgisTgBriJOp6TuFM2VO5PArhK0ycyI-TfsqrhbLIB1F-hJm7O6FRlV_8xA7qzjUR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhhnhcu
    vfhhohhmshhonhcuoehgihhtsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtg
    homhdrrghuqeenucggtffrrghtthgvrhhnpeejgfffffeijedtueejffekgeevieduvdeu
    keffjeeiueetkeffjeekveelieejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghi
    lhdrtghomhdrrghu
X-ME-Proxy: <xmx:gaBxY_1sBBTvtEF8PU3YNfOok1FI2GCaeOvv8wGAV8kZZAjiSwmmJg>
    <xmx:gaBxYxF6TZv6K916ejqAnWZVH8z_OyQtj2DrhQsLISAZPw-n6LfP7g>
    <xmx:gaBxY4_bOoK84fS7B6dZquikBwfDiiEEiz7YDVQDciEJH9Hba-Tfhg>
    <xmx:gaBxY6PdVZYI8Cd1IC2AA4boOZKmyFcMRQXYHNidqzxRWW16p5OQbw>
Feedback-ID: ic081425d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 20:57:19 -0500 (EST)
From:   John Thomson <git@johnthomson.fastmail.com.au>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Thomson <git@johnthomson.fastmail.com.au>
Subject: [PATCH 2/3] mips: ralink: mt7621: soc queries and tests as functions
Date:   Mon, 14 Nov 2022 11:56:57 +1000
Message-Id: <20221114015658.2873120-3-git@johnthomson.fastmail.com.au>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221114015658.2873120-1-git@johnthomson.fastmail.com.au>
References: <20221114015658.2873120-1-git@johnthomson.fastmail.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the SoC register value queries and tests to specific functions,
to remove repetition of logic
No functional changes intended

Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
---
 arch/mips/ralink/mt7621.c | 86 +++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 25 deletions(-)

diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index 17dbf28897e0..6e126f570f0c 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -97,7 +97,57 @@ void __init ralink_of_remap(void)
 		panic("Failed to remap core resources");
 }
 
-static void soc_dev_init(struct ralink_soc_info *soc_info, u32 rev)
+static unsigned int __init mt7621_get_soc_name0(void)
+{
+	return __raw_readl(MT7621_SYSC_BASE + SYSC_REG_CHIP_NAME0);
+}
+
+static unsigned int __init mt7621_get_soc_name1(void)
+{
+	return __raw_readl(MT7621_SYSC_BASE + SYSC_REG_CHIP_NAME1);
+}
+
+static bool __init mt7621_soc_valid(void)
+{
+	if (mt7621_get_soc_name0() == MT7621_CHIP_NAME0 &&
+			mt7621_get_soc_name1() == MT7621_CHIP_NAME1)
+		return true;
+	else
+		return false;
+}
+
+static const char __init *mt7621_get_soc_id(void)
+{
+	if (mt7621_soc_valid())
+		return "MT7621";
+	else
+		return "invalid";
+}
+
+static unsigned int __init mt7621_get_soc_rev(void)
+{
+	return __raw_readl(MT7621_SYSC_BASE + SYSC_REG_CHIP_REV);
+}
+
+static unsigned int __init mt7621_get_soc_ver(void)
+{
+	return (mt7621_get_soc_rev() >> CHIP_REV_VER_SHIFT) & CHIP_REV_VER_MASK;
+}
+
+static unsigned int __init mt7621_get_soc_eco(void)
+{
+	return (mt7621_get_soc_rev() & CHIP_REV_ECO_MASK);
+}
+
+static const char __init *mt7621_get_soc_revision(void)
+{
+	if (mt7621_get_soc_rev() == 1 && mt7621_get_soc_eco() == 1)
+		return "E2";
+	else
+		return "E1";
+}
+
+static void soc_dev_init(struct ralink_soc_info *soc_info)
 {
 	struct soc_device *soc_dev;
 	struct soc_device_attribute *soc_dev_attr;
@@ -108,12 +158,7 @@ static void soc_dev_init(struct ralink_soc_info *soc_info, u32 rev)
 
 	soc_dev_attr->soc_id = "mt7621";
 	soc_dev_attr->family = "Ralink";
-
-	if (((rev >> CHIP_REV_VER_SHIFT) & CHIP_REV_VER_MASK) == 1 &&
-	    (rev & CHIP_REV_ECO_MASK) == 1)
-		soc_dev_attr->revision = "E2";
-	else
-		soc_dev_attr->revision = "E1";
+	soc_dev_attr->revision = mt7621_get_soc_revision();
 
 	soc_dev_attr->data = soc_info;
 
@@ -126,11 +171,6 @@ static void soc_dev_init(struct ralink_soc_info *soc_info, u32 rev)
 
 void __init prom_soc_init(struct ralink_soc_info *soc_info)
 {
-	unsigned char *name = NULL;
-	u32 n0;
-	u32 n1;
-	u32 rev;
-
 	/* Early detection of CMP support */
 	mips_cm_probe();
 	mips_cpc_probe();
@@ -153,27 +193,23 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 		__sync();
 	}
 
-	n0 = __raw_readl(MT7621_SYSC_BASE + SYSC_REG_CHIP_NAME0);
-	n1 = __raw_readl(MT7621_SYSC_BASE + SYSC_REG_CHIP_NAME1);
-
-	if (n0 == MT7621_CHIP_NAME0 && n1 == MT7621_CHIP_NAME1) {
-		name = "MT7621";
+	if (mt7621_soc_valid())
 		soc_info->compatible = "mediatek,mt7621-soc";
-	} else {
-		panic("mt7621: unknown SoC, n0:%08x n1:%08x\n", n0, n1);
-	}
+	else
+		panic("mt7621: unknown SoC, n0:%08x n1:%08x\n",
+				mt7621_get_soc_name0(),
+				mt7621_get_soc_name1());
 	ralink_soc = MT762X_SOC_MT7621AT;
-	rev = __raw_readl(MT7621_SYSC_BASE + SYSC_REG_CHIP_REV);
 
 	snprintf(soc_info->sys_type, RAMIPS_SYS_TYPE_LEN,
 		"MediaTek %s ver:%u eco:%u",
-		name,
-		(rev >> CHIP_REV_VER_SHIFT) & CHIP_REV_VER_MASK,
-		(rev & CHIP_REV_ECO_MASK));
+		mt7621_get_soc_id(),
+		mt7621_get_soc_ver(),
+		mt7621_get_soc_eco());
 
 	soc_info->mem_detect = mt7621_memory_detect;
 
-	soc_dev_init(soc_info, rev);
+	soc_dev_init(soc_info);
 
 	if (!register_cps_smp_ops())
 		return;
-- 
2.37.2

