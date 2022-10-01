Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637D45F19FA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 07:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJAFMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 01:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJAFMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 01:12:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0677111471F;
        Fri, 30 Sep 2022 22:12:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EF49601D0;
        Sat,  1 Oct 2022 05:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A809DC433C1;
        Sat,  1 Oct 2022 05:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664601169;
        bh=lFMhny3seUl8jER9qTxIz0tqzb7aJpt16hJDo4KNXgo=;
        h=Date:From:To:Cc:Subject:From;
        b=bcckoXcDZubey+Eu3bwxpESluFniHj+SEn/oVbYZVxpSsuxswfhnW7VdnYzWszeuA
         eBRjxvlg5fa3EeLw4auZAxc33hZkqL/0tk+YSqFkXantnw5UMt1TXkNQldtgtQ7RjK
         h81HzikmeE9q0xBekfXlklQYHE8szbZf9R5XseYCplQ1cZkAlY/4AcPvFtG61NLqXJ
         L8dY8L7Fjqzi92xxoIOKTuVLIKC6AmQy2C1yjD/lbrozyYzBXTb4FFultFWeTWVnCe
         /dgq6w8YLPoutd5X7lPNE4KhsddsM9B2g59q+VJljBIAB4F3aQrwED7JYx1PVYTr/K
         Yj+9grx3lVblQ==
Date:   Sat, 1 Oct 2022 07:12:45 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.0] media fixes
Message-ID: <20221001071245.6720babc@coco.lan>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.0-1


For:
  - some fixes at the v4l2 ioctl handler logic;
  - a fix for an out of bound access at DVB videobuf2 handler;
  - 3 driver fixes (rkvdec, mediatek/vcodek and uvcvideo).

Regards,
Mauro

---

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.0-1

for you to fetch changes up to 3a99c4474112f49a5459933d8758614002ca0ddc:

  media: rkvdec: Disable H.264 error detection (2022-09-27 10:24:44 +0200)

----------------------------------------------------------------
media fixes for v6.0-rc8

----------------------------------------------------------------
Hangyu Hua (1):
      media: dvb_vb2: fix possible out of bound access

Hans Verkuil (2):
      media: v4l2-compat-ioctl32.c: zero buffer passed to v4l2_compat_get_a=
rray_args()
      media: v4l2-ioctl.c: fix incorrect error path

Nicolas Dufresne (1):
      media: rkvdec: Disable H.264 error detection

N=C3=ADcolas F. R. A. Prado (1):
      media: mediatek: vcodec: Drop platform_get_resource(IORESOURCE_IRQ)

Ricardo Ribalda (1):
      media: uvcvideo: Fix InterfaceProtocol for Quanta camera

 drivers/media/dvb-core/dvb_vb2.c                   | 11 +++++++++
 .../platform/mediatek/vcodec/mtk_vcodec_enc_drv.c  |  9 +++-----
 drivers/media/usb/uvc/uvc_driver.c                 |  2 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      |  2 ++
 drivers/media/v4l2-core/v4l2-ioctl.c               | 26 ++++++++++--------=
----
 drivers/staging/media/rkvdec/rkvdec-h264.c         |  4 ++--
 6 files changed, 31 insertions(+), 23 deletions(-)

