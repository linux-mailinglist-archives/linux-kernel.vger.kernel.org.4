Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FD96806CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 08:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjA3H7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 02:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjA3H7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:59:37 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D5055A9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 23:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/wdUzQl36Iu2VK5SbxqISsiHtJoNcLhLCTKQmxCJJbY=;
  b=rP2I+Q2YPs6kIcE402J66lkFzMA5aMdxHHBhbZlkFHeKANxQRJ/VElGa
   9EwXDJtuBwAxZdzNdbIyw+NhfrYqYysim4Mi+YgcpA2ERy8d5P/jq7A5m
   D9vApj/HF00NQnhsHICqtplb3/SxdXahgrP8bYEZl5d6I2bKac6piATgR
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="89979550"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:59:34 +0100
Date:   Mon, 30 Jan 2023 08:59:34 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
cc:     linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/infiniband/ulp/ipoib/ipoib_main.c:333:2-10: WARNING: NULL
 check before dev_{put, hold} functions is not needed. (fwd)
Message-ID: <26215e5-3195-ab2e-f51c-4daf2a8c7f60@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please check lines 333 and 2007 as noted below.

julia

---------- Forwarded message ----------
Date: Mon, 30 Jan 2023 14:45:21 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/infiniband/ulp/ipoib/ipoib_main.c:333:2-10: WARNING: NULL check
     before dev_{put, hold} functions is not needed.

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Ziyang Xuan <william.xuanziyang@huawei.com>
CC: Julia Lawall <julia.lawall@inria.fr>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6d796c50f84ca79f1722bb131799e5a5710c4700
commit: bbd5c96850d9de535a83a3a3842dec2169cb31d1 scripts/coccinelle/free: add NULL test before dev_{put, hold} functions
date:   7 months ago
:::::: branch date: 9 hours ago
:::::: commit date: 7 months ago
config: powerpc-randconfig-c034-20230129 (https://download.01.org/0day-ci/archive/20230130/202301301452.jacYfrpm-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@lip6.fr>

cocci warnings: (new ones prefixed by >>)
>> drivers/infiniband/ulp/ipoib/ipoib_main.c:333:2-10: WARNING: NULL check before dev_{put, hold} functions is not needed.
   drivers/infiniband/ulp/ipoib/ipoib_main.c:2007:2-9: WARNING: NULL check before dev_{put, hold} functions is not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
