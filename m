Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779905B2EB8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiIIGVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIIGVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:21:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601AF11FCBE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 23:21:34 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MP5RN0S4cznVFZ;
        Fri,  9 Sep 2022 14:18:56 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 14:21:32 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 14:21:31 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <jlbec@evilplan.org>, <hch@lst.de>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH -next 0/3] configfs: Clean up by adding helpers
Date:   Fri, 9 Sep 2022 14:56:08 +0800
Message-ID: <20220909065611.31695-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clean up in dir.c, inode.c, and symlink.c.

Shang XiaoJing (3):
  configfs: Add configfs_remove_drop_dirent helper
  configfs: Add group_to_dentry helper
  configfs: Add subsys_to_item helper

 fs/configfs/configfs_internal.h |  1 +
 fs/configfs/dir.c               | 61 +++++++++++++++++++++------------
 fs/configfs/inode.c             |  6 +---
 fs/configfs/symlink.c           |  6 +---
 4 files changed, 42 insertions(+), 32 deletions(-)

-- 
2.17.1

