Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497AB6497DF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 03:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiLLCLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 21:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiLLCLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 21:11:34 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5E2D135
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 18:11:33 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NVlTP5j6rzRpy0;
        Mon, 12 Dec 2022 10:10:33 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Dec 2022 10:11:30 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <akinobu.mita@gmail.com>, <akpm@linux-foundation.org>,
        <nathan@kernel.org>, <peterz@infradead.org>,
        <keescook@chromium.org>, <ndesaulniers@google.com>,
        <jpoimboe@kernel.org>, <dan.j.williams@intel.com>,
        <ojeda@kernel.org>, <isabbasso@riseup.net>, <vbabka@suse.cz>,
        <linux@rasmusvillemoes.dk>
CC:     <linux-kernel@vger.kernel.org>, <weiyongjun1@huawei.com>
Subject: [PATCH -next v2 0/4] fault-injection: make stacktrace filter works with others
Date:   Mon, 12 Dec 2022 10:11:12 +0800
Message-ID: <1670811076-38625-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
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

From: Wei Yongjun <weiyongjun1@huawei.com>

This patchset allow fault injection run on x86_64, and make stacktrace
filter works as expected. With this, we can test device driver module by
fault injecting more easy.

v1 -> v2: patch#3 Using debugfs_create_xul() instead of debugfs_create_xl(),
and del the local define debugfs_create_xl().
V1: https://www.spinics.net/lists/kernel/msg4476664.html

Wang Yufen (1):
  fault-injection: make some stack filter attrs more readable

Wei Yongjun (3):
  fault-injection: allow stacktrace filter for x86-64
  fault-injection: skip stacktrace filtering by default
  fault-injection: make stacktrace filter works as expected

 lib/Kconfig.debug  |  1 -
 lib/fault-inject.c | 22 ++++++++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

-- 
1.8.3.1

