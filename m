Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742146A9100
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCCG0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjCCG0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:26:41 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4994112BFB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 22:26:03 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vd-4.6P_1677824719;
Received: from 30.97.48.241(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vd-4.6P_1677824719)
          by smtp.aliyun-inc.com;
          Fri, 03 Mar 2023 14:25:20 +0800
Message-ID: <65437f0e-dea9-115e-decd-b34cd8c79f81@linux.alibaba.com>
Date:   Fri, 3 Mar 2023 14:25:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: mark z_erofs_lzma_init/erofs_pcpubuf_init w/
 __init
To:     Yue Hu <zbestahu@gmail.com>, Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230303031418.64553-1-frank.li@vivo.com>
 <20230303140405.000035a6.zbestahu@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230303140405.000035a6.zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/3 14:04, Yue Hu wrote:
> On Fri,  3 Mar 2023 11:14:18 +0800
> Yangtao Li <frank.li@vivo.com> wrote:
> 
>> They are used during the erofs module init phase. Let's mark it as
>> __init like any other function.
>>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   fs/erofs/decompressor_lzma.c | 2 +-
>>   fs/erofs/pcpubuf.c           | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
>> index 091fd5adf818..307b37f0b9f5 100644
>> --- a/fs/erofs/decompressor_lzma.c
>> +++ b/fs/erofs/decompressor_lzma.c
>> @@ -47,7 +47,7 @@ void z_erofs_lzma_exit(void)
>>   	}
>>   }
>>   
>> -int z_erofs_lzma_init(void)
>> +int __init z_erofs_lzma_init(void)
>>   {
>>   	unsigned int i;
>>   
>> diff --git a/fs/erofs/pcpubuf.c b/fs/erofs/pcpubuf.c
>> index a2efd833d1b6..c7a4b1d77069 100644
>> --- a/fs/erofs/pcpubuf.c
>> +++ b/fs/erofs/pcpubuf.c
>> @@ -114,7 +114,7 @@ int erofs_pcpubuf_growsize(unsigned int nrpages)
>>   	return ret;
>>   }
>>   
>> -void erofs_pcpubuf_init(void)
>> +void __init erofs_pcpubuf_init(void)
>>   {
>>   	int cpu;
>>   
> 
> Update them in internal.h as well?

Yeah, please help revise, thanks!

Thanks,
Gao Xiang

