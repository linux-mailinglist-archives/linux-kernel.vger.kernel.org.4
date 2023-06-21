Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE62737E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjFUI7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjFUI6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:58:41 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86921FD5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:57:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9500E5C0152;
        Wed, 21 Jun 2023 04:57:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 21 Jun 2023 04:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1687337849; x=1687424249; bh=sqjidIDUcm
        CoYCCZKcZoG0QaTsvHKMai8wcILNcUgKk=; b=ebduSWYlrRTYiKI7ti+dk52cC3
        0km1PhIJrVqn+bE3n8dAwbQaLyStHVgiv+KXZTEn7lsp9AOLRgJDZuxO3G1AzHAo
        S0ypSa6VvAkQcA/JRu6c/55uVy4F1I0KCkOv/CjW4EXqpGwoHXVuMXk6RpkDkoV/
        b0X1Ky6ofOQxf7owBJej+7aywJM2CFEDc8yGca6UIHxusSotgOi7xavnhy9p8Xk9
        23cKRs+syG4MhH4lVCmeS3lEa/l7eMmjjWXJObgOQ3Iq1suLldapnr8i8jGmo1oN
        55HacTgtjhWoYEgkAM5LmIFGl0lesxuKfcIwBK0Esf3JvyOdazVnG9ySnbOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687337849; x=1687424249; bh=sqjidIDUcmCoY
        CCZKcZoG0QaTsvHKMai8wcILNcUgKk=; b=QNplretzkQ9u00GR1x0I81W7kSkJ/
        ZSctVpCPkByfkDFbem6re4diMdN/c3IhkbRtm1UddnEUayLtqtWbuEFRg1Wtt6/F
        ZCII/eR6S6QfJppooGMS0EX/0G6yobiXYldqANiOpPs/5qnnbTowHdohuZA3MNHp
        Sxsjqx47YEbclQYEth+a5fw+rE2F9v5B4t6/9+sU1ogGk3bbHCj69DkVMs1gx1+2
        hRa6QjNiZVqxVsEvrS1SX+9JXLM8klkH/InxzK96iNh8bFEAGuInjY+Qk5G9cChI
        zhFQOkcyyJhTEZg4ODJilUF/5pxljrX2qf0GEmlrJyggf4OTZk8XQ9sIg==
X-ME-Sender: <xms:eLuSZERaY5JzbB7Y-icX_53pUjZDhOsEeYjOKuoJKubB83qshBnL8w>
    <xme:eLuSZByjDA6z4Z9fmH5ExMHSrFbItPag4ssN318b_fEYb7MZVptBlWYSEXA9oFSzU
    uy4j3EEya5uJkLmlWU>
X-ME-Received: <xmr:eLuSZB3zHPOBmPye00ADpP584kZtU8kR6_SRXbiuh7tVtL43MX-NWYHLCNwx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefjedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:eLuSZID9Xg_oxvMabKEC9isi5j_mG-RhygwU0nPPeX7oMoN8Y81b8A>
    <xmx:eLuSZNizdtEkSkb9fny7-A8v9wso9bxn28E1cK8qquy8Csh07c9AoA>
    <xmx:eLuSZEo_JXEkpMeE2YXPtbMvjXTNnTkimkMWI_gyK6pAOeUQciZw6g>
    <xmx:ebuSZIXYKwQXvAcc2xxL83L-2qfIynJbf_wKtOeTqnTQdd4DKmvvIQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jun 2023 04:57:25 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     perex@perex.cz, sbinding@opensource.cirrus.com,
        tangmeng@uniontech.com, andy.chi@canonical.com, p.jungkamp@gmx.net,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for ASUS ROG GV601V
Date:   Wed, 21 Jun 2023 20:57:15 +1200
Message-ID: <20230621085715.5382-1-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
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
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 17d5bdd4be6f..dabfdecece26 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9527,6 +9527,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1473, "ASUS GU604V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1483, "ASUS GU603V", ALC285_FIXUP_ASUS_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1493, "ASUS GV601V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.41.0

