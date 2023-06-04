Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D9A72172B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 15:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjFDNBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 09:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFDNBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 09:01:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CEDCA;
        Sun,  4 Jun 2023 06:01:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6570261CF4;
        Sun,  4 Jun 2023 13:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E98C433EF;
        Sun,  4 Jun 2023 13:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685883701;
        bh=9ntLwc1z7S2sfr5YdN4prD8/9ngZb3YwUtL5tMsSEP4=;
        h=Date:From:To:Cc:Subject:From;
        b=ZikrEU2XIPxwurbgug8kwim46czK0x1PhPMNKgLXAkzLLIpYpQIgYFtIQqxHmoAoc
         djCjqOqURexApmhuR82y9HVw1P6+frrN0E39bUY/edCzQ/yETD7+egdyUCzol596zs
         Bimv4LeYsOFH7PDBgS/Qqdwf9ELy/Mo7XTT1UqXSYkuMjO7iMtC7V2vnKy1sOaxNjx
         /oSyTUfrbJe6sRVNkM0Yb9KSd6ZRUwF2JfSYHoKw8AcSybDXUj0FhmC7WJHyisAe9V
         tdM43oK++94TV4IZt1Xoyee8jNkMfzDal/+80DZewn/pfjhjMeoWRdEQe8m6hkuAQ0
         bdbRLecIo7Kcw==
Date:   Sun, 4 Jun 2023 14:01:37 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.4-rc5] media fixes
Message-ID: <20230604140137.1f160782@sal.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.4-4

For some driver fixes:
- a regression fix at verisilicon driver;
- uvcvideo: don't expose unsupported video formats to userspace;
- camss-video: don't zero subdev format after init;
- mediatek: some fixes for 4K decoder formats;
- fix a Sphinx build warning (missing doc for client_caps);
- some fixes for imx and atomisp staging drivers;

And two CEC core fixes:
- don't set last_initiator if tx in progress
- disable adapter in cec_devnode_unregister

Regards,
Mauro

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.4-5

for you to fetch changes up to 899e373ef0b0d3f1c2712a849f019de4f46bfa02:

  Merge tag 'v6.4-rc4' into v4l_for_linus (2023-06-04 13:50:38 +0100)

----------------------------------------------------------------
media fixes for v6.4-rc5

----------------------------------------------------------------
Benjamin Gaignard (1):
      media: verisilicon: Additional fix for the crash when opening the driver

Hans Verkuil (4):
      media: cec: core: disable adapter in cec_devnode_unregister
      media: cec: core: don't set last_initiator if tx in progress
      media: staging: media: atomisp: init high & low vars
      media: staging: media: imx: initialize hs_settle to avoid warning

Laurent Pinchart (1):
      media: uvcvideo: Don't expose unsupported formats to userspace

Mauro Carvalho Chehab (2):
      Merge tag 'v6.4-rc2' into v4l_for_linus
      Merge tag 'v6.4-rc4' into v4l_for_linus

Pin-yen Lin (1):
      media: mediatek: vcodec: Only apply 4K frame sizes on decoder formats

Tomi Valkeinen (1):
      media: v4l2-subdev: Fix missing kerneldoc for client_caps

Vaishnav Achath (1):
      media: v4l2-mc: Drop subdev check in v4l2_create_fwnode_links_to_pad()

Yassine Oudjana (1):
      media: camss: camss-video: Don't zero subdev format again after initialization

 drivers/media/cec/core/cec-adap.c                        |  8 ++++++--
 drivers/media/cec/core/cec-core.c                        |  2 ++
 drivers/media/cec/core/cec-priv.h                        |  1 +
 .../platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c   |  3 +++
 drivers/media/platform/qcom/camss/camss-video.c          |  1 -
 drivers/media/platform/verisilicon/hantro_v4l2.c         |  6 ++++--
 drivers/media/usb/uvc/uvc_driver.c                       | 16 +++++++++++-----
 drivers/media/v4l2-core/v4l2-mc.c                        |  3 +--
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c       |  4 ++--
 drivers/staging/media/imx/imx8mq-mipi-csi2.c             |  2 +-
 include/media/v4l2-subdev.h                              |  1 +
 11 files changed, 32 insertions(+), 15 deletions(-)

