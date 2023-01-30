Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5805681AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbjA3Txa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbjA3TxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:53:25 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142AE3E630
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:53:23 -0800 (PST)
Received: from dslb-188-097-040-029.188.097.pools.vodafone-ip.de ([188.97.40.29] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pMaDM-0007S2-0D; Mon, 30 Jan 2023 20:53:16 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/9] staging: r8188eu: another round of xmit cleanups
Date:   Mon, 30 Jan 2023 20:52:54 +0100
Message-Id: <20230130195303.138941-1-martin@kaiser.cx>
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

Here's some more cleanups for the xmit code. Amongst other things, there's
one more __queue that can be replaced with a list_head.

Martin Kaiser (9):
  staging: r8188eu: rtw_free_xmitframe_queue needs no spinlock
  staging: r8188eu: change function param from __queue to list_head
  staging: r8188eu: change another function param from __queue to
    list_head
  staging: r8188eu: make sta_pending a list_head
  staging: r8188eu: use kernel helper to iterate over a list
  staging: r8188eu: legacy_dz is initialised but never used
  staging: r8188eu: apsd is initialised but never used
  staging: r8188eu: option in struct sta_xmit_priv is not used
  staging: r8188eu: replace switch-case with if

 drivers/staging/r8188eu/core/rtw_sta_mgt.c    | 10 +++---
 drivers/staging/r8188eu/core/rtw_xmit.c       | 31 +++++--------------
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  4 +--
 drivers/staging/r8188eu/include/rtw_xmit.h    |  8 ++---
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  8 +----
 5 files changed, 18 insertions(+), 43 deletions(-)

-- 
2.30.2

