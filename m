Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C66734B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjFSGDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFSGDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:03:32 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20010A9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:03:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8C98732001E9;
        Mon, 19 Jun 2023 02:03:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 19 Jun 2023 02:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1687154608; x=1687241008; bh=bc7ZXX6MFX
        B90to3uQmcdd1P2M2ygAGGajXNV59dtrk=; b=Qho1HUx7sRkZSmM/C+HOLx0z8q
        Cxf3WT7BnoOyVNW3DSkZZ1WkH8EMPmKLTmW+EJLInP9ovlBWSr0BCDECTvVMAEdY
        ooCVg9JjrIAP7yezUBJSdvUzIvk8y+2ZN/j321Uiu8l/XCvAA1wo8gelZt4e59XU
        9F8lDxmKVNxxVxb/NI2iNKGynpbCfDu9CD6eedLE4lW1syz+k5OB0w2LBH6GB8Cm
        IFd9CmEiA9VQHW4NviEt5r34rUgXiNwNcmvMmYo8Bqln7FSvICs7W2U+cIzHdqwb
        aOwgl1cQQuNxVyPlZBcXvNjj1b7iVbPpq1V+lDYLGMfAYTPw1Z6QYOChUyww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687154608; x=1687241008; bh=bc7ZXX6MFXB90
        to3uQmcdd1P2M2ygAGGajXNV59dtrk=; b=ax0TtflL8XtQ9jmptPE0upqDmzA5X
        Uy50VGrtQVmXJOBqvZo8Vztn9qpRoX0a387nBPSrL0HV5tf4siyr7ggqUF6D8BoN
        UpbU9Xn+jRWo10nrjaJMzIYKm1Q6Kqtd4PHjaF3xo8dEmHGQP1Pcy5ESyqZ+UF04
        GgBBXil///IEi3wC1lN/SeuKTQM+KkubWtIMo+QWf5iL3vUxdt24ickJQLcdc78I
        T3LkU4usFLGNXSwTct4yn/Ta5hdjOJthnrgSyXXZEDanCotMsBDJAE87wEgVA4dZ
        CMm6nyz0v/T5wcqcoZxoPdbPrTw3ssQxIvXYcg7v0XHuftD2DmDUAKgOw==
X-ME-Sender: <xms:r--PZMLoN5wQleIR02QX-bO4xZCEQglQq8Bm9zSxsePDVr1ypblwiQ>
    <xme:r--PZMKCutU7i_kjeWTmC1EytHii2bL5M65J5z0JGmW-eOohIMLKQSyqIpCazgQrA
    x61xGLp_y4z3eGVChE>
X-ME-Received: <xmr:r--PZMtQHFDlPH42q54ouO4xKYMR4LprwAk4ddrAQxS0HDAge2_bsyaKxppN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefuddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftd
    dtvdfhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:r--PZJY0rFbrwTCqilmpQfONqI7MTDVa_m2FSopLMQgG8mbkJbWDNQ>
    <xmx:r--PZDbsHGnTaZOvEvdN9a9AnRlMGe7_5nT744tI0DPAelYMjYybxg>
    <xmx:r--PZFCzN9Q5qGCD_pwzcmPnwE01eNrYkVLdfOh1-CBmA_pn80_Zuw>
    <xmx:sO-PZPEyxXPklBLy0mXKg4CLHrW5alvS0XU134LxOYxext-6F00Tmw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 02:03:25 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, sbinding@opensource.cirrus.com,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for ASUS ROG G634Z
Date:   Mon, 19 Jun 2023 18:03:20 +1200
Message-Id: <20230619060320.1336455-1-luke@ljones.dev>
X-Mailer: git-send-email 2.40.1
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
on the ASUS ROG G634Z series.

While this works if the related _DSD properties are made available, these
aren't included in the ACPI of these laptops (yet).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a5d55a7063d3..437cf13d10d2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9552,6 +9552,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
+	SND_PCI_QUIRK(0x1043, 0x1caf, "ASUS G634JYR/JZR", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
-- 
2.40.1

