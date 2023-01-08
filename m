Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0958B66185F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjAHS57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHS54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:57:56 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4CBE00C
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 10:57:54 -0800 (PST)
Received: from dslb-188-096-147-053.188.096.pools.vodafone-ip.de ([188.96.147.53] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pEarb-0003b8-57; Sun, 08 Jan 2023 19:57:47 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/13] staging: r8188eu: some more xmit cleanups
Date:   Sun,  8 Jan 2023 19:57:25 +0100
Message-Id: <20230108185738.597105-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another set of xmit cleanups, based on my previous patches.

Martin Kaiser (13):
  staging: r8188eu: beq_cnt is write-only
  staging: r8188eu: bkq_cnt is write-only
  staging: r8188eu: viq_cnt is write-only
  staging: r8188eu: voq_cnt is write-only
  staging: r8188eu: replace switch with if
  staging: r8188eu: make rtl8188eu_inirp_init a void function
  staging: r8188eu: dir_dev is unused
  staging: r8188eu: remove unused hal_xmit_handler define
  staging: r8188eu: txirp_cnt is write-only
  staging: r8188eu: remove unused QSLT defines
  staging: r8188eu: xmit_priv's vcs_type is not used
  staging: r8188eu: xmit_priv's vcs is not used
  staging: r8188eu: xmit_priv's vcs_setting is not used

 drivers/staging/r8188eu/core/rtw_mlme.c       |  5 ---
 drivers/staging/r8188eu/core/rtw_xmit.c       | 42 -------------------
 drivers/staging/r8188eu/hal/usb_halinit.c     | 14 ++-----
 drivers/staging/r8188eu/include/drv_types.h   |  1 -
 drivers/staging/r8188eu/include/hal_intf.h    |  2 +-
 .../staging/r8188eu/include/rtl8188e_xmit.h   | 11 -----
 drivers/staging/r8188eu/include/rtw_xmit.h    | 10 -----
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  3 --
 .../staging/r8188eu/os_dep/usb_ops_linux.c    | 23 +---------
 9 files changed, 5 insertions(+), 106 deletions(-)

-- 
2.30.2

