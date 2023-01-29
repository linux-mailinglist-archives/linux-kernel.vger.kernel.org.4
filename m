Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C5667FC39
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 02:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjA2Byk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 20:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjA2Byi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 20:54:38 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C861C329
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 17:54:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guorui.yu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VaIuoBd_1674957271;
Received: from 192.168.51.205(mailfrom:GuoRui.Yu@linux.alibaba.com fp:SMTPD_---0VaIuoBd_1674957271)
          by smtp.aliyun-inc.com;
          Sun, 29 Jan 2023 09:54:32 +0800
Message-ID: <bde64a70-7d9c-9e85-cd02-0301d4a0838e@linux.alibaba.com>
Date:   Sun, 29 Jan 2023 09:54:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/4] swiotlb: Add a new cc-swiotlb implementation for
 Confidential VMs
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com,
        linux-coco@lists.linux.dev
Cc:     robin.murphy@arm.com
References: <20230128083254.86012-1-GuoRui.Yu@linux.alibaba.com>
 <20230128083254.86012-3-GuoRui.Yu@linux.alibaba.com>
 <c966018b-95f0-7b92-0a5a-9023236b0dfb@infradead.org>
From:   Guorui Yu <GuoRui.Yu@linux.alibaba.com>
In-Reply-To: <c966018b-95f0-7b92-0a5a-9023236b0dfb@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

在 2023/1/29 00:41, Randy Dunlap 写道:
> Hi--
> 
> On 1/28/23 00:32, GuoRui.Yu wrote:
>> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
>> index 56866aaa2ae1..7e6b20d2091f 100644
>> --- a/kernel/dma/Kconfig
>> +++ b/kernel/dma/Kconfig
>> @@ -78,8 +78,18 @@ config ARCH_HAS_FORCE_DMA_UNENCRYPTED
>>   
>>   config SWIOTLB
>>   	bool
>> +	depends on !CC_SWIOTLB
>>   	select NEED_DMA_MAP_STATE
>>   
>> +config CC_SWIOTLB
>> +	bool "Enable cc-swiotlb for Confidential VMs"
>> +	default n
>> +	select NEED_DMA_MAP_STATE
>> +	help
>> +	  This enables a cc-swiotlb implementation for Confidential VMs,
>> +	  which allows allocating the SWIOTLB buffer allocation on runtime.
> 
> Two "allocat..." words seems to be redundant. Probably the second one
> can be dropped.
> Also, instead of "on runtime", how about "at runtime"?

Thanks for your kindly advice, and I will fix it in the next version.

> 
>> +	  If unsure, say "n".
> 
> Thanks.

Sincerely,
Guorui
