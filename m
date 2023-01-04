Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A32865D0F5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbjADKxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbjADKwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:52:40 -0500
X-Greylist: delayed 2457 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 02:50:52 PST
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880CBE7D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:50:52 -0800 (PST)
Received: from localhost (raina-lt.asicdesigners.com [10.193.177.176] (may be forged))
        by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 304A9GXG016296;
        Wed, 4 Jan 2023 02:09:28 -0800
Date:   Wed, 4 Jan 2023 15:39:16 +0530
From:   Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To:     linux-firmware@kernel.org
Cc:     linux-kernel@vger.kernel.org, jwboyer@kernel.org,
        rahul.lakkireddy@chelsio.com
Subject: pull request: linux-firmware: update cxgb4 firmware to 1.27.1.0
Message-ID: <Y7VQTMD97rHTqsBo@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the new Chelsio firmware from the following URL.

  http://git.chelsio.net/pub/git/linux-firmware.git for-upstream

Thanks,
Rahul


The following changes since commit 52261d0329b1a2e414ee394aae3c5ca36283730f:

  Merge https://github.com/pkshih/linux-firmware (2022-12-16 07:10:10 -0500)

are available in the Git repository at:

  http://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to 52e62d6af5c56b82ef49db415b12c8cfe4faf756:

  cxgb4: Update firmware to revision 1.27.1.0 (2023-01-04 09:14:46 +0000)

----------------------------------------------------------------
Rahul Lakkireddy (1):
      cxgb4: Update firmware to revision 1.27.1.0

 WHENCE                                         |  12 ++++++------
 cxgb4/{t4fw-1.27.0.0.bin => t4fw-1.27.1.0.bin} | Bin 570880 -> 570880 bytes
 cxgb4/t5fw-1.27.0.0.bin                        | Bin 677376 -> 0 bytes
 cxgb4/t5fw-1.27.1.0.bin                        | Bin 0 -> 678400 bytes
 cxgb4/{t6fw-1.27.0.0.bin => t6fw-1.27.1.0.bin} | Bin 729600 -> 730112 bytes
 5 files changed, 6 insertions(+), 6 deletions(-)
 rename cxgb4/{t4fw-1.27.0.0.bin => t4fw-1.27.1.0.bin} (73%)
 delete mode 100644 cxgb4/t5fw-1.27.0.0.bin
 create mode 100644 cxgb4/t5fw-1.27.1.0.bin
 rename cxgb4/{t6fw-1.27.0.0.bin => t6fw-1.27.1.0.bin} (54%)
