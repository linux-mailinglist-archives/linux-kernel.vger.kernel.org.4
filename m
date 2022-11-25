Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071B563821C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 02:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKYBjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 20:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiKYBjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 20:39:45 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F99F2A72D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 17:38:56 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NJHZ501bpzmW83;
        Fri, 25 Nov 2022 09:38:21 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 09:38:43 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 09:38:43 +0800
Subject: =?UTF-8?B?UmU6IFJl77yaUmU6IFtQQVRDSCAzLzNdIGFybV9zY3BpOiBtb2RpZnkg?=
 =?UTF-8?Q?to_support_acpi?=
To:     =?UTF-8?B?546L5rSq6L6J?= <honghui.wang@ucas.com.cn>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Cristian Maruss <cristian.marussi@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <tencent_3D435BAB4430B7F532CF2ADD@qq.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <9732f012-f2f5-d770-c9b7-6005fa0c578f@huawei.com>
Date:   Fri, 25 Nov 2022 09:38:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <tencent_3D435BAB4430B7F532CF2ADD@qq.com>
Content-Type: text/plain; charset="gb18030"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Honghui,

On 2022/11/24 22:17, Íõºé»Ô wrote:
> Thanks!
> 
> The uefi firmware was built include ACPI/AML, but current kernel code is not able to extract the info, the ACPI/AML driver of kernel is not enough for majority of  devices , but fdt driver is. I think there's a lot of work to support more acpi driver.

I think the firmware did the wrong thing about SCPI support,
please take a look at ACPI 6.5, chapter 14 Platform Communications
Channel (PCC).

Thanks
Hanjun
