Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5296466F3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLHC2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLHC1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:27:55 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B796E2183E;
        Wed,  7 Dec 2022 18:27:52 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NSJ2C6Lhqz15NCP;
        Thu,  8 Dec 2022 10:26:59 +0800 (CST)
Received: from [10.174.176.219] (10.174.176.219) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Dec 2022 10:27:16 +0800
Subject: Re: reply for ACPI: APEI: handle synchronous exceptions in task work
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     <akpm@linux-foundation.org>, <baolin.wang@linux.alibaba.com>,
        <bp@alien8.de>, <cuibixuan@linux.alibaba.com>,
        <dave.hansen@linux.intel.com>, <james.morse@arm.com>,
        <jarkko@kernel.org>, <lenb@kernel.org>, <linmiaohe@huawei.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <naoya.horiguchi@nec.com>, <rafael@kernel.org>,
        <tony.luck@intel.com>, <zhuo.song@linux.alibaba.com>,
        <xiezhipeng1@huawei.com>, <yingwen.cyw@alibaba-inc.com>
References: <20221206153354.92394-1-xueshuai@linux.alibaba.com>
 <20221207095413.1980862-1-lvying6@huawei.com>
 <737ba26b-d7c1-0014-d97f-33782ea4cd20@linux.alibaba.com>
 <7accd70e-ce35-d540-8254-fa41403b9eab@linux.alibaba.com>
From:   Lv Ying <lvying6@huawei.com>
Message-ID: <da25bfa5-9919-a77d-bf17-0148d70b8434@huawei.com>
Date:   Thu, 8 Dec 2022 10:27:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7accd70e-ce35-d540-8254-fa41403b9eab@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.219]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/7 22:04, Shuai Xue wrote:
> 
> 
> On 2022/12/7 PM8:56, Shuai Xue wrote:
>>
>>
>> On 2022/12/7 PM5:54, Lv Ying wrote:
>>> Hi Shuai Xue:
>>>
>>> I notice that  we are both handling the same problem, my patchset:
>>> RFC: https://lkml.org/lkml/fancy/2022/12/5/364
>>> RFC PATCH v1: https://lkml.org/lkml/2022/12/7/244
>>> has CC to you
>>
>> I am glad to see that the community is trying to address the same problems,
>> I have replied to your RFC version.
>>
>>> Yingwen's proposal in 2022/12/06[1]:
>>> Add Bit 8 in "Common Platform Error Record" -> "Section Descriptor" ->
>>> Flags (which Now, Bit 8 through 31 – Reserved)
>>>
>>> [1] https://members.uefi.org/wg/uswg/mail/thread/9453
>>>
>>> Yingwen's proposal makes distinguish synchronous error by CPER report more
>>> easy, however, it's not supported yet.
>>> Looking forward to your reply if there is any progress on the proposal and
>>> your suggestions about my patchset.
>>
>> Yes, it is not supported yet. So we separated synchronous error handling into
>> task work based on a similar flag internally.
>>
>> We submitted the proposal last month after discussed with Tony. But there
>> is still no progress, I will update it here in time.
>>
>> Cheers,
>> Shuai
> 
> By the way, if you agree with the proposal, please vote to approve it in UEFI community
> with your right on behalf of your organization, then we can make it happen soon. :)
> 

I notice your proposal yesterday, however I have no permission to access 
this proposal[1]. I already made my firmware colleague aware of your 
suggestion yesterday. I will make the meaning and background of this 
work clear to my firmware colleague, I also hope that this work will 
move forward :)

[1] https://members.uefi.org/wg/uswg/mail/thread/9453

-- 
Thanks!
Lv Ying
