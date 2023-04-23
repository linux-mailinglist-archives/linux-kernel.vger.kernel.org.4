Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C146EBF05
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 13:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjDWLFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 07:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDWLF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 07:05:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB9210DB;
        Sun, 23 Apr 2023 04:05:26 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q453n6myZzsRSL;
        Sun, 23 Apr 2023 19:03:49 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 19:05:24 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <robbiek@xsightlabs.com>, <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <wangkefeng.wang@huawei.com>,
        <huangdaode@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v3 0/2] mailbox: pcc: Support platform notification for type4 and shared interrupt
Date:   Sun, 23 Apr 2023 19:03:33 +0800
Message-ID: <20230423110335.2679-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20221016034043.52227-1-lihuisong@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.79.22]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCC supports processing platform notification for slave subspaces and
shared interrupt for multiple subspaces.

---
 -v3: update requesting shared irq code due to pcc using mbox_bind_client.
 -v2: extract cmd complete code into a function.
      unrelated types regard chan_in_use as dummy.
 -v1: using subspace type to replace comm_flow_dir in patch [1/2]
 -rfc-v3: split V2 into two patches.
 -rfc-v2: don't use platform interrupt ack register to identify if the given
      channel should respond interrupt.

Huisong Li (2):
  mailbox: pcc: Add support for platform notification handling
  mailbox: pcc: Support shared interrupt for multiple subspaces

 drivers/mailbox/pcc.c | 91 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 11 deletions(-)

-- 
2.22.0

