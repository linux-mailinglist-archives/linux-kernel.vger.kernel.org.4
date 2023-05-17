Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C570709B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjEQSUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjEQSUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:20:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5689F1BE7;
        Wed, 17 May 2023 11:20:01 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C24765C0046;
        Wed, 17 May 2023 14:20:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 17 May 2023 14:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684347600; x=
        1684434000; bh=KSnphhYejWUvC0O6HxRUPmnz6slx1Pk6ZLSyjVku7do=; b=G
        iKdUR2FflKmrqn1aJT5sPCRNXjfthV/lAPLQd0QttUh5yvEAYiLjQwNksp+qntWg
        n47ciCB31D9W4lD9rL7JC0vzTv5WwvzsYYokZQKcy/xTV+ImoosycBkz5zv2cld1
        ih7orDJ2jIgBttI0YobcYBU77QbRWANMafk+l1ByiO+4mTCR8HKbVMXk1nYOxbkQ
        xHFBzOFfwggGko/FtEBG7FOXvtJrcD2DDCnpj7oatfU046tgN4QoaKnqBtzRjsOY
        3eZX5ls5VqQC14j1voio3y8QrkSP8fd5NDOLZERFl8yUN59blOLwd5jEVtAHS6uH
        ysl/l+ElF344jXZELq6Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684347600; x=
        1684434000; bh=KSnphhYejWUvC0O6HxRUPmnz6slx1Pk6ZLSyjVku7do=; b=G
        47RBIv+/lDCYfFyyQzoJ9U3C6DPy7WSIl4bAvp/4oPTxZoBxYYfwLzZx5Ijz/F7l
        KXyfWpzklH6TWEViv/XtGrS0arzk4u4NkfEKMmKLg3gk6ap0caCo/++zwWGeAIjL
        Rn72K7fNDTDS5zkJ3v0s2vgnGNrdBH2AcHV0aJtLGnByP0iLPeXV749yDKoRn33J
        hJWdGUM2A+70f1JqOTpwtwzTYauclnyZ22bmZBh5czAfdtn9/F+/LWA7df71UxIr
        Nu1fj77E69jvcw3fTN0qtL6EYCSNNOuIm9DrjNH6LB8l/EK8kNHEuKwzz0oryPGI
        F5IptsXcd8x+4YBZKOQmw==
X-ME-Sender: <xms:0BplZCXsQ1IgjfnhwehlsA7fGz-ZrrzBa-w56IbUND-m3z3IG-07HA>
    <xme:0BplZOnlJh0ZpYlw4eCniCA2OBgxno8UcGkLcVO7muO_tXDFhEWdL90o8DmMLbqvo
    J7DTMBFrS1G1FB0kPE>
X-ME-Received: <xmr:0BplZGaSS1Q0FyRe_2-9Qc5mR-VuycxLUWfJa3faBiCwI3VYD8bPMnAQ3tDIwSeMsN3X4QfOUTXec_dBsHMHGT6MeMEHj9VVPUu5LtgPyubP4stxeHLSt1eXnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:0BplZJVloHgOp4r5rptTJGcuCC405mA_kaMuOGEXmCftXmDbR8pkBw>
    <xmx:0BplZMniLo_6d95sVm3Hoi_oP9jDVAnXz-SJgfBr-NI-Etzbx8fNZA>
    <xmx:0BplZOfB6fbuhTFM99ZYwqplEA6shifKoUicYuMtQZOpvZ5RNVDF7A>
    <xmx:0BplZGjdm2g0493TW0dkZx_wjLAvFuWFArQNkxbhXkZpSTOC_16u1A>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 May 2023 14:20:00 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] platform/x86: think-lmi: Correct NVME password handling
Date:   Wed, 17 May 2023 14:19:44 -0400
Message-Id: <20230517181945.3725-3-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517181945.3725-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20230517181945.3725-1-mpearson-lenovo@squebb.ca>
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
 drivers/platform/x86/think-lmi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index b8431d3b137f..2d95b1a199fa 100644
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
@@ -1519,6 +1519,10 @@ static int tlmi_analyze(void)
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

