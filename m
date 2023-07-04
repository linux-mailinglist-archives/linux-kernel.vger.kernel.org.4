Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC09D74686A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 06:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjGDEqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 00:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGDEqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 00:46:34 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9409A133
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 21:46:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E56FF5C0287;
        Tue,  4 Jul 2023 00:46:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 04 Jul 2023 00:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1688445990; x=1688532390; bh=ODloePsypp
        nHeOIoKjovw8nmOk9jHbc4KBmzFH1wHuo=; b=jpZcn/2l6Bnux+KnOtIJWSfbYB
        DQZM3UHwCn6EJTLvnRYZp2yKy0HLmNMX645sj6WVHigIuWYPcOH2e7TwgjZC3NBM
        dgQD+1ed8vsQzDRpmipwuWz/gEBWGmbXnuNxV9VMqSF6sLZYggcmGy0y2zmVyU8W
        ktvwCUATyJwnjfcRLNfjYRoj8qMTohLV5pefLah5LlJCbh4XfT1j2f56w88Qftb6
        lqv4fmHjp2FMz+zY2yKFlNf5X1ilrxamYDbOWXTEzrXuw6FEOcIP5fmDM7XuGPVm
        ur6zt20t/wnCdasWmeo5uFLwB/rv2K9mYdvLfijMV8pk5qVu6hfAgzgSZPEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688445990; x=1688532390; bh=ODloePsyppnHe
        OIoKjovw8nmOk9jHbc4KBmzFH1wHuo=; b=CF/dadherJJcVqLw7kppj1RctAxB1
        QgJDiz05LG8AawbCs5aJKllX6G55Mv3opIC1Lxi5seppS0JjSAreACdzK9Cu2CE6
        n5hdhXumNkhuxTTYKlRE8tWTgzW+P9eREuPzYjh80RLwhLJFvpdUIuHsrn4dCRvq
        8WKSGgWr29K2NgtueFJElp1PVUIgEVJhooTDYoF1cmtrSEHWHiR3520+XfDwYB7W
        sWoYiXkrMPLzzaq2WXUxC6XREnCcXJATfBCVXEjZu/e2hyYwZtcFcwfwXkVZ0eF+
        iCqAuush9Pgm//PxkNw/7zyL6A20DU9hzamVVYP47OwWOa03c6+pRwuTQ==
X-ME-Sender: <xms:JaSjZCfYlrniEgC56pbVSMJH3dRVH0MAX_IKl9CXBcVJXCfJPkKk5g>
    <xme:JaSjZMMuV-nDwwyYA-OtrxD3rIWuGqymidz2qvvMJhsKStZy74QF7Om__E2-0AWTI
    N6_6n4cHvne1f3I2BI>
X-ME-Received: <xmr:JaSjZDhzRtswVCOcmlK0aUZAUjkGBZsaEmJ0cJBqIVwyetmSHJB8iXQcpA3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:JaSjZP_KBrVmfOE8U-aHMH2t4tP3PgbECeRUb7LEktRmyyR5PuWgcQ>
    <xmx:JaSjZOtMna8HXi_f4jOdj91EmO7KKqsZ7qdQW21KCIaveO8gyi5doA>
    <xmx:JaSjZGF-n0zo2TylEd_NbyjqqusHDltaSdcDD23stPu3HdCsh0gIDQ>
    <xmx:JqSjZGHrBZbHo-pCEkOWVFxg2En7ncd4u75lNk_AjMBeIB6d-AZXQw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jul 2023 00:46:25 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     perex@perex.cz, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, tcrawford@system76.com,
        tangmeng@uniontech.com, p.jungkamp@gmx.net, kasper93@gmail.com,
        ruinairas1992@gmail.com, yangyuchi66@gmail.com,
        yangyingliang@huawei.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/5] ALSA: hda/realtek: add extra ROOG laptop quirks
Date:   Tue,  4 Jul 2023 16:46:14 +1200
Message-ID: <20230704044619.19343-1-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
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

- Adds quirks for various ASUS ROG laptops.
- Fixes up a previous quirk
- Fixes up a whitespace error

This introduces a quirk chain that is similar to the ROG Ally quirk chain, but
due to the verb configs being currently tested these new quirks do not use it
and instead add a new chain. It is likely the Ally quirk will be removed in
favour of this new chain in future.

Luke D. Jones (5):
  ALSA: hda/realtek: Add quirk for ASUS ROG GX650P
  ALSA: hda/realtek: Add quirk for ASUS ROG GA402X
  ALSA: hda/realtek: Amend G634 quirk to enable rear speakers
  ALSA: hda/realtek: Add quirk for ASUS ROG G614Jx
  Fixes: 31278997add6 (ALSA: hda/realtek - Add headset quirk for Dell
    DT)

 sound/pci/hda/patch_realtek.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

-- 
2.41.0

