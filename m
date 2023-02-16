Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA06C698D28
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBPGhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPGhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:37:43 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C0341B50;
        Wed, 15 Feb 2023 22:37:41 -0800 (PST)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PHQD84kcYzRs4F;
        Thu, 16 Feb 2023 14:35:04 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Feb 2023 14:37:38 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <robbiek@xsightlabs.com>, <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>,
        <lihuisong@huawei.com>
Subject: [PATCH 0/2] mailbox: pcc: Support platform notification for type4 and shared interrupt
Date:   Thu, 16 Feb 2023 14:36:51 +0800
Message-ID: <20230216063653.1995-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20221016034043.52227-1-lihuisong@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.79.22]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCC supports processing platform notification for slave subspaces and
shared interrupt for multiple subspaces.

---
 -v1: using subspace type to replace comm_flow_dir in patch [1/2]
 -rfc-v3: split V2 into two patches.
 -rfc-v2: don't use platform interrupt ack register to identify if the given
      channel should respond interrupt.

Huisong Li (2):
  mailbox: pcc: Add processing platform notification for slave subspaces
  mailbox: pcc: Support shared interrupt for multiple subspaces

 drivers/mailbox/pcc.c | 102 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 9 deletions(-)

-- 
2.33.0

