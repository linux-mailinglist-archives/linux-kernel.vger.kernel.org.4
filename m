Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E75D707BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjERI1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjERI1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:27:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7E110D9;
        Thu, 18 May 2023 01:27:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C2960BED;
        Thu, 18 May 2023 08:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786A8C433D2;
        Thu, 18 May 2023 08:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684398424;
        bh=qlEedEz1QRXOaDC6eN3Z12rGZNbHc6nQNHx8J4uRuaw=;
        h=Date:From:To:Cc:Subject:From;
        b=nuOJa5VnFHFPzvNcKg68FykF/x1zO4OohwGTexhhcafXaHl+qLz9nwy5j/5nRFFNd
         jU+KfzsULMwBQZCg33WFpWdg7WKUGYe8JOFuiUWzEXIEBEEa4zM+BQxBFdPQsIX3sJ
         0N8NL53SmN3finXcnpx6D1e1x2NCe4wdao9abBM5wHQ2mCL6+3RCOuLUdkALZmnh8x
         0TpK4H1VmSvB/dRj2/tSzemmRvNqo5UZbt/CUKZx+xGMVyK5GkDCxQXa76eVx05GWh
         IdGvSMMgKojBI0JbGqb3xpyizi4czcvgMPXdDVzXqfQRENOwQy0gvTr1wI+/RUvNom
         7zI2T96RQnB1w==
Date:   Thu, 18 May 2023 09:26:59 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.4-rc3] media fixes
Message-ID: <20230518092659.4a4de8ea@sal.lan>
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
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.4-3

For several fixes at the dvb core and drivers:

  - Address some UAF and null pointer de-reference conditions at DVB core;
  - Fix kernel runtime warning for blocking operation in wait_event*() at dvb core;
  - Fix a size write bug at DVB conditional access core;
  - Address a bug at the dvb demux continuity counter debug check logic;
  - a couple randconfig build fixes at pvrusb2 and mn88443x drivers;
  - fix a memory leak at ttusb-dec driver;
  - a fix at netup_unidvb probe-time error check logic;
  - dw2102 will better handle an error check if it can't retrieve DVB MAC address.

Regards,
Mauro

---

The following changes since commit ae3c253f595b31ff30d55b4c50b4470e56bc4e0d:

  media: platform: mtk-mdp3: work around unused-variable warning (2023-05-08 12:11:25 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.4-3

for you to fetch changes up to 280a8ab81733da8bc442253c700a52c4c0886ffd:

  media: dvb-core: Fix use-after-free due to race condition at dvb_ca_en50221 (2023-05-14 16:04:48 +0100)

----------------------------------------------------------------
media fixes for v6.4-rc3

----------------------------------------------------------------
Arnd Bergmann (1):
      media: pvrusb2: fix DVB_CORE dependency

Duoming Zhou (1):
      media: netup_unidvb: fix use-after-free at del_timer()

Hyunwoo Kim (5):
      media: ttusb-dec: fix memory leak in ttusb_dec_exit_dvb()
      media: dvb-core: Fix use-after-free on race condition at dvb_frontend
      media: dvb-core: Fix use-after-free due on race condition at dvb_net
      media: dvb-core: Fix use-after-free due to race at dvb_register_device()
      media: dvb-core: Fix use-after-free due to race condition at dvb_ca_en50221

Krzysztof Kozlowski (1):
      media: mn88443x: fix !CONFIG_OF error by drop of_match_ptr from ID table

Takashi Iwai (1):
      media: dvb-core: Fix kernel WARNING for blocking operation in wait_event*()

Wei Chen (6):
      media: dvb-usb: az6027: fix three null-ptr-deref in az6027_i2c_xfer()
      media: dvb-usb-v2: ec168: fix null-ptr-deref in ec168_i2c_xfer()
      media: dvb-usb-v2: ce6230: fix null-ptr-deref in ce6230_i2c_master_xfer()
      media: dvb-usb: digitv: fix null-ptr-deref in digitv_i2c_xfer()
      media: dvb-usb: dw2102: fix uninit-value in su3000_read_mac_address
      media: netup_unidvb: fix irq init by register it at the end of probe

YongSu Yoo (2):
      media: dvb_demux: fix a bug for the continuity counter
      media: dvb_ca_en50221: fix a size write bug

Zhang Shurong (1):
      media: dvb-usb-v2: rtl28xxu: fix null-ptr-deref in rtl28xxu_i2c_xfer

 drivers/media/dvb-core/dvb_ca_en50221.c            | 49 +++++++++++--
 drivers/media/dvb-core/dvb_demux.c                 |  4 +-
 drivers/media/dvb-core/dvb_frontend.c              | 69 ++++++++++++++----
 drivers/media/dvb-core/dvb_net.c                   | 38 +++++++++-
 drivers/media/dvb-core/dvbdev.c                    | 84 ++++++++++++++++------
 drivers/media/dvb-frontends/mn88443x.c             |  2 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c | 19 ++---
 drivers/media/usb/dvb-usb-v2/ce6230.c              |  8 +++
 drivers/media/usb/dvb-usb-v2/ec168.c               | 12 ++++
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c            | 20 ++++++
 drivers/media/usb/dvb-usb/az6027.c                 | 12 ++++
 drivers/media/usb/dvb-usb/digitv.c                 |  4 ++
 drivers/media/usb/dvb-usb/dw2102.c                 |  2 +-
 drivers/media/usb/pvrusb2/Kconfig                  |  1 +
 drivers/media/usb/ttusb-dec/ttusb_dec.c            |  3 +-
 include/media/dvb_frontend.h                       |  6 +-
 include/media/dvb_net.h                            |  4 ++
 include/media/dvbdev.h                             | 15 ++++
 18 files changed, 293 insertions(+), 59 deletions(-)

