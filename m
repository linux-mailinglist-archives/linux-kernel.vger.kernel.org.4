Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9196C62420D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiKJMN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKJMN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:13:28 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ACCF1C;
        Thu, 10 Nov 2022 04:13:25 -0800 (PST)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N7LMT72Mhz15MR0;
        Thu, 10 Nov 2022 20:13:09 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 20:13:23 +0800
Message-ID: <91e13efd-2de9-6fa1-188f-ec74958fff99@huawei.com>
Date:   Thu, 10 Nov 2022 20:13:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH RFC] ACPI: container: Add power domain control methods
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <lenb@kernel.org>, <patchwork@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <wanghuiqiang@huawei.com>, <lihuisong@huawei.com>
References: <20221025061437.17571-1-zhangzekun11@huawei.com>
 <CAJZ5v0hpYodc_fd1DtBM-VEmhxepq7eQcQkbDXvWn0uMQ_yGNA@mail.gmail.com>
From:   "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <CAJZ5v0hpYodc_fd1DtBM-VEmhxepq7eQcQkbDXvWn0uMQ_yGNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.82]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Kindly ping.

在 2022/10/29 1:07, Rafael J. Wysocki 写道:
> On Tue, Oct 25, 2022 at 8:17 AM Zhang Zekun <zhangzekun11@huawei.com> wrote:
>> Platform devices which supports power control are often required to be
>> power off/on together with the devices in the same power domain. However,
>> there isn't a generic driver that support the power control logic of
>> these devices.
> Not true.
>
> There is the ACPI power resources interface designed to represent
> power domains that is well supported and used in the industry.
>
> If it doesn't work for you, explain why.
>

