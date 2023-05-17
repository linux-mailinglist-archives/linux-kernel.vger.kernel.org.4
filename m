Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DA1707096
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjEQSUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjEQSUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:20:01 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D031708;
        Wed, 17 May 2023 11:20:00 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B3A7F5C00FD;
        Wed, 17 May 2023 14:19:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 17 May 2023 14:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684347599; x=
        1684433999; bh=yEx5pnV4SMs/Lz7ucq6fHxr/ssA2T3F4PyuZxJWZ4yY=; b=R
        jp1dLxRduXWT3nYcjKZOrxkxUsPrajWOV1BZEPxXO8MIBXBQIX03cltsF0H3h7IF
        C9XUvFwZMH3VPcOwtHUacQRKqfgHM1yk81atZ/E3iTGJ8lI1zykuxBQu5bAHlTo0
        VcbpjkVFjIVvtxQDDj4LFtYcDPpNjEy6bIDoR42E9iBeiAtTjgjXWZSlLlvNRaHf
        WUXNjQHYLnC6DAeskjQiV1JZvVbEI0GdXEudg8qvmCgDl/Fp4rjzhKEoRci0QB/L
        l9MdIjevN+xZ6OyaB2gDg8u3UwET9/gJPUvcU1v2/WCo8Fm0hCR3faKYB72VCaBL
        Ef0F2ACDVN1I9QvxEBT9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684347599; x=
        1684433999; bh=yEx5pnV4SMs/Lz7ucq6fHxr/ssA2T3F4PyuZxJWZ4yY=; b=G
        mnytK7zwKLwGwRdlfhC7PYDkMvoW8rxidNiNVbtTl2Je4xXGViexK1KDO+ZFan+Z
        CS2yKFQxYCGSJVM9JiLahycsSWFPYfh69naTGXcC+G54WF5qQ0bBTTKlI8OTpOMe
        GC7ChaK/CNVUJkWzLOMkynKUDb+kFa10rJV9l550bNNfBnKfAnBwe2qK4QVrpHQW
        rtOoMkxCNaWv+XCAgGlEqyQ4bOfzKfSQPAvlLTMMnxjXTJTlEVkXDiACUYShepjP
        tP2dTsn/aZlP093SgKX2wBV25M6YaeekyHPn4xvLkEbd3f4KKZMHC1eKEDnuGbI+
        ksk4mAsHjwhlrudKDMH7g==
X-ME-Sender: <xms:zxplZDjcu-1Fe4YF8AoI6VzCm3h1pL9dkyVAU5_N4KkRZAFn2OdNgA>
    <xme:zxplZAAwbdwzBSTjHrsny4qpYeLzElyX6dFwZjj66IJxWdB0tos5My8s0heXJOLY-
    V8CiMz_XB8I83OlXxc>
X-ME-Received: <xmr:zxplZDHI_SqAzCvzbFiEATO4BVs2ayc7H34eFSQ8O_Qyod2yGCgMaOoPfl6C7NO2glH_pHoe1dutudbV6ZP-c4_cqcXLTgGlPOKNKPVwE9ciZEuWL350OAtJNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:zxplZASv-Z9A2Ze747b4oMrFZyzAn7tevOyVWDBszUwdjYAX0nYCuw>
    <xmx:zxplZAzhgHzw-kBc1PZjgqtWheoWDC2OcOeBB8CCSHMMqybskXDjig>
    <xmx:zxplZG42By1zzlWKzooU_TrOfOBMbAOxXbd3dj8DWxZp60v9ouW1Dg>
    <xmx:zxplZM-7Sl5JKlrgAfCFor-A3_P_39F838u5JQw1Qc5J8KONo9qO3A>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 May 2023 14:19:58 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] platform/x86: think-lmi: Enable opcode support on BIOS settings
Date:   Wed, 17 May 2023 14:19:42 -0400
Message-Id: <20230517181945.3725-1-mpearson-lenovo@squebb.ca>
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
 drivers/platform/x86/think-lmi.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 1138f770149d..d9341305eba9 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -1001,7 +1001,28 @@ static ssize_t current_value_store(struct kobject *kobj,
 				tlmi_priv.pwd_admin->save_signature);
 		if (ret)
 			goto out;
-	} else { /* Non certiifcate based authentication */
+	} else if (tlmi_priv.opcode_support) {
+		/* If opcode support is present use that interface */
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

