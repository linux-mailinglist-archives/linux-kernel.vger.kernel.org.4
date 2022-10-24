Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67B4609C30
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJXIOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJXIOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:14:33 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30551EAEB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:14:29 -0700 (PDT)
Received: from ipservice-092-217-079-032.092.217.pools.vodafone-ip.de ([92.217.79.32] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1omsbI-0000nk-Vq; Mon, 24 Oct 2022 10:14:25 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/17] staging: r8188eu: clean up mlme handlers
Date:   Mon, 24 Oct 2022 10:14:00 +0200
Message-Id: <20221024081417.66441-1-martin@kaiser.cx>
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

This series cleans up the mlme handlers that process incoming management
frames.

We can reorder the handler functions and remove forward declarations. We
can also remove unused return values and simplify the error handling.

This series should be applied after the "some more small cleanups" series.

As usual, this series was tested with EdimaxV2 on an arm32 system.

Martin Kaiser (17):
  staging: r8188eu: restructure mlme subfunction handling
  staging: r8188eu: make OnAssocReq static
  staging: r8188eu: make OnAssocRsp static
  staging: r8188eu: make OnProbeReq static
  staging: r8188eu: make OnProbeRsp static
  staging: r8188eu: make OnBeacon static
  staging: r8188eu: make OnDisassoc static
  staging: r8188eu: make OnAuthClient static
  staging: r8188eu: make OnDeAuth static
  staging: r8188eu: make OnAction static
  staging: r8188eu: make OnAuth static
  staging: r8188eu: change mlme handlers to void
  staging: r8188eu: remove unnecessary label
  staging: r8188eu: remove unnecessary else branch
  staging: r8188eu: remove unnecessary return
  staging: r8188eu: remove an else branch
  staging: r8188eu: go2asoc is not needed

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 226 ++++++++----------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  23 +-
 2 files changed, 100 insertions(+), 149 deletions(-)

-- 
2.30.2

