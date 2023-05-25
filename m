Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F8371177A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbjEYTfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242117AbjEYTfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:35:11 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C189E76;
        Thu, 25 May 2023 12:34:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B924E5C0163;
        Thu, 25 May 2023 15:31:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 25 May 2023 15:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685043096; x=
        1685129496; bh=nIF4nS4aI6UYDF03seQTWUx2L320yvW6X+vuwnM3gHs=; b=H
        etWuZb/DQn5hyQA486hENqKq91k8fa/wqsbZG9smS994puEzZJ656wEHjrsihNk8
        n+PWnI8XgXgZF/IiliScJ8RR/09ShTyL4YRFLG4tWm8us6A5Zp4sqsVulED4HmJz
        LVqd7LUNdmRO7gXtFkdCE57LrUmMO4ZpuXk2OswIr2YqjEb5YzgVpBYEj+ljvetv
        oG7bm2faNzWsJs52yx0MFytAk2qMHSJ1TWoqmPlWBoApO1cwUfdKcAmPe8AP6Wxe
        W9+EM45PjHVfmyJ0jhUGHQwsCm57lkWyoHWVPkphNMutUKx3FrURRJPKTxqtHn/H
        eE+GrwQy/sazIYuoKhZVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685043096; x=
        1685129496; bh=nIF4nS4aI6UYDF03seQTWUx2L320yvW6X+vuwnM3gHs=; b=e
        Q4PWgHOWR3v1M71bF4E4VhTVAm51jlY8CQLDXCUwhhi//Czz6XPiPGhXdyqNi2fX
        aF5cEJbYNfycQmVj1K/d70shvmidJHqXYUY+AL6m+QdN9W33cNTENjO+gRx3uCMl
        qH5Ydq1RAZfjwjKat1xIw+kKd0zK1iknoh2UXrTRtfZFH3V5hhpCSg+yx6ZrsLrp
        KCvWO9zmmDCb9YiSfCLMmGTO0yT3pCLfY2V1s33JaB/XTxrLL5lq6l7mPTRRPfqv
        chujFyo59Dx/jzucV4r+mBuhPgaNUcAl1e1dsOkt7WPytg21D+BqZsIXiWdGCgG5
        NnNRYx1qNItvMN8cj5VHQ==
X-ME-Sender: <xms:mLdvZGj5NXBODF39WKdFKuqZ5NawTlc0zi0KzBHxQDqck3l_ekZZRQ>
    <xme:mLdvZHC95KiF9eM2dcMTukjULBKA8h4Lhjt5Puf-aK-lF9UNRiZVZXBYkFcsCG1Jl
    wWJIgpbQ1FjQ-752ig>
X-ME-Received: <xmr:mLdvZOGgNyas-cPIyu9TTiVdDFLpa5e4h88RYHz02dMePQEmjScvqmc3usxpcb9moB_a9KCDUuNtEBx6GiGrpcqjQuwTezv5A50atGyY9Vm5_ByDhBmBvlqDmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:mLdvZPQRifLXFPyaAFyuEBKoLBeY96QkH-EqWskixWAffbO_fO-Dhg>
    <xmx:mLdvZDyhscsSCFwVFNuXG48B1GVsQlcMUZ_bRuYPfMkQopJmn6ynHA>
    <xmx:mLdvZN4qtH1pvuVoDgyBXnHtfQLcsTi4CiikaAYbc8SFP4jFUUUedQ>
    <xmx:mLdvZD_OlxTYB-tvNUOnsSudaL1Sal-1rK341S1bJr2mNL11p8vS6w>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 15:31:36 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] platform/x86: think-lmi: Correct System password interface
Date:   Thu, 25 May 2023 15:31:29 -0400
Message-Id: <20230525193132.3727-2-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525193132.3727-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20230525193132.3727-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system password identification was incorrect. This means that if
the password was enabled it wouldn't be detected correctly; and setting
it would not work.
Also updated code to use TLMI_SMP_PWD instead of TLMI_SYS_PWD to be in
sync with Lenovo documentation.

Correct these mistakes.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in V2:
 - Updated define name to be SMP_PWD instead of SYS_PWD
 - Clarified in comments what each password type is.

 drivers/platform/x86/think-lmi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 2745224f62ab..c7e98fbe7c3d 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -168,11 +168,11 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
  */
 #define LENOVO_CERT_THUMBPRINT_GUID "C59119ED-1C0D-4806-A8E9-59AA318176C4"
 
-#define TLMI_POP_PWD (1 << 0)
-#define TLMI_PAP_PWD (1 << 1)
-#define TLMI_HDD_PWD (1 << 2)
-#define TLMI_SYS_PWD (1 << 3)
-#define TLMI_CERT    (1 << 7)
+#define TLMI_POP_PWD (1 << 0) /* Supervisor */
+#define TLMI_PAP_PWD (1 << 1) /* Power-on */
+#define TLMI_HDD_PWD (1 << 2) /* HDD/NVME */
+#define TLMI_SMP_PWD (1 << 6) /* System Management */
+#define TLMI_CERT    (1 << 7) /* Certificate Based */
 
 #define to_tlmi_pwd_setting(kobj)  container_of(kobj, struct tlmi_pwd_setting, kobj)
 #define to_tlmi_attr_setting(kobj)  container_of(kobj, struct tlmi_attr_setting, kobj)
@@ -1509,11 +1509,11 @@ static int tlmi_analyze(void)
 		tlmi_priv.pwd_power->valid = true;
 
 	if (tlmi_priv.opcode_support) {
-		tlmi_priv.pwd_system = tlmi_create_auth("sys", "system");
+		tlmi_priv.pwd_system = tlmi_create_auth("smp", "system");
 		if (!tlmi_priv.pwd_system)
 			goto fail_clear_attr;
 
-		if (tlmi_priv.pwdcfg.core.password_state & TLMI_SYS_PWD)
+		if (tlmi_priv.pwdcfg.core.password_state & TLMI_SMP_PWD)
 			tlmi_priv.pwd_system->valid = true;
 
 		tlmi_priv.pwd_hdd = tlmi_create_auth("hdd", "hdd");
-- 
2.40.1

