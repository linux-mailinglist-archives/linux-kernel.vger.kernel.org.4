Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59AA68B7AC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjBFIrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBFIrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:47:07 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605781040C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:46:57 -0800 (PST)
Received: from kwepemm600015.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P9KZQ0MQwznW2c;
        Mon,  6 Feb 2023 16:44:46 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 16:46:50 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <rpeterso@redhat.com>, <agruenba@redhat.com>
CC:     <cluster-devel@redhat.com>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>
Subject: [PATCH 0/2] gfs2: fix sleep from invalid context bug in gfs2_glock_wait()
Date:   Mon, 6 Feb 2023 17:55:41 +0800
Message-ID: <20230206095543.539186-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChenXiaoSong (2):
  gfs2: factor out __gfs2_ail1_empty() and gfs2_ail1_withdraw()
  gfs2: fix sleep from invalid context bug in gfs2_glock_wait()

 fs/gfs2/log.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

-- 
2.31.1

