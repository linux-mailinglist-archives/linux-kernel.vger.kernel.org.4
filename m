Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAE068E112
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjBGTXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjBGTXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:23:35 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201A932E7C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:23:34 -0800 (PST)
Received: from dslb-178-004-202-208.178.004.pools.vodafone-ip.de ([178.4.202.208] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pPTYr-0002XK-I5; Tue, 07 Feb 2023 20:23:25 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/7] staging: r8188eu: another round of xmit cleanups
Date:   Tue,  7 Feb 2023 20:23:12 +0100
Message-Id: <20230207192319.294203-1-martin@kaiser.cx>
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

This series contains some more cleanups for the xmit code.

Amongst other things, we can reduce the data for the completion function
of the usb bulk urbs that we send out.

Martin Kaiser (7):
  staging: r8188eu: merge do_queue_select into its only caller
  staging: r8188eu: simplify rtw_alloc_xmitframe
  staging: r8188eu: remove unused frametag defines
  staging: r8188eu: xmit_buf's ff_hwaddr is not used
  staging: r8188eu: simplify xmit_buf flags
  staging: r8188eu: simplify rtw_get_ff_hwaddr
  staging: r8188eu: bagg_pkt parameter is not used

 drivers/staging/r8188eu/core/rtw_xmit.c       | 85 +++++--------------
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  8 +-
 drivers/staging/r8188eu/include/rtw_xmit.h    | 17 +---
 .../staging/r8188eu/os_dep/usb_ops_linux.c    | 25 +-----
 4 files changed, 27 insertions(+), 108 deletions(-)

-- 
2.30.2

