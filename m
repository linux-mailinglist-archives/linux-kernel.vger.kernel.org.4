Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E6B5FBF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 04:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJLCqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 22:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJLCqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 22:46:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327F16CF7B;
        Tue, 11 Oct 2022 19:46:12 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MnH2t6V9szHtvc;
        Wed, 12 Oct 2022 10:41:10 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 10:46:10 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 10:46:09 +0800
Message-ID: <ddc71922-c7cd-a8ef-057d-7d2b25d31305@huawei.com>
Date:   Wed, 12 Oct 2022 10:46:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] clk: at91: fix the build with binutils 2.27
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        <linux-clk@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221008051534.151392-1-wangkefeng.wang@huawei.com>
 <20221012022816.5E6C6C433C1@smtp.kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221012022816.5E6C6C433C1@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/10/12 10:28, Stephen Boyd wrote:
> Quoting Kefeng Wang (2022-10-07 22:15:34)
>> diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
>> index 3484309b59bf..4fc387d0335d 100644
>> --- a/include/linux/clk/at91_pmc.h
>> +++ b/include/linux/clk/at91_pmc.h
>> @@ -12,6 +12,8 @@
>>   #ifndef AT91_PMC_H
>>   #define AT91_PMC_H
>>   
>> +#include <vdso/bits.h>
> Can we just include linux/bits.h instead? It looks weird to include
> vdso/ outside of the kernel's vdso.
sure, will send v2.
>> +
>>   #define AT91_PMC_V1            (1)                     /* PMC version 1 */
>>   #define AT91_PMC_V2            (2)                     /* PMC version 2 [SAM9X60] */
>>
> .
