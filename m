Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F996396F5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKZQBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:01:41 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F63E193E0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 08:01:40 -0800 (PST)
Received: from dslb-188-096-151-149.188.096.pools.vodafone-ip.de ([188.96.151.149] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oyxcT-0000Ub-JF; Sat, 26 Nov 2022 17:01:33 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/10] staging: r8188eu: clean up OnBeacon
Date:   Sat, 26 Nov 2022 17:01:19 +0100
Message-Id: <20221126160129.178697-1-martin@kaiser.cx>
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

This series cleans up the OnBeacon function. It tries to replace
driver-sepcific message parsing with ieee80211 helper functions.

Please apply this after the "another round of cleanups" series.

Martin Kaiser (10):
  staging: r8188eu: replace one GetAddr3Ptr call
  staging: r8188eu: read timestamp from ieee80211_mgmt
  staging: r8188eu: replace GetAddr2Ptr calls
  staging: r8188eu: pass only ies to process_p2p_ps_ie
  staging: r8188eu: use ie buffer in update_beacon_info
  staging: r8188eu: simplify update_sta_support_rate params
  staging: r8188eu: exit if beacon is not from our bss
  staging: r8188eu: stop beacon processing if kmalloc fails
  staging: r8188eu: simplify error handling for missing station
  staging: r8188eu: remove a variable

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 130 ++++++++----------
 drivers/staging/r8188eu/core/rtw_p2p.c        |  11 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |   9 +-
 .../staging/r8188eu/include/rtw_mlme_ext.h    |   3 +-
 4 files changed, 66 insertions(+), 87 deletions(-)

-- 
2.30.2

