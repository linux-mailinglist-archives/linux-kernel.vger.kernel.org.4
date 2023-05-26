Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12929712B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbjEZRRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbjEZRRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:17:20 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4661CF2;
        Fri, 26 May 2023 10:17:17 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B319A5C00DC;
        Fri, 26 May 2023 13:17:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 26 May 2023 13:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685121436; x=
        1685207836; bh=a6e+m1dGX2S9IHv+LEb0KF8KfjhX5NO7nh1vFg/in2g=; b=T
        NK1CLoTndCbe2AqPL2bBK38QMNjJTuAAbabkVZnzGUJEIjykcEzqFp11Ryor0BvB
        eG8bfjobd/ERFsg7Okn4xtydB+al2wtbyv2RQ+ehTkboGGqgZ/5rbdyVN+kflsCL
        3drRe3FZqoVThy6OeSIu0qdaXcPwly2l1XRCwF3CY8518xTlYN3R1mT5Q8UTIPh1
        DooeJIAG1rWGWzatFU/nzvaGljhcH5Mr4lOvUBVvq4E4tq8XxE06XURa0dj5/6/3
        AVZOE8iCxK06N5XQC82t8EOZG4u+0vEnRtoY7ir23Vm4cn6ztmXG5s59YwDIzepa
        zZlSi7VEoGiniRz8TNg1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685121436; x=
        1685207836; bh=a6e+m1dGX2S9IHv+LEb0KF8KfjhX5NO7nh1vFg/in2g=; b=Y
        LVMY9FMRyfyLPM7j3KEP2oZ+xk/MFaHJMTkd+WsqZMlHRXKq4GE+mggW266UEflu
        5EUi840C/1Mt6DRyGLkEeuklrsmAA2KnINPy+syT+PaByJ1MnEH6qB/tE65z+63X
        fdT9EIwNTFj+Wwu1b6ZGPtz6pDUBbwuXhoHR+I2cxZccaryTEkUoxlRexD0WPtx/
        ubdTJuHdwuRmR7OLjf/A+j+0uNDMano+KLaQfSkYruOXA/XflMaimL7g7gv9GhdC
        PYG+oC1Zrq11+uaxhchiwVPGPXnsuAhpH59w3X4bi21oVOBnlmj3Z4xmHKX7aRPn
        NocrBzsc5A/mjMUTFcDPw==
X-ME-Sender: <xms:nOlwZOQ7tyASaxwaYubBS5bP0dDWlFpsPkCOXb-L1gHQvFqZle-WAg>
    <xme:nOlwZDx0-cNjEq_Et3LppAqSxzV2FuhyoUELYFMkgyx6d5BbLDrJOao-qIEp0xiZ6
    1gL_Ca1BBn59m6GroM>
X-ME-Received: <xmr:nOlwZL29VLYanBats2rij568-qBr1fxzUKZrxKHm1xmuHBsDZ1xbFuaYUixkG9zDZm-9wPHelgBAEZzqGKqS4NpN3F6BPet6HzK2gemO1KPbFUPCc_NHLOv7Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:nOlwZKADrNk0hq-M0npqA7N4tB-lvrqf6JwZ87d3g7bzqNbXllXj5A>
    <xmx:nOlwZHgPQ432SqscBkbcOvU3wUbEZ068p_ziip-P0ek6ER7294bXyg>
    <xmx:nOlwZGoC-jhRX5dGZm9HIGzIZO3-UWnoo_Ei9kQtHGjg4N1mLPm3Dg>
    <xmx:nOlwZEuLtLTpUYkszUh0tdHvDZ9C17vLT9Ih04iMTwntuCVPmFzcdQ>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 May 2023 13:17:16 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] platform/x86: think-lmi: mutex protection around multiple WMI calls
Date:   Fri, 26 May 2023 13:16:58 -0400
Message-Id: <20230526171658.3886-5-mpearson-lenovo@squebb.ca>
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

Add mutex protection around cases where an operation needs multiple
WMI calls - e.g. setting password.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2: New commit added after review of other patches in series.
Changes in v3: Simplified mutex handling as recommended.

 drivers/platform/x86/think-lmi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 64cd453d6e7d..86185358dba2 100644
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
@@ -437,6 +439,9 @@ static ssize_t new_password_store(struct kobject *kobj,
 	/* Strip out CR if one is present, setting password won't work if it is present */
 	strip_cr(new_pwd);
 
+	/* Use lock in case multiple WMI operations needed */
+	mutex_lock(&tlmi_mutex);
+
 	pwdlen = strlen(new_pwd);
 	/* pwdlen == 0 is allowed to clear the password */
 	if (pwdlen && ((pwdlen < setting->minlen) || (pwdlen > setting->maxlen))) {
@@ -493,6 +498,7 @@ static ssize_t new_password_store(struct kobject *kobj,
 		kfree(auth_str);
 	}
 out:
+	mutex_unlock(&tlmi_mutex);
 	kfree(new_pwd);
 	return ret ?: count;
 }
@@ -987,6 +993,9 @@ static ssize_t current_value_store(struct kobject *kobj,
 	/* Strip out CR if one is present */
 	strip_cr(new_setting);
 
+	/* Use lock in case multiple WMI operations needed */
+	mutex_lock(&tlmi_mutex);
+
 	/* Check if certificate authentication is enabled and active */
 	if (tlmi_priv.certificate_support && tlmi_priv.pwd_admin->cert_installed) {
 		if (!tlmi_priv.pwd_admin->signature || !tlmi_priv.pwd_admin->save_signature) {
@@ -1031,7 +1040,6 @@ static ssize_t current_value_store(struct kobject *kobj,
 			if (ret)
 				goto out;
 		}
-
 		ret = tlmi_save_bios_settings("");
 	} else { /* old non opcode based authentication method (deprecated)*/
 		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
@@ -1071,6 +1079,7 @@ static ssize_t current_value_store(struct kobject *kobj,
 		kobject_uevent(&tlmi_priv.class_dev->kobj, KOBJ_CHANGE);
 	}
 out:
+	mutex_unlock(&tlmi_mutex);
 	kfree(auth_str);
 	kfree(set_str);
 	kfree(new_setting);
-- 
2.40.1

