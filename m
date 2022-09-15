Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C035B95F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiIOIJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiIOIJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:09:45 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBF5167C1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:09:44 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 797353200B50;
        Thu, 15 Sep 2022 04:09:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 15 Sep 2022 04:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1663229382; x=1663315782; bh=vF
        9yk8jSGcOUiyf4eGbShAgD4UX6iWj8uUKlajrxg1Q=; b=BHZ2E2ufgGuQ/CnZV5
        jqNOHRY2EvO0VVnzxP0hSUnk2YaLG61j6Zvc3M2Xd7+CUX191HdJZt3aybSxBgB1
        JyjE557sJ4VT0cunOEzxJ1IwgOCPXlvc+UshyEMZKMw1V6Lx52Wot9Vnc0Z+NpC7
        uZqjeW1/oMBWvAyXJ8F/8MWnwzxEqeQNkU/yCTtdwRiX9LQiJPPX+EBakG2/DwRS
        3POKy3XZCdEFXbPilS0IKOuf5t1S774YOoSBxAvBh0FS+kawUjsJxlifAZPPKEMB
        q+2XwmyjFNa3v5l0eCR4M0jF28FZqXrMrhUUGCJ/ESS/bEwRBvv/oywn24jq0yGu
        y3LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1663229382; x=1663315782; bh=vF9yk8jSGcOUi
        yf4eGbShAgD4UX6iWj8uUKlajrxg1Q=; b=lvCIz+A9RuT29UYvG5FUjGQ+5fr9W
        /qjyhZ5gS5871Ds3KJlU5IHeA6kVzSBL22qtVHmSPIer++DmAai3el4u4u30r6mj
        o1zGritPYjxfB4BkZrmpJlEFlQh0FOZjRUTaKUkQ9zk2VGFTihP64YxasIwo+yVW
        20UKqL4zuGy7Se1VeQIPfL/lXYFgbRNKuoAU6OLuXbkK7ypyJ3zUFWXcCgiBFntp
        oywNuAii2kbVYecfG6Gmxvn6kGDHRtbAwwOgQJgTr33UIqfjf1cc6iDqBSynM52W
        GFKt++VgNGm4wNAbXj0k6kaRv73yDvplcFCGZh+bCGnSgIAOTeOPYyNtg==
X-ME-Sender: <xms:xt0iY4x6pRhaBiWTgxB1YNtXIJGV5d7UbuE7FV8INpChS5-g9KWHfA>
    <xme:xt0iY8QRldOyQ6AJaasOkg9AAQiqVbYyTqg9iobjVa8aQvo0zWrc9XhLJDM4Mg9hg
    sSw8cs3oyJyT_JNPSE>
X-ME-Received: <xmr:xt0iY6UAf1S4QNzOZc6JlEuW9h-K58N-7iUGQ-KCq2LP6yoJCrcqc1GXMrRX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedukecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugffgle
    eltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:xt0iY2jwpgdTuqon4CY-z5KviESsg4WJi2w8XVSqivxsCBguTPgB1A>
    <xmx:xt0iY6CQNUqsHWhh9NcKGvbR-6SWHX63PQYl9GnQmYkzZ0EP-mPlBw>
    <xmx:xt0iY3LwJE0ol-0uryhvP32R40rmiNuq662PApbJ0ey-_v81cnYGug>
    <xmx:xt0iY9MRptkWzDS4tXM5dXSFXINHYTqy7iF_5MI8R1K9q_H-1D6lLw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Sep 2022 04:09:39 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        perex@perex.cz, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 2/3] sound: realtek: Add pincfg for ASUS G533Z HP jack
Date:   Thu, 15 Sep 2022 20:09:20 +1200
Message-Id: <20220915080921.35563-3-luke@ljones.dev>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220915080921.35563-1-luke@ljones.dev>
References: <20220915080921.35563-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes up the pincfg for ASUS ROG Strix G15 (G533Z) headphone combo jack

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1485dea712d8..a44a55619144 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7026,6 +7026,7 @@ enum {
 	ALC294_FIXUP_ASUS_GU502_PINS,
 	ALC294_FIXUP_ASUS_GU502_VERBS,
 	ALC294_FIXUP_ASUS_G513_PINS,
+	ALC285_FIXUP_ASUS_G533Z_PINS,
 	ALC285_FIXUP_HP_GPIO_LED,
 	ALC285_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_GPIO_LED,
@@ -8373,6 +8374,15 @@ static const struct hda_fixup alc269_fixups[] = {
 				{ }
 		},
 	},
+	[ALC285_FIXUP_ASUS_G533Z_PINS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x14, 0x90170120 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_G513_PINS,
+	},
 	[ALC294_FIXUP_ASUS_COEF_1B] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -9325,6 +9335,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", ALC294_FIXUP_ASUS_G513_PINS),
+	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
 	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
-- 
2.37.3

