Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CFE611F56
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 04:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJ2Cff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 22:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJ2Cfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 22:35:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5497C7436B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 19:35:28 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mzk394c1DzFqRL;
        Sat, 29 Oct 2022 10:32:37 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 10:35:26 +0800
Subject: Re: [PATCH RFC 1/2] mm: Always compile in pte markers
To:     Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20221024204830.1342169-1-peterx@redhat.com>
 <20221024204830.1342169-2-peterx@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <cbbb7a4d-1c96-1102-45fc-5f0ffb329518@huawei.com>
Date:   Sat, 29 Oct 2022 10:35:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221024204830.1342169-2-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/25 4:48, Peter Xu wrote:
> The PTE markers code is tiny and now it's enabled for most of the
> distributions.  It's fine to keep it as-is, but to make a broader use of
> it (e.g. replacing read error swap entry) it needs to be there always
> otherwise we need special code path to take care of !PTE_MARKER case.
> 
> It'll be easier just make pte marker always exist.  Use this chance to
> extend its usage to anonymous too by simply touching up some of the old
> comments, because it'll be used for anonymous pages in the follow up
> patches.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Many thanks for your work.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin


