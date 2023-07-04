Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB007746872
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 06:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjGDErX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 00:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGDErH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 00:47:07 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071C510FA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 21:46:54 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BB80C5C017E;
        Tue,  4 Jul 2023 00:46:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 04 Jul 2023 00:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688446013; x=
        1688532413; bh=I7hwEV3srjyCYS9t+KWnEQ73pm3PsV/kMvHeobjOFJQ=; b=X
        lXegA7OjSwia35Cvwj9U6IIADHrmmE/GEUE0vKaLiZ0JqiestiZXqCnXi9Y3bmtX
        rfgoA6QhAz+rLufUskh2r1eaFNijxn3gj0J6I80KktDL9VpMukKz0G5EZhS85b6i
        IGjGLmBUyCRARx7YZn8RayU+x2WWN60ehsZ3jWKz7wY7YE7DBOTGDq60BWSc0X6H
        oyZU0o40l1B6RtH5DV3lsLRVlb1Uwf+Ch7zOadohJ5Dzy+T952kwXUrg298zGw1U
        cxwqYy9652mPrULRN9dC0qWMyM6g8+5qEXtUr+HHkjiqwkz9GxG3V6+5bdtvYaw0
        vNUw9F/4UZkTBHnFLDcOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688446013; x=
        1688532413; bh=I7hwEV3srjyCYS9t+KWnEQ73pm3PsV/kMvHeobjOFJQ=; b=a
        oOR3VF9pK9LHYkU1GsLZh3MXRTx8UXEfnTFj11+Dg6w4X0pZmy1dKg/p26lZAP1n
        4GkPdwSYSZkaCGnsE+eJVfqCDICLg0kVCStjwUROhC0pbAimyydLUibp890uUDwZ
        y05ds78HyFA4dhp6gsTZKmJZKoHybOuRQIzlBI9WH9v1LbgvAuKLh9Xcb1N00Fie
        Z0iIHBp8q4kWFNyOLq6MXrNyItNEIFIobvi84dRvUjRxGeWI2Yml/L7e+lwxirHb
        hC/8RQApkYmHOL3Bs2QKVdjU0gGMIivFXEOPumv2GJPO/+PmAZ1AkYA2Do+Pe8m7
        cQZatJUPZMH/njO1UQ7qA==
X-ME-Sender: <xms:PaSjZPFbBr2dwFDpobYodLh5eLssqb2AuFV483H8s04V64B8XRDafQ>
    <xme:PaSjZMXHcTrWgMD4QeFyqAkczB_MwDLBjLJNfsfvb9aqg5D04THGbjtzkNAUa8pKy
    zON9JMTg8IW__kC6sM>
X-ME-Received: <xmr:PaSjZBJl6RIgEhJt6dv-JQJDy8gGZZgbf9MdmPccSs1Aa3GANLGV9p3cJz4e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:PaSjZNGgqcv1JjlyxNsbjKq0I7Wvk54W-ePd6lMJ2Wz8ioKtg0QTWg>
    <xmx:PaSjZFUDpdi4p2Nl5XDqV6dLQH8RuHIPJfU8tQDDzksOnGIN0atazA>
    <xmx:PaSjZINlg8jUb5k-vHleHP7jzBGtGShNdRtIFHKG8r4dLc7RgsEXLA>
    <xmx:PaSjZAPfGU76qa8pWIV7TtGmUn5Hd58WTkykzh1aEQ-6hZyTxQiX5g>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jul 2023 00:46:49 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     perex@perex.cz, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, tcrawford@system76.com,
        tangmeng@uniontech.com, p.jungkamp@gmx.net, kasper93@gmail.com,
        ruinairas1992@gmail.com, yangyuchi66@gmail.com,
        yangyingliang@huawei.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 5/5] Fixes: 31278997add6 (ALSA: hda/realtek - Add headset quirk for Dell DT)
Date:   Tue,  4 Jul 2023 16:46:19 +1200
Message-ID: <20230704044619.19343-6-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704044619.19343-1-luke@ljones.dev>
References: <20230704044619.19343-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an erroneous whitespace.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ba3c113f0be1..1547c40dc7e9 100644
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
-- 
2.41.0

