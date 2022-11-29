Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA9463C9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbiK2UwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiK2UwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:52:06 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E782B6367
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:52:05 -0800 (PST)
Received: from dslb-188-104-061-001.188.104.pools.vodafone-ip.de ([188.104.61.1] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1p07aA-0001pO-87; Tue, 29 Nov 2022 21:51:58 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/5] staging: r8188eu: clean up OnDisassoc
Date:   Tue, 29 Nov 2022 21:51:47 +0100
Message-Id: <20221129205152.128172-1-martin@kaiser.cx>
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

Clean up the OnDisassoc function. Use a struct ieee80211_mgmt for parsing
the incoming message and reduce the indentation levels.

Please apply this after the two series I sent some days ago

Martin Kaiser (5):
  staging: r8188eu: use ieee80211_mgmt to parse addresses
  staging: r8188eu: read reason code from ieee80211_mgmt
  staging: r8188eu: move bBusyTraffic update
  staging: r8188eu: handle the non-ap case first
  staging: r8188eu: simplify err handling for unknown station

 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 47 ++++++++++-----------
 1 file changed, 22 insertions(+), 25 deletions(-)

-- 
2.30.2

