Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3770B6632E4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjAIV3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbjAIV3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:29:09 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49066644F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:29:08 -0800 (PST)
Received: from dslb-188-096-147-178.188.096.pools.vodafone-ip.de ([188.96.147.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pEzhX-0007iD-6X; Mon, 09 Jan 2023 22:29:03 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 00/12] staging: r8188eu: some more xmit cleanups
Date:   Mon,  9 Jan 2023 22:28:40 +0100
Message-Id: <20230109212852.75612-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230108185738.597105-1-martin@kaiser.cx>
References: <20230108185738.597105-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another set of xmit cleanups, based on my previous patches.

changes in v2:
- drop "make rtl8188eu_inirp_init a void function" patch
  (we should relay the return value instead of discarding it)

Martin Kaiser (12):
  staging: r8188eu: beq_cnt is write-only
  staging: r8188eu: bkq_cnt is write-only
  staging: r8188eu: viq_cnt is write-only
  staging: r8188eu: voq_cnt is write-only
  staging: r8188eu: replace switch with if
  staging: r8188eu: dir_dev is unused
  staging: r8188eu: remove unused hal_xmit_handler define
  staging: r8188eu: txirp_cnt is write-only
  staging: r8188eu: remove unused QSLT defines
  staging: r8188eu: xmit_priv's vcs_type is not used
  staging: r8188eu: xmit_priv's vcs is not used
  staging: r8188eu: xmit_priv's vcs_setting is not used

 drivers/staging/r8188eu/core/rtw_mlme.c       |  5 ---
 drivers/staging/r8188eu/core/rtw_xmit.c       | 42 -------------------
 drivers/staging/r8188eu/include/drv_types.h   |  1 -
 .../staging/r8188eu/include/rtl8188e_xmit.h   | 11 -----
 drivers/staging/r8188eu/include/rtw_xmit.h    | 10 -----
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  3 --
 .../staging/r8188eu/os_dep/usb_ops_linux.c    | 23 +---------
 7 files changed, 1 insertion(+), 94 deletions(-)

-- 
2.30.2

