Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9873CD60
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 01:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjFXXKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 19:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjFXXJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 19:09:58 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF261710
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 16:09:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id BCE7C3200065;
        Sat, 24 Jun 2023 19:09:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 24 Jun 2023 19:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687648194; x=1687734594; bh=LsDkS9pGWUmtwQ/it8iQoRg4trvNKXyKWbw
        xvK6Qf4Y=; b=Z311eWtdfZZdzMVJY+cCZ4lLbj3VY+FRSq2D2T0UIYzSufoOb9p
        k3+6s1l4CdzztiC0Gwlxw00CTb7nhlby9pdXzU5sWF06hi2A7WRUXu1jC7RTqniZ
        Y06oxQcRl5qvBoZois5eF5O9rlaZP/5zDps3kJsuDJQJ2BLOKdve6VJWv1fcNDGh
        vP1HfwuEIQUCsEFy7ZzuBQIfWKWW473SxPyxEXLIcKh0w2OQ7Fk7ZI+34YCxfV71
        CXRHHVZWDxXRamyH3MWhAe4m3dR17+aHxdKk9a6gG6MMcmhrn3vhz+ITPls2Mk72
        qdpRdnwL1kopuAgGJcjL/CL4nugRriUeK0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687648194; x=1687734594; bh=LsDkS9pGWUmtw
        Q/it8iQoRg4trvNKXyKWbwxvK6Qf4Y=; b=BeuHP9JePZWfv1KjmffHIRYH+8JE0
        v7HZyAmM0LZj3IswHZc2R1rVlldK02aRQ3RTI5UPXadIG23OS4df7kg35HFB3M2l
        kv9Elk+8dtLR7yZ1UH7Fv8+gzyjYGDIYJXrWcpe9ZXpNjt5kvyzLKPdITL9M8yHN
        3SSJt9wuoyWo2UUB9s/9EzDcB1ZwmTnpkTkI/sL/fF6rura8j4fGCwZzRgIsjNsw
        wrIqBB3SjR4dG9wohZns/1gVofR/hNdyKsqX/o5hoaeNXZdTlyFuEXvh76gsJf75
        FievnyafQ/NipfFKo4vUVSGxCWIxr78IS0E6rpl6/+4uiep/jYgnEJc9w==
X-ME-Sender: <xms:wneXZOzpDMXyHB5nNGihQDlwEvm80EBrOvlC7u8oELUKq-ClfMJzsw>
    <xme:wneXZKS9LxYIa9-xfvtRxMt6OM-kuGBdL8LsQFY_EmJqoyji-fY9IxSbm0TiZhfHL
    Tv0d-eq0TN7a14>
X-ME-Received: <xmr:wneXZAVvRVlejMu023IVEBvLIgwq7HKeE6-hP_ws8zk4QswXOjZP5OiFHLzRNOeZg191CheYFpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegkedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgvmhhiucfo
    rghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhnghhslh
    grsgdrtghomheqnecuggftrfgrthhtvghrnhepvdefgeekvdekgfffgeekhfeijedtffek
    hefhleehfeejueetgfelgefgtdevieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgr
    sgdrtghomh
X-ME-Proxy: <xmx:wneXZEgvzlc8nVYPOhk5f79G5koevQvdF9XTFkPt7YtRffBoAVRdaQ>
    <xmx:wneXZACW6ONEW_NBXszyPtQivp26sWwGhzAyC2mvLaeoRmEytclsTA>
    <xmx:wneXZFJ6sskoNJVl1UxJa9EJPJGHvT0uE5dBj_PfNP1HaAx1Z0v7qQ>
    <xmx:wneXZDNj8EA4ceoM3u9pdPZMiVmQ9XlubqorahAvGwxnbj62_01Utw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jun 2023 19:09:53 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Diskseq support in device-mapper
Date:   Sat, 24 Jun 2023 19:09:43 -0400
Message-ID: <20230624230950.2272-1-demi@invisiblethingslab.com>
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

This work aims to allow userspace to create and destroy device-mapper
devices in a race-free way.

Changes since v1:

- Potentially backwards-incompatible changes to device-mapper now
  require userspace opt-in.
- The code has been tested: I have a block script written in C that uses
  these changes to successfully boot a Xen VM.
- The core block layer is completely untouched.  Instead of exposing a
  block device inode directly to userspace, device-mapper ioctls that
  create a block device now return that device's diskseq.  Userspace can
  then use that diskseq to safely open the device.  Furthermore, ioctls
  that operate on an existing device-mapper device now accept a diskseq
  parameter, which can be used to prevent races.

Demi Marie Obenour (4):
  dm ioctl: Allow userspace to opt-in to strict parameter checks
  dm ioctl: Allow userspace to provide expected diskseq
  dm ioctl: Allow userspace to suppress uevent generation
  dm ioctl: inform caller about already-existing device

 drivers/md/dm-core.h          |   2 +
 drivers/md/dm-ioctl.c         | 351 ++++++++++++++++++++++++++++------
 drivers/md/dm.c               |   5 +-
 include/linux/device-mapper.h |   2 +-
 include/uapi/linux/dm-ioctl.h |  90 ++++++++-
 5 files changed, 382 insertions(+), 68 deletions(-)

-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

