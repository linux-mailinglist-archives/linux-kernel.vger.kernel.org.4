Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE4371F494
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjFAVZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFAVZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:25:16 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C253B184
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:25:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A4215C01BD;
        Thu,  1 Jun 2023 17:25:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Jun 2023 17:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1685654713; x=1685741113; bh=MLwRAM3dVWLmfg+MF4/R7sr5DQxJwUt+yRz
        pW2JKSv8=; b=Qpa5q7fSLyazw/VQWnv17Qz8/yjV9fZXvHc6R9ThNfhy1o0Mr5z
        W1dZ3qjfzgr70vV2+SaTiP5pi5XlrHQQfQB6WChjAsfZbOYotw0X4V72CDvvlezi
        M0tujXY7i0ryYRYkT6SQ58zcifsdhx4TNhbZIOhJrXTK4dkxiZ66sVlNHqrJxkbt
        daDyePUXMjDXCB3vSjYUwSUWm6+h4wO8ZUHMG/uPNFnQ1x4dfdB7eeeYYLRoY5a4
        iy/YvvXi8zkhNr+v62gPzlXicK639BZqbMRIzKMvzFAEZ0S55q8iSda8Wg6gzjUl
        MA8RqFS7+lomTRTic5biuIqdAYfXR8o86KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685654713; x=1685741113; bh=MLwRAM3dVWLmf
        g+MF4/R7sr5DQxJwUt+yRzpW2JKSv8=; b=MZ9NK3xPt7QgNzxpOGlT8nMYS5hYR
        0G3T5fqusT6RfsrsiDfk+Kxi1eJwAxPq9E3rosBZx0L7mLOBGgjbCDmnO36RrdSj
        sq07KS7BbHD7B2eT5zh39aZfz/4CjmXgK8zhtL8I0lHjWkkWMygjJYxlVC7oh8pV
        8LFszYOX3CqXXJXqRHIWu/F5tgEY/1bavuQDEKQNBmHNZxkeZEWHpoFyWFuhAVlc
        24qn9d0R6YDVeBbfyuRdZQZYZp04DPOxM9AeSAQbfWKpxi5afk5iz0/g4PhX8m2Q
        P+znKcUHDfXpfIeffkUq1/Pk1hX1W7xRR5nRL3i9NuEIqcbfyM5nW4q1w==
X-ME-Sender: <xms:uAx5ZEorR5uh5S82mapCbkteVGxsfNfzQgPbmETHb8AQHwWR74nQFg>
    <xme:uAx5ZKoGYGpndiV7OJsVE0Z_rM5Eb_KTHVAsDXjtbRNFEd8ji0Za9Q7C3T4D6aOds
    av8EBOZ-PhKzvk>
X-ME-Received: <xmr:uAx5ZJPq9xiWmPAr5GldAXllT0ERcWFLPD1CPRs2ZWe0QR_5aTe93kCBRfK9wMZ11C13faYi7gI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffvghmihcu
    ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvfeegkedvkefgffegkefhieejtdff
    keehhfelheefjeeutefgleeggfdtveeileenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhl
    rggsrdgtohhm
X-ME-Proxy: <xmx:uAx5ZL5etlybPL6lKFpSm62GS08sCaBLNDvPNcFIsMimYQH-yWQvHQ>
    <xmx:uAx5ZD7PMKrmXTwrViJnaCY22nz3SQ_y_by29spSWbJt1Ws2Mi305A>
    <xmx:uAx5ZLiNCKOi3EbAzysfbnXdCGVOUWBYmHPTXRlvMkqceMZtcGR0eA>
    <xmx:uQx5ZDFGw3Nx3Zhgv2A7uRMy77Fynnu1decOGHWcKPeIxLOsGDzTgg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 17:25:12 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Several device-mapper fixes
Date:   Thu,  1 Jun 2023 17:24:49 -0400
Message-Id: <20230601212456.1533-1-demi@invisiblethingslab.com>
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

This series contains several miscellaneous fixes to input validation in
device-mapper.  The only potentially controversial commits should be the
last two, which prevent creating devices named ".", "..", or "control".
The other patches fix input validation problems that have existed since
at least the beginning of git history.

Demi Marie Obenour (6):
  device-mapper: Check that target specs are sufficiently aligned
  device-mapper: Avoid pointer arithmetic overflow
  device-mapper: structs and parameter strings must not overlap
  device-mapper: Avoid double-fetch of version
  device-mapper: Refuse to create device named "control"
  device-mapper: "." and ".." are not valid symlink names

 drivers/md/dm-ioctl.c | 75 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 12 deletions(-)

-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

