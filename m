Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ADA680E18
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbjA3Mzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjA3Mzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:55:51 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A47210E3;
        Mon, 30 Jan 2023 04:55:50 -0800 (PST)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P57NR11tHz6J7fC;
        Mon, 30 Jan 2023 20:51:35 +0800 (CST)
Received: from fasthvm.lan (10.48.151.146) by lhrpeml500004.china.huawei.com
 (7.191.163.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 12:55:47 +0000
From:   Antonio Paolillo <antonio.paolillo@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <longman@redhat.com>, <boqun.feng@gmail.com>, <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Antonio Paolillo <antonio.paolillo@huawei.com>
Subject: [PATCH] doc: locktorture fix
Date:   Mon, 30 Jan 2023 13:55:38 +0100
Message-ID: <20230130125538.20359-1-antonio.paolillo@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.151.146]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual build option for rtmutex lock is `CONFIG_RT_MUTEXES`, not
`CONFIG_RT_MUTEX`.

Signed-off-by: Antonio Paolillo <antonio.paolillo@huawei.com>
---
 Documentation/locking/locktorture.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/locking/locktorture.rst b/Documentation/locking/locktorture.rst
index dfaf9fc883f4..3f7b44e2c070 100644
--- a/Documentation/locking/locktorture.rst
+++ b/Documentation/locking/locktorture.rst
@@ -67,7 +67,7 @@ torture_type
 
 		     - "rtmutex_lock":
 				rtmutex_lock() and rtmutex_unlock() pairs.
-				Kernel must have CONFIG_RT_MUTEX=y.
+				Kernel must have CONFIG_RT_MUTEXES=y.
 
 		     - "rwsem_lock":
 				read/write down() and up() semaphore pairs.
-- 
2.34.1

