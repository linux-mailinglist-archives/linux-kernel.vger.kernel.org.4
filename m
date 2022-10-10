Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17225F985E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiJJGa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiJJGaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:30:21 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDCB4D4FD;
        Sun,  9 Oct 2022 23:30:20 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4FCF13200929;
        Mon, 10 Oct 2022 02:30:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 10 Oct 2022 02:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1665383418; x=1665469818; bh=QgWFXZJMByTxewkr+8LX9hI9U
        gOQHwYcjRmMNM2oVGQ=; b=oSrwXp5SQUHNgFVhc9Y+Jb2SYOPCrkUsdyq6I/l/f
        yC7f6FMaGNar82Rc6dnuDiXPGVtwCNYBtQCH3213TO7Dg71eg55RNOtK0SpBV6BP
        GAMkSs6LOs+wcpK0i4kPXxFYSBdv1DLmIcNLs8TZkuOHdr5gCT1KGGlK5NBtm8Gr
        yUD5b8a7A/lcPx5m6fWt6clJcm6ysMbi2kYJdhSv/kzrtqvR+uOJ7WqJD+6e3bao
        k75+FGhaNjLbLzUR7bP2nnkAx/XTZcIxhuurCQvaQc5WiMz6G006MNHpkSZB3h6t
        4DGDRvNmekMl5OGclVHnJU3p3gSB9SjMRXEL7pB+2jftA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1665383418; x=1665469818; bh=QgWFXZJMByTxewkr+8LX9hI9UgOQHwYcjRm
        MNM2oVGQ=; b=JJ96P9dhvYiA2pdEnn192eioiTehMnd6fTvRhH4L330XxjWPhU9
        4uWXs6JcehIoMLZiCDeQWLbYGhfCPWiUvbBXfBTnAxYpoEQLe+AaBbevOwSke7oi
        nQvzi9+d1ZTg1AVDDv8stVRuy4VRXw0ci87bnmz7/nAHKknZUwnj26FneyJKrKW9
        +wrTQJGSsLmIncXRcGPm6tvDeZ9mWmIOq2h7PukHzAr/Fz0GxEiJ/6Acuzt8g7p0
        Q1le55OI6TyNmpxXmHNLtnKPxOrKsw/Kgol5QfS49Y1w58uTY4ZC1buVPcvJIoaR
        RTrpFNeEyURuZa9dihT/ERE7EcaH+RZVkMg==
X-ME-Sender: <xms:-rtDY4EuwxEl4aWAfLax3G5a3rrk9Kw1wbrwS6yWEyo8tXuFr1KpWg>
    <xme:-rtDYxXPxPAZmBrt3Oy_ISQabW1SSrnm9U0yCY_-5yKrshsiWatr55iDJ8SERLlq3
    VCWVeco3gpmg4Glv10>
X-ME-Received: <xmr:-rtDYyJilWqLP-7DPFsbeBtafzxoUTumgdGf6ulJon5PQPMMCakNLtseHplg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftd
    dtvdfhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:-rtDY6HAANBszl1vk1IGM3oV8BMRqtRax1pBGRPn6feIicxbhWYypw>
    <xmx:-rtDY-VuEqwluRlI3O35Aj3a1qBciPSA53fwAeH3vyEn-noU4v_PDg>
    <xmx:-rtDY9ORfSWFRQdPD0YFfbl60ylStKXV1hiwyV-YtXIFdWOB9JrFcQ>
    <xmx:-rtDY7iTJKADDtCUiQnx919sdk6RFAD0Ez0sO4y4Wo5pnfg3VVYUYQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Oct 2022 02:30:15 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH]  platform/x86: asus-wmi: Add support for ROG X16 tablet mode
Date:   Mon, 10 Oct 2022 19:30:09 +1300
Message-Id: <20221010063009.32293-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quirk for ASUS ROG X16 Flow 2-in-1 to enable tablet mode with
lid flip (all screen rotations).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-nb-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 613c45c9fbe3..c685a705b73d 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -464,6 +464,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_tablet_mode,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ROG FLOW X16",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GV601R"),
+		},
+		.driver_data = &quirk_asus_tablet_mode,
+	},
 	{},
 };
 
-- 
2.37.3

