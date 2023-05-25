Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16655711772
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbjEYTdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjEYTdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:33:35 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D949E69;
        Thu, 25 May 2023 12:32:59 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 255DB5C010E;
        Thu, 25 May 2023 15:31:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 25 May 2023 15:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685043096; x=
        1685129496; bh=2YuucB8ge+Gjjiz/CAErVcfKQLxgmGcYZa0k32yeS+o=; b=V
        NddOGdr11wVcCWiNRkYsBegF/WljAvWvksusx68y/+1/FNxd4EE7nJmHqnr/qCgD
        Sypzx3vSWxUHSO1cSl9dhr1NxjyuD1+osg30HIBihODpLP8GGYGUQv+XuMfDEy1g
        UPkT/ylzF4hGTjeqjr5TaUifsWKz//nwmvHfsM1bXKSe1RnPX6bStfphsk7POoP+
        1fhWz1rH1ha/Ib2c9Thw8646R5uE0aY3v9bqP7L1jNfPCsT+gC35NKdqQ7cMEW1m
        GotGxUE7iprVjIfEE01fm41JS6m/w9V0uVpSMNcwgzgo06tUY/JloeK7FyTb2oi7
        vLdMPInASb4BOvifBIXbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685043096; x=
        1685129496; bh=2YuucB8ge+Gjjiz/CAErVcfKQLxgmGcYZa0k32yeS+o=; b=i
        NGvbCK7t0iqhF1zqVLwOYOE2BCiXEKtGx56hLHKAPclCBHKgIJWijZssastntqKt
        OJOCy8JIhxonAEHir8h/OCn+yQA8I8rjD28SVWcn0KZU1K6Ad7wOyITZQYCULCK8
        krhYvUNpC1b3N8mjDD+/yZpWFUVAVJi0XZnk5QQI+QsIZAwH5XPlHDa4OZBKgbhL
        cvFMC2hAAVQ4wiDHEh8ZKc+mFZ+4W5B9Gk7KMx5T461/r3EO/r/WCUqKnA/dcIeJ
        UGcDIrtQcAopp1nEgGgjBrQP4G3C45/IXRG5P1WmjCWvP/lLNp3nHsTnqUIFlYrj
        f/oqbS1NfeEyku2jkIE7w==
X-ME-Sender: <xms:l7dvZB3_Kst54dHCrMsUSS4bJcuP2bD8cDVwhuUQgbcT6wnPTFmOuw>
    <xme:l7dvZIHJNL8leR1NSjN4vMjv1JKwTGSe_I0Opo18HFaOytr3KPat6AcrfVKUXc6Pt
    UqghRHtfFCoB4OefB8>
X-ME-Received: <xmr:l7dvZB4K0G5f9rtn873-GWQ742g08g6O6VMS5B1LdLEayup-gBoyxYeMCZcZX8ewlXEXlbD2sOqIgKZcLkCtLPgnsKwEHEXg_ya_MZIfAfXAVO-nHkxgxPU-Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:l7dvZO2uNrSGBG29RMsrXBkizIhJErTbzXMgKb81jJnRIm_-Ddz_gw>
    <xmx:l7dvZEEtMeHs6cSFuDdALCeta3-Syzzj3L5_lBCISnOsKsZxiIQTHg>
    <xmx:l7dvZP9Ga6cwMTs8xxoH_-_iP90jY269mTrZonfUKVOtEsp7Dbf6hg>
    <xmx:mLdvZIDtb78sTFzMkbunjzZIQTn6mU7v_UWrbh0FGvHSFZyEgcpXqw>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 15:31:35 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] platform/x86: think-lmi: Enable opcode support on BIOS settings
Date:   Thu, 25 May 2023 15:31:28 -0400
Message-Id: <20230525193132.3727-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
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

Whilst reviewing some documentation from the FW team on using WMI on
Lenovo system I noticed that we weren't using Opcode support when
changing BIOS settings in the thinkLMI driver.

We should be doing this to ensure we're future proof as the old
non-opcode mechanism has been deprecated.

Tested on X1 Carbon G10 and G11.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in V2: Update comment for clearer explanation of what the driver
is doing

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

