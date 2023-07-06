Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F156E74A71B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGFWdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjGFWdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:33:43 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E06C1703
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:33:38 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9179A5C0195;
        Thu,  6 Jul 2023 18:33:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 06 Jul 2023 18:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1688682817; x=
        1688769217; bh=VvWl5kOkPscDVS2RZXZt/XY/s2/14BZ4TOS3JMYoi6w=; b=h
        vgV70Lm4m577dbnW4XHi0O8v/H02Ma6tdc+71l7IF+tmeOWpOYm6aMsmHkl8aQn9
        J83A/2megLp7EM0rWEfnK2eM+xmYV9FaDYijxsRnw8Zrsi9uXcHHzOJ2VipbUviu
        nKXaI3OXJGP07u+Drcl29jUSslsm4+4ipc5sWc0pmVDuzcOXqu4/8Whe5HNMi8eA
        R5NnLIit1T/TBNTfPHC23Qt4NZWMh9Ypu11luM3eOfaB2LoscUN/iWCLvdKQhlqE
        MpWCE6OsmTN2O5k2LHD5Vg0B9PHhwxlfcRC/zyGMvgRZj2Qgjk9X7krL38IcGgnm
        bYyXGY63IHDbnX0PpLqQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688682817; x=
        1688769217; bh=VvWl5kOkPscDVS2RZXZt/XY/s2/14BZ4TOS3JMYoi6w=; b=b
        8+jFkdMFb843nAvsMKxP/9nBWQjNdm7VSCc/ebmfsYN6oiFtIuq4FVWbvsLF4yWI
        FBAH6A9D9teQpftQdfe8h8pyXNfH4RuXi6DQ4BU0IOUKk/9uJGzvUuXkD8ddmwxJ
        XDv3wp2vLhecb9xEAhhimb9/i7OtgtgeFd4zCwECaje3LlxnRLuQBYriJ3O4vvUm
        pwkpK7a29MJFtOMa49LlSTJgOycpMW/qOkoYDljJm6a3LDH8bMmOF/Rg86YerQPw
        C3XIaPtJpXV03cQiQvXh8IjQvsXaUc+Zg1At0kTR5otaUzSVvSSc2gniJu2O4qfC
        0p6iCWSl2yfPCSy2a9FoA==
X-ME-Sender: <xms:QUGnZJAsbeCcK-rZF3j7xUrfOdu0ugpJA_1mLmU2YR--LoK2XiEeSA>
    <xme:QUGnZHh1O-ESdis_3UsHegd3wWtu0vheurkpSd6_wS0-Jj0l4JXZvm-ugDIiuhcSf
    2Evveu2AZIqwE-0sNE>
X-ME-Received: <xmr:QUGnZEks26Nvk9bdn4HNzsIQ0GDT9mC0hN_In6Pmc6lEMEPnjZT3FVvAedKer1Ng1Xs0whL9M--FyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddtgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:QUGnZDzdShRcTxPTs9b6KZudOv3sbqmUe968hbXFcQBAxG950WpFuw>
    <xmx:QUGnZOTeNx7QMCe_bDH9x6WDPkrNA301XszMsmYYH_m066km_plswQ>
    <xmx:QUGnZGZbIcNjpKfQoSITzXl6ah97jCsngxybO1lf3HwShy0x5cpl8w>
    <xmx:QUGnZLRNzdPNEiPfM1go8WuEzw657sXKUz3Fc_ZWFTPuqeft19jPfA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jul 2023 18:33:34 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     perex@perex.cz, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, tangmeng@uniontech.com, p.jungkamp@gmx.net,
        kasper93@gmail.com, yangyuchi66@gmail.com,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 1/1] ALSA: hda/realtek: Add quirk for ASUS ROG GZ301V
Date:   Fri,  7 Jul 2023 10:33:23 +1200
Message-ID: <20230706223323.30871-2-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706223323.30871-1-luke@ljones.dev>
References: <20230706223323.30871-1-luke@ljones.dev>
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

Adds the required quirk to enable the Cirrus amp and correct pins
on the ASUS ROG GZ301V series which uses an SPI connected Cirrus amp.

While this works if the related _DSD properties are made available, these
aren't included in the ACPI of these laptops (yet).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

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

