Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B197867B228
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjAYMDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjAYMDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:03:10 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BFB568A2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:03:09 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 53C255C0099;
        Wed, 25 Jan 2023 07:03:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 25 Jan 2023 07:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1674648188; x=
        1674734588; bh=hZ7RuQIyW+uO5lxrWZkD8RA7gqZCCqok8mXl9QhbwOw=; b=I
        MW2g/5LyJYS+42oOzu3Cj9Vcwc/3YoVkBS3xgk4gAQOxYN9ikRFFIZnDhrbAgZ9r
        njPluiEfvCP6sxJbJzjXIvX6myT/CN7ewe7MrsUhP0MPmPnSuAgjojZ/+VxMYY9x
        EMEsMubc/Q8DingX9wY0glifnWMbXKTgxSmOttanpx1e3ASQnf9cXVeTLBHHv0DO
        mRKNl610cdv6mzlG4TAehH+wpPdcGv7vuHssokKbRm3awZ/ut4E8V2V5IBlGuX4e
        s4gsyFabmMPVJWpO5hKGsPZTTH6waTMYBLsdc91k3VMd9chMm/3cKjZIinJYA1ra
        buHX0iCDrQxljOqOZmtow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674648188; x=1674734588; bh=hZ7RuQIyW+uO5
        lxrWZkD8RA7gqZCCqok8mXl9QhbwOw=; b=FS2mTxpAKmYyZPsbtyJj7pIVmTG/1
        X+Nfmzm7cZBuTXTHOx4dghUqSYK84Blmh2mAb8kdJlAgqGc0koX3eQvjLMKA8p1l
        9WB/ZU0DOAGKCSrWf75BdTe0sXjjoWpN1XA7bl06HrTKf92hGy69ffuYALH+3dz5
        IIrnTI6/BIGyeY4aS4BXqlOtvmNQoWpWBG6C1X3q0MrVLJzMCO2h49Uc1RXqQAsH
        kijKmPN3/eklgPuiE2KydIP+UyITiIQNfUdKVF6qcXA3S9/L2EFzIG2b2Yq0HNhr
        VM4vVvwwAT0GPOR0rk3keBOUdu4pBCZ5O82H46MuqpafRLWJ7gNwUA9Rw==
X-ME-Sender: <xms:fBrRY9Ku1erhEDclvnmlCl1NZVFV1Q5e5gFuWu8v1SdDVn7EBaQCsQ>
    <xme:fBrRY5I3moWgK4chzyD3HezEDKQh_9loBA8srodJjXUcuptLhtbgAb53tBbLvITVj
    7ihBEFG37m-B_ZMcD0>
X-ME-Received: <xmr:fBrRY1stjz6-jPczH2zd9ECU1S7KbHZlQ0uc7Pn_6YNy7et7b8d972cLb9Xqw6OFzKYKFkN4GFWOkKpSUr0SiIPGzWfstiyY8jDPhW6clFuXe3k7EJ1cg8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:fBrRY-Z9fURJqtK9eV655C7JSN8zrxcOcA8ROgJoPShmnlmHc2nXxw>
    <xmx:fBrRY0YD16jaVmjIbn9xG0CLhTl1NVyDAWfxxessGrj3i5XAMnEjAA>
    <xmx:fBrRYyDl60nHRKYsyDRHeqMe0CaGSf6Ppn2J5ULK_B8fkHaqAOvOOg>
    <xmx:fBrRYznzqP6WuplouZ9GG2Pi-oXXOtgVR4MmGCyu_iMtEJxjInWIQA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 07:03:07 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: [PATCH 01/11] firewire: cdev: add new version of ABI to notify time stamp at request/response subaction of transaction
Date:   Wed, 25 Jan 2023 21:02:51 +0900
Message-Id: <20230125120301.51585-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230125120301.51585-1-o-takashi@sakamocchi.jp>
References: <20230125120301.51585-1-o-takashi@sakamocchi.jp>
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

This commit adds new version of ABI for future new events with time stamp
for request/response subaction of asynchronous transaction to user
space.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c       | 1 +
 include/uapi/linux/firewire-cdev.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 2c16ee8fd842..88c8b5fac5e5 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -43,6 +43,7 @@
 #define FW_CDEV_VERSION_EVENT_REQUEST2		4
 #define FW_CDEV_VERSION_ALLOCATE_REGION_END	4
 #define FW_CDEV_VERSION_AUTO_FLUSH_ISO_OVERFLOW	5
+#define FW_CDEV_VERSION_EVENT_ASYNC_TSTAMP	6
 
 struct client {
 	u32 version;
diff --git a/include/uapi/linux/firewire-cdev.h b/include/uapi/linux/firewire-cdev.h
index 92be3ea3c6e0..621ee56d11b5 100644
--- a/include/uapi/linux/firewire-cdev.h
+++ b/include/uapi/linux/firewire-cdev.h
@@ -457,6 +457,7 @@ union fw_cdev_event {
  *  5  (3.4)     - send %FW_CDEV_EVENT_ISO_INTERRUPT events when needed to
  *                 avoid dropping data
  *               - added %FW_CDEV_IOC_FLUSH_ISO
+ *  6  (6.3)     - added some event for subactions of asynchronous transaction with time stamp
  */
 
 /**
-- 
2.37.2

