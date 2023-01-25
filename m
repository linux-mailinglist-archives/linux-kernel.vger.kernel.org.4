Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF04A67B229
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbjAYMDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjAYMDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:03:10 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AEF5689F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:03:09 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D6C255C00C8;
        Wed, 25 Jan 2023 07:03:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 25 Jan 2023 07:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674648186; x=1674734586; bh=e4m11TiEjI
        aZf2UJgbdhE53Uz0/WMy5JOj6ZAjA+f84=; b=IOcHzGcRFfOLuFM3+Hepg6kluM
        xnH4kMbFX/SNiDEP+470bE9JVUjfHpfle9TTyrVxz/U6Z1r0T4byHf66ifjQcJzC
        YM8vpHeTdL33U7dvazVDMwa3foO4eCfz0cuq4YwoC8HW7+c8u1Eji7cLx2geBlEI
        Jp98ROA0xjBwJ4W2z98QG1JiFJfafWqZF231+aFyokg2Jq8H2rbO1nCSTF2YGIXj
        kKJLa/aRTmyZM0hsTeuCdagdt6dgaK4lbL/dLLYjSYoCuGCu9gi3NT72MLJSCaCV
        K+VSK+dDuaeLa4I1itTE95oAWlVW9f0nYykdPXDUq6tTNU5zr7yNrFdUzwHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1674648186; x=1674734586; bh=e4m11TiEjIaZf2UJgbdhE53Uz0/WMy5JOj6
        ZAjA+f84=; b=Q3/l96+VyHXCPTGnuWxIGs3HhgjCIvNF3YlqZpJFF9ioWXyODSG
        z2MV64hgWjMkdt1aQqSJAvtU6PTC+y1Sf9JgJSAQ0OyNebro9vfl7QaGtNTIYsSt
        7hn16l6cpdsGP0cueMYXFzpI7mBvMRGwPuHxHc4vFGan4+B4w9uksJHM+TiRWYTu
        I3UvLZUbgLUmj3ixexoWu54UrsLAPscXKR4Tpw6FTBtf65LN2CxeCRHRVKiB+EiN
        5Ky8FcXyt7HmCRZUCW3ASEPcNvBmJ6+1Lx9k5OnISK7IVk6EBn+GRMBJgZu4M3FT
        Cl6okgd7K46zJOmcWT6xTAwc+a61UEkUBIw==
X-ME-Sender: <xms:ehrRYzYvSqvpYXInYJxbwegx1xapKWc7-EMV323hGP5M76DGqHb7PA>
    <xme:ehrRYya6vjYoeLy1HRzkGBDHRBYB-g8axLRHLON9KZfN6R8G7bgIvoL9tUhsqjrPP
    oj__HFGZUFM4XdBIJw>
X-ME-Received: <xmr:ehrRY1--2zBoNpFtfOFmEIaO2PBV-MoEbcMgvYwB9A5-su8_m53bEJVDajsqqS65n5khCfZo6buXJnE_D8JFpwT1Ep61TS89A0jI03zIBnDaY0fgrfGlq3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpefgtdfhteehtd
    evfedtheehtdduhfevleehueejieffteefvdfhgfetgeekheetffenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgt
    tghhihdrjhhp
X-ME-Proxy: <xmx:ehrRY5rUEGFHvG6pylrVTC6vpaQkVG2UHqzlIyCimfxpwPJSNUhj2Q>
    <xmx:ehrRY-qlaDlOYd1sIggGLATm-T7Ttf666u5f9QmkFfu1xU3Mh5IwnA>
    <xmx:ehrRY_R8PdfWu6OAHWpK3_Y8H76iIxBvAsJ48McH7yFYB3530ywhYw>
    <xmx:ehrRY13GJnMbO37aa66gviAzcV3EMH96SonanbXpfxBeiBm1w9-5vA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 07:03:05 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: [PATCH 00/11] firewire: deliver hardware time stamp for asynchronous transaction
Date:   Wed, 25 Jan 2023 21:02:50 +0900
Message-Id: <20230125120301.51585-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

1394 OHCI hardware supports hardware time stamp for asynchronous
communication at 8,000 Hz resolution (= isochronous cycle), while
current implementation of FireWire subsystem does not deliver the time
stamp to both unit driver and user space application when operating the
asynchronous communication. It is inconvenient to a kind of application
which attempts to synchronize data from multiple sources by the (coarse)
time stamp.

This patchset changes the subsystem so that the unit driver and the user
space application to receive the time stamp, therefore it affects kernel
service for asynchronous transaction, kernel API for unit driver, and UAPI
for user space application. It is based on the kernel tree to which the
other patches are applied[1]. It is also available in my remote repository
in github.com[2] for backporting purpose to kernel v5.19 or later.
Additionally, a test result is reported in README in the repository.


Well, in recent few years, I have requested the maintainer of sound
subsystem to apply small fixes to FireWire subsystem since upstream of
FireWire subsystem has been inactive[3]. Nevertheless, this patchset should
be enough large and beyond his courtesy[4]. At present, it's unclear that
who reviews them and who sends them to mainline. It matters to me... I'm
pleased that any one has an idea to solve the upstream problem.

(Iwai-san supposed the best would be that I would step up as a maintainer
for FireWire stack, but it is the last resort.)

[1] [PATCH 0/3] firewire: use single object for user space listeners to
dispatch request to IEC 61883-1 FCP region
https://lore.kernel.org/lkml/20230120090344.296451-1-o-takashi@sakamocchi.jp/
[2] https://github.com/takaswie/linux-firewire-dkms/tree/topic/firewire/async-context-tstamp
[3] https://lore.kernel.org/alsa-devel/s5htub52zz1.wl-tiwai@suse.de/
[4] https://lore.kernel.org/lkml/873581r76s.wl-tiwai@suse.de/


Regards

Takashi Sakamoto (11):
  firewire: cdev: add new version of ABI to notify time stamp at
    request/response subaction of transaction
  firewire: cdev: add new event to notify request subaction with time
    stamp
  firewire: cdev: implement new event to notify request subaction with
    time stamp
  firewire: core: use union for callback of transaction completion
  firewire: core: implement variations to send request and wait for
    response with time stamp
  firewire: cdev: code refactoring to operate event of response
  firewire: cdev: add new event to notify response subaction with time
    stamp
  firewire: cdev: implement new event to notify response subaction with
    time stamp
  firewire: cdev: code refactoring to dispatch event for phy packet
  firewire: cdev: add new event to notify phy packet with time stamp
  firewire: cdev: implement new event relevant to phy packet with time
    stamp

 drivers/firewire/core-cdev.c        | 252 +++++++++++++++++++++-------
 drivers/firewire/core-transaction.c |  93 +++++++---
 drivers/firewire/core.h             |   7 +
 drivers/firewire/ohci.c             |  17 +-
 include/linux/firewire.h            |  82 ++++++++-
 include/uapi/linux/firewire-cdev.h  | 180 +++++++++++++++++---
 6 files changed, 515 insertions(+), 116 deletions(-)

-- 
2.37.2

