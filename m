Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A780A6175FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiKCFGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiKCFGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:06:04 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE41E18399;
        Wed,  2 Nov 2022 22:06:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E1EDA32008FF;
        Thu,  3 Nov 2022 01:06:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Nov 2022 01:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1667451962; x=
        1667538362; bh=7mGzV4zhQmEf5V0BcI7s5Pz8LXywshCqcP9bhn/Gi0Q=; b=g
        Z0oVhByNqBZGhqEtvJhT2J4PgGP4HqQKanX/laSM11d7jQ1ONkpWCTk15446NPKv
        b44gqNN9fjZ9KFjEa5bIB+gcZP3ux7y/Vp6rf2z4CgLcifOKxIKsiK77wE4ho8ms
        1n6zpA2/4vGw+xSWT8etvy+gdC3k+Z2gTIbqYOy5io4gyw7+8Siglb2MAXWd9JT6
        DG/Eg2lsJsBDHJXbzMUJTTP4omenojXaNKAUKs44Mkp0zr/BG8DvfJa7CxSORWu7
        yQ48qgoAK5SJHXCtnSRStEOLF5PXJSGtlZQAXROLmepp30hAb+dzxR7uAltVT/3l
        zl9sMIJEx28ouu8CuGstQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667451962; x=1667538362; bh=7mGzV4zhQmEf5
        V0BcI7s5Pz8LXywshCqcP9bhn/Gi0Q=; b=HEg579y55YW0Ot9nBs4WPiJlnnP5s
        /71N0AuOLKXmT4fbjtoHQ1+Ntj6RNhSaEElj3ZNgCxXIoZNdfQLfhx0oJTD0HPzI
        JrohO8H9MfXEqm/QW2HANn4aoBWBD9dNvoQOtlUzuU5RlyQ9GfEfqdTjbA+N6X7i
        xCLH+Lib1IRkEIP58VB3qtBnriFWv3m+TGDqjZOxfIEPYzVyTIacISGBkr7sGtF3
        MQ8vqHXiWHTUFNQJmR55TlwwpxF+8wzFFBku4SDouJtmZDV8xJEXjbq9oEzWMNBG
        H9YaDSAvkbOuxE0ATqISFaWQ6fMpOk573h9y7ZwPLXlqmh/vDHTQsI3Bw==
X-ME-Sender: <xms:OkxjY6ypmce8peL7Ypa9lVvD3SYO-sFjI6lOfhcC_AglI2yyHwdnrg>
    <xme:OkxjY2TiY-UbwfgspO5CjGCrezWYS7G-uZjcfotc81xRuPXz_oiKg_7tmls6Bl9R6
    c94AJkHx28ji9qzJA>
X-ME-Received: <xmr:OkxjY8WUfcyeeAgEdK-uHp2YEVDOktdbBvfdOSJR8Xvy5k6LFPB_4u9I6ptSXeduj3smShvVw_gaF8N-XgIWcXnVLec7zttyLG0fLXvxTCrQsdWG0mMgg_em417JeKgD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudekgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhhnhcu
    vfhhohhmshhonhcuoehgihhtsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtg
    homhdrrghuqeenucggtffrrghtthgvrhhnpeejgfffffeijedtueejffekgeevieduvdeu
    keffjeeiueetkeffjeekveelieejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghi
    lhdrtghomhdrrghu
X-ME-Proxy: <xmx:OkxjYwjCoCWbrHG2_g5kg83ABS4maz-PO-8b4yUNDbch30BVfZhKTg>
    <xmx:OkxjY8CRaX_JWP1orG_BfEb_R2zn3vhcDcdTgX3SMmCqfBAutvArxg>
    <xmx:OkxjYxIrzHaB4GEIdAWX-W7SmcH1rt6ghLu33qFIJ5LROQorCsrSww>
    <xmx:OkxjY74Uw_yqs2O_qZ0XGFCQ30Qzvb_wCvtg9z1h3CVmjFN81RnOnQ>
Feedback-ID: ic081425d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Nov 2022 01:05:59 -0400 (EDT)
From:   John Thomson <git@johnthomson.fastmail.com.au>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Thomson <git@johnthomson.fastmail.com.au>
Subject: [RFC PATCH 2/3] mips: ralink: mt7621: soc queries and tests as functions
Date:   Thu,  3 Nov 2022 15:05:37 +1000
Message-Id: <20221103050538.1930758-3-git@johnthomson.fastmail.com.au>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221103050538.1930758-1-git@johnthomson.fastmail.com.au>
References: <20221103050538.1930758-1-git@johnthomson.fastmail.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 17dbf28897e0..f2443b833bc3 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -97,7 +97,57 @@ void __init ralink_of_remap(void)
 		panic("Failed to remap core resources");
 }
 
-static void soc_dev_init(struct ralink_soc_info *soc_info, u32 rev)
+static const unsigned int __init mt7621_get_soc_name0(void)
+{
+	return __raw_readl(MT7621_SYSC_BASE + SYSC_REG_CHIP_NAME0);
+}
+
+static const unsigned int __init mt7621_get_soc_name1(void)
+{
+	return __raw_readl(MT7621_SYSC_BASE + SYSC_REG_CHIP_NAME1);
+}
+
+static const bool __init mt7621_soc_valid(void)
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
+static const unsigned int __init mt7621_get_soc_rev(void)
+{
+	return __raw_readl(MT7621_SYSC_BASE + SYSC_REG_CHIP_REV);
+}
+
+static const unsigned int __init mt7621_get_soc_ver(void)
+{
+	return (mt7621_get_soc_rev() >> CHIP_REV_VER_SHIFT) & CHIP_REV_VER_MASK;
+}
+
+static const unsigned int __init mt7621_get_soc_eco(void)
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

