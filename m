Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65098743397
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 06:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjF3Ebc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 00:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjF3Eb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 00:31:27 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B4D1FF9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 21:31:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 11FA73200919;
        Fri, 30 Jun 2023 00:31:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 30 Jun 2023 00:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688099484; x=
        1688185884; bh=57Ar0Z5PkxbqAqRL5TUEKObulBq/y5OcnzsbzdU1dqs=; b=k
        EVaCU9L8TcBJEXEjy4j6/kDMx3ovkQfVH1L3UxSlsCsB6DRIW2qwowroKZXtGI8t
        ATxwJ7hhOfl319ZMSwNlFkA6lZsCgOVyAecUcLGK8LJZpXXl2gwX3NLxpJBUDRhB
        3y8qWqeEaH2x6vYL5Kh4zSMZ8gcHWjGpOORqJVfgGeoKjhoICfdXJAXM0BaeiwsZ
        UfZkL/UU5Vsp6hBwRvcyuqv4EcpqneUI0WajS+8zXsCPKo/F0VMOwXxP7rjc7Vcp
        2G/SrRZhI5cZqDvZLXwI5bVV2bBXt/IgNk26Yo1v68gbax+dDTgm14wfvt9NnsKT
        iQfDUo1R8e0yHvGQhgYTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688099484; x=
        1688185884; bh=57Ar0Z5PkxbqAqRL5TUEKObulBq/y5OcnzsbzdU1dqs=; b=C
        QC9bYWOtt44Iugn9iaKLWfi21LPBNG/sNzLTo7zrHt8XHLDtqtvax52atVVH1mVS
        eug1IjAxjh0SVYThOl0gx2EfWuXGyVUUpPwpILfLmzm03oDB5S2FhU3GFLiZNeeX
        QKvXhlBqW7XqGzVBazXqsEDfMDlrd372OQrQhFEHMLAZI0qNrzu9H0huhguOBWbQ
        sVwEkBO7HfNwGmbnHYfvs0nK3I/Ga4oIADC6FBnajxqaRWIOETIu/qMBRVqdWVio
        yf01Lqh0eaJZGiJbU9LV31NrXTx9IRIRyRIr2usqIOekW+wruWezQjOlomuGPeyb
        7e4b598VcbTsZSwk1m72w==
X-ME-Sender: <xms:m1qeZOXuqwNSzKHfWIXHwWWhOg9wYQMjOS2qMwJZYs-_9SA652AJVw>
    <xme:m1qeZKmR6CGvZOy_kmX_Or6v4nxPIcqRf0SEaWhSBU0y7oiyLIFZRZ4hX2hqRlQGt
    3WPxufPE0GG0GejZdI>
X-ME-Received: <xmr:m1qeZCYzEDC2ZkkgbX61-mtNUSkswAPa9wnMn-gSNnwZfcMUFTpf9TgKEfrZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:m1qeZFVXxWQNw3WUn7ruHd_K98JG3RLw9t0fnlNetgfBcGSlhXnL5g>
    <xmx:m1qeZIlRHKnO-lsLTOr4X5khCBPwpUza8W3O2jKRRoSE5pKAFNSbTA>
    <xmx:m1qeZKdpgus0NTfQi-hBSNex79jdG3jRkFTHhhS7X-ngNJ-q9hWAYg>
    <xmx:nFqeZHs46kx8GTvnjXA1YrdhXFhKqHQlXVuAN9m5-nyfojOS6EBnmA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 00:31:21 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     perex@perex.cz, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, tangmeng@uniontech.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/2] ALSA: hda/realtek: Add quirk for ASUS ROG GX650P
Date:   Fri, 30 Jun 2023 16:31:05 +1200
Message-ID: <20230630043106.914724-2-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630043106.914724-1-luke@ljones.dev>
References: <20230630043106.914724-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the required quirk to enable the Cirrus amp and correct pins
on the ASUS ROG GV601V series.

While this works if the related _DSD properties are made available, these
aren't included in the ACPI of these laptops (yet).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dabfdecece26..1c26f24b1246 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5883,7 +5883,7 @@ static void alc_fixup_headset_mode_alc255_no_hp_mic(struct hda_codec *codec,
 		struct alc_spec *spec = codec->spec;
 		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
 		alc255_set_default_jack_type(codec);
-	} 
+	}
 	else
 		alc_fixup_headset_mode(codec, fix, action);
 }
@@ -7065,6 +7065,8 @@ enum {
 	ALC285_FIXUP_SPEAKER2_TO_DAC1,
 	ALC285_FIXUP_ASUS_SPEAKER2_TO_DAC1,
 	ALC285_FIXUP_ASUS_HEADSET_MIC,
+	ALC285_FIXUP_ASUS_I2C_SPEAKER2_TO_DAC1,
+	ALC285_FIXUP_ASUS_I2C_HEADSET_MIC,
 	ALC280_FIXUP_HP_HEADSET_MIC,
 	ALC221_FIXUP_HP_FRONT_MIC,
 	ALC292_FIXUP_TPT460,
@@ -8051,6 +8053,22 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_ASUS_SPEAKER2_TO_DAC1
 	},
+	[ALC285_FIXUP_ASUS_I2C_SPEAKER2_TO_DAC1] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_speaker2_to_dac1,
+		.chained = true,
+		.chain_id = ALC287_FIXUP_CS35L41_I2C_2
+	},
+	[ALC285_FIXUP_ASUS_I2C_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a11050 },
+			{ 0x1b, 0x03a11c30 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC285_FIXUP_ASUS_I2C_SPEAKER2_TO_DAC1
+	},
 	[ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -9525,6 +9543,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
+	SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650P", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1473, "ASUS GU604V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1483, "ASUS GU603V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1493, "ASUS GV601V", ALC285_FIXUP_ASUS_HEADSET_MIC),
-- 
2.41.0

