Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DA071488C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjE2LeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjE2LeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:34:17 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9002CF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:34:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4B5F832004CE;
        Mon, 29 May 2023 07:34:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 29 May 2023 07:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685360051; x=1685446451; bh=1f
        uN5P032DVe47O4bTEIAt4bBcXabCWszDOBsC3t9E4=; b=suWnMOA3yiBeHJaQqg
        4YCtGlE0yS+VOjxrJh/ZIsAJ2HBWGvM31zaJJ7vUbRMysuswLJt4e/Ld/87Ol3a3
        Q4qYehyQGwkaozOBsZ8IXCfU/I4Q0zDPNO7y4qworuUSpqYe01AYMemSfPUFYeCI
        +YZT254kbuZQq6K69DMekb0OisWAWr1SJVengn+VkdNMvve7XyXvNebp7XkuHxlQ
        G8oQzDu8BS53/cH5DKj6trb75gAa8qAx9x7aTKCorh71d2gLLaDp66Vt0gcbRAWr
        D/9XlOJn93DYZgV0h688rgN2gOuTgi3rbJEt+Evz2k7ivYauCiTK/C7ww3o/yIdE
        OUSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685360051; x=1685446451; bh=1fuN5P032DVe4
        7O4bTEIAt4bBcXabCWszDOBsC3t9E4=; b=lL21VbLAfTchY2EgGoCH679I/DICm
        yvNJpttIAFPZsamZOtMMXY6qNqur1FFYuTSV4AH21h5aGW39j+HShlhZFEWt/X21
        RRtv+jDb7hpR16ursFBevK5qaHoc6NElOCHDbGJrDq/UWNght+s66knBKWsGaIr6
        MuukoFZinDTRi36HGwrQCJAQRzq1V8k3YiBJDkF+3kSQBc5h63mgcgLD1rHoer7N
        Ax3uG/H2am5N300NjMLznh7/5b2Is9SMAKpNcbKMWrWXiRapMXCF3xIcQA3XUpOr
        j0tJAe+U3e/hp6uhrQlR+55qY4sGxjHKUOLHJ3X7saqNmL/aihGnubDNw==
X-ME-Sender: <xms:s410ZD0Gi7W3UiRaz3iOs5S99pkVzz_QgSULBEuwmRKVuZ8KCHPzYg>
    <xme:s410ZCGS_iHxzqZmX1pHKiCod3LOrLmHYXSWfpqV53_6IBXEPxuKz4drqVA0XRlVC
    -0rnoStEtrZZvfpnGw>
X-ME-Received: <xmr:s410ZD42enwya_5_wA2gt7ObgyB_6lMOo60zKoHCVfaXOTa_YdiYXv-RZiVE_42FfupnVgT-Z4MBd1VY8gx7b30uLj53l1WkcU7geFz-u6hU0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeggfehleehje
    eileehveefkefhtdeffedtfeeghfekffetudevjeegkeevhfdvueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:s410ZI040NZjDFZXbHWmtRJfrZSrM2mwBaHFFWoKgl3FV2a_YosRiA>
    <xmx:s410ZGGGti2U46S1KnK5JPC9bcvbLCqgWChUHMv2PbCKyFWbl2tfvg>
    <xmx:s410ZJ_5xPNyjkRl6nDpO5-TKc_cQ4GS6UGkOBR0Zis7xTFTPC482g>
    <xmx:s410ZIPort7fhJJN1U8QheEA-BOBBUqO0hoN1ISU9TR-PDMRZyWlqw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 May 2023 07:34:10 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     kunit-dev@googlegroups.com
Subject: [PATCH v3 00/12] firewire: deliver hardware time stamp for asynchronous transaction
Date:   Mon, 29 May 2023 20:33:54 +0900
Message-Id: <20230529113406.986289-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: kunit-dev@googlegroups.com

Hi,

This patchset is revised version of the previous one[1], I realized that
it included wrong version number of Linux kernel. The new series
includes changes just for it.


Copied from the initial cover letter:

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

[1] https://lore.kernel.org/lkml/20230525101625.888906-1-o-takashi@sakamocchi.jp/

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

