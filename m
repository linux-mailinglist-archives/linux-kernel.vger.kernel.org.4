Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B91638212
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 02:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiKYBUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 20:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYBUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 20:20:35 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2460818B1A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 17:20:31 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NJH8q5gLzzmW9b;
        Fri, 25 Nov 2022 09:19:55 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 09:20:29 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 09:20:28 +0800
Subject: Re: [PATCH 3/3] arm_scpi: modify to support acpi
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Wang Honghui <honghui.wang@ucas.com.cn>
CC:     Cristian Maruss <cristian.marussi@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <F813BC8072CDDB25+Y38Yq2QKFefSupZV@TP-P15V.lan>
 <20221124111015.vrfuroty4fbemqv7@bogus>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <5c005ae4-bdf2-8d4a-ef3a-c2964c9df5d8@huawei.com>
Date:   Fri, 25 Nov 2022 09:20:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20221124111015.vrfuroty4fbemqv7@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/11/24 19:10, Sudeep Holla wrote:
> Hi Wang,
> 
> On Thu, Nov 24, 2022 at 03:09:31PM +0800, Wang Honghui wrote:
>> arm_scpi: modify to support acpi
>>
> 
> 1. The commit message is pretty useless. I don't get the complete picture
>     of why you need this change or what you are trying to do in this change.
> 
> 2. I am unable to see the series as a whole, just have 2 versions of 3/3
>     in my inbox.
> 
> 3. This is not the correct way to use SCPI or mailbox in ACPI. You need
>     to use PCC and PCC OpRegion to achieve what you want. The whole SCPI
>     protocol details gets abstracted in the firmware(ACPI ASL)

Agreed, using PCC for ARM SCPI support, not some self-defined bindings.
If you have any issue to support SCPI in your platform, we can add the
support in the ACPI spec first, but from what I read from the ACPI spec,
the PCC or PCC OpRegion can support SPCI well, let me know if any
issues.

Thanks
Hanjun
