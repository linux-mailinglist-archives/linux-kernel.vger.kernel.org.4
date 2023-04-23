Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7906EBCC0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 05:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjDWD6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 23:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDWD6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 23:58:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AD210E0;
        Sat, 22 Apr 2023 20:58:32 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q3vXB0wzZzSsPW;
        Sun, 23 Apr 2023 11:54:18 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 11:58:29 +0800
Message-ID: <4f817538-ef0f-f35a-a748-03d4f7b51506@huawei.com>
Date:   Sun, 23 Apr 2023 11:58:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Robbie King <robbiek@xsightlabs.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>,
        "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "tanxiaofei@huawei.com" <tanxiaofei@huawei.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "huangdaode@huawei.com" <huangdaode@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230314111135.16520-1-lihuisong@huawei.com>
 <20230327113326.dgrb5ainl6mv7wr5@bogus>
 <570a6f6d-87cb-48ca-3bbc-cd1221bfa88c@huawei.com>
 <7ef4eec4-2cfb-6f66-a9b9-9c130a1b71d8@huawei.com>
 <AS8P193MB2335FA58943B305F97D2BACCCA9A9@AS8P193MB2335.EURP193.PROD.OUTLOOK.COM>
 <57c537d8-6728-2ffc-3421-accd79c1eddf@huawei.com>
 <AS8P193MB2335F1954BC345575A2C8829CA999@AS8P193MB2335.EURP193.PROD.OUTLOOK.COM>
 <3d8e8817-12b9-62bc-4c04-34d8822d366f@huawei.com>
 <20230421105510.hjmyt4l3rpx36mhl@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230421105510.hjmyt4l3rpx36mhl@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/21 18:55, Sudeep Holla 写道:
> On Tue, Apr 18, 2023 at 10:21:54AM +0800, lihuisong (C) wrote:
>> 在 2023/4/14 21:48, Robbie King 写道:
>>> Sorry for the delay.  I ran my simple stress test against the patch set and
>>> saw no issues.  For the record it is by no means a thorough regression, but it
>>> has illuminated issues in the past.
>> Thanks for your testing.
>>> The test itself uses a "heartbeat" module in the SCP firmware that generates
>>> notifications at a programmable interval.  The stress test is simply generating
>>> these heartbeats (SCP to AP notifications) while also generating protocol version
>>> queries (AP to SCP).  The notifications are sequence numbered to verify none are
>>> lost, however SCP to AP notification support does not support SCP generating
>>> notifications faster than the AP can process them, so the heartbeat rate must be
>>> reasonably slow (on the order of 10s of millliseconds).
>> I understand your concern. I think this doesn't get int the way of what we
>> are doing.
>>
>> My stress tests were also run in type3 and type4 concurrent scenarios.
>> There were two drivers using type3 to send command looply on platform.
>> In the firmware terminal window,
>> there were two channels for type4 to generate notifications from platform at
>> the 1ms(even shorter) interval.
>> I didn't find anything issues in this stress after running a couple of
>> hours.
>>
>> @Robbie King and @Sudeep, what do you think of my test?
>>
> IMO if there is a need to have this driver changes upstream, then it is good
> enough test as it is the best that can be done at this time. We can always fix
> the bugs or extend to new use-cases in the future.
>
> Since it is merge window next week, it is quite late now. But sometimes
> Rafael picks up additional patches late. So please post v3 even if there
> are no changes with my reviewed-by and Robbie's tested-by so that I can ask
> Rafael to pick it up.
All right. patch 2/2 needs to be updated because of the following patch:
76d4adacd52e ("mailbox: pcc: Use mbox_bind_client")

v3 will be sent ASAP.
>
