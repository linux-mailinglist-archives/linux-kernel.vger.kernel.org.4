Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040D6712B93
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbjEZRRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjEZRRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:17:17 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE258B2;
        Fri, 26 May 2023 10:17:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0626F5C00C4;
        Fri, 26 May 2023 13:17:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 26 May 2023 13:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685121434; x=
        1685207834; bh=3H+Xr8+kBb0oLRwshP3ohk2SfeItphOtUJ4BgiDd58o=; b=G
        jduknsKae90MfW2LyUQZfGgKk+QNKW0iUGr25IpGpV+e3YmVwOC7/8XrG2j4diBv
        GPS6Hd4pYABNFAk/DH/0rEfCdyg4kKwD+5Gy3lU0937wZjQlZOGiFpbrn6z9tdDy
        MrI4omcrIwjA2PZU2DlbS07rgKmRAt4ces9eae5dXxbj7P6lyKkm8YCObEx3UpUb
        Lkm+LF1pZYCGzmUqUn/RiCWZNzGHAsIOEHwYfkVd4fwBn2qxXYIubSAmD23Cg3Yw
        zkvbq0I5Ed7I3v8gGG+yG2GKzNsh8FTyJjCG3eLaNa8i61nNbHX0mjdVZQUm/6UA
        SlYS7yjX2vHNz5GFPYQdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685121434; x=
        1685207834; bh=3H+Xr8+kBb0oLRwshP3ohk2SfeItphOtUJ4BgiDd58o=; b=R
        3BmtsiEzBOBdYJrpouC8kU8xnj7T57Lc4FPIQQxWPkQ6WkXkxS6kEfsyc91R3KBF
        xss3DywV6Fxh3e4xWez3+oaeRRFpcqOTs3FX9LJD3pCIwWfGeUahheM9ucsDuwra
        W/Hpg+VDjXUUS6GbvYo6QWglPLBZ4YR2ZotU+GKRCE/9uh9zAd7e0nYR2d2FQCGI
        VJwBubkH5tENtC0scKvKRdgDoLA3B3xzZMgYQQ/51/rDZYIHoXwqKfSKFfRD+CxX
        xlm6BiLrrU8XaDKRAQNKcBKfDBo8FulAFkV7P89ivyE50oknUPQhYJ1bwjxgW7R5
        y25yvmMAaykx0Nn5mHixw==
X-ME-Sender: <xms:melwZD5Ru3K1QlNIYk_oR3QdTc5rs2cN18-TjsC9dWx5lUrmXIyyiQ>
    <xme:melwZI5n3RV-ZBDnqfdg8UuEP-xBwdPzR58ovcTocReYebpEnms6mgkE2_3OoI6wm
    FQ8X98m5PkOCc3wwI4>
X-ME-Received: <xmr:melwZKcDl8zuH50l6tSc96d7VE_iee6bOYJQYS3BT0vmgXVeuNhU1IPvtE2duJKcnGsXv9BEjoYigO7x36IJzaUrbk7UkXTw6PM2QQls85fZ-RWRrXlxGBkEDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:melwZEIEbD4WA3XqBE1Ky5LKal4IGAzX_-MdeAvpaSkCFk59U8YWXQ>
    <xmx:melwZHLg7ARXnqsWXRQ0TaEpwMQQY_0B6LFHyBgJxbXO-dRhzwMUBA>
    <xmx:melwZNyYgDAUgr-hThgJI_cx_7DNfjs-112MvSqenUBw1Bhtzt9h3g>
    <xmx:mulwZP29-MCdgYbTTAbX4IX6giu_w7qxNRVOAwaGRHMzsE722x1Eyw>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 May 2023 13:17:13 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] platform/x86: think-lmi: Enable opcode support on BIOS settings
Date:   Fri, 26 May 2023 13:16:54 -0400
Message-Id: <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
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

Whilst reviewing some documentation from the FW team on using WMI on
Lenovo system I noticed that we weren't using Opcode support when
changing BIOS settings in the thinkLMI driver.

We should be doing this to ensure we're future proof as the old
non-opcode mechanism has been deprecated.

Tested on X1 Carbon G10 and G11.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2: Update comment for clearer explanation of what the driver
is doing
Changes in v3: None. Version bump with rest of series

 drivers/platform/x86/think-lmi.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 1138f770149d..2745224f62ab 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -1001,7 +1001,33 @@ static ssize_t current_value_store(struct kobject *kobj,
 				tlmi_priv.pwd_admin->save_signature);
 		if (ret)
 			goto out;
-	} else { /* Non certiifcate based authentication */
+	} else if (tlmi_priv.opcode_support) {
+		/*
+		 * If opcode support is present use that interface.
+		 * Note - this sets the variable and then the password as separate
+		 * WMI calls. Function tlmi_save_bios_settings will error if the
+		 * password is incorrect.
+		 */
+		set_str = kasprintf(GFP_KERNEL, "%s,%s;", setting->display_name,
+					new_setting);
+		if (!set_str) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTINGS_GUID, set_str);
+		if (ret)
+			goto out;
+
+		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
+					tlmi_priv.pwd_admin->password);
+			if (ret)
+				goto out;
+		}
+
+		ret = tlmi_save_bios_settings("");
+	} else { /* old non opcode based authentication method (deprecated)*/
 		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
 			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
 					tlmi_priv.pwd_admin->password,
-- 
2.40.1

