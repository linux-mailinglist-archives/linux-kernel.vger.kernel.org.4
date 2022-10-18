Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4479860244F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJRGZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJRGY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:24:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE7E1F9C8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 23:24:57 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ms3fV4q2TzpVgW;
        Tue, 18 Oct 2022 14:21:38 +0800 (CST)
Received: from [10.67.110.83] (10.67.110.83) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 14:24:55 +0800
Subject: Re: ping// Re: [PATCH v5 0/2] squashfs: Add the mount parameter
 "threads="
To:     Phillip Lougher <phillip.lougher@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <phillip@squashfs.org.uk>,
        <wangle6@huawei.com>, <yi.zhang@huawei.com>,
        <zhongjubin@huawei.com>, <chenjianguo3@huawei.com>
References: <20220916083604.33408-1-nixiaoming@huawei.com>
 <20220930091406.50869-1-nixiaoming@huawei.com>
 <910e5533-4abc-85f1-6bfc-4d776f8bed7b@huawei.com>
 <CAB3wodeXGT0dGxZ+AGJvTU1mMHsqNo4--1c+6UVhYmJj4fO14w@mail.gmail.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <e07213f1-2734-95ce-994f-c707bba4d6ad@huawei.com>
Date:   Tue, 18 Oct 2022 14:24:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <CAB3wodeXGT0dGxZ+AGJvTU1mMHsqNo4--1c+6UVhYmJj4fO14w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/18 6:59, Phillip Lougher wrote:
> On Mon, Oct 17, 2022 at 2:11 AM Xiaoming Ni <nixiaoming@huawei.com> wrote:
>>
>> ping
> 
> I was hoping you'd notice the obvious mistake you made in the patch set,
> and send an updated version, which would avoid me having to point out
> such mistakes again.
> 
> I have replied to patch [1/2]
> 
> Phillip
> 
I'm so sorry.
I'm very ashamed of my serial mistakes.

I'll fix it again later and resend it, I'm sorry I need to take up your 
valuable time to help review it again.


Thanks
Xiaoming Ni


