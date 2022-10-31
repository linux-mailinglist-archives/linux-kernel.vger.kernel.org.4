Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29706613208
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJaI5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiJaI5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:57:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C1B1D3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:57:00 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N16TP3QSvzHvXQ;
        Mon, 31 Oct 2022 16:56:41 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 16:56:47 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 16:56:46 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <akpm@linux-foundation.org>, <thomas.orgis@uni-hamburg.de>,
        <ismael@iodev.co.uk>
CC:     <linux-kernel@vger.kernel.org>, <yangyingliang@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] tools/accounting/procacct: remove some unused variables
Date:   Mon, 31 Oct 2022 17:15:57 +0800
Message-ID: <20221031091557.192180-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the following unused variables inherited from getdelays.c:

  'aggr_len', 'len2', 'cmd_type', 'tid', 'containerset', 'containerpath'
  and 'sigset'.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 tools/accounting/procacct.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/accounting/procacct.c b/tools/accounting/procacct.c
index 8353d3237e50..90c4a37f53d9 100644
--- a/tools/accounting/procacct.c
+++ b/tools/accounting/procacct.c
@@ -261,25 +261,20 @@ void handle_aggr(int mother, struct nlattr *na, int fd)
 
 int main(int argc, char *argv[])
 {
-	int c, rc, rep_len, aggr_len, len2;
-	int cmd_type = TASKSTATS_CMD_ATTR_UNSPEC;
+	int c, rc, rep_len;
 	__u16 id;
 	__u32 mypid;
 
 	struct nlattr *na;
 	int nl_sd = -1;
 	int len = 0;
-	pid_t tid = 0;
 
 	int fd = 0;
 	int write_file = 0;
 	int maskset = 0;
 	char *logfile = NULL;
-	int containerset = 0;
-	char *containerpath = NULL;
 	int cfd = 0;
 	int forking = 0;
-	sigset_t sigset;
 
 	struct msgtemplate msg;
 
-- 
2.20.1

