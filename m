Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8FB615B30
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKBDv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKBDv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:51:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA8C18E2D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 20:51:55 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N2Ccl3KBPz15MJd;
        Wed,  2 Nov 2022 11:51:51 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 11:51:54 +0800
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 11:51:54 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <dave@stgolabs.net>,
        <tangmeng@uniontech.com>, <vbabka@suse.cz>, <mcgrof@kernel.org>,
        <willy@infradead.org>, <zhangjinhao2@huawei.com>,
        <zhengyejian1@huawei.com>
Subject: Re: [PATCH 0/2] Fix encode_comp_t()
Date:   Wed, 2 Nov 2022 11:52:00 +0800
Message-ID: <20221102035200.2879900-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210515140631.369106-1-zhengyejian1@huawei.com>
References: <20210515140631.369106-1-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 5:36:11 +0800, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Sat, 15 May 2021 22:06:29 +0800 Zheng Yejian <zhengyejian1@huawei.com> wrote:
>
> > Type conversion in encode_comp_t() may look a bit problematic.
> >
>
> It took me a while, but these patches seem OK to me.  Is your May 2021
> series still all good to apply?

Yes, they are still good to apply, I have re-checked them in:
https://lore.kernel.org/lkml/20210515140631.369106-1-zhengyejian1@huawei.com/

Those problems seems existed since 1da177e4c3f4 ("Linux-2.6.12-rc2").

-- Best regards, Zheng Yejian

>
> Thanks,

