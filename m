Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF02711780
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbjEYTfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241981AbjEYTfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:35:30 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19539E4B;
        Thu, 25 May 2023 12:34:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C6B885C0084;
        Thu, 25 May 2023 15:31:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 25 May 2023 15:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685043098; x=
        1685129498; bh=vRdhAijcr+SqqHZKB0865doAzp+2d040yLp8Fj5LvAw=; b=K
        4p2qBytCnfrw9jS/FittH63a+5p7qQwL1tWyxf02Dg14PwIexBVaY/tiXdzRvKng
        owhxti7tNgDDgtJsKeZwzQgRUF2YRiNDrJ0AbYagLjMaGFwABu+LNq7p4O8ve65w
        IA2jwvzYR0hsZwdYsdTr8xIHVtQYeaKEacqafKqk1qHhq3JSnmKiYg+0MYcP7lsC
        cVrjg4/kXiK0EGmjXzw1X/TZTKgpo+X6JORtgwuOwzEn8SVTkY/kPMnop6gd5uGZ
        DaZ2p0BDpl++n2y9PAu+7XSKCo7D5BT5or8Abi7/SfY0KukMf+8lMLR9YJo3ceQb
        m1vlOFPxGjQqpjpU5mYLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685043098; x=
        1685129498; bh=vRdhAijcr+SqqHZKB0865doAzp+2d040yLp8Fj5LvAw=; b=A
        yaksA8veTA8EfyiyF7jlwflHdz1QAFH/7EV4oM7ipG4cLNjE+Q4nFZR0yylo7e7F
        rNeD41gf9qZYfary7fUVjsMXgmaYHBc/jmqBJ1ZIoNCP//cOyGd1OV2J2QyvZMiO
        6rFIHVOuBAGkFalIwpN6H0s9KdBvbPpuzqP2plb6A1hToFMNQvBOXrO/Cxw96FMv
        fQxXE0LFJY5SHXtIVlzJ+PzTK1zfIvhU8rk9Et7AgeTPpJke7/LcXyui5wX5V9cL
        NZ9ZPQG3iKDXhoFqe+cSciy46LwUP2FqHCHwnl8j4DY9F+/qoGDjqGXlk19kJv+d
        IYF6x0ikk4uK04Q5igWoA==
X-ME-Sender: <xms:mrdvZH008kZT1N_lAxTQF3uUdXWREbNxFFA0JCcQgAvkVmEJgwGAcA>
    <xme:mrdvZGHDeuGWbVJOU0bobITlxbNb0Yqbm41KfSTP4GP7wWW_lI8q_juvgMZzHGxLp
    hLGqTeU-xCdFn1-SGU>
X-ME-Received: <xmr:mrdvZH6umn9j9syJRq0YT92gFthHQPxyHoxtn2s1CaktUpX5cW4UHTDkykjp-mGSZoYjrsfAYAGEYOQEgUSejvgeVlVAp_BsyMU0gBVdfzvADXTC--8fV1_tKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:mrdvZM3rrLJhjbyXFvQq4WWvL_igKAeh4avJr23--ZejSze3qIrjIA>
    <xmx:mrdvZKFYutLckVhj5W55CahG0hz5ihpg9fuMOzDc2lw-VLtSysEGUg>
    <xmx:mrdvZN_-SvgHi_Ruxb9M_1tNrDQAnrnCw_pxfVHDWHsuKrFuHqLJLA>
    <xmx:mrdvZGDB2tJBGsFW8SM5G8rFBjos_7gfnj4HlS6lvLJEQGymkUmnPw>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 15:31:38 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] platform/x86: think-lmi: mutex protection around multiple WMI calls
Date:   Thu, 25 May 2023 15:31:32 -0400
Message-Id: <20230525193132.3727-5-mpearson-lenovo@squebb.ca>
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

Add mutex protection around cases where an operation needs multiple
WMI calls - e.g. setting password.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in V2: New commit added after review of other patches in series.

 drivers/platform/x86/think-lmi.c | 46 ++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 64cd453d6e7d..f3e1e4dacba2 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/mutex.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/dmi.h>
@@ -195,6 +196,7 @@ static const char * const level_options[] = {
 };
 static struct think_lmi tlmi_priv;
 static struct class *fw_attr_class;
+static DEFINE_MUTEX(tlmi_mutex);
 
 /* ------ Utility functions ------------*/
 /* Strip out CR if one is present */
@@ -463,23 +465,32 @@ static ssize_t new_password_store(struct kobject *kobj,
 			sprintf(pwd_type, "%s", setting->pwd_type);
 		}
 
+		mutex_lock(&tlmi_mutex);
 		ret = tlmi_opcode_setting("WmiOpcodePasswordType", pwd_type);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&tlmi_mutex);
 			goto out;
-
+		}
 		if (tlmi_priv.pwd_admin->valid) {
 			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
 					tlmi_priv.pwd_admin->password);
-			if (ret)
+			if (ret) {
+				mutex_unlock(&tlmi_mutex);
 				goto out;
+			}
 		}
 		ret = tlmi_opcode_setting("WmiOpcodePasswordCurrent01", setting->password);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&tlmi_mutex);
 			goto out;
+		}
 		ret = tlmi_opcode_setting("WmiOpcodePasswordNew01", new_pwd);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&tlmi_mutex);
 			goto out;
+		}
 		ret = tlmi_simple_call(LENOVO_OPCODE_IF_GUID, "WmiOpcodePasswordSetUpdate;");
+		mutex_unlock(&tlmi_mutex);
 	} else {
 		/* Format: 'PasswordType,CurrentPw,NewPw,Encoding,KbdLang;' */
 		auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s,%s,%s;",
@@ -1000,11 +1011,16 @@ static ssize_t current_value_store(struct kobject *kobj,
 			goto out;
 		}
 
+		mutex_lock(&tlmi_mutex);
 		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTING_CERT_GUID, set_str);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&tlmi_mutex);
 			goto out;
+		}
 		ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
 				tlmi_priv.pwd_admin->save_signature);
+
+		mutex_unlock(&tlmi_mutex);
 		if (ret)
 			goto out;
 	} else if (tlmi_priv.opcode_support) {
@@ -1021,18 +1037,23 @@ static ssize_t current_value_store(struct kobject *kobj,
 			goto out;
 		}
 
+		mutex_lock(&tlmi_mutex);
 		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTINGS_GUID, set_str);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&tlmi_mutex);
 			goto out;
+		}
 
 		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
 			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
 					tlmi_priv.pwd_admin->password);
-			if (ret)
+			if (ret) {
+				mutex_unlock(&tlmi_mutex);
 				goto out;
+			}
 		}
-
 		ret = tlmi_save_bios_settings("");
+		mutex_unlock(&tlmi_mutex);
 	} else { /* old non opcode based authentication method (deprecated)*/
 		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
 			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
@@ -1056,14 +1077,17 @@ static ssize_t current_value_store(struct kobject *kobj,
 			goto out;
 		}
 
+		mutex_lock(&tlmi_mutex);
 		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTINGS_GUID, set_str);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&tlmi_mutex);
 			goto out;
-
+		}
 		if (auth_str)
 			ret = tlmi_save_bios_settings(auth_str);
 		else
 			ret = tlmi_save_bios_settings("");
+		mutex_unlock(&tlmi_mutex);
 	}
 	if (!ret && !tlmi_priv.pending_changes) {
 		tlmi_priv.pending_changes = true;
-- 
2.40.1

