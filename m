Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D8F6F4F47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 05:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjECDuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 23:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjECDus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 23:50:48 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20162E7
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 20:50:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 54DB33200B99;
        Tue,  2 May 2023 23:50:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 May 2023 23:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1683085845; x=1683172245; bh=twjvR+8FUi
        ccRKqC2PlVe9ds9MWJ3LKswPKdW5p38AA=; b=z3GG90cfz8byZ5GngRGyFI7qPe
        6eVXu/I5Rwq/9wTH/Jd6/KtFRDYnzeYkFhB60Hy5euWQd9eUugHcBSxmRIgGm3l/
        dZygZgk9T7A0QCfJ+Q/c0uyEotymgnS1e8s/Yz6zfMJmjWrmMXmkRLhUYgC919++
        iDniABXW4ehfCubeOnDDsq4spne6e4i+Vre/E/gz2Tt90HaLFUjs5EwLOmTYcw34
        +3VO2xX39A56HM6vDoU9k3urkA0AwSbEMr7pX0Dfvm4F5lbbEQkfnxQH7wrHPuK4
        W/Ce2ClkWF6JvdnotVnICJSuGp6Zrw/QrlsCIm6ZLbvRM2ksLOmBrSf8Ng+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683085845; x=1683172245; bh=twjvR+8FUiccR
        KqC2PlVe9ds9MWJ3LKswPKdW5p38AA=; b=bMUc/u2MrRh2i2PIv8Q/hC8Tbjlx3
        VATcB/uIHKdg3+cEOVtFsqvqah3jaZbcEId8wluYr0zZxLJZ3gSPns3SF5a6gYYF
        zg2WxRWowx8B68/UwCvcwtbZDURz7vsooUNmaWzQEbyAYzpAzhl+5w08qxfKhz1N
        ocJpmqYWXka8Dk5ePxN11PfQe6mya7TfRrNIA8PR6zIwAS6FC58cQ+nRFeu/uogg
        NDcIJb4Gdy2u8GLNoxEmBBsDgO9KVnc9vtoNaMM6jdbicw+Dvz+rdKoG1DWATDyi
        un8S5cwg9gj5Cs8e58/HIkwTN0tAbzeDPjSzw+TORKrwJowslik2DQ4Rg==
X-ME-Sender: <xms:FNpRZH5B8bIdem-i6d5yFYyS7QA4bY6Ex0H5jKQxF4vzPouXPUzMXQ>
    <xme:FNpRZM4yrt1dP94fagg-4ueHyISGF-zRgLQ-yNMtW-wPMnYaCzTb2Hc6inBvsUJeP
    V2_TLW7UZwiWvCvElg>
X-ME-Received: <xmr:FNpRZOcNGVbvckvzdSI5xKuaq7-LVnkzcQQzFtLup1BAwNAb624KUGrA-qfL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:FNpRZILh_5LXitJVcCWfeeb1cZdzh4MGZkmmQI6CcYK2HGSKghR6vQ>
    <xmx:FNpRZLKUqVdROu54vzw6_9_hCON9AMJiq94P2vzhoSRwHUAwFr-01g>
    <xmx:FNpRZBzYyp80pd_bhOncjFIHq_h0H6YVps347FA9QDR3JCa38jddvQ>
    <xmx:FdpRZCXGu2iOCCOoHjB_D82PtT8kgxOsuuNaAYLbNu9ty5UmEj4dpQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 23:50:41 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for 2nd ASUS GU603
Date:   Wed,  3 May 2023 15:50:35 +1200
Message-Id: <20230503035035.254346-1-luke@ljones.dev>
X-Mailer: git-send-email 2.40.0
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

Add quirk for GU603 with 0x1c62 variant of codec.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3b9f077a227f..4a585050edc3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9501,6 +9501,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1740, "ASUS UX430UA", ALC295_FIXUP_ASUS_DACS),
 	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPK),
-- 
2.40.0

