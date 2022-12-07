Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C36456E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiLGJx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLGJx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:53:56 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F816102A;
        Wed,  7 Dec 2022 01:53:55 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRszM70p7zmWJX;
        Wed,  7 Dec 2022 17:53:03 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 7 Dec
 2022 17:53:52 +0800
From:   Lv Ying <lvying6@huawei.com>
To:     <xueshuai@linux.alibaba.com>
CC:     <akpm@linux-foundation.org>, <baolin.wang@linux.alibaba.com>,
        <bp@alien8.de>, <cuibixuan@linux.alibaba.com>,
        <dave.hansen@linux.intel.com>, <james.morse@arm.com>,
        <jarkko@kernel.org>, <lenb@kernel.org>, <linmiaohe@huawei.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <naoya.horiguchi@nec.com>, <rafael@kernel.org>,
        <tony.luck@intel.com>, <zhuo.song@linux.alibaba.com>,
        <xiezhipeng1@huawei.com>, <lvying6@huawei.com>
Subject: reply for ACPI: APEI: handle synchronous exceptions in task work
Date:   Wed, 7 Dec 2022 17:54:13 +0800
Message-ID: <20221207095413.1980862-1-lvying6@huawei.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221206153354.92394-1-xueshuai@linux.alibaba.com>
References: <20221206153354.92394-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuai Xue:

I notice that  we are both handling the same problem, my patchset:
RFC: https://lkml.org/lkml/fancy/2022/12/5/364
RFC PATCH v1: https://lkml.org/lkml/2022/12/7/244
has CC to you 

Yingwen's proposal in 2022/12/06[1]:
Add Bit 8 in "Common Platform Error Record" -> "Section Descriptor" ->
Flags (which Now, Bit 8 through 31 – Reserved) 

[1] https://members.uefi.org/wg/uswg/mail/thread/9453

Yingwen's proposal makes distinguish synchronous error by CPER report more
easy, however, it's not supported yet.
Looking forward to your reply if there is any progress on the proposal and
your suggestions about my patchset.
