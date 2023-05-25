Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FA6711773
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbjEYTdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbjEYTdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:33:37 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ED1E6F;
        Thu, 25 May 2023 12:32:59 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5AA5C5C01E0;
        Thu, 25 May 2023 15:31:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 25 May 2023 15:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685043097; x=
        1685129497; bh=/PlZsAh2PqLyxP7nKoIuoVm4Q+hIJHqGY7bemnqtU0s=; b=T
        HNgAn0WGCwfIg3mv2F04i+N53xkJomReivfd2qvb6aTW9ddBOvGXiYwBIRtPfJfU
        bD3I/JOxPPolUr/CTzMDXuTLF+F3iWAeddO5hTTnn0ORt0xhVtmk7W6dGvAbp637
        5x4/+2eltd0fzwzotdy4qXhrvdO5wnFYlfe/L+GcBhAquqso+kt+fZpgGLewmYUR
        cNziPS2BxFPWxOO6I4PN+4taEMsl0e+EK+BQUGhruUZbmrQGQ4EuGlaJwJcCNuTq
        Ikt5FMEoRQS+9NYmbsAy5l/6dFV5/4x0bQRjll2RE1WuAivlWDKlweLfDNs1FtJv
        mw7/fUlblSktu5In5WxdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685043097; x=
        1685129497; bh=/PlZsAh2PqLyxP7nKoIuoVm4Q+hIJHqGY7bemnqtU0s=; b=u
        zALnOWf41Icac+jiYTnhJRqO0InA2TLlxOqrDOxlrlZMchAAlJwH4ytDmefjJyBL
        uVdp6kZVKeWs9BsA8M5/i+vLY97YtB1qRx6PeUN7EKF3f51gFxNmYIFcNjZ/3Zov
        CXn6mCn0a9Rf8aE8clrk6EJrdf94iErMaHyrHCluFuy/pdvxqN7bwrJ8pU24VvJh
        va7uR0suCZllXPrQXTKMDuoaNLeSyLB9WxEZi3afVSBa7+b+AyRS4zH5lX/ATWXE
        VGMFrM0hsz0LvO2/pVLQa2zK2M2iSFEovMiOEoL0AyxERUgFAjEDRCOloAX09D19
        40NPXjGdEFRH1VqCilM3g==
X-ME-Sender: <xms:mbdvZANQPPWh-flk1SZvDX0euRK40s2yeosk6-IzCH-5SHPLVc_hPA>
    <xme:mbdvZG_fSj9Ejh9PUZ0dGfqHjWWYD1arnnYlSf9tiraRL_uiINy7P7Wyh-LbZnbmM
    iD5DngSUa3_WEX0HCM>
X-ME-Received: <xmr:mbdvZHQ0U2uZmq3VKVc2SXmlvapat-UHBHWmwpiSAtaCqVD1LbqvSVZhyWE5_Ys4jxK0r8SzfZmXiwBUcM04TDGgqFOn1h4Usyz21yyrlq-CZ-jau6liDRwJWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:mbdvZIv5YKudsRLDFZGrHD18Jw2iE6W3zeRwwXAAj6x32r8Pz2VlBQ>
    <xmx:mbdvZIfm5OqbnLk2FfzXG9lV5QPWB8idGRS9phAUHhjtcRVHLP_8nw>
    <xmx:mbdvZM0N7sE8Zj7cDsf3v_ZngQEfaUulJRVdENhYV9fM02583xJq4g>
    <xmx:mbdvZA6AixF6eX8Ji8SdZtbHuYzEA7sDvGTRMPiA59-Qh5FRl_hMJA>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 15:31:36 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] platform/x86: think-lmi: Correct NVME password handling
Date:   Thu, 25 May 2023 15:31:30 -0400
Message-Id: <20230525193132.3727-3-mpearson-lenovo@squebb.ca>
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

NVME passwords identifier have been standardised across the Lenovo
systems and now use udrp and adrp (user and admin level) instead of
unvp and mnvp.

This should apparently be backwards compatible.

Also cleaned up so the index is set to a default of 1 rather than 0
as this just makes more sense (there is no device 0).

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in V2: None. Version bumped in series

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

