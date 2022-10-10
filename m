Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C073A5F98F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiJJHEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiJJHE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:04:26 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5C056BAD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:04:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1B32E5C00D7;
        Mon, 10 Oct 2022 03:04:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 10 Oct 2022 03:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1665385448; x=1665471848; bh=jr/yrDrSj6WhzrDOCLLva7Gql
        0cAfGglhZZtqKViZwk=; b=ipZmpqFbboo8JPmqzwOv679nDMC68l9ItOktHU7o7
        9NdGluL2TtJ2OvCzXUvNtIXldSMfe9lXPi7oDLiA03SNIGNFH7UkfM/zgC4y88dP
        ybuFD6jjYJW7nOsTKzHvq/G4fvuQmx5Dc1ugbDr08+I4PBSaDPxSdRG4Z6HvyCuV
        trZxdIrw4ZeW+HdUBix5Ka7e3WjpP19GdzBPfXWPZfbUn1Spht84Tr8tOLVrtHS1
        fwmzdjOJuqVECT5w42bG46CUtrzsLegOvHfcKAfd+PqymOD6LBihiPnERCL0s/ah
        rg50tz7obKXLbqZVTGvIwoyhbs5nOU4dnxWMgzCSOz/Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1665385448; x=1665471848; bh=jr/yrDrSj6WhzrDOCLLva7Gql0cAfGglhZZ
        tqKViZwk=; b=HynA1yT7x4gi6h/VTUnjaiCCgG3bkNm5Q6PBEjkFy7Fkk2cYVPP
        ObOtkPZV0WpIj+HmC6i4G/sGruW1IckEOXWLnLGWGlg3vmODy9P93r4QmUTvSvWQ
        e+8ixQQv6bxGfyikxbK4Lb2IMSYpUbXIXVxVCWlFFi9OQjTaDZ2a7FJFvMVSvkeA
        odLMn+mxEyxBEr16SYhhzj+AJVwBY3aKbHqkw83kMtBEdcOOkEdp4RA1xu3uFYSV
        Rtjm66502vHSUIa5cEFmSTF2ji6UyfeVO/Y9837Wn0GCEoAwo70Ie+R0Zqe3wB7/
        WKYa0vFL2QLlcvExeZty9hwNEmGO6OvOTIg==
X-ME-Sender: <xms:58NDY7NMJPpvFvoEcYFS5byrEHtqk13yy5ss91SgUCu9g64VaefSyg>
    <xme:58NDY1-WV1Vb2psYgsWTXJFnezT93HwhkPLJjgq529ITJOISitmkHBtu4ZkaM45EJ
    mWSEfHINaH5plqnAxA>
X-ME-Received: <xmr:58NDY6S4WAAM3MAb-iJ7duk4B_OdKzvdjMVtut8u6mm1qVE5-lOBmfAV3XCp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejfedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:58NDY_thvY9PVEYr3jAJMmrlKdafWqwpmsrzmWsptCt5iaMWTTIcEA>
    <xmx:58NDYzf-UZOpuiwzKyzlFP1eKKBGHX0VbmLgyp9Ku4GYNkedDhxkWw>
    <xmx:58NDY71D6fGEKsE7TpRIiTWKuWoti5NSESkuj1hRpW8Xx56CXAk4ow>
    <xmx:6MNDY0r7M47rU4YPNwDjAMdtlhmUqfctyu1fUSN97c_nMoyN6Ac5uQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Oct 2022 03:04:04 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH]  ALSA: hda/realtek: Add quirk for ASUS GV601R laptop
Date:   Mon, 10 Oct 2022 20:03:47 +1300
Message-Id: <20221010070347.36883-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS ROG X16 (GV601R) series laptop has the same node-to-DAC pairs
as early models and the G14, this includes bass speakers which are by
default mapped incorrectly to the 0x06 node.

Add a quirk to use the same DAC pairs as the G14.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bce82b834cec..1ffea762ba57 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9422,6 +9422,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1c52, "ASUS Zephyrus G15 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x1f92, "ASUS ROG Flow X16", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS S101", ALC269_FIXUP_STEREO_DMIC),
-- 
2.37.3

