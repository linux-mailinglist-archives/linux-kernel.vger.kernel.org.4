Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCD56EFFF0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 05:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242855AbjD0Dtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 23:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjD0Dto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 23:49:44 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6763CC1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 20:49:43 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 09B97320069B;
        Wed, 26 Apr 2023 23:49:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 26 Apr 2023 23:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1682567379; x=1682653779; bh=oIZ0uphE+l
        KqWtXq79GUSl2Jtb/QJ6+AX9CSwkIJhcg=; b=moVPG0WvdJ6TIghtsP978v06EB
        B1P1+fpPUrHsaalQ1pr5X/UaVQMSeq2VISr1Ywb4V4ZdxlqeP9IIoOXN/psRBvmu
        c1OXQ1fPgZMoFOYw9hdh0PE8wIO5ktmjcOVGbdBR4LwINBhEbz96OvS8IWBrkMsw
        HsUX/feqFXUdRUA9K0X7vWCIZxcGwOYAjSlKvefGuLBpjwXzk//uTXPLm8vuOlXA
        313aDCp34NVmwl0EkCElZSfz+5MtOQRSdkohdwECz21laQx9U/yKKYX8YBO5fO5o
        vPbAPwYmLFNsUmrDqncIz1Mt+EpIAd9CDFg1FT21Qma8WBl4s4hqBwNxhKWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682567379; x=1682653779; bh=oIZ0uphE+lKqWtXq79GUSl2Jtb/QJ6+AX9C
        SwkIJhcg=; b=Gd2NzWnKYRp1oBv/7u4z94onL/RsmluT4A1WWM2E1otqFFofayr
        /eFL09Jc2kQG0UnuQrlkVWvQUBDTHJ4wG4plnUiH25ATmJfyavjzN+3YQr188GL3
        +D1Aun7W38jxL7AAA7sTWtaFkvD3xM0UDG9fMd4Vrv096zaNgnWcp5On7rTKWE3Y
        CSSgoZna6T4HYpWNz+CSiSfXSCWhgfqr7T/fgj8KRIcz+xczgFai6pTJ8QqO1FKW
        aUkGYJFrPaeD+si93vYNICIztWl/d6h4jDheXrWbEsF0xL4tS0k0NxWisymiTzNp
        BXKndzg9k6Pgq4J9WAISjYywEdSU86FaFDw==
X-ME-Sender: <xms:0_BJZOG3VezINyRqXkB_X_82t8J90HzvLvxpiulRp4XQbcLrbQUQ3Q>
    <xme:0_BJZPWMFY0a4f7nZm9sxMo8zliFqK8IaJoqYbCUyqZsXmnZaghaYjWEIzYp6JfrL
    No-ZfZKTnMZ5tDkk8o>
X-ME-Received: <xmr:0_BJZIJ6Dc4geWigaloQorBGgfrluQyfGXMGC_lb8AZFNLstyNTj7S6g0lrBWaAMu7Sb46nc2cbgYYv0ry87JWdfPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduhedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefve
    egvdfggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:0_BJZIFhicjUm7vfhBmaHYEClw7lFlPXFbmMn5KqxHNAfnasirkn4w>
    <xmx:0_BJZEUuSM37T4Imr99Lc6a25pWY0CDzOS94kkdpWk7HG8phuLuhqQ>
    <xmx:0_BJZLNN0D-zi_hY_XP35H-AiN3jCPyay87n8FrXYkGrmz-6TiBjFw>
    <xmx:0_BJZLSWo-fN1HU6Q2yEf2MfmT_VxmoHgH75SrLT8olfgyoZ5JBqDg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Apr 2023 23:49:37 -0400 (EDT)
Date:   Thu, 27 Apr 2023 12:49:34 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     torvalds@linux-foundation.org
Cc:     broonie@kernel.org, tiwai@suse.de, stefanr@s5r6.in-berlin.de,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] firewire updates for 6.4-rc1
Message-ID: <20230427034934.GA556709@workstation>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        torvalds@linux-foundation.org, broonie@kernel.org, tiwai@suse.de,
        stefanr@s5r6.in-berlin.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Nice to meet you. I'm a new maintainer of FireWire subsystem, taking over
from Stefan Richter. Please pull FireWire updates for 6.4-rc1.

The following changes since commit 457391b0380335d5e9a5babdec90ac53928b23b4:

  Linux 6.3 (2023-04-23 12:02:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-6.4-rc1

for you to fetch changes up to 02dc51a0a07a379539b4661ecb56eeb5b19b3928:

  firewire: init_ohci1394_dma: use correct function names in comments (2023-04-24 09:19:35 +0900)

----------------------------------------------------------------
firewire updates for 6.4-rc1

The pull request includes a few changes, Its main purpose is to prepare
for my future work by taking over maintainership from Stefan Richter. I
have plans to work on several items; e.g. packet processing in workqueue
context instead of tasklet.

As you may be aware, the IEEE 1394 technology is outdated. However, we
still have users. It is better to ensure a smooth transition for the users
to shift to other categories of devices. The first commit includes my
schedule to maintain the subsystem for the next six years. I would
appreciate your assistance throughout this period.

----------------------------------------------------------------
Randy Dunlap (1):
      firewire: init_ohci1394_dma: use correct function names in comments

Takashi Sakamoto (1):
      MAINTAINERS: replace maintainer of FireWire subsystem

 MAINTAINERS                          | 5 +++--
 drivers/firewire/init_ohci1394_dma.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)
