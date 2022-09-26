Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4275EA835
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiIZORo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiIZORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:17:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3351FCCB1;
        Mon, 26 Sep 2022 05:27:15 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbhjV0b0lzWgwr;
        Mon, 26 Sep 2022 20:22:54 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 20:26:57 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 20:26:56 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v2 0/4] memory: tegra: Use DEFINE_SHOW_ATTRIBUTE to simplify code
Date:   Mon, 26 Sep 2022 21:00:21 +0800
Message-ID: <20220926130025.1061373-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE helper macro to simplify the code.
No functional change.

v1->v2: remove duplicate blank lines.

Liu Shixin (4):
  memory: tegra20-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
  memory: tegra30-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
  memory: tegra210-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
  memory: tegra186-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code

 drivers/memory/tegra/tegra186-emc.c      | 15 +--------------
 drivers/memory/tegra/tegra20-emc.c       | 15 +--------------
 drivers/memory/tegra/tegra210-emc-core.c | 15 +--------------
 drivers/memory/tegra/tegra30-emc.c       | 15 +--------------
 4 files changed, 4 insertions(+), 56 deletions(-)

-- 
2.25.1

