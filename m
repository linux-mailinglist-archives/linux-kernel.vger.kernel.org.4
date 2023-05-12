Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718B7700603
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbjELKvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbjELKvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:51:08 -0400
X-Greylist: delayed 3615 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 May 2023 03:50:44 PDT
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12DB1FCE
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:50:44 -0700 (PDT)
Received: from localhost (venkateshellapu.asicdesigners.com [10.193.177.158] (may be forged))
        by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 34C9oF2c021181;
        Fri, 12 May 2023 02:50:16 -0700
Date:   Fri, 12 May 2023 15:20:15 +0530
From:   Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To:     linux-firmware@kernel.org
Cc:     linux-kernel@vger.kernel.org, jwboyer@kernel.org,
        rahul.lakkireddy@chelsio.com
Subject: pull request: linux-firmware: update cxgb4 firmware to 1.27.3.0
Message-ID: <ZF4L1/RVZXJKhTx0@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the new Chelsio firmware from the following URL.

 http://git.chelsio.net/pub/git/linux-firmware.git for-upstream

Thanks,
Rahul


The following changes since commit 6c9e0ed5362ff9fd74c11a2b9552a9223371f04a:

  check_whence: error on directory listed as File (2023-05-08 08:38:18 -0400)

are available in the Git repository at:

  http://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to a0146258f1b44913f763eec95168ceb1baa5f4a3:

  cxgb4: Update firmware to revision 1.27.3.0 (2023-05-12 08:55:06 +0000)

----------------------------------------------------------------
Rahul Lakkireddy (1):
      cxgb4: Update firmware to revision 1.27.3.0

 WHENCE                                         |  12 ++++++------
 cxgb4/{t4fw-1.27.1.0.bin => t4fw-1.27.3.0.bin} | Bin 570880 -> 570880 bytes
 cxgb4/{t5fw-1.27.1.0.bin => t5fw-1.27.3.0.bin} | Bin 678400 -> 678912 bytes
 cxgb4/{t6fw-1.27.1.0.bin => t6fw-1.27.3.0.bin} | Bin 730112 -> 730624 bytes
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename cxgb4/{t4fw-1.27.1.0.bin => t4fw-1.27.3.0.bin} (59%)
 rename cxgb4/{t5fw-1.27.1.0.bin => t5fw-1.27.3.0.bin} (50%)
 rename cxgb4/{t6fw-1.27.1.0.bin => t6fw-1.27.3.0.bin} (59%)
