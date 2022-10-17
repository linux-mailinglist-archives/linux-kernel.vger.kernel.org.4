Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ACF6006C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJQGb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiJQGbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:31:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6B15723F;
        Sun, 16 Oct 2022 23:31:18 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MrRrJ4kwmzpVqZ;
        Mon, 17 Oct 2022 14:28:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 14:31:16 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <axboe@kernel.dk>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <linux-block@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next 0/3] fix possible memleak in '__blk_trace_remove'
Date:   Mon, 17 Oct 2022 14:53:18 +0800
Message-ID: <20221017065321.2846017-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ye Bin (3):
  blktrace: introduce 'blk_trace_swicth_state' helper
  blktrace: fix possible memleak in '__blk_trace_remove'
  blktrace: remove unnessary stop block trace in 'blk_trace_shutdown'

 kernel/trace/blktrace.c | 84 ++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

-- 
2.31.1

