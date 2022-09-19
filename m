Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4795BD6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiISWKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiISWKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:10:14 -0400
X-Greylist: delayed 1346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Sep 2022 15:10:14 PDT
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178AA3DF00
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:10:13 -0700 (PDT)
Received: from localhost (divyakrishna.asicdesigners.com [10.193.177.136] (may be forged))
        by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 28JLlYgS031685;
        Mon, 19 Sep 2022 14:47:35 -0700
Date:   Tue, 20 Sep 2022 03:17:33 +0530
From:   Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To:     linux-firmware@kernel.org
Cc:     linux-kernel@vger.kernel.org, jwboyer@kernel.org,
        rahul.lakkireddy@chelsio.com
Subject: pull request: linux-firmware: update cxgb4 firmware to 1.27.0.0
Message-ID: <YyjjdfpfEG89h8cw@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_20,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the new Chelsio firmware from the following URL

http://git.chelsio.net/pub/git/linux-firmware.git for-upstream

Thanks,
Rahul

The following changes since commit f09bebf31b0590bdc875d7236aa705279510cfd0:

  amdgpu: update yellow carp DMCUB firmware (2022-09-13 08:02:23 -0400)

are available in the Git repository at:

  http://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to e6e48db2f8509578902d767b2d05a536b117256e:

  cxgb4: Update firmware to revision 1.27.0.0 (2022-09-19 20:35:56 +0000)

----------------------------------------------------------------
Rahul Lakkireddy (1):
      cxgb4: Update firmware to revision 1.27.0.0

 WHENCE                                         |  12 ++++++------
 cxgb4/{t4fw-1.26.6.0.bin => t4fw-1.27.0.0.bin} | Bin 570880 -> 570880 bytes
 cxgb4/{t5fw-1.26.6.0.bin => t5fw-1.27.0.0.bin} | Bin 676352 -> 677376 bytes
 cxgb4/{t6fw-1.26.6.0.bin => t6fw-1.27.0.0.bin} | Bin 729600 -> 729600 bytes
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename cxgb4/{t4fw-1.26.6.0.bin => t4fw-1.27.0.0.bin} (79%)
 rename cxgb4/{t5fw-1.26.6.0.bin => t5fw-1.27.0.0.bin} (77%)
 rename cxgb4/{t6fw-1.26.6.0.bin => t6fw-1.27.0.0.bin} (71%)
