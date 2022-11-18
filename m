Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8487B62EDA6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240819AbiKRGd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiKRGdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:33:55 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96CC6455C;
        Thu, 17 Nov 2022 22:33:54 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ND6Rr2c5LzmW2Z;
        Fri, 18 Nov 2022 14:33:28 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 14:33:53 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 18 Nov
 2022 14:33:52 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <rafael.j.wysocki@intel.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <yu.c.chen@intel.com>,
        <linux-acpi@vger.kernel.org>, <guohanjun@huawei.com>,
        <liwei391@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] change to use ACPI_FREE() to free the ACPI memory
Date:   Fri, 18 Nov 2022 14:32:17 +0800
Message-ID: <20221118063219.2612473-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_evaluate_dsm_typed()/acpi_evaluate_dsm() should be coupled with
ACPI_FREE() to free the ACPI memory, because we need to track the
allocation of acpi_object when ACPI_DBG_TRACK_ALLOCATIONS enabled,
so use ACPI_FREE() instead of kfree().

Wang ShaoBo (2):
  ACPI: pfr_telemetry: use ACPI_FREE() to free acpi_object
  ACPI: pfr_update: use ACPI_FREE() to free acpi_object

 drivers/acpi/pfr_telemetry.c | 6 +++---
 drivers/acpi/pfr_update.c    | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.25.1

