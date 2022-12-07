Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1123F645BFF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLGOGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiLGOFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:05:52 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5AB9594;
        Wed,  7 Dec 2022 06:04:58 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=0;PH=DS;RN=18;SR=0;TI=SMTPD_---0VWmLqB6_1670421893;
Received: from 30.120.151.145(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VWmLqB6_1670421893)
          by smtp.aliyun-inc.com;
          Wed, 07 Dec 2022 22:04:54 +0800
Message-ID: <7accd70e-ce35-d540-8254-fa41403b9eab@linux.alibaba.com>
Date:   Wed, 7 Dec 2022 22:04:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: reply for ACPI: APEI: handle synchronous exceptions in task work
Content-Language: en-US
From:   Shuai Xue <xueshuai@linux.alibaba.com>
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
 <737ba26b-d7c1-0014-d97f-33782ea4cd20@linux.alibaba.com>
In-Reply-To: <737ba26b-d7c1-0014-d97f-33782ea4cd20@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/7 PM8:56, Shuai Xue wrote:
> 
> 
> On 2022/12/7 PM5:54, Lv Ying wrote:
>> Hi Shuai Xue:
>>
>> I notice that  we are both handling the same problem, my patchset:
>> RFC: https://lkml.org/lkml/fancy/2022/12/5/364
>> RFC PATCH v1: https://lkml.org/lkml/2022/12/7/244
>> has CC to you 
> 
> I am glad to see that the community is trying to address the same problems,
> I have replied to your RFC version.
> 
>> Yingwen's proposal in 2022/12/06[1]:
>> Add Bit 8 in "Common Platform Error Record" -> "Section Descriptor" ->
>> Flags (which Now, Bit 8 through 31 – Reserved) 
>>
>> [1] https://members.uefi.org/wg/uswg/mail/thread/9453
>>
>> Yingwen's proposal makes distinguish synchronous error by CPER report more
>> easy, however, it's not supported yet.
>> Looking forward to your reply if there is any progress on the proposal and
>> your suggestions about my patchset.
> 
> Yes, it is not supported yet. So we separated synchronous error handling into
> task work based on a similar flag internally.
> 
> We submitted the proposal last month after discussed with Tony. But there
> is still no progress, I will update it here in time.
> 
> Cheers,
> Shuai

By the way, if you agree with the proposal, please vote to approve it in UEFI community
with your right on behalf of your organization, then we can make it happen soon. :)

Thank you.

Best Regards,
Shuai
