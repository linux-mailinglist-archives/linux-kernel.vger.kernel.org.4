Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C024E6BC4FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjCPDym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCPDyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:54:40 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF8C298EC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 20:54:38 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PcYKm123vzKmtg;
        Thu, 16 Mar 2023 11:54:20 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 11:53:59 +0800
Message-ID: <91830203-bc04-a583-ecfb-41da29ac0aad@huawei.com>
Date:   Thu, 16 Mar 2023 11:53:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/3] userfaultfd: convert __mcopy_atomic_hugetlb() to
 use a folio
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <akpm@linux-foundation.org>,
        <vishal.moola@gmail.com>, <sidhartha.kumar@oracle.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20230314131350.924377-1-zhangpeng362@huawei.com>
 <20230314131350.924377-3-zhangpeng362@huawei.com>
 <20230315195328.GA3092@monkey>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20230315195328.GA3092@monkey>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/16 3:53, Mike Kravetz wrote:

> On 03/14/23 13:13, Peng Zhang wrote:
>> From: ZhangPeng <zhangpeng362@huawei.com>
>>
>> Change copy_huge_page_from_user() to copy_folio_from_user().
> Any reason why you did not change copy_user_huge_page to folios as
> well?  All callers are passing &folio->page.
>
> Just my opinion, but it might be better/easier to review if the copy
> routines were done in a separate patch.  There is a little more than
> folio conversion happening there.

Thanks for your review.

I will change copy_user_huge_page to folios and split this patch in a
v3 of this patch series.

Thanks,
Peng.

