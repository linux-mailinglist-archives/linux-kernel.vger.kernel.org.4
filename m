Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBABD5E6002
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIVKh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIVKhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:37:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DCEA9C3E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:37:54 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYBWf0hMXzHplf;
        Thu, 22 Sep 2022 18:35:42 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 18:37:52 +0800
Subject: Re: [PATCH] rv/monitor: add __init/__exit annotations to module
 init/exit funcs
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <rostedt@goodmis.org>,
        <mingo@redhat.com>
References: <20220911030418.94609-1-xiujianfeng@huawei.com>
 <d0c8336b-bdaa-8e57-38fa-f570c3d696b8@kernel.org>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <468b3d61-a1a9-a49b-b737-c2d39ca22a4e@huawei.com>
Date:   Thu, 22 Sep 2022 18:37:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <d0c8336b-bdaa-8e57-38fa-f570c3d696b8@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/9/22 17:25, Daniel Bristot de Oliveira 写道:
> Hi Xiu
> 
> The first char after the subsys: must be capital, i.e.,
> 
> [PATCH] rv/monitor: Add __init/__exit annotations to module init/exit funcs
> 
> On 9/11/22 05:04, Xiu Jianfeng wrote:
>> Add missing __init/__exit annotations to module init/exit funcs.
> 
> Please, also add these tags to the monitor templates here:
> 
> 
> tools/verification/dot2/dot2k_templates/main_global.c
> tools/verification/dot2/dot2k_templates/main_per_cpu.c
> tools/verification/dot2/dot2k_templates/main_per_task.c
> 
> So the fix is propagated to future monitors.

Thanks for the review, will do in v2.

> 
> Thanks
> -- Daniel
> .
> 
