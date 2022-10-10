Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A986C5F98BA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiJJG5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJJG5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:57:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6B83C8C1
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:57:13 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A46545C0046;
        Mon, 10 Oct 2022 02:57:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 10 Oct 2022 02:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1665385032; x=1665471432; bh=M0xz8gCJgFMguwuRajN2lHrq/
        yFlTQty3u4N0i9n68k=; b=cykmAfvcPf4z2BqZWNe8nzG0sRG9yNdZG8v62FH1r
        x2pyXKJ/YUOApcDHqJXyk0HFKNumH3mzKPorQhuUXqZWKV4j1w2LmYUt/BfW2v+n
        c4wmFJB9EiM/dLMkIGo3csJZjESImyVWoSZv2Nb4YAc/7EYgzgyqtVFilxTs70O0
        LqlsRbQLMQp2t2UIHBcKP1nva1s63PIFmwFw1Fxd+sw1mGDq7NFw26aBiLELY+NM
        ociyR9oa3fB8Udh+OV2avwJBufPx3iHO/O8x/DB8nplYusQdpj5ViAM0X8IazscP
        +bUxXEIxmlTE02AOq4pTm+5hch6Tbg9ZJ+BynIex8AYtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1665385032; x=1665471432; bh=M0xz8gCJgFMguwuRajN2lHrq/yFlTQty3u4
        N0i9n68k=; b=k4XCxcZ/mXsLg6iwnhXNGUej0MLb/wxvbVdTtdCQ/dF3b1zfxkW
        YqGYYxWNCKHQwg2Rj6TZQ2khcTZ+/z9NUmwcjD/5/Dq5rvZj10M+m72dxfMYhq7O
        sOCXh11j9qw5R8IMh1JWBkzQeaGu3/0f+E+qqpNX5WZUx3OdStDpYZx6vEJ3hqYW
        9YAVmo1edpdL+zsqSvEXEuDee2RTUtZ4QCARk1MIBBNAbfM7hXdX8ZJu24QtDsks
        v9dxYqfh7JzgCJ6Xet6Y39/C3zSULsToQNGZVbAEd0eHL4mYJoVdIkA+/mtGZJOm
        wekj3a+IHd3D8tpLfytVignaoJEOz41MyHg==
X-ME-Sender: <xms:SMJDY4Glo4zAvQRGYvCCa1O3JRgnz2IxTATd6XH73Z7OJLPvgW1sbQ>
    <xme:SMJDYxV6QaFnm64Okndx4r0ewb1GL3Yl37mOkc49SJNXt1rrKnxe584YS6jzszV0u
    sLOgSry8Idhz28gQnI>
X-ME-Received: <xmr:SMJDYyIxTDUkxMrjkmmL0sXj48beZfaikuz-u8ShR2cnPPlOkvZErEZhjNgi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejvddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftd
    dtvdfhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:SMJDY6Hj0DGMwPzKHi8qSxzvAMagE5x9mxAc7Oxen-KAzpyooAYNlw>
    <xmx:SMJDY-VVI5WOQDnbvpK1HSRwiVK6ek5b4z691qvQP9lqFtfWz6sDYw>
    <xmx:SMJDY9PsOYXxQo6VhgwWTPnTnXtZKgjr2MH4FCKk62Pwr5W2HOrjKA>
    <xmx:SMJDY7hay42e9qTIBZ5A3HSmB1XIjwM0zoHlRxPFhLdpXWmJ67EJoQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Oct 2022 02:57:08 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] Fixes bc2c23549ccd ("ALSA: hda/realtek: Add pincfg for ASUS G533Z HP jack")
Date:   Mon, 10 Oct 2022 19:57:02 +1300
Message-Id: <20221010065702.35190-1-luke@ljones.dev>
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

The initial fix for ASUS G533Z was based on faulty information. This
fixes the pincfg to values that have been verified with no existing
module options or other hacks enabled.

Enables headphone jack, and 5.1 surround.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bce82b834cec..24406f81da27 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8449,11 +8449,13 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC285_FIXUP_ASUS_G533Z_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x14, 0x90170120 },
-			{ }
+				{ 0x14, 0x90170152 }, /* Speaker Surround Playback Switch */
+				{ 0x19, 0x03a19020 }, /* Mic Boost Volume */
+				{ 0x1a, 0x03a11c30 }, /* Mic Boost Volume */
+				{ 0x1e, 0x90170151 }, /* Rear jack, IN OUT EAPD Detect */
+				{ 0x21, 0x03211420 },
+				{ }
 		},
-		.chained = true,
-		.chain_id = ALC294_FIXUP_ASUS_G513_PINS,
 	},
 	[ALC294_FIXUP_ASUS_COEF_1B] = {
 		.type = HDA_FIXUP_VERBS,
-- 
2.37.3

