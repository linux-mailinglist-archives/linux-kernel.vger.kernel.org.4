Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA1C6874AC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 05:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjBBEuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 23:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjBBEua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 23:50:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86A283258
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 20:48:47 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P6mSs3JhSznVtx;
        Thu,  2 Feb 2023 12:46:05 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 2 Feb 2023 12:48:08 +0800
From:   Longlong Xia <xialonglong1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <xialonglong1@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <chenwandun@huawei.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: Re:[PATCH -next] cleanup of devtmpfs_*_node()
Date:   Thu, 2 Feb 2023 04:47:19 +0000
Message-ID: <20230202044719.1254691-1-xialonglong1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202031046.1224338-1-xialonglong1@huawei.com>
References: <20230202031046.1224338-1-xialonglong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forget to CC mail list, will resend, please ignore
this one.
