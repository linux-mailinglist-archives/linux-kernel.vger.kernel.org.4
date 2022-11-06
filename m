Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F8361E229
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 13:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiKFMtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 07:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKFMtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 07:49:12 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439BF63B7
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 04:49:11 -0800 (PST)
Received: from ipservice-092-217-068-220.092.217.pools.vodafone-ip.de ([92.217.68.220] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1orf5E-0008Dj-Ua; Sun, 06 Nov 2022 13:49:05 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/9] staging: r8188eu: another round of cleanups
Date:   Sun,  6 Nov 2022 13:48:52 +0100
Message-Id: <20221106124901.720785-1-martin@kaiser.cx>
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

Here's another patch set with several cleanups throughout the driver.

Martin Kaiser (9):
  staging: r8188eu: don't store addba request
  staging: r8188eu: remove some obsolete comments
  staging: r8188eu: reorder assignments, clarify the header format
  staging: r8188eu: reformat a function header
  staging: r8188eu: remove state checks in rtw_led_control
  staging: r8188eu: clean up rtw_hal_init
  staging: r8188eu: remove get_fwstate
  staging: r8188eu: merge two rtw_free_network_nolock functions
  staging: r8188eu: remove checks in dump_mgntframe

 drivers/staging/r8188eu/core/rtw_led.c        |  3 +-
 drivers/staging/r8188eu/core/rtw_mlme.c       | 23 ++++++---------
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 28 ++++++++-----------
 drivers/staging/r8188eu/core/rtw_recv.c       |  2 --
 drivers/staging/r8188eu/hal/hal_intf.c        | 19 +++++--------
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  6 +---
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c | 15 ++++------
 drivers/staging/r8188eu/include/rtw_mlme.h    |  7 -----
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  4 +--
 drivers/staging/r8188eu/include/wifi.h        |  8 ------
 10 files changed, 36 insertions(+), 79 deletions(-)

-- 
2.30.2

