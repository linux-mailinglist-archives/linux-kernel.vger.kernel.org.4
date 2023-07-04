Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A377470B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjGDMTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjGDMS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:18:58 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C165810EF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:18:53 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2594E32009B4;
        Tue,  4 Jul 2023 08:18:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 04 Jul 2023 08:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1688473132; x=1688559532; bh=TFejWBSEdC
        irJhK9+BSCkX03krBBQ5n4YbwiIw1ENxA=; b=AAlBf6c2M4sh+7H1YAM1K7PzvH
        xTOwlbyncXDXjmjWTuW3rISaNThFjbZEVQxTL4wc/53kMtEAjTHPQ9VdeUxnJLOQ
        GOkEiQWdo4MoWuISx8UZWF+DYR0k+rhC0zQaw5IJEjFE2879PO7teT6CW2ijLyre
        ebGrYt0NMxijXY5au4UrBgqBoTkF9qbI8ImAxKHWdvxtVT9M28njSOoTIVMUzuZX
        1mvOVhc7wzmjxJ/R1MvnebtLUI4hb8UZXVYJhtYavklJYrp6hUMTTAlHPKH5/6pd
        CHvOq1SUliO5OgW5GN9x9lxtRAKK9iXLvoRNPBs62QvIcW6elcrH1TV+3XrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688473132; x=1688559532; bh=TFejWBSEdCirJhK9+BSCkX03krBBQ5n4Ybw
        iIw1ENxA=; b=MGmIPDWHpPFm16D/CS1d6xbTOWZeVoS5JvFDx4vKjlCGtTrsDyr
        FCJXt74KaltSreL8faNPG6AkYgNSO2Ub6efn7Sm7+WhDo379/A9LbKqNi3gB9Wh2
        E9ybHw40oPjkbJoIlVqmKRAdJzD+yj9AjRSSEFDStBkh5WBE1du96k8Yga/ESrDY
        lJqssPYJvUo69xMvnfWjnmZZ7UTMVaeuG65qlnwdC30IKke/KlB7G2CaCKO6hTHp
        4qdgnB+UFgcdl0+q4WTERDBUkmsC2PZGERcyH7r5k6V8rmoHGnnn00asG/Z7Qanb
        Q5Xp1EjsSGAhnQdtgL0r8qzORpTwzuFUwHg==
X-ME-Sender: <xms:LA6kZISMxGD7b5Y0HJDmPw1IYIkufcCsgP1GtvxmkeIbWicHwtZgJA>
    <xme:LA6kZFyIlBOMe4iFx1iuQYcg17AGkZzdzldR6rM1Cm82GSxOAXwiURpV0EWWe7hnl
    8ZL6mdT3xeYsh5Ifp4>
X-ME-Received: <xmr:LA6kZF0P8TxpI2qCCo4J1wANRL2v4La8nnGFcdWpJRCgke6ASHUBTcy-wV_ThEjVZMmnJ-VY4JNZNWlaTZFtqlRjg-NwuTb4sRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeggdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepteefieetfeevge
    dvgfegffehteeljeekkeelueegfffftdfgtdetteekvedvvdfgnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:LA6kZMCEEJug6CoAx2flDy4RHASHs-s8b-PmhpueZVXS0aDQhlrQzw>
    <xmx:LA6kZBjKkPq4Of5aFeEY_sOjeY9XjSF9_nGkA3oA7kEobutSZcrlwA>
    <xmx:LA6kZIo4PmT_W5Qa6HvDEM-iJXqUv6E-1eQyLCVQ4OedEv_zXwhP_g>
    <xmx:LA6kZBLbW7d7fVomH7uwcfsyQ8PlqHEBIlQBlcTaZnz7xLTJza-JkQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jul 2023 08:18:51 -0400 (EDT)
Date:   Tue, 4 Jul 2023 21:18:47 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] firewire updates for 6.5-rc1
Message-ID: <20230704121847.GA26576@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull firewire updates for v6.5-rc1.

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-6.5-rc1

for you to fetch changes up to 3ff256751a2853e1ffaa36958ff933ccc98c6cb5:

  firewire: net: fix use after free in fwnet_finish_incoming_packet() (2023-06-24 14:03:46 +0900)

----------------------------------------------------------------
firewire updates for 6.5-rc1

The updates consist of three parts; UAPI update, OHCI driver update, and
several bug fixes.

Firstly, the 1394 OHCI specification defines method to retrieve hardware
time stamps for asynchronous communication, which was previously
unavailable in user space. This change adds new events to the UAPI,
allowing applications to retrieve the time when asynchronous packet are
received and sent. The new events are tested in the breeding edge of
libhinawa and look to work well. The new version of libhinawa will be
released after current merge window is closed.

* https://git.kernel.org/pub/scm/libs/ieee1394/libhinawa.git/

Secondly, the FireWire stack includes a PCM device driver for 1394 OHCI
hardware, This change modernizes the driver by managed resource (devres)
framework.

Lastly, the rest of change is bug fixes for firewire-net and firewire-core.

----------------------------------------------------------------
Takashi Sakamoto (24):
      firewire: add KUnit test to check layout of UAPI structures
      firewire: cdev: add new version of ABI to notify time stamp at request/response subaction of transaction
      firewire: cdev: add new event to notify request subaction with time stamp
      firewire: cdev: implement new event to notify request subaction with time stamp
      firewire: core: use union for callback of transaction completion
      firewire: core: implement variations to send request and wait for response with time stamp
      firewire: cdev: code refactoring to operate event of response
      firewire: cdev: add new event to notify response subaction with time stamp
      firewire: cdev: implement new event to notify response subaction with time stamp
      firewire: cdev: code refactoring to dispatch event for phy packet
      firewire: cdev: add new event to notify phy packet with time stamp
      firewire: cdev: implement new event relevant to phy packet with time stamp
      firewire: fix build failure due to missing module license
      firewire: fix warnings to generate UAPI documentation
      firewire: ohci: use devres for memory object of ohci structure
      firewire: ohci: use devres for PCI-related resources
      firewire: ohci: use devres for MMIO region mapping
      firewire: ohci: use devres for misc DMA buffer
      firewire: ohci: use devres for requested IRQ
      firewire: ohci: use devres for list of isochronous contexts
      firewire: ohci: use devres for IT, IR, AT/receive, and AT/request contexts
      firewire: ohci: use devres for content of configuration ROM
      firewire: ohci: release buffer for AR req/resp contexts when managed resource is released
      firewire: core: obsolete usage of GFP_ATOMIC at building node tree

Zhang Shurong (1):
      firewire: net: fix use after free in fwnet_finish_incoming_packet()

 drivers/firewire/.kunitconfig       |   4 +
 drivers/firewire/Kconfig            |  16 +++
 drivers/firewire/Makefile           |   3 +
 drivers/firewire/core-cdev.c        | 252 +++++++++++++++++++++++++++---------
 drivers/firewire/core-device.c      |   2 +-
 drivers/firewire/core-topology.c    |   2 +-
 drivers/firewire/core-transaction.c |  93 +++++++++----
 drivers/firewire/core.h             |   7 +
 drivers/firewire/net.c              |   6 +-
 drivers/firewire/ohci.c             | 191 +++++++++++----------------
 drivers/firewire/uapi-test.c        |  89 +++++++++++++
 include/linux/firewire.h            |  82 +++++++++++-
 include/uapi/linux/firewire-cdev.h  | 178 +++++++++++++++++++++----
 13 files changed, 694 insertions(+), 231 deletions(-)
 create mode 100644 drivers/firewire/.kunitconfig
 create mode 100644 drivers/firewire/uapi-test.c
