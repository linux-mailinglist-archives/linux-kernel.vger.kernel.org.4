Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8565A71F36B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjFAUGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjFAUGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:06:02 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0331613D;
        Thu,  1 Jun 2023 13:06:01 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 20D563200934;
        Thu,  1 Jun 2023 16:06:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 01 Jun 2023 16:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685649959; x=
        1685736359; bh=cLRPgHTyo6c+6/oybL3A1mBCEIZMGkL9lFVRPDGt43Y=; b=o
        irn+iISfJ2v2EiO0BiBzXMNutmFAim0Ed/VDO69SfSuvKkpMGIyrkoEou54p4Ywk
        dQVgAUOUWp75+MLcMWliJb7TV2brHPzaK0fZ51pV9iPevQa3wyi1naqTo352fqv3
        moQIzmxsVhiThXMAaJGhjFN1oRiXmn4s1941y0srcLleyIYyKP7SY8jNNpF8aAyf
        LrgQVscA/8iz7Wlfp0JLHKE0X2ZlqnoS4+hrvk8UFtYT96gEcclBfDSTeMqBooFF
        /LZ1UMbP79a03LtgTxkgHbnB/07sy8MlWPNjdehrVPDrn8xmgeDlN3MGY8M4UvFu
        QkYCaN4SXcN/z9Lj5Vilg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685649959; x=
        1685736359; bh=cLRPgHTyo6c+6/oybL3A1mBCEIZMGkL9lFVRPDGt43Y=; b=m
        wD3SyB2r5oQrgbxOuR+t45kOCGcEil8va8a6hZnmLKu/TFZCP3G8VSU1sAQCOcOW
        +H0jpBJs3jNRPw9KrSkemqoKt5nNmGTzgP/mk2P17O+rDQj38VEKOKQy/qHcW9eg
        Z9x0THnN/e5Bq02TIGEIBSkJVZXag7Cs2qGF8EzRkqQ6eeOqkq0U/eTT2tvv0q0H
        rDoqQORPjyz0bDwZGc3yV1oaAfNy3mlZRaQQK5CGODC9vpNJIcny7913ZAUtXduq
        JpeWdWDbtwOvAnJFxkV+stPQTOUUCCIoqwo2++BY4URZqv5mKbD8hDj3Dz4d1WSg
        h5dHuMGtQBX9BgVCXc0oQ==
X-ME-Sender: <xms:J_p4ZNQhZ6qRHXlulFoQEdSlrlUDH1bbqERtV2ahA2wxGMfzxRwzIQ>
    <xme:J_p4ZGz7s4VGKqUQQrgvppd49djtDYQ9KL2KdC80x9eBelmoMXt60Te9rHejyqJuX
    IlyIXPVf1unvBKTjL4>
X-ME-Received: <xmr:J_p4ZC1tdQjVpAGjLOod_HD9Vs0CiS52HYHURm9k4BJ8_5-ul7anaIcQGjO7OsZfS7xjE35_QgwXfvWCEbeeGQV5G7ivzEO7ddGfX-BGjhzBm7pa7LTj_oHDmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:J_p4ZFBWdQrwoGK-DlaYbQ6hoMB0Sir1H5F0unhgQQplAF994MFy7g>
    <xmx:J_p4ZGhkhQ2Z_sO6ED6zhEtPiDKVTv8bCIZF0_aAInroFjrh54UNOw>
    <xmx:J_p4ZJrMx9r6eknezFImJAFN0P4Qm8JXsdZ9oZ9Z5vETBaBOhLK3Cw>
    <xmx:J_p4ZOfkCJlU2LEWDqoIO_yluZ94Qd4HzMXchDgvbw4IRqlPRc3Q5A>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 16:05:59 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 3/8] platform/x86: think-lmi: Correct System password interface
Date:   Thu,  1 Jun 2023 16:05:47 -0400
Message-Id: <20230601200552.4396-3-mpearson-lenovo@squebb.ca>
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

The system password identification was incorrect. This means that if
the password was enabled it wouldn't be detected correctly; and setting
it would not work.
Also updated code to use TLMI_SMP_PWD instead of TLMI_SYS_PWD to be in
sync with Lenovo documentation.

Fixes: 640a5fa50a42 ("platform/x86: think-lmi: Opcode support")
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2:
 - Updated define name to be SMP_PWD instead of SYS_PWD.
 - Clarified in comments what each password type is.
Changes in v3:
 - None. Version bump with rest of series.
Changes in v4:
 - This patch was previously #2 and is now #3 in series.
 - Patch split so comment updates moved into new patch (next in series).

 drivers/platform/x86/think-lmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 80a5c989db03..f6d1931540f1 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -172,7 +172,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
 #define TLMI_POP_PWD (1 << 0)
 #define TLMI_PAP_PWD (1 << 1)
 #define TLMI_HDD_PWD (1 << 2)
-#define TLMI_SYS_PWD (1 << 3)
+#define TLMI_SMP_PWD (1 << 6) /* System Management */
 #define TLMI_CERT    (1 << 7)
 
 #define to_tlmi_pwd_setting(kobj)  container_of(kobj, struct tlmi_pwd_setting, kobj)
@@ -1519,11 +1519,11 @@ static int tlmi_analyze(void)
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

