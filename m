Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8BB63E918
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiLAEyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLAEyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:54:52 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827638EE6A;
        Wed, 30 Nov 2022 20:54:51 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NN3cg0rDkzHwMm;
        Thu,  1 Dec 2022 12:53:39 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 1 Dec
 2022 12:54:10 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huaweicloud.com>, <linfeilong@huawei.com>,
        <liuzhiqiang@huawei.com>
Subject: [PATCH 0/5] A few cleanup and bugfix patches for sbitmap
Date:   Thu, 1 Dec 2022 12:54:03 +0800
Message-ID: <20221201045408.21908-1-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this series contain a patch to fix protential wakup lost in
__sbq_wake_up and some random cleanup patches to remove unnecessary
check and repeat code.
Thanks.

Kemeng Shi (5):
  sbitmap: don't consume nr for inactive waitqueue to avoid lost wakeups
  sbitmap: remove unnecessary calculation of alloc_hint in
    __sbitmap_get_shallow
  sbitmap: remove redundant check in __sbitmap_queue_get_batch
  sbitmap: rewrite sbitmap_find_bit_in_index to reduce repeat code
  sbitmap: add sbitmap_find_bit to remove repeat code in
    __sbitmap_get/__sbitmap_get_shallow

 lib/sbitmap.c | 111 +++++++++++++++++++++++---------------------------
 1 file changed, 51 insertions(+), 60 deletions(-)

-- 
2.30.0

