Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5D961FF84
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiKGU2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiKGU2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:28:40 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD24183B6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:28:38 -0800 (PST)
Received: from ipservice-092-217-067-198.092.217.pools.vodafone-ip.de ([92.217.67.198] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1os8jQ-0004bP-Ag; Mon, 07 Nov 2022 21:28:32 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 0/3] staging: r8188eu: another round of cleanups
Date:   Mon,  7 Nov 2022 21:28:21 +0100
Message-Id: <20221107202824.61431-1-martin@kaiser.cx>
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

Here's some more cleanups, mostly related to bSurpriseRemoved and
bDriverStopped.

Please apply them after the series I sent yesteday.

Changes in v2
- Fixed the header len calculation in patch 1. Thanks to Dan Carpenter
  for spotting this mistake.

Martin Kaiser (3):
  staging: r8188eu: use a qos_hdr in validate_recv_data_frame
  staging: r8188eu: drop another removal/stop check
  staging: r8188eu: drop removal/stop check in
    dump_mgntframe_and_wait_ack

 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 6 ------
 drivers/staging/r8188eu/core/rtw_recv.c     | 9 +++++----
 2 files changed, 5 insertions(+), 10 deletions(-)

-- 
2.30.2

