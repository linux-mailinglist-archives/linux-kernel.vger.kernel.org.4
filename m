Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB57749811
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjGFJPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGFJPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:15:02 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4761737
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 02:15:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 792AC3200A02;
        Thu,  6 Jul 2023 05:14:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 06 Jul 2023 05:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1688634897; x=1688721297; bh=5b+VgbxkjC
        LLidJDTxAr4SD67dWnJF5+KKTepwtOn0Y=; b=SUxk87cPv5Ex3rlCBedfYgROmB
        YBpftP3bvAJqDMsEGe0Ou54mxYEqySIAQCL2TkKUw4AonudLwOym2/aUpyi9Q3pO
        e5xfcGIY/hykViCCxAGjQYXnifkRTiCcvzH5FWtpLYMvkRwvaP1J8Jyu4QYfF6W5
        +6gia2HpP9b3wIE1/sxtq1qDjiwwekzuiPa2lZlC1ofvySc2z05VLy8JmPNcrTAf
        x1t9T908FkySvuOx5k12UfaKlOmDIIP3QEaaW0rl//lIll2/gl4K07M3ZBjd+gQE
        QT2iRzto2vPHB/MEJWiuuBEQv5D92BtDEgC1QlOKdvZKZODKIx89Spk4KwNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688634897; x=1688721297; bh=5b+VgbxkjCLLi
        dJDTxAr4SD67dWnJF5+KKTepwtOn0Y=; b=XT9kdThXfpD9KLMZMV5kOwhTp0lzu
        m6tIBiJAoZmWNehED4istWBC9FGS19k6TELU55z8BlnsUMKceJ1944HziOyGUEUI
        J71FbtHDMhAx5ErJ1D3DB/Mml9K0T74vs6eT5HnsjFV8ohN631VvWWnUTOZfenpQ
        th0OuA8nVIDBY93itlUceFO2obJdCDEl17ivJ+aZwLBY8pkbaG0DMlMYkTaRxY5T
        ODn2/OUDrPL9Lq0HAXZzHDB81AV8RBOoHBOcLy4Li/84NILdvDmJR21xZUbWBz5O
        x60/MAnSpAgHQZ9GE66T4R8dDBCUqhV0gZKFAn3+ZRvkIkES7HUO0ScOg==
X-ME-Sender: <xms:D4amZOL2StD8MaCJV7AS5hIBdz0kgoX-GuP1Hg_Vtg8Ip2O1B8p9Zw>
    <xme:D4amZGJGCOaRCgoZs7f-SaNLZqQizjgGw-W56m_quUWySXFFrRxkjDh0HDsR4VT0p
    8PRh2Osu2lo7_3U2gs>
X-ME-Received: <xmr:D4amZOtbejagdZlrEPUXql0ywCvCjt1c34EmYN_b_esbYvJudJw8Mho58naNzi6NSpNxuOCdbQxXGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:D4amZDaxNeyK9pnLOYsncwjzvmqVMNzvGUQejegDlr8Is5E5o2PUHQ>
    <xmx:D4amZFa8Hj7f_FXuBb154S09aCE5LVsZMAJqJuePKAa7kA8f9R8zfA>
    <xmx:D4amZPAQesQNnZxL-rt-bJv3r97BmpXZ7ngdCrOiB6hf5usysNXJGw>
    <xmx:EYamZB4teA-_8MVIdkwyrcKzPuX0qc8G6hzg1N6UwuKG7NP2BuGy-w>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jul 2023 05:14:52 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     perex@perex.cz, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, tangmeng@uniontech.com, p.jungkamp@gmx.net,
        kasper93@gmail.com, yangyuchi66@gmail.com,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for ASUS ROG GZ301V
Date:   Thu,  6 Jul 2023 21:14:47 +1200
Message-ID: <20230706091447.17025-1-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the required quirk to enable the Cirrus amp and correct pins
on the ASUS ROG GZ301V series which uses an SPI connected Cirrus amp.

While this works if the related _DSD properties are made available, these
aren't included in the ACPI of these laptops (yet).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 Makefile                      | 2 +-
 sound/pci/hda/patch_realtek.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 12579666581f..e2cae6cc7574 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 6
 PATCHLEVEL = 4
 SUBLEVEL = 0
-EXTRAVERSION =
+EXTRAVERSION = .rog
 NAME = Hurr durr I'ma ninja sloth
 
 # *DOCUMENTATION*
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1547c40dc7e9..969eb0736bca 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9607,6 +9607,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1483, "ASUS GU603V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1493, "ASUS GV601V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
+	SND_PCI_QUIRK(0x1043, 0x1573, "ASUS GZ301V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
-- 
2.41.0

