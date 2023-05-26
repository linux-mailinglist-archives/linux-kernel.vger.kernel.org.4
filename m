Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CCF712B98
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbjEZRR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbjEZRRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:17:20 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FD7194;
        Fri, 26 May 2023 10:17:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 61AA85C01E9;
        Fri, 26 May 2023 13:17:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 26 May 2023 13:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685121435; x=
        1685207835; bh=Gv5qXDxaPiGyrdXH4F6xJJKqVcwExZ70ZDGntPIt+Vc=; b=p
        C0CKWpNqJGerMXBQd7yVMiHpRjq1XUr+e6V+f6bYtMBZE1cmegBn02U3g+qSyGoJ
        Hx2B7Y+aByw1+WTBHCpUDZtEZ/znTLcUJK+s/5fdAuyB3RFmvFitjcryQ3+lq0q7
        +yfCDgY8pXMQEaqDl73B5YjCJOyZ46gUluBtwbPQgznR73zAGHwPHWS3s2kIkkRY
        woN5MoqIBUWH1JZ6BTiB0xRBFP4x35rWNu+IBp9de8tlaEuQaCmWhVEtZnnxZDl2
        98HeZokjadrOIHn/rjPg5KDSLAVGPUnKvMHh+U7x6Gxqgv/GeJnb+hhs2+5iLNM1
        72jA74yfZ3l3CDjhX5EAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685121435; x=
        1685207835; bh=Gv5qXDxaPiGyrdXH4F6xJJKqVcwExZ70ZDGntPIt+Vc=; b=T
        5lAchV0qJ5Tji1D+4qpY9b/cXd1Nf2a9QK9JxnY7Kryfaojf1R8C+IrwI1fJfaiB
        5jZ9PfkO0zxraOCPpuW8ok3foC/T5Dx4D101s0X00g9to2Im7soLi7rkfoV4cyDt
        2F/c9P4p0IiLRIZxdWqS/3im7Q4XBSShqnfYqHLCJAfwuIghjtlKA9SBiDrvY/WQ
        hls8ftc0cROQyEAi1u9TRJw8DDEf3dn5zFzXr7BlRZU9Z5Kfms4x1xkAn9BfGrvS
        vh76NzBhjLl1+m2C8O5X99PeH5/9nWgW5aGvHtx9MXkxttSnjDF7a/Zqu5sWLKvy
        LI3glnHeGkxG2cHHtVEcw==
X-ME-Sender: <xms:m-lwZKjlXWNfQPmLjXH_T54_gD4KKPol8Biuf5bYaRzWQ2J29PGsFQ>
    <xme:m-lwZLDUJVomuzU7engklWFwN7fN_Zs2BYynLKLTXSfGlln5DFZ6qrwd9_BEB6q0x
    dHMbCZHaRE8YzA3E1E>
X-ME-Received: <xmr:m-lwZCEH0gjZOxLBWU2rLZC5QQUPsV5azoAXYzJ_IOrRI-th7qjxIMQIS9DUsyUXroCvgwbqVetTLXGwyrcCvScguCvsFLDSQYFnXNuhmXjKePpi_WVqzBKu3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:m-lwZDQbJOnCVAHTspRZTaaDyF3O9XtHSmWY41wkOlmVUMBHdVvC2Q>
    <xmx:m-lwZHwRBB33gl-LtUuVjWnJku6UVfDq3avZHadVeNdEK9ReyYNCbw>
    <xmx:m-lwZB52pynrT7rjzM132DULFQBgRB6xp_sMhiWn9HIoTm2yBOlC-w>
    <xmx:m-lwZH9B8foAdLe47Ug5TBqbtO6tFsbSVXlBkmpx0n-EiWlTzQF1uw>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 May 2023 13:17:14 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] platform/x86: think-lmi: Correct NVME password handling
Date:   Fri, 26 May 2023 13:16:56 -0400
Message-Id: <20230526171658.3886-3-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVME passwords identifier have been standardised across the Lenovo
systems and now use udrp and adrp (user and admin level) instead of
unvp and mnvp.

This should apparently be backwards compatible.

Also cleaned up so the index is set to a default of 1 rather than 0
as this just makes more sense (there is no device 0).

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2 & v3: None. Version bumped in series

 drivers/platform/x86/think-lmi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index c7e98fbe7c3d..1c02958035ad 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -456,9 +456,9 @@ static ssize_t new_password_store(struct kobject *kobj,
 				sprintf(pwd_type, "mhdp%d", setting->index);
 		} else if (setting == tlmi_priv.pwd_nvme) {
 			if (setting->level == TLMI_LEVEL_USER)
-				sprintf(pwd_type, "unvp%d", setting->index);
+				sprintf(pwd_type, "udrp%d", setting->index);
 			else
-				sprintf(pwd_type, "mnvp%d", setting->index);
+				sprintf(pwd_type, "adrp%d", setting->index);
 		} else {
 			sprintf(pwd_type, "%s", setting->pwd_type);
 		}
@@ -1524,6 +1524,10 @@ static int tlmi_analyze(void)
 		if (!tlmi_priv.pwd_nvme)
 			goto fail_clear_attr;
 
+		/* Set default hdd/nvme index to 1 as there is no device 0 */
+		tlmi_priv.pwd_hdd->index = 1;
+		tlmi_priv.pwd_nvme->index = 1;
+
 		if (tlmi_priv.pwdcfg.core.password_state & TLMI_HDD_PWD) {
 			/* Check if PWD is configured and set index to first drive found */
 			if (tlmi_priv.pwdcfg.ext.hdd_user_password ||
-- 
2.40.1

