Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA496E1968
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDNBF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNBFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:05:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ADB30C7;
        Thu, 13 Apr 2023 18:05:24 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PyJ8Q0bmgzKyS7;
        Fri, 14 Apr 2023 09:02:46 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 09:05:21 +0800
Message-ID: <57c537d8-6728-2ffc-3421-accd79c1eddf@huawei.com>
Date:   Fri, 14 Apr 2023 09:05:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
To:     Robbie King <robbiek@xsightlabs.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
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
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <AS8P193MB2335FA58943B305F97D2BACCCA9A9@AS8P193MB2335.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/11 22:47, Robbie King 写道:
> Apologies, missed earlier emails.  Will make this a priority for the week.
Thanks. Looking forward to you reply.
>
> -----Original Message-----
> From: lihuisong (C) <lihuisong@huawei.com>
> Sent: Sunday, April 9, 2023 9:27 PM
> To: Sudeep Holla <sudeep.holla@arm.com>; Robbie King <robbiek@xsightlabs.com>
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; rafael@kernel.org; rafael.j.wysocki@intel.com; wanghuiqiang@huawei.com; zhangzekun11@huawei.com; wangxiongfeng2@huawei.com; tanxiaofei@huawei.com; guohanjun@huawei.com; xiexiuqi@huawei.com; wangkefeng.wang@huawei.com; huangdaode@huawei.com
> Subject: Re: [PATCH v2 0/2] mailbox: pcc: Support platform notification for type4 and shared interrupt
>
>
> 在 2023/3/27 20:31, lihuisong (C) 写道:
>> 在 2023/3/27 19:33, Sudeep Holla 写道:
>>> On Tue, Mar 14, 2023 at 07:11:33PM +0800, Huisong Li wrote:
>>>> PCC supports processing platform notification for slave subspaces
>>>> and shared interrupt for multiple subspaces.
>>>>
>>> Other than a super minor nit in the patch 1/2, this looks good to me.
>>> It would be good if we can get tested-by from Robbie King
>>> <robbiek@xsightlabs.com>
>>>
>>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>> Thanks for your review.😁
>>
>> @Robbie King, can you give us some feedback?
>> Looking forward to you reply.
>>
>>
> @Robbie King, kindly ping.
