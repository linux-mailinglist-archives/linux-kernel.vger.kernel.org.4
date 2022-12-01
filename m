Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB67B63F07F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiLAM3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiLAM3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:29:16 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6360CAC190
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:29:12 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NNFjT1lTBz15Mxr;
        Thu,  1 Dec 2022 20:28:29 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 1 Dec
 2022 20:29:10 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <javier@osg.samsung.com>, <mirq-linux@rere.qmqm.pl>,
        <christian@kohlschutter.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] regulator: core: fix some resource leaks
Date:   Thu, 1 Dec 2022 20:27:04 +0800
Message-ID: <20221201122706.4055992-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes resource leaks in some error cases.

Yang Yingliang (2):
  regulator: core: fix module refcount leak in set_supply()
  regulator: core: fix resource leak in regulator_register()

 drivers/regulator/core.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.25.1

