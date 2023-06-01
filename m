Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB4D71F361
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjFAUGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFAUGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:06:01 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22456133;
        Thu,  1 Jun 2023 13:05:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 96B8C3200923;
        Thu,  1 Jun 2023 16:05:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 01 Jun 2023 16:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685649956; x=
        1685736356; bh=wwrl/88jn/a0BD/DhG3Tosh5K8gTAwVmFmge7TvKrps=; b=B
        uY+uBQFNanNfjzjPdJlEEe2l9Akf4nGuX8V9jVo/dJ8AcDSrVD0veNWC1cOrzt9y
        o6Fu2y2UpTEPl4GOjCuWfV9YWnzfo5GIWCM6OSsPr1G6TbKNu4enm7hobBWL6ZZB
        WSZ3UF3ASfhkyyWidsIfhUMlrcavgcmYbrea7n1xUQTUi1ZvdAfmMD3niUUtm0uq
        IXUL1/liGSYy1YNfdBYGLmXFKWqRA/AMDxBKxfSqU51/jAGzbm3b/v8D9RICEqvC
        FeT69bM1p4uSEZlqphXPoXR6QFUgoce8lRTdUAn39vcAv3WpAji4Kbfr3g4CFsT3
        /6GBPOHhvMxRVXRjqpJyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685649956; x=
        1685736356; bh=wwrl/88jn/a0BD/DhG3Tosh5K8gTAwVmFmge7TvKrps=; b=r
        ifA9ljKY3Z8xZ06pU6OxoXVtYH6dhC3I8WMoktWHJQTJWtIW+ly49U5Pc3mChvOU
        AyF5y9FmDxafr4D8oWfRooGXQVwXss7iRjXdhR8OdKXaJURAt2FttQ4GAkEcsJD7
        xvxrF2ytVlPot1C2vEoiixuE1rbbwOS6IFdytM3KqpuRaeOEAoJttWJS17oYiZRT
        lcez2S3CRW9Fxf0yHoYY2/82KgLHDD9iDbLwbL4BHXQVA+w7Sgs3JWOPV+/rrG/c
        eleDjghMaWaaUOGKzLuWNiMpSPU8fRUbUZp10xkgVWfnjXcjTZXogjAXxP3lJasf
        hgZTM0m2B/yq0JRqDUsUQ==
X-ME-Sender: <xms:I_p4ZInSxsa9nK3siSanLGBAKHB-pZL7O7k-ywnwyYLzxrrrr1kOsg>
    <xme:I_p4ZH3WEHCPJ6fYrGJbOv38aZQSOiRheWpB1SO_gcK43iFBms8f9Del4JzpnLVxI
    iGnV5WRvR2kvOFMayg>
X-ME-Received: <xmr:I_p4ZGr5e_Cu90pew3xTbeuuvtIT7xWVT-37xkogVgKTh3CvdPxhKpxJ0vKZv24GxSuQNcaNuaIJXgP_pZiblm0UVWUPlbCVfX9Sw2sBO4YzjfpGp2Gl2CBz4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:I_p4ZEnaeeUUk5cAzFDBk4wv7UcRYhzS5x2_CyXjY3azpUFHPNwfJQ>
    <xmx:I_p4ZG1Lj_SQZ8T07EeCsw-z_oYNKYQQ9XnOX4ECmgMMqtVtCpk3Mw>
    <xmx:I_p4ZLunKW5PBAyvaimtafIACKICgaOBZQHO_iIQptkj4hcxbUd5qQ>
    <xmx:JPp4ZJRMk1ngy1oUMqZSojv_ssdZ4irxp-HdlTwlo82Fc6K_r4yk3A>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 16:05:55 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 1/8] platform/x86: think-lmi: mutex protection around multiple WMI calls
Date:   Thu,  1 Jun 2023 16:05:45 -0400
Message-Id: <20230601200552.4396-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an attribute is being changed if the Admin account is enabled, or if a password
is being updated then multiple WMI calls are needed.
Add mutex protection to ensure no race conditions are introduced.

Fixes: b49f72e7f96d ("platform/x86: think-lmi: Certificate authentication support")
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2:
 - New commit added after review of other patches in series.
Changes in v3:
 - Simplified mutex handling as recommended.
Changes in v4:
 - This was the 5th patch in the series but moved to be first.
 - Added Fixes tag.
 - Improved commit information to be clearer.

 drivers/platform/x86/think-lmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 1138f770149d..6cf77bc26b05 100644
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
@@ -981,6 +987,9 @@ static ssize_t current_value_store(struct kobject *kobj,
 	/* Strip out CR if one is present */
 	strip_cr(new_setting);
 
+	/* Use lock in case multiple WMI operations needed */
+	mutex_lock(&tlmi_mutex);
+
 	/* Check if certificate authentication is enabled and active */
 	if (tlmi_priv.certificate_support && tlmi_priv.pwd_admin->cert_installed) {
 		if (!tlmi_priv.pwd_admin->signature || !tlmi_priv.pwd_admin->save_signature) {
@@ -1039,6 +1048,7 @@ static ssize_t current_value_store(struct kobject *kobj,
 		kobject_uevent(&tlmi_priv.class_dev->kobj, KOBJ_CHANGE);
 	}
 out:
+	mutex_unlock(&tlmi_mutex);
 	kfree(auth_str);
 	kfree(set_str);
 	kfree(new_setting);
-- 
2.40.1

