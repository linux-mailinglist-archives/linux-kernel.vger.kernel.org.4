Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB32C5FFAF4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiJOPY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJOPYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:24:54 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D946382
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:24:52 -0700 (PDT)
Received: from ipservice-092-217-066-135.092.217.pools.vodafone-ip.de ([92.217.66.135] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ojj1q-000722-9k; Sat, 15 Oct 2022 17:24:46 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/9] staging: r8188eu: clean up the OnDeAuth function
Date:   Sat, 15 Oct 2022 17:24:31 +0200
Message-Id: <20221015152440.232281-1-martin@kaiser.cx>
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

This series cleans up the OnDeAuth function and tries to replace
driver-specific parsing code with helpers from ieee80211.h.

Martin Kaiser (9):
  staging: r8188eu: replace one GetAddr3Ptr call
  staging: r8188eu: get reason code from mgmt struct
  staging: r8188eu: clarify the bBusyTraffic assignment
  staging: r8188eu: use sa instead of Addr2
  staging: r8188eu: get bssid from mgmt struct
  staging: r8188eu: exit for deauth from unknown station
  staging: r8188eu: remove unnecessary return
  staging: r8188eu: summarize two flags checks
  staging: r8188eu: ignore_received_deauth is a boolean

 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 45 ++++++++++-----------
 1 file changed, 21 insertions(+), 24 deletions(-)

-- 
2.30.2

