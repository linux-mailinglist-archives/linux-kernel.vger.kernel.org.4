Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EFA71F369
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjFAUGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjFAUGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:06:05 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C0A134;
        Thu,  1 Jun 2023 13:06:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 46F1A32002F9;
        Thu,  1 Jun 2023 16:06:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 01 Jun 2023 16:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685649962; x=
        1685736362; bh=aQVnrUtWK2iD10mHCHPBgoH3zv4+A/ErwEDXziIOT4Y=; b=A
        1QHzVjZuTET09em988ya3g3r6xXQHIs6GQkU3VC3ZdUo2D2mV31RhrtJhn/SAbTP
        MeMDfcWDROzN6frZYU3DYZf51+lyuAw9JW+QbYUuhZNsY3dz35IowNpwkPkPBdZV
        jIuzu1GOQ7SvD6Z//aV2w8mWCVSIO4VcOgysZppZmsPEjSxOx0Iq529YIle+KyEC
        g50B5NtoNnihpUsbFIcKBAQbQiiFZl2Vp3Z/JCCTqyrQa2JNtFhjIZ3vIsW2DLH8
        /orZYIia97KCj0mpLJ+gJEY4W13E7BOZqzuNsMWzQJJif3cIoa+c40WbWWzrlD46
        i7xOfgNmbIjKSVy13dqUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685649962; x=
        1685736362; bh=aQVnrUtWK2iD10mHCHPBgoH3zv4+A/ErwEDXziIOT4Y=; b=h
        qV+vs8PG36jy6iwxv7JFh7TKtwTbGMjlCDXhQR1DHbZIGuCiRUX7KQ/AcOT6SV8y
        We4mx1jPHGg43a2eEGPm0C8rJfjTWeVd1CNDeagBRN97ri+J4PNiWFGhG3JoKjZU
        AvWbyHC4g+TkByRS40Went7Z7VBc+od4T86O580i2fX7/51J3uZws0asLO4UYm90
        wDC84Xj5ShEmMK5w899NhWFptzwujZFCx2fazw1dJYmfdZuCvV5QpBm+hoTHWmK1
        aE0vo6f5KrHzWE08e6B4u9cvRMNnb2iDf+GyAUieYal5UG82hPvbBYwkjhwtYRSY
        KE+5yhGxsRy2NzEEMULSA==
X-ME-Sender: <xms:Kvp4ZGgwfAaPpP6MnXRpnqAkTocUWP9tdLEj1ftnwQHVtmFtFytmig>
    <xme:Kvp4ZHAoNG4ERqKbzoQfZS1ZKVBTolTl40J_gG6F6gXxQVW37Ao0pn_IvR0EvclTG
    ZU2qLmTlOXZtc7y3sM>
X-ME-Received: <xmr:Kvp4ZOEvKieW4uwq7MiH9gDtIIeMSmocHUlqvjbpXKaQR6UMP_irmUpaCUmt3yRkIkNndkC3_hwhP_8vXHUgD-MTtrx4KZO359bpvBKqJWrXoBiKLOD6495qTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:Kvp4ZPT0SRprddSJWexBoCWy7BPj7wy3vgTagf88Iy-Vse5wQeUTrA>
    <xmx:Kvp4ZDxIxEg02vImg7oMogz-L6W2icpyTVvEPTs_EozrgK4ljS3-0Q>
    <xmx:Kvp4ZN5Fr3QVkXVsAZ5UDX2VdbcjcxuHBXaH3ZaVBozF_5DrG_vivQ>
    <xmx:Kvp4ZFtpNE9fGbOzjFNw-j7_UyOjJFDY3Y6iU42as0GQOoxFQZ54nA>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 16:06:02 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 5/8] platform/x86: think-lmi: Update password fields to use BIT
Date:   Thu,  1 Jun 2023 16:05:49 -0400
Message-Id: <20230601200552.4396-5-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601200552.4396-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20230601200552.4396-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code clean up to use BIT macro as suggested.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v4:
 - New patch split out from previous patch #2.

 drivers/platform/x86/think-lmi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 564e3fc33cfb..e3be99b44ce0 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -169,11 +169,11 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
  */
 #define LENOVO_CERT_THUMBPRINT_GUID "C59119ED-1C0D-4806-A8E9-59AA318176C4"
 
-#define TLMI_POP_PWD (1 << 0) /* Supervisor */
-#define TLMI_PAP_PWD (1 << 1) /* Power-on */
-#define TLMI_HDD_PWD (1 << 2) /* HDD/NVME */
-#define TLMI_SMP_PWD (1 << 6) /* System Management */
-#define TLMI_CERT    (1 << 7) /* Certificate Based */
+#define TLMI_POP_PWD BIT(0) /* Supervisor */
+#define TLMI_PAP_PWD BIT(1) /* Power-on */
+#define TLMI_HDD_PWD BIT(2) /* HDD/NVME */
+#define TLMI_SMP_PWD BIT(6) /* System Management */
+#define TLMI_CERT    BIT(7) /* Certificate Based */
 
 #define to_tlmi_pwd_setting(kobj)  container_of(kobj, struct tlmi_pwd_setting, kobj)
 #define to_tlmi_attr_setting(kobj)  container_of(kobj, struct tlmi_attr_setting, kobj)
-- 
2.40.1

