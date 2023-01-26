Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D38667C390
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbjAZDeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbjAZDeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:34:14 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F283C457F2;
        Wed, 25 Jan 2023 19:34:08 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D81D35C05B2;
        Wed, 25 Jan 2023 22:34:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 25 Jan 2023 22:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1674704045; x=1674790445; bh=3zrqCCWozEhlE3QduurTIaTnuK8HrtZwnOI
        /8OAKWhk=; b=itbOC/cn4y/B40q8XnHC36ZK342HhUiZQWzWRilS+UaShH1NhZp
        1PIxe43uByehOYWScDldnSB68SutvMRyXl/4yQ7STcrYFsYiZxDIdibVrkfQd59y
        smuG5Op6lc6AP91KJTBaEkXF4J+7yg3MUFiilIMxFP0EiZxs/I016ZoFZFI2tBci
        9w7zB9ntKgF7oe9mhUDMTKz2pnLewxPQUN2Izy4WUrdvWwVGWHskqPXAtNoOiop+
        XDLHC8lPhPgqa6XJ8JtDKVoBXB5MRkNV9+BowGxC0SWn5O9gr1KxGin24Vs8sqN+
        1bBzr/xYHNkhKOCWtfqrdtjly7Jh0E7AK8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674704045; x=1674790445; bh=3zrqCCWozEhlE
        3QduurTIaTnuK8HrtZwnOI/8OAKWhk=; b=oxKex1i2j/0Mco60GksvTldYC42Dd
        pdUMjSpUSOTpb9z1QAY+WUjYg6ksLLQK2uzbQKUAo1Zg2C+sHtIXBCpAnIbFsAjn
        4+0oxB0u3bOM25qOS+bHQra+pbeecgVar02jsJ9u+jvTbdz4WMSYw49Jb34aMEYM
        eA7qAkSX54AjjyHdGvu4vnqfb//Q+JQdEJJN4zQg7/KwK2oz0+Y7dZaj6f58L7TT
        hs5nF3d73B2HTS3diqakESrrVHJYBme1t58O9mNY2dfhdL+yq37BpqHFilxmkj3P
        N3TdP1ZHcFZtWcQrp9Tc+rIw7+GJR9krLEHVjqwyH+TQS+i2g8sdlFxCQ==
X-ME-Sender: <xms:rfTRY6725xmw3M9_wy6VAcPGHbcrIDAAXALC_ezzqGgu8_uRhoPv0w>
    <xme:rfTRYz54wgPmc9J-m65mihdjNty8KrpH3dOxqxrzqbIl5I_4wleBtSzykLUzL999H
    yEK2Y9VkVevVew>
X-ME-Received: <xmr:rfTRY5c-XeYocmJVDOF_vnw6pNbx_lwfvTcuwuxZ1xAZTtge5V4IEydC9RVAweE53XptqUbyW9xj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeffvghmihcu
    ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefhgefgieeitdeijeeguddtkefgteeg
    heehgeetkeevhfefgfduhedtveelgeeugeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhl
    rggsrdgtohhm
X-ME-Proxy: <xmx:rfTRY3K8BsaR6SikC5jT7-f3d9e22OHeqXhkgePMrLn0y58UnAVNCw>
    <xmx:rfTRY-JsiC-CmyH3JqmtndM5ovAjIocOp_H5Vnz5xbocvmIcvUB5Vw>
    <xmx:rfTRY4wEKKzvSMjPN6rg_jb98hKZEXW7biJaskmWaZ9ourLFDq6IKQ>
    <xmx:rfTRY9_6RGw9FBSqSFdBrKQEovNBIAL-_eHatj1IbfsXY2Q7MP1mdQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 22:34:04 -0500 (EST)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, dm-devel@redhat.com
Subject: [RFC PATCH 0/7] Allow race-free block device handling
Date:   Wed, 25 Jan 2023 22:33:52 -0500
Message-Id: <20230126033358.1880-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This work aims to allow userspace to create and destroy block devices
in a race-free and leak-free way, and to allow them to be exposed to
other Xen VMs via blkback without leaks or races.  It’s marked as RFC
for a few reasons:

- The code has been only lightly tested.  It might be unstable or
  insecure.

- The DM_DEV_CREATE ioctl gains a new flag.  Unknown flags were
  previously ignored, so this could theoretically break buggy userspace
  tools.

- I have no idea if I got the block device reference counting and
  locking correct.

Demi Marie Obenour (7):
  block: Support creating a struct file from a block device
  Allow userspace to get an FD to a newly-created DM device
  Implement diskseq checks in blkback
  Increment diskseq when releasing a loop device
  If autoclear is set, delete a no-longer-used loop device
  Minor blkback cleanups
  xen/blkback: Inform userspace that device has been opened

 block/bdev.c                        |  77 +++++++++++--
 block/genhd.c                       |   1 +
 drivers/block/loop.c                |  17 ++-
 drivers/block/xen-blkback/blkback.c |   8 +-
 drivers/block/xen-blkback/xenbus.c  | 171 ++++++++++++++++++++++------
 drivers/md/dm-ioctl.c               |  67 +++++++++--
 include/linux/blkdev.h              |   5 +
 include/uapi/linux/dm-ioctl.h       |  16 ++-
 8 files changed, 298 insertions(+), 64 deletions(-)

-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
