Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F444712B94
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbjEZRRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjEZRRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:17:17 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5798DFB;
        Fri, 26 May 2023 10:17:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BE9205C0179;
        Fri, 26 May 2023 13:17:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 26 May 2023 13:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685121434; x=
        1685207834; bh=6WpOx2gK33A4/xpMNBFpnpPcJvOudjsGpjGgTRy4P64=; b=r
        zRmM84NG2q7CQ1nO6rpI6HFyCLaXO4Jw4qXmefCKDcpm008YbduVPk5EMQNwo0kh
        v4KHlFFHLduzyv3LgQ9IgEGDJQj/G+hASoPvoNVxcf0Y2wlHH7i3qbjpzZQe83TA
        dmMq7dH/r8ROrb2GIMba++BcfF2nHNFnVVupSw8XjPbl4OaA3lIclJvY8bIVWoHv
        xyMzcl3rBedQ5VIJoLnSv2GmmFYkjMJotsjT6hBYozCgUXg8k3ALFx1z2GK0ZNIt
        Z25jyypSQmynW59QI/RQjqUnoJyKVRKu6JHL+e0Yt6bwKwE9o55QvvGR9GLO+eQU
        30Z3diNJapJ007Y+KFM4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685121434; x=
        1685207834; bh=6WpOx2gK33A4/xpMNBFpnpPcJvOudjsGpjGgTRy4P64=; b=q
        V2PTC19SUOoVYlZZ7pkfwDw+HRKN7WR1TPQcdbYAon4raDZJz564MavPZDMbCxHH
        5i1jbFGZHRzW9WZI3gUxR9A+E2tN7hG4rdYHQh9FjvVEGLsElLKfHlFH6i46kL6l
        3knRz0OLJ9Mw0I5O1/JRyLCI6K0TEWZILYMtr4kvOsly+rw/2L0j5p0+VXiIdhhw
        WoT7qNboRizuckXx+J8gh6dBkDE/1fcKm02HJ2PohV9whIb8OPQ0swla4LI+z61I
        /0NFZPcIx0q7ACygLcD8lO15fBOPZ8PwJV3+gk+V0xgnzfyYy++4/uvaAQCLf4bd
        FGz93E8kJrGN6byxyW9MQ==
X-ME-Sender: <xms:mulwZJOjSdl6mPqfx0EjU4nbtjNJW4Pkm76Y-p4XOsSRbBJ19tbCJQ>
    <xme:mulwZL_TyjrS56z271zZXN-RcgHnfAsWW6e3jfU6NkO_Xlp0HF_Xa88qP2JxBVTe6
    kP2XtCxeJ8CXuyDP18>
X-ME-Received: <xmr:mulwZIQaDhCyCnZ4u9bePJTEvAS6cKLqLfE0OrMvza9q-f3qQCY2y3sqIrHoYH4hWHHlEGu7nvUtb9wI5ezqsAYyHrcUvQ742gkMnZgaZgqTJAh0oXYmQy60tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:mulwZFtOZ7A_cNXmk5am1cUEYLmx6rs1fTKPvq_ykCHsEQD6vR3iEg>
    <xmx:mulwZBfjiU7LF6mmWbuAw4cOFhr9dE8ePj_f770ITYfc3Twq9SLdiA>
    <xmx:mulwZB331h6p59agp0X1gHj5XEUZ_6bzVs0ByW54KwPTh1jM041CmQ>
    <xmx:mulwZF5DCh2768tPKOdukl6-n4Ykkc62zyWQr0OH2UWgfmSMYikyTQ>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 May 2023 13:17:14 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] platform/x86: think-lmi: Correct System password interface
Date:   Fri, 26 May 2023 13:16:55 -0400
Message-Id: <20230526171658.3886-2-mpearson-lenovo@squebb.ca>
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

The system password identification was incorrect. This means that if
the password was enabled it wouldn't be detected correctly; and setting
it would not work.
Also updated code to use TLMI_SMP_PWD instead of TLMI_SYS_PWD to be in
sync with Lenovo documentation.

Correct these mistakes.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2:
 - Updated define name to be SMP_PWD instead of SYS_PWD
 - Clarified in comments what each password type is.
Changes in v3: None. Version bump with rest of series

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

