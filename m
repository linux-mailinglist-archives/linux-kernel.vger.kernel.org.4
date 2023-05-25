Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499F97109E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbjEYKRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbjEYKQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:16:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F7D1A4
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:16:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B3E55C01A6;
        Thu, 25 May 2023 06:16:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 25 May 2023 06:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685009790; x=1685096190; bh=Wc
        9w3kWKGue5AkBPboUKgcnbBhGEfTTn2MbGT+ui8WA=; b=TzySZ+u5L0uFc+qqrv
        IRyEduQPvIG4W2O3GlLsHyhJHat69y72XD3vaEkp9FkEGbU3/YQBbPRwOcQY3hBu
        m9EkNCTLuCnmqDyo7lTz1UFJUfSk2MSnzIF3r5XnTI1Huf66d+BcbwhQnRk9y1kX
        eMki1U9U0YinrJ9SLxd35yFlOs+fBOIm0YIpvfLseImTY4jBtCrfivc4+3MwAjEg
        0VImjXmPSpTgX16qHomzlk9Bo33O+BHeADuXwQUJwmNz+NCRQaiLImrlSjwJi34k
        bmXOFnhx2sdXuc1AWdj64I3CZ6558GqHxlYmtcobw7+Oq3lVfGZjSoB81pFULtEs
        H0YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685009790; x=1685096190; bh=Wc9w3kWKGue5A
        kBPboUKgcnbBhGEfTTn2MbGT+ui8WA=; b=PVF5K47n8yC9R/VDm9XLqi0J+pxnP
        eiZBLtHRArSD70tEPVFrAI9kai89n35FYjo2jIRf511mWq5+Rc4okUPivl5OMOKW
        p2VHC4SVB3pwXrz6XHNzTJl3gXVpYFJrWpNhOZlpfhZwq5uloNxwc0rM0hipGcm1
        bDXm/KvKXBc/IdjgkI4MkpmOIGCEJRVTl8nyxWl8dbWCe5CnpNjWtcB7yCiIAfPp
        v8Ldr+s4thbhLk8IX4jYWToCMPn5r0GKlgUYFZZWHw257jQ2aSJrRPiWkLR4G72s
        2CZccZBcCi/7AVUpgXaALAGuCBWdN9DhnSkFOUwufnuSrYXQp2hRQ3Mxg==
X-ME-Sender: <xms:fTVvZBUIXoXWcgEwoS7pGqI-XGO8wN00X1ZGcasr8QWxwM0t5gHsgw>
    <xme:fTVvZBlrnjX5QHT4V1Q9pL84EQafg1ZGzHZ3bR8xarbZw6BzkkYVPTN4PRMlcgi0V
    EyxIxQHpQEpzuS3WbA>
X-ME-Received: <xmr:fTVvZNZnGIlg9Tpvp8-6q8QNvqXMy_dK-2ejCtU_s8RKpumk6_dctluwGN3-dJt39M8CUOetSCJw95c5RPlA3rv6W3BzY7E0GUV_lpBKMUDRUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeggfehleehje
    eileehveefkefhtdeffedtfeeghfekffetudevjeegkeevhfdvueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:fTVvZEXm2d4VHuIh0hjelk7U8YvjapXNrT5kgwTap23J2N_rVnXA6w>
    <xmx:fTVvZLnNiAF80tCOxmMzfO2JEGS3wPacsQQafzqVk-TVdgfxpgxKQg>
    <xmx:fTVvZBdqhiVApI5mf2HCDpUcXpy8eI0urDYA0nme3hRzY8w43b882w>
    <xmx:fjVvZDuVa07yKQ_P7IcVoOxXTgIt8C85zdVdUnhmGVG1pHJm47SC4g>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 06:16:28 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     kunit-dev@googlegroups.com
Subject: [PATCH v2 00/12] firewire: deliver hardware time stamp for asynchronous transaction
Date:   Thu, 25 May 2023 19:16:13 +0900
Message-Id: <20230525101625.888906-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset is revised version of the previous one[1]. Copied from the
cover letter:

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
for user space application.


The first patch is newly added for KUnit test to check layout of structure
exposed to user space. I'm pleased if getting any review by KUnit
developers since it is my first time to write any KUnit test.

The new feature will be used for my future work to replace tasklet with
workqueue. The hardware time stamp could enable us to compute the
processing delay so precise.

[1] https://lore.kernel.org/lkml/20230125120301.51585-1-o-takashi@sakamocchi.jp/

Takashi Sakamoto (12):
  firewire: add KUnit test to check layout of UAPI structures
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

 drivers/firewire/.kunitconfig       |   4 +
 drivers/firewire/Kconfig            |  16 ++
 drivers/firewire/Makefile           |   3 +
 drivers/firewire/core-cdev.c        | 252 +++++++++++++++++++++-------
 drivers/firewire/core-transaction.c |  93 +++++++---
 drivers/firewire/core.h             |   7 +
 drivers/firewire/ohci.c             |  17 +-
 drivers/firewire/uapi-test.c        |  87 ++++++++++
 include/linux/firewire.h            |  82 ++++++++-
 include/uapi/linux/firewire-cdev.h  | 180 +++++++++++++++++---
 10 files changed, 625 insertions(+), 116 deletions(-)
 create mode 100644 drivers/firewire/.kunitconfig
 create mode 100644 drivers/firewire/uapi-test.c

-- 
2.39.2

