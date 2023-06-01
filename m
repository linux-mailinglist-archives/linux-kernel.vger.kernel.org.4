Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDF471F362
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjFAUGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFAUGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:06:01 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E8C134;
        Thu,  1 Jun 2023 13:05:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 6EB7C32001FC;
        Thu,  1 Jun 2023 16:05:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 01 Jun 2023 16:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685649958; x=
        1685736358; bh=BuihjXCY0FZRPM1FRQ1H6wx+Ft5lKyW8JMDLJbKUpdE=; b=p
        TFEbXB2nZmJpBzR2g/prdstVVpfbEzaj0wJ+vCmlyrCotpnJ0G8igJajZ4DojHKh
        jez4xHv2Fx9WV0jggwH0FRO7vRhqTuveCjU6cif3iLa9wgkpxO0c4IcU+tSbVOk5
        CqWECsJzplVCsGSYOYQsVc3tiBb0lrKs8wiGQAaTZx+w58wswgpgqh8+5Jya0YSM
        rQpZmVqszmP6uWqgjXJqjPJofHHifPzr+KAyNEXfu+RgZ/Mbp6itog3L6+J3UGiH
        PsBO34LrY8WFxTS9nAh44VeLhs3yQ3NtBd2ykDjY9z/ffr0U2MTIFsk8M95VSLjn
        nakJIIhLnIX1Yap9usQ2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685649958; x=
        1685736358; bh=BuihjXCY0FZRPM1FRQ1H6wx+Ft5lKyW8JMDLJbKUpdE=; b=g
        3aoVubITj4Yqj+bVpLgZA+HbXFBGAKK87N1jZ84aYdeYO60D/NlOYIfe+hMGaK/H
        Z+TnLHdUAIdWY96g0zSNU46LbTYJGLBDy6BeUS0x5Fq9pIs280qnsBMDFEwHbDB8
        AVBviyOr0Enw9y627yU14MEnz/DGTyawEM+UC1wDnvVuTpYs88Z1D7GktrLd9SpI
        cHAhJaCjaDD6QxLGH7w+AaXkDgKBkqpA4i2M2DIoU1wvXECyDvsnh22CLUGecKxC
        XlV9S5Lr58b+cKTAzTdkfe9pFkas8ayBN77mM65xqCjARtVQAMCkAeUACF0SBsRR
        UtdBq+Ng6hu6yyuBZlIag==
X-ME-Sender: <xms:Jfp4ZEzsw39U6kKUrKRVOyiQaIC0QnrKnAPKYoyt83JbppXWTq9gAw>
    <xme:Jfp4ZIQAvnKwMsARyIjbaLNqFuKKq75ldffc2Tl9IQfrCitJ3lAb-vMbzSoz68yc4
    hViex7NeGrCWpj4Ft0>
X-ME-Received: <xmr:Jfp4ZGUobXidmF6RDJjLrJjqFkZk_N1V1PhJBgLFTpd6mVaTgEmYsipwqlowZ-mQXktIrzZ02wBav4GHSfYJO6OX1PF7KGtP0DvANZm6ZxGV71CS73jXmLNoww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:Jfp4ZChdxHCfaVVozUizkKiAJevq9rsQTL8WWZgRH5cJCizugVjomA>
    <xmx:Jfp4ZGBecTz0K1S-qhgTtAmKFhcWdkAOoSUMVdWY6FbOSW7G61RUyQ>
    <xmx:Jfp4ZDILdlh1IZX2G87iYmNDprFRRNcCom8019KrOJ36Ez1lLxyToA>
    <xmx:Jvp4ZJ860YOogXffU9xcTd-WVG0NvMcaKdcHHR7TyLJQszujvIpk9A>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 16:05:57 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 2/8] platform/x86: think-lmi: Enable opcode support on BIOS settings
Date:   Thu,  1 Jun 2023 16:05:46 -0400
Message-Id: <20230601200552.4396-2-mpearson-lenovo@squebb.ca>
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

Whilst reviewing some documentation from the FW team on using WMI on
Lenovo system I noticed that we weren't using Opcode support when
changing BIOS settings in the thinkLMI driver.

We should be doing this to ensure we're future proof as the old
non-opcode mechanism has been deprecated.

Tested on X1 Carbon G10 and G11.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2:
 - Update comment for clearer explanation of what the driver is doing.
Changes in v3:
 - None. Version bump with rest of series.
Changes in v4:
 - Fixed code alignment as requested.
 - changed 'non opcode' to 'non-opcode'.
 - Missing space added at end of comment.
 - This patch was previously #1 and is now #2 in series.

 drivers/platform/x86/think-lmi.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 6cf77bc26b05..80a5c989db03 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -1010,7 +1010,33 @@ static ssize_t current_value_store(struct kobject *kobj,
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
+				    new_setting);
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
+						  tlmi_priv.pwd_admin->password);
+			if (ret)
+				goto out;
+		}
+
+		ret = tlmi_save_bios_settings("");
+	} else { /* old non-opcode based authentication method (deprecated) */
 		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
 			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
 					tlmi_priv.pwd_admin->password,
-- 
2.40.1

