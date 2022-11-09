Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32FD622764
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiKIJqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKIJqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:46:12 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8F122BE4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:46:11 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6g882vczzRp2M;
        Wed,  9 Nov 2022 17:46:00 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 17:46:08 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <mark.rutland@arm.com>
CC:     <xuqiang36@huawei.com>, <weiyongjun1@huawei.com>,
        <wangwensheng4@huawei.com>
Subject: [PATCH -next 0/3] Optimize code for ftrace
Date:   Wed, 9 Nov 2022 09:44:31 +0000
Message-ID: <20221109094434.84046-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those are small optimizations discovered by code review.

Wang Wensheng (3):
  ftrace: Fix the possible incorrect kernel message
  ftrace: Optimize the allocation for mcount entries
  ftrace: Delete unused variable ftrace_update_time

 kernel/trace/ftrace.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

-- 
2.17.1

