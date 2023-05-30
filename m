Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47144716EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjE3Ubl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjE3Ubi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:31:38 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD713F7;
        Tue, 30 May 2023 13:31:36 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E6A0D3200906;
        Tue, 30 May 2023 16:31:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 30 May 2023 16:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1685478693; x=1685565093; bh=mBn4BtTIuaSR4k6kR5OhxVvo4
        bxwgD7eI3h6KSrS77Y=; b=OV5XCQmm52GKorJgytjmRhmDfFno0a/Pgi7UWpDrL
        hmac3z3F+t+j3QvIAwMR4SXWsjE00Dk8J2pl4/bzWVkMLVwTCqNUhcwwpYQQyRID
        prcGg+R9vE6c37cpOzefITiocc0xsV6Klz2vTQHMOb7Bq4dZxG0KjFsbkZlmP2KN
        4UGnkgg5UwPtIm1WL0u1FQq0kfl3kpp3phUtHwN0psepWye8YFq97zYVHkIfuPNZ
        XwdZ5Q15Y7S6lVoiCRL7QUWcNMt4WbaKMKTLoIV+vAoQTKxR0jmJ6p2DjVSE/Nvp
        eo3yhydz4SncBJZ1C9N20dkMonTC3o23ffZYDb/MYwasA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685478693; x=1685565093; bh=m
        Bn4BtTIuaSR4k6kR5OhxVvo4bxwgD7eI3h6KSrS77Y=; b=AsrK9fySZ3AZJANui
        7+TxVT0aD6Mmt+OOYUCS1xBbGC40JB4t9Zr57FAhjpU9BbocgsFPZv3WNzEHoyiw
        T9iw4+MxlfR5NR9KNQD77hE9wDHDsXxa0IM+szCQBqgjx9Jzd+6H0dn8mz8XkxbN
        LRLDdd58fW+Zs20WpFjccSO76SGJy2Ryqfg87kJHl9jRUt5dPpNasxKX+RAc4T1L
        bXo0Gg/hA2d6xc6Bcd5Hr+l3xrVftdl7twbjEh52cjWu0wYiR2RsWqfKFx7vZ+4X
        8esMxX3l4CZV0yTt6g7boPGvPu+uu0wNvJUK9FRrodoQFrKkOkYS+Z9UWiOdk64K
        9dIMg==
X-ME-Sender: <xms:JV12ZKw_sleDe0CYhkOy1rfxDsKjpyELd-fxjymHbgcgq5lekwsKZA>
    <xme:JV12ZGTAn57_8e1GFIsXL0ysKh0FpixwJKQ-TddPSbdxYp9ycPOiTVwaNOrltt2ad
    ug8Bk31vxxSZPs>
X-ME-Received: <xmr:JV12ZMUabxwRmIasWNcUfFJi1r8ayOF9Gz99yU6V6s-nhGY0G9ciErqgnlwdmTNxI5uZ2MoKV6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhephfeggfeiiedtieejgedutdekgfet
    geehheegteekvefhfefgudehtdevleegueegnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:JV12ZAjQ2rV9YCzr3z2bw2d41_MyNZJp_kvJGEi-trj6PoDKHYaXqQ>
    <xmx:JV12ZMCHtfgQyZp2PZhX45i91mJDIhD_ys-ao3poTncETHRblZjImQ>
    <xmx:JV12ZBLpJyOl-upuH58Tw1NYpbK7gxAD5Bx9jCgXSTOlNIObWkK6QA>
    <xmx:JV12ZKAryiWCZk5crUODpJpFTwj0sB-WzC-8b4F9y9v0UR85ql4CiA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 16:31:32 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 00/16] Diskseq support in loop, device-mapper, and blkback
Date:   Tue, 30 May 2023 16:31:00 -0400
Message-Id: <20230530203116.2008-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This work aims to allow userspace to create and destroy block devices
in a race-free way, and to allow them to be exposed to other Xen VMs via
blkback without races.

Changes since v1:

- Several device-mapper fixes added.
- The diskseq is now a separate Xenstore node, rather than being part of
  physical-device.
- Potentially backwards-incompatible changes to device-mapper now
  require userspace opt-in.
- The code has been tested: I have a block script written in C that uses
  these changes to successfully boot a Xen VM.
- The core block layer is almost completely untouched.  Instead of
  exposing a block device inode directly to userspace, device-mapper
  ioctls that create a block device now return that device's diskseq.
  Userspace can then use that diskseq to safely open the device.
  Furthermore, ioctls that operate on an existing device-mapper device
  now accept a diskseq parameter, which can be used to prevent races.

There are a few changes that make device-mapper's table validation
stricter.  Two of them are clear-cut fixes for memory safety bugs: one
prevents a misaligned pointer dereference in the kernel, and the other
prevents pointer arithmetic overflow that could cause the kernel to
dereference a userspace pointer, especially on 32-bit systems.  One
fixes a double-fetch bug that happens to be harmless right now, but
would make distribution backports of subsequent patches unsafe.  The
remaining fixes prevent totally nonsensical tables from being accepted.
This includes parameter strings that overlap the subsequent target spec,
and target specs that overlap the 'struct dm_ioctl' or each other.  I
doubt there is any userspace extant that generates such tables.

Finally, one patch forbids device-mapper devices to be named ".", "..",
or "control".  Since device-mapper devices are often accessed via
/dev/mapper/NAME, such names would likely greatly confuse userspace.  I
consider this to be an extension of the existing check that prohibits
device mapper names or UUIDs from containing '/'.

Demi Marie Obenour (16):
  device-mapper: Check that target specs are sufficiently aligned
  device-mapper: Avoid pointer arithmetic overflow
  device-mapper: do not allow targets to overlap 'struct dm_ioctl'
  device-mapper: Better error message for too-short target spec
  device-mapper: Target parameters must not overlap next target spec
  device-mapper: Avoid double-fetch of version
  device-mapper: Allow userspace to opt-in to strict parameter checks
  device-mapper: Allow userspace to provide expected diskseq
  device-mapper: Allow userspace to suppress uevent generation
  device-mapper: Refuse to create device named "control"
  device-mapper: "." and ".." are not valid symlink names
  device-mapper: inform caller about already-existing device
  xen-blkback: Implement diskseq checks
  block, loop: Increment diskseq when releasing a loop device
  xen-blkback: Minor cleanups
  xen-blkback: Inform userspace that device has been opened

 block/genhd.c                       |   1 +
 drivers/block/loop.c                |   6 +
 drivers/block/xen-blkback/blkback.c |   8 +-
 drivers/block/xen-blkback/xenbus.c  | 147 ++++++++--
 drivers/md/dm-core.h                |   2 +
 drivers/md/dm-ioctl.c               | 432 ++++++++++++++++++++++------
 drivers/md/dm.c                     |   5 +-
 include/linux/device-mapper.h       |   2 +-
 include/uapi/linux/dm-ioctl.h       |  67 ++++-
 9 files changed, 551 insertions(+), 119 deletions(-)

-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

