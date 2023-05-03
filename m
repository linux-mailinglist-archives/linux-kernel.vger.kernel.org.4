Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439486F4F3E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 05:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjECDr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 23:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjECDrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 23:47:48 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066F33C14;
        Tue,  2 May 2023 20:47:46 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1801D3200B88;
        Tue,  2 May 2023 23:47:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 02 May 2023 23:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1683085664; x=
        1683172064; bh=qJF/y3PUtn5/2JZtl7kI9dJefyoiVSOcY3IKgthNpIc=; b=z
        ySnQ1rBAnzidl6iL0pwfcaV7q1BhJw7K8Z7Gnxg+eWmliFMapKVb5x4C5tMnYIeI
        cGCvsTxLAV4Bxi5DuvP60YET7SQYI0Cve51cwXF5DOypi9VECATBXGq9KEatcUHY
        Oe1WT9JwIBJBMwx8opbIxeSA4xSniYADfOiQaMKp1LxcbngPLEvlJ0HW07C++HJp
        6ihMgw5X8VwpBEu8uWbrz5JXf6xX3ZENWQZXh+fTshrLedsGzStgwCXFya/GiO0w
        Cjcunb7cz5X9Qpjf2pQoH3ZLjzIH3VFz7z1jbz1roJjErX48qq3qqeCfTyVs15Wu
        bMJq8bTP7KlzYUzutz+YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1683085664; x=
        1683172064; bh=qJF/y3PUtn5/2JZtl7kI9dJefyoiVSOcY3IKgthNpIc=; b=F
        q4CSQVoiVKJBh109TYziJStlzxq1sjjUmGriCCBd38wb9kuFlkd3E08E4XGFhfZ9
        NYbVWIIpEmBmEupXYwGoF4Q7hjROkHISgaGAF38xDJTv+lIVVusS4qvj2SBY16vH
        m4ncYsmRxv88s/Eyv3CtKaiMAlWoc9t2cIqybsZDmNgF11IJ60a/3nA4XGx9wvNA
        xsi+1H0eEN0SR0cNSSsstVdOVWwbTIhYEh1IJaqg6XaJUSimuoeVDAZQJw/ulWaY
        SedOObQrBG48FFcktNmyIj8GGzBCvgSLAM6P+QrKm8RDUs6RPZV/LufLMJCDZ9Vn
        P3/rM+MNEKyAdVOXcHPgg==
X-ME-Sender: <xms:YNlRZBEFbFuN_2YGOoSjn0odGphkeebWYlk1-3ZgTgL4v-CpfGE0mA>
    <xme:YNlRZGWKLav97EaSgh7cUr_84y7l7ldC2mLIn_iozexPGp2Mk6aV0caIHMDzdxX8I
    7vpzLLToRs_RBosY4U>
X-ME-Received: <xmr:YNlRZDIDN-8Z4Z7Q6oVrNjraN_0pprjhM5hpBdVcpZaRpJFElgRMUZbSQv27>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvjedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:YNlRZHG0RtoAcJjiVoXXTYLT20r_w2IsLriJmA0_yIL0Vx21ZEi8Rg>
    <xmx:YNlRZHUeqAjaZf0E9tf5HBY2snKSPsSPzvFWxwceNfK_VOqtyGZGnw>
    <xmx:YNlRZCOytMVG7m_0pt38xUxRmkihz2dqus9i8iimYp9zGDLbyoAytA>
    <xmx:YNlRZCQZphj9di9Rep5XOKq2CFkwNLPNnlIhM-hf1fT-ncug7cbZPQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 23:47:41 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-input@vger.kernel.org
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        rydberg@bitmath.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 3/3] HID: asus: reformat the hotkey mapping block
Date:   Wed,  3 May 2023 15:47:11 +1200
Message-Id: <20230503034711.253439-3-luke@ljones.dev>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503034711.253439-1-luke@ljones.dev>
References: <20230503034711.253439-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older formatting of this block was beginning to get somewhat cluttered.
Condensing the block and putting comments to the side makes it easier
to read and scan the scancodes plus keycodes.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 44 ++++++++++++------------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 918d0d05ca88..2bc14e076739 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -885,38 +885,18 @@ static int asus_input_mapping(struct hid_device *hdev,
 		case 0xc5: asus_map_key_clear(KEY_KBDILLUMDOWN);		break;
 		case 0xc7: asus_map_key_clear(KEY_KBDILLUMTOGGLE);	break;
 
-		/* ASUS touchpad toggle */
-		case 0x6b: asus_map_key_clear(KEY_F21);			break;
+		case 0x6b: asus_map_key_clear(KEY_F21);		break; /* ASUS touchpad toggle */
+		case 0x38: asus_map_key_clear(KEY_PROG1);	break; /* ROG key */
+		case 0xba: asus_map_key_clear(KEY_PROG2);	break; /* Fn+C ASUS Splendid */
+		case 0x5c: asus_map_key_clear(KEY_PROG3);	break; /* Fn+Space Power4Gear */
+		case 0x99: asus_map_key_clear(KEY_PROG4);	break; /* Fn+F5 "fan" symbol */
+		case 0xae: asus_map_key_clear(KEY_PROG4);	break; /* Fn+F5 "fan" symbol */
+		case 0x92: asus_map_key_clear(KEY_CALC);	break; /* Fn+Ret "Calc" symbol */
+		case 0xb2: asus_map_key_clear(KEY_PROG2);	break; /* Fn+Left previous aura */
+		case 0xb3: asus_map_key_clear(KEY_PROG3);	break; /* Fn+Left next aura */
+		case 0x6a: asus_map_key_clear(KEY_F13);		break; /* Screenpad toggle */
+		case 0x4b: asus_map_key_clear(KEY_F14);		break; /* Arrows/Pg-Up/Dn toggle */
 
-		/* ROG key */
-		case 0x38: asus_map_key_clear(KEY_PROG1);		break;
-
-		/* Fn+C ASUS Splendid */
-		case 0xba: asus_map_key_clear(KEY_PROG2);		break;
-
-		/* Fn+Space Power4Gear Hybrid */
-		case 0x5c: asus_map_key_clear(KEY_PROG3);		break;
-
-		/* Fn+F5 "fan" symbol on FX503VD */
-		case 0x99: asus_map_key_clear(KEY_PROG4);		break;
-
-		/* Fn+F5 "fan" symbol on N-Key keyboard */
-		case 0xae: asus_map_key_clear(KEY_PROG4);		break;
-
-		/* Fn+Ret "Calc" symbol on N-Key keyboard */
-		case 0x92: asus_map_key_clear(KEY_CALC);		break;
-
-		/* Fn+Left Aura mode previous on N-Key keyboard */
-		case 0xb2: asus_map_key_clear(KEY_PROG2);		break;
-
-		/* Fn+Right Aura mode next on N-Key keyboard */
-		case 0xb3: asus_map_key_clear(KEY_PROG3);		break;
-
-		/* Screenpad toggle on N-Key keyboard */
-		case 0x6a: asus_map_key_clear(KEY_F13);		break;
-
-		/* Arrows/Page-up/Down toggle on N-Key keyboard */
-		case 0x4b: asus_map_key_clear(KEY_F14);		break;
 
 		default:
 			/* ASUS lazily declares 256 usages, ignore the rest,
@@ -1319,4 +1299,4 @@ static struct hid_driver asus_driver = {
 };
 module_hid_driver(asus_driver);
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL");
\ No newline at end of file
-- 
2.40.0

