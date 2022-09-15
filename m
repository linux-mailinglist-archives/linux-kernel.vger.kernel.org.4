Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD3A5B95F0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiIOIJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIOIJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:09:38 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69459393
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:09:35 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3CA843200B5D;
        Thu, 15 Sep 2022 04:09:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 15 Sep 2022 04:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1663229372; x=1663315772; bh=jB3LbFdeH6Kq+2icxS6m8jTZv
        X8bT5/rnnwz9l1va1E=; b=GvflTb70bej+GmsOiABbrcvA3AzhTVK4O04Ma4DN4
        s4Y2YpVAcAmTwcCwjGsewc8DJ5i/mDfDwd8a057keKOmmAObzGiFwji23xFeYXee
        KuSIzVEfEl/FRscwOqPdhHp/z+2+zPczaKZXwKRtBSboZuTh55K8B5bDlE8/Z3dY
        SmKskrT0Y7U+Xm5f0PQF/gYxCh9idakEItYd/dJWj3ytqbt4KNiWcWL3EhKPbZeT
        rSK53rAIPGvlMq/jVgZjhZqmhh+iRVmvWvW0iE22gRPtEMbVs0bDDOZCWFNiL8Sm
        pz9nr6ebZlQ0Rccd4oYw0DBl+K02atBTGESP5DviTl+Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1663229372; x=1663315772; bh=jB3LbFdeH6Kq+2icxS6m8jTZvX8bT5/rnnw
        z9l1va1E=; b=epYlB/+5l9dbXlQaZ4DnGm9a2CydhPB/ZKt9cG7/8qWWefHmfzB
        YJ5ZSYlH+j0JXd9mcUmjCGv4iz3a6aYPhwqNFOjr29ToHdn/9akFuV9aAEcwekrq
        gEcFXNlmfzG56KFtsscZ6bGGuvxFqBEnfTgVDdThX05m1cvYGMU7vnUANtsa/rbB
        ePW2UFZnGb0JxUwsUJS20udGLYxcurBHaMcql3j7maPEz4DWhu4B4ov1vHvNVzn3
        YyDS1xPJ1ypJxP+I73EvAYIomNvPkUrPp81DQCAC0WsCg6T7VYOBbcEE0Ob/w8Jk
        4ybL4NuiNmJyzlqI924sGPtDT/CgzxU5Q6Q==
X-ME-Sender: <xms:u90iYxI4HAl_rw_yhNZX7PHUEunkA56wBruwnw-3HNAX0EeI8AoqmQ>
    <xme:u90iY9In8s-0n6Gfefw6NCkhVBKgwrZaLoCC28kca4EnHXVAE7tJF5cwqMILxGVDA
    YxxThyaJ87IwLPeTuc>
X-ME-Received: <xmr:u90iY5v42eJonoUskDFoQ7p49z268KyyVkvH2qPBuQapzzefl2Y1CjPftdrn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedukecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghs
    rdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvdfhge
    duudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:u90iYyaI8UnGH9KEpLuV42ezMX27PFJ_q9xPwu6n8-xTd8z0PQAMlQ>
    <xmx:u90iY4bgdC9Ti14RwE4iIN4TyCyVSC8jtSgDGeKIzKqqtzUnEeEtlg>
    <xmx:u90iY2CZ6ubAa3y_NngeoLzEk2b81Hlw30aRfJ524SDfw1dG-A3JKw>
    <xmx:vN0iY3k4rR-ixRL5tjGJUaymbU5SzmyfWdp4TGyyr48m5hlep2nuRg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Sep 2022 04:09:28 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        perex@perex.cz, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/3] sound: realtek: add quirks for ASUS G513, G533Z, GA503R
Date:   Thu, 15 Sep 2022 20:09:18 +1200
Message-Id: <20220915080921.35563-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.3
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

This series adds quirks to fix pincfg for the ASUS ROG G513 and G533Z laptops, and adds a mapping
for the ASUS ROG GA503R to use the previous G15/G14 quirks which fix the DAC mapping.

Changelog:
V2:
- Use smallcaps in hex string
- Chain the G533Z quirk with the G513 quirk as they use the same base pincfg
- Add the quirk for GA503R series to use GA401 quirk

Luke D. Jones (3):
  sound: realtek: Add pincfg for ASUS G513 HP jack
  sound: realtek: Add pincfg for ASUS G533Z HP jack
  sound: realtek: Add quirk for ASUS GA503R laptop

 sound/pci/hda/patch_realtek.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

-- 
2.37.3

