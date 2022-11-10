Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36841624441
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiKJO2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiKJO2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:28:34 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FA925D1;
        Thu, 10 Nov 2022 06:28:26 -0800 (PST)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N7PMG3bMrz15MNt;
        Thu, 10 Nov 2022 22:28:10 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 22:28:23 +0800
Message-ID: <21498cd9-e84f-2592-8f7b-16c86c4f05fd@huawei.com>
Date:   Thu, 10 Nov 2022 22:28:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH RFC] ACPI: container: Add power domain control methods
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <lenb@kernel.org>, <patchwork@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <wanghuiqiang@huawei.com>, <lihuisong@huawei.com>,
        <wangxiongfeng2@huawei.com>
References: <20221025061437.17571-1-zhangzekun11@huawei.com>
 <CAJZ5v0hpYodc_fd1DtBM-VEmhxepq7eQcQkbDXvWn0uMQ_yGNA@mail.gmail.com>
 <91e13efd-2de9-6fa1-188f-ec74958fff99@huawei.com>
 <CAJZ5v0h1zNSo4E-hk+vBemfV7_gsOe+3Gz-vAcn9AiufTCwX3Q@mail.gmail.com>
From:   "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <CAJZ5v0h1zNSo4E-hk+vBemfV7_gsOe+3Gz-vAcn9AiufTCwX3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.82]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rafael J

Thanks a lot for your advice! I will look into LPI and find a better way
to do what I want.

Best Regards,
Zekun, Zhang

在 2022/11/10 21:05, Rafael J. Wysocki 写道:
> On Thu, Nov 10, 2022 at 1:13 PM zhangzekun (A) <zhangzekun11@huawei.com> wrote:
>> Kindly ping.
> I'm not going to apply this patch if that's what you're asking about.
>
> Please have a look at LPI which is the ACPI way of doing what you want.
>
> If you need to extend the support for it in the kernel, please do so.
>
> If you need to extend the definition of LPI in the ACPI specification,
> there is also a way to do that.
>
> What you are trying to do would require extending the container device
> definition in the specification anyway.
>
>> 在 2022/10/29 1:07, Rafael J. Wysocki 写道:
>>> On Tue, Oct 25, 2022 at 8:17 AM Zhang Zekun <zhangzekun11@huawei.com> wrote:
>>>> Platform devices which supports power control are often required to be
>>>> power off/on together with the devices in the same power domain. However,
>>>> there isn't a generic driver that support the power control logic of
>>>> these devices.
>>> Not true.
>>>
>>> There is the ACPI power resources interface designed to represent
>>> power domains that is well supported and used in the industry.
>>>
>>> If it doesn't work for you, explain why.
>>>

