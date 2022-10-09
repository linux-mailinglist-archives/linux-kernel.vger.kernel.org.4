Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6E55F892D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 05:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJIDkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 23:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJIDka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 23:40:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8692E9DB
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 20:40:28 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MlSNy2xp6zHts6;
        Sun,  9 Oct 2022 11:35:30 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 11:40:27 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 9 Oct
 2022 11:40:26 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <chenhuacai@kernel.org>, <lvjianmin@loongson.cn>,
        <chenhuacai@loongson.cn>
Subject: [PATCH -next 0/3] platform/loongarch: laptop: fix some issues
Date:   Sun, 9 Oct 2022 11:40:06 +0800
Message-ID: <20221009034009.60026-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes some issues in error path and remove unnecessary
BUG_ON() in generic_subdriver_init().

Yang Yingliang (3):
  platform/loongarch: laptop: add missing platform_driver_unregister()
    in generic_subdriver_exit()
  platform/loongarch: laptop: add missing generic_subdriver_exit() in
    generic_acpi_laptop_init()
  platform/loongarch: laptop: remove unnecessary BUG_ON in
    generic_subdriver_init()

 drivers/platform/loongarch/loongson-laptop.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.25.1

