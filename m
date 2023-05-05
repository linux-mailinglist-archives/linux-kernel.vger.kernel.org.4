Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA05E6F83EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjEENZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjEENZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:25:37 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377601F4A1;
        Fri,  5 May 2023 06:25:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A4F2B5C033F;
        Fri,  5 May 2023 09:25:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 05 May 2023 09:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1683293136; x=
        1683379536; bh=QOaw7XzCs4L0ES0o3JcSmPFtMCXKaf9+L8kg0dTL+xI=; b=d
        yqj9mN46RdQVEWAWdVSTrour+rzDZsXGmc1OD2nNYb56pUcjGbFArpnbwY5xyUTK
        GCEjCMM1GfXWxGCYRowiJ7+u6ubAensAoHK92dcevPHz/CIA2HLzE1oGXSfes7yM
        4MIa74DsegTQ2SLJnpbfThndQSbiid/FcBEf9yibAwHCmtL/D4iCE2rm2Av/5vg+
        th0UK0WTHgEZ3gW6JbMiWfwHSF69s856y2alD2KsEzOyftTJtyCv92t0nTnhXPpA
        XL1UDLNl1TTWpa7CuHwSJwQ98OQGaewuSoehOooS6Ot6wWvZNw/Z/D7k6guHQcXe
        D+c5Rfx/xuHyGfk6lp2UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1683293136; x=
        1683379536; bh=QOaw7XzCs4L0ES0o3JcSmPFtMCXKaf9+L8kg0dTL+xI=; b=f
        hupG2IZTwpE9q0xW6szhWt4sE1zXUj8HugoGWlqURkIzWGFT6fdaUD1E+thRNR5L
        O5ojvesw5tyCWFQGFmtwfxr+ZqwWSmIs4Xm2tffdYgj+dGbSTPAlxfNrfd5+lV79
        rn4kGNXu3SohOiY/iJ5/CUpWPGt3aIZTo7WvoJLQUeNIJG9HPBK4Sl4eRnMOSxgQ
        V1kKkzh9K6LDYgLeKSzChn7BlWtOuJ9l7L6jeB+G9tTZrAtHuaYz41M8A56efejV
        PnZp/OkATO0yjSzZCNODQPGOVEFp/O//bVFXGzpMsfHl0UDujeg+T0qobIBIXfJX
        MIRBERaQ87QxtoXwobLqQ==
X-ME-Sender: <xms:0ANVZM5PnMtROP0-Mi4ZLIgZMIETL4fpoZrREjwd8_yOP5Jeg-x1LQ>
    <xme:0ANVZN4qH58hz8fUb1kWqVbnqfcm79qmwPgQTnRO-9aahLe4xpcHHGynNw_b-DkCz
    jj4NIkKW4gPGjdUA18>
X-ME-Received: <xmr:0ANVZLcM0cBh5LsMHBFHYRezYLHxAG5R9_PICQhG_uPH_mfNC2J3dZU11Me18tNs0gkfk7bjEYBWQLTs7HXPP4RBgPL1E7P5mA97VCaDcmVnLveTf1pFdOj-Hci1yyXShInPAkSSsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefvddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhs
    ohhnuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueet
    hefgvdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:0ANVZBJABprEZBMWr1IHLhiwL6ySDOow3t0tlo2xau7aCL0H4aJDQw>
    <xmx:0ANVZAI4FRvTNcvkE0nrf8PTOmSsaDUf2KKLdsajcnJlpOqiyF4K1Q>
    <xmx:0ANVZCxBGXdFHcjyhlKe3ZVQLlxQPBx84YTTEyxmFs0RhDryh6N5FA>
    <xmx:0ANVZE0gwK7AHeOfq7Xx_xjOK_BzquBNJ9eCSgrieQ2P6eWslFoeRg>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 09:25:35 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: thinkpad_acpi: Add profile force ability
Date:   Fri,  5 May 2023 09:25:23 -0400
Message-Id: <20230505132523.214338-2-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230505132523.214338-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20230505132523.214338-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has been a lot of confusion around which platform profiles are
supported on various platforms and it would be useful to have a debug
method to be able to override the profile mode that is selected.

I don't expect this to be used in anything other than debugging in
conjunction with Lenovo engineers - but it does give a way to get a
system working whilst we wait for either FW fixes, or a driver fix
to land upstream, if something is wonky in the mode detection logic

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/platform/x86/thinkpad_acpi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d84a4c7e3c35..2bbb10ac8066 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10310,6 +10310,7 @@ static atomic_t dytc_ignore_event = ATOMIC_INIT(0);
 static DEFINE_MUTEX(dytc_mutex);
 static int dytc_capabilities;
 static bool dytc_mmc_get_available;
+static int profile_force;
 
 static int convert_dytc_to_profile(int funcmode, int dytcmode,
 		enum platform_profile_option *profile)
@@ -10572,6 +10573,21 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 	if (err)
 		return err;
 
+	/* Check if user wants to override the profile selection */
+	if (profile_force) {
+		switch (profile_force) {
+		case -1:
+			dytc_capabilities = 0;
+			break;
+		case 1:
+			dytc_capabilities = BIT(DYTC_FC_MMC);
+			break;
+		case 2:
+			dytc_capabilities = BIT(DYTC_FC_PSC);
+			break;
+		}
+		pr_debug("Profile selection forced: 0x%x\n", dytc_capabilities);
+	}
 	if (dytc_capabilities & BIT(DYTC_FC_MMC)) { /* MMC MODE */
 		pr_debug("MMC is supported\n");
 		/*
@@ -11633,6 +11649,9 @@ MODULE_PARM_DESC(uwb_state,
 		 "Initial state of the emulated UWB switch");
 #endif
 
+module_param(profile_force, int, 0444);
+MODULE_PARM_DESC(profile_force, "Force profile mode. -1=off, 1=MMC, 2=PSC");
+
 static void thinkpad_acpi_module_exit(void)
 {
 	struct ibm_struct *ibm, *itmp;
-- 
2.40.0

