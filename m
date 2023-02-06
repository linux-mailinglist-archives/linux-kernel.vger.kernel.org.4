Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E2168C774
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjBFUSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjBFUSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:18:33 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C16B1026E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:18:15 -0800 (PST)
Received: from ipservice-092-217-084-033.092.217.pools.vodafone-ip.de ([92.217.84.33] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pP7wE-0007ps-Sz; Mon, 06 Feb 2023 21:18:06 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/6] staging: r8188eu: remove intf_start and intf_stop
Date:   Mon,  6 Feb 2023 21:17:54 +0100
Message-Id: <20230206201800.139195-1-martin@kaiser.cx>
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

Remove the two pointers to media-specific start and stop functions. The
r8188eu driver supports only usb.

Update some of the functions in the start and stop paths to return
standard error codes instead of _SUCCESS and _FAIL.

Martin Kaiser (6):
  staging: r8188eu: pass a struct recv_buf to rtw_read_port
  staging: r8188eu: use standard error codes in rtw_read_port
  staging: r8188eu: use standard error codes in rtl8188eu_inirp_init
  staging: r8188eu: remove intf_start pointer
  staging: r8188eu: handle rtl8188eu_inirp_init errors
  staging: r8188eu: remove intf_stop pointer

 drivers/staging/r8188eu/hal/usb_halinit.c   | 16 ++++++--------
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 20 ++++++++---------
 drivers/staging/r8188eu/include/drv_types.h |  2 --
 drivers/staging/r8188eu/include/hal_intf.h  |  2 +-
 drivers/staging/r8188eu/include/rtw_io.h    |  2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c   | 12 +++++------
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 24 +++------------------
 7 files changed, 26 insertions(+), 52 deletions(-)

-- 
2.30.2

