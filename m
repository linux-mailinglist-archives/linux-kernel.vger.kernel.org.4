Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16E35BD99C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiITBqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiITBqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:46:09 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FB03BC75
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:46:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VQGgUhH_1663638364;
Received: from 30.240.98.170(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQGgUhH_1663638364)
          by smtp.aliyun-inc.com;
          Tue, 20 Sep 2022 09:46:05 +0800
Message-ID: <4d1041d6-2163-1a90-7f25-daf72f7d139c@linux.alibaba.com>
Date:   Tue, 20 Sep 2022 09:46:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH V3] mm/hugetlb: add available_huge_pages() func
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     songmuchun@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220917011528.11331-1-xhao@linux.alibaba.com>
 <YykCPfGkMwNksqCs@monkey>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <YykCPfGkMwNksqCs@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/20 上午7:58, Mike Kravetz 写道:
> On 09/17/22 09:15, Xin Hao wrote:
>> In hugetlb.c file, there are several places to compare the values of
>> 'h->free_huge_pages' and 'h->resv_huge_pages', it looks a bit messy, so
>> there add a new available_huge_pages() func to do these.
> Thanks, I think the code looks a little better with this change.
>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> Changes from v2
>> https://lore.kernel.org/linux-mm/20220916064127.1904-1-xhao@linux.alibaba.com/
>> - Convert is_resv_equal_free() to available_huge_pages()
> I believe the above 'Changes from v2' information should be below the marker
> '---' as it will not be included in the changelog.
Ok, i will remove the changelog in the next patch.
>
>> ---
>>   mm/hugetlb.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
> The changes look fine,
>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
