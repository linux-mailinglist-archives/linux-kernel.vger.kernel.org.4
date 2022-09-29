Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34DF5EF14E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbiI2JH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbiI2JH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:07:56 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E132213FB5B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:07:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VQzEbyZ_1664442467;
Received: from 30.240.99.201(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQzEbyZ_1664442467)
          by smtp.aliyun-inc.com;
          Thu, 29 Sep 2022 17:07:48 +0800
Message-ID: <0a8409f7-4de5-4da4-b186-d5e5aacecd4a@linux.alibaba.com>
Date:   Thu, 29 Sep 2022 17:07:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH] x86/mm/tlb: fix error word 'clleared' to 'cleared'
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     namit@vmware.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220928151109.19364-1-xhao@linux.alibaba.com>
 <YzVc6UwLSwkG7jKX@hirez.programming.kicks-ass.net>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <YzVc6UwLSwkG7jKX@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-14.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/29 下午4:52, Peter Zijlstra 写道:
> On Wed, Sep 28, 2022 at 11:11:09PM +0800, Xin Hao wrote:
>> Just correct the wrong word 'clleared' to 'cleared'
>>
>> Fixes: c9fe66560bf2 ("mm/mprotect: do not flush when not required architecturally")
> Please, don't ever use Fixes on a comment.
Get it, Thanks.
