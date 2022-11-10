Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B59623936
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiKJBww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiKJBwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:52:49 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C50B48F;
        Wed,  9 Nov 2022 17:52:48 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N74bP1NfTzmVp0;
        Thu, 10 Nov 2022 09:52:33 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 09:52:47 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 09:52:46 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <sudeep.holla@arm.com>,
        <rafael.j.wysocki@intel.com>, <wanghuiqiang@huawei.com>,
        <zhangzekun11@huawei.com>, <wangxiongfeng2@huawei.com>,
        <tanxiaofei@huawei.com>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <wangkefeng.wang@huawei.com>,
        <huangdaode@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 0/3] ACPI: PCC: optimize pcc codes and fix one bug
Date:   Thu, 10 Nov 2022 09:50:31 +0800
Message-ID: <20221110015034.7943-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.79.22]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series optimizes PCC codes as follows:
 - Rename platform interrupt bit macro name to make it more reasonable and
   readable.
 - add check for platform interrupt in acpi_pcc.c

In addition, this series fixes a problem that mailbox channel can still be
requested successfully when fail to initialize PCC.

Huisong Li (3):
  mailbox: pcc: rename platform interrupt bit macro name
  ACPI: PCC: add check for platform interrupt
  mailbox: pcc: fix 'pcc_chan_count' when fail to initialize PCC

 drivers/acpi/acpi_pcc.c | 47 +++++++++++++++++++++++++----------------
 drivers/mailbox/pcc.c   | 13 ++++++++----
 include/acpi/actbl2.h   |  2 +-
 3 files changed, 39 insertions(+), 23 deletions(-)

-- 
2.22.0

