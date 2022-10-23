Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F356094FE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiJWRIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJWRIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:08:21 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DE272FF4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:08:20 -0700 (PDT)
Received: from ipservice-092-217-070-181.092.217.pools.vodafone-ip.de ([92.217.70.181] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1omeSN-0000Rj-Jk; Sun, 23 Oct 2022 19:08:15 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/5] staging: r8188eu: some more small cleanups
Date:   Sun, 23 Oct 2022 19:08:03 +0200
Message-Id: <20221023170808.46233-1-martin@kaiser.cx>
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

Here's another series with simple cleanups in several places.
Tested with EdimaxV2 on an arm32 system.

Martin Kaiser (5):
  staging: r8188eu: use standard multicast addr check
  staging: r8188eu: don't set pcmd_obj components to 0
  staging: r8188eu: NetworkTypeInUse is not in use
  staging: r8188eu: remove wait_ack param from _issue_probereq_p2p
  staging: r8188eu: bCardDisableWOHSM is write-only

 drivers/staging/r8188eu/core/rtw_mlme.c       | 16 ----------------
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 18 ++++--------------
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  2 +-
 drivers/staging/r8188eu/include/drv_types.h   |  1 -
 drivers/staging/r8188eu/include/wifi.h        |  5 -----
 drivers/staging/r8188eu/include/wlan_bssdef.h |  9 ---------
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  4 ----
 7 files changed, 5 insertions(+), 50 deletions(-)

-- 
2.30.2

