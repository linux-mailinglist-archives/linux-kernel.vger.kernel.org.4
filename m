Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F05F645A3D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLGM4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLGM4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:56:11 -0500
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24BC53ED0;
        Wed,  7 Dec 2022 04:56:09 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=0;PH=DS;RN=18;SR=0;TI=SMTPD_---0VWm7Ihy_1670417763;
Received: from 30.221.145.221(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VWm7Ihy_1670417763)
          by smtp.aliyun-inc.com;
          Wed, 07 Dec 2022 20:56:05 +0800
Message-ID: <737ba26b-d7c1-0014-d97f-33782ea4cd20@linux.alibaba.com>
Date:   Wed, 7 Dec 2022 20:56:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: reply for ACPI: APEI: handle synchronous exceptions in task work
Content-Language: en-US
To:     Lv Ying <lvying6@huawei.com>
Cc:     akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        bp@alien8.de, cuibixuan@linux.alibaba.com,
        dave.hansen@linux.intel.com, james.morse@arm.com,
        jarkko@kernel.org, lenb@kernel.org, linmiaohe@huawei.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        naoya.horiguchi@nec.com, rafael@kernel.org, tony.luck@intel.com,
        zhuo.song@linux.alibaba.com, xiezhipeng1@huawei.com,
        yingwen.cyw@alibaba-inc.com
References: <20221206153354.92394-1-xueshuai@linux.alibaba.com>
 <20221207095413.1980862-1-lvying6@huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20221207095413.1980862-1-lvying6@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/7 PM5:54, Lv Ying wrote:
> Hi Shuai Xue:
> 
> I notice that  we are both handling the same problem, my patchset:
> RFC: https://lkml.org/lkml/fancy/2022/12/5/364
> RFC PATCH v1: https://lkml.org/lkml/2022/12/7/244
> has CC to you 

I am glad to see that the community is trying to address the same problems,
I have replied to your RFC version.

> Yingwen's proposal in 2022/12/06[1]:
> Add Bit 8 in "Common Platform Error Record" -> "Section Descriptor" ->
> Flags (which Now, Bit 8 through 31 – Reserved) 
> 
> [1] https://members.uefi.org/wg/uswg/mail/thread/9453
> 
> Yingwen's proposal makes distinguish synchronous error by CPER report more
> easy, however, it's not supported yet.
> Looking forward to your reply if there is any progress on the proposal and
> your suggestions about my patchset.

Yes, it is not supported yet. So we separated synchronous error handling into
task work based on a similar flag internally.

We submitted the proposal last month after discussed with Tony. But there
is still no progress, I will update it here in time.

Cheers,
Shuai
