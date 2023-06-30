Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFE9743396
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 06:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjF3EbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 00:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF3EbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 00:31:21 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C622D71
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 21:31:21 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id EB90132007F9;
        Fri, 30 Jun 2023 00:31:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 30 Jun 2023 00:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1688099479; x=1688185879; bh=UiAWsI8tH3
        jOLRq3enhFEFv5i0nenQzGAZVM87LWRNw=; b=qM6OGu7Ir7gJkulUdQLhY68WmV
        kzOILSOf2bLI7YLQhxcx2LVcimvorZFCfHb42lX7MoaAH4CFOLiLR+NFFS/DoGLe
        aaCx53zXhVIesA5AFgkssu4RLN18g3AdKQbtfGVFeXxa0NQUjIxiZ3JGTZ4H3jxT
        Bb/rtgLrMaq3XXNikCqb7PtusLHgUYSbTLWheAyCJpV5LedUYxuhduGpVVrhLO4x
        n0qUCKerY9s3u8HWV4kT4/RQnnNReFDNzkRrctB7YCv5Jat6mIvSOcDJYuhaIxtu
        I5lzONl9i6BHDAaxul9xmrnQmf98VFnIxtfmsPwSnvStHLM9P/LLpmNm7qVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688099479; x=1688185879; bh=UiAWsI8tH3jOL
        Rq3enhFEFv5i0nenQzGAZVM87LWRNw=; b=Gy7eIe5tXUgs1ekxnhKG1zqHL/V2P
        kpM4UPsJYtlIapwipTGM1LqDATqJCGKpJWr+OqeSQ3JjcOGDgiLQOH51HZyCrPaj
        QsB4YF4m1HpTOGZNsxoz2DFa+C8lOQNAavuj1MQ8BQl02vxwHQYV4Obn0cfHwuO5
        ddFVllfOFkCwbfMq5TQG37DNXrTFnmotCcUUKRuURkH5wxYw+dfdJQGIOSOpp2wj
        QQZvqttAIoSK9CM3tt53quNuvKJFxcBHFmn5hPgnqH+57a1QCjx7o8kE/yb5sxlb
        P4TyegSH9Zjwxm3XaYTFHLKtVbZgkggQN+iHIEai5TyYBoU/+nn9b1skA==
X-ME-Sender: <xms:lVqeZCLmNXUW3NYBAZUgUTHa206tAl3w3pJZ5XAx1tz5W8hvCsSlcQ>
    <xme:lVqeZKKkA0D8hjKGvSNk0Y4gRou_xILDWK7bh3AQf7nGJXyRFTDJcnNiD4dMDYP4s
    lBFz6h6Zp61brsnKfI>
X-ME-Received: <xmr:lVqeZCv9LsAqsiXr3YIVQdzN5JIrrXyWOw-ak1fnWtVpR8_VTCknl_Egyb_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:llqeZHbZ_f2BnLcuZ76G-7HiYZo6KDo-dHqbc88TjkTbIPC_mqBJqg>
    <xmx:llqeZJZfgT-zMUn-_RowPcm0whCgEKjgOIXPAuJB9htI7ms-OrVG4g>
    <xmx:llqeZDATJfmsh311JNlWTzQjHtZfex3KH4Wegb3845JbemCm2QrHzg>
    <xmx:l1qeZMzwrTn117Nq1dDv7LSzqxY0ywfbARddcdPYjMuxEAIWwm3ciw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 00:31:15 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     perex@perex.cz, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, tangmeng@uniontech.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 0/2] ALSA: hda/realtek: Add quirk for ASUS ROG laptops
Date:   Fri, 30 Jun 2023 16:31:04 +1200
Message-ID: <20230630043106.914724-1-luke@ljones.dev>
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

Adds two quirks for each GX650P and GA402X laptop with the I2C connected Cirrus amp.

The added quirk chain is similar to the one added for ROG Ally but with the verbs
removed. It is likely that the ROG Ally quirk will move to this set in future.

Luke D. Jones (2):
  ALSA: hda/realtek: Add quirk for ASUS ROG GX650P
  ALSA: hda/realtek: Add quirk for ASUS ROG GA402X

 sound/pci/hda/patch_realtek.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

-- 
2.41.0

