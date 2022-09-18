Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B935BBF37
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 19:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIRR5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 13:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIRR5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 13:57:13 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9006E16586
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 10:57:11 -0700 (PDT)
Received: from dslb-188-096-149-102.188.096.pools.vodafone-ip.de ([188.96.149.102] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oZyXR-0006VL-Q4; Sun, 18 Sep 2022 19:57:05 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/6] staging: r8188eu: another round of led layer cleanups
Date:   Sun, 18 Sep 2022 19:56:54 +0200
Message-Id: <20220918175700.215170-1-martin@kaiser.cx>
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

Here's some more cleanups for the led layer. This series should be applied
on top of the "staging: r8188eu: more led cleanups" series I sent on Sep
11th.

Martin Kaiser (6):
  staging: r8188eu: cancel blink_work during wps stop
  staging: r8188eu: update status before wps success blinking
  staging: r8188eu: remove bLedNoLinkBlinkInProgress
  staging: r8188eu: remove BlinkingLedState
  staging: r8188eu: remove duplicate bSurpriseRemoved check
  staging: r8188eu: remove two unused enum entries

 drivers/staging/r8188eu/core/rtw_led.c    | 104 +++-------------------
 drivers/staging/r8188eu/include/rtw_led.h |   8 --
 2 files changed, 12 insertions(+), 100 deletions(-)

-- 
2.30.2

