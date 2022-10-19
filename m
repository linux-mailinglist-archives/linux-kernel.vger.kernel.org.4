Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D96604D69
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiJSQ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiJSQ3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:29:12 -0400
Received: from smtpcmd02102.aruba.it (smtpcmd02102.aruba.it [62.149.158.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3EF21C906C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:29:10 -0700 (PDT)
Received: from [192.168.50.220] ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id lBwJo6MaJsjaWlBwJoQS9y; Wed, 19 Oct 2022 18:29:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666196948; bh=KWsCb7oSfeaVAXK7sDGwYaVZUTsD5X0vw6E+Eo89lmQ=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=MwPNcV8wK12n91NymN56jBSo3LSW9ItFJpXWJ/UpNLhm19mo9MzCOwZBNPCAGXHxW
         4C+eVO75telqGgVPlv7L/eiIIcUwzXsNOkhvi1DfMhYaIifDULVhiwT7jLR1qlPclK
         CEFI9Oi07xVIL4svdmHdUcUxlk69UYRTJG+pAhPp8xbkMAlN+eAXECt6QLzFY8Ic6O
         f8PQYZZ43KFWxukhd2Z5wADHUeHGvlY+s3L9xH75rxUHKe8kSgXt1vB3ezCGJoP2D0
         4cEF80qQOQWkvmx92UKcujhLdRebWlxc2/O02n+iUZkv6h2iSJ7mwK2jI+3GhSNOKT
         TH8xKgWSubG9Q==
Message-ID: <55de7884-a564-72a4-fe83-173a80aac6ad@benettiengineering.com>
Date:   Wed, 19 Oct 2022 18:29:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 2/2] ARM: mm: convert empty_zero_page to array for
 consistency
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>
References: <20221018222503.90118-1-giulio.benetti@benettiengineering.com>
 <20221018222503.90118-2-giulio.benetti@benettiengineering.com>
 <Y1ANW9ZRRPDJxlmc@shell.armlinux.org.uk>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <Y1ANW9ZRRPDJxlmc@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDFMFHFFTX76a7US2qRhumCRZocCh9AOvE2xr2bwIdRt51fLDpJ1X5JdZzSqq8qq4t72OvjRMsrNYGkF4bYB24gpPNMMU4WDiWvRuvfvxJYYzlpJ+UVg
 y9ui8Fdi8rgh+NL+uxQadOkiXj74ysGRiHn9DB8Pd723WZ2OTRapCNqCSme+IfV2rpGilNdGGAa7V6HitPvqZVdjKwF3axRMiCZPxM7kIyGKdgMFZNIinoDI
 e/9qQZAKPasjBtGxL5VpQp1vSpLbhFrvWERKOZh/uDiVwxBe1XADQnytgIWAIuuzcwQHiwFolp4/4rS7RAAH32qRUXb9QdHqZygBUJSeZSdqDUuU4uVkXNRX
 Jo5YCbzC9dbImmYfbPPdxIHC9p34I3pAg3/YRi50cqlTTv4jRjDHX9EF/jSZHbLgzUpad79MNsEqJmqRidyAOA7VdEDbqIg4HDdTLjYpsc2b1dW4W3xEIkXA
 t5RTTdIXO2yBnOeq
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

On 19/10/22 16:44, Russell King (Oracle) wrote:
> On Wed, Oct 19, 2022 at 12:25:03AM +0200, Giulio Benetti wrote:
>> ARM architecture is the only one to have empty_zero_page to be a
>> struct page pointer, while in all other implementations empty_zero_page is
>> a data pointer or directly an array(the zero page itself). So let's convert
>> empty_zero_page to an array for consistency and to avoid an early
>> allocation+dcache flush. Being the array in .bss it will be cleared earlier
>> in a more linear way(and a bit faster) way.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> 
> I'm completely against this approach. It introduces inefficiencies in
> paths we don't need, and also means that the zero page is at a fixed
> location relative to the kernel, neither of which I like in the
> slightest.

I haven't considered those details, I'm pretty new in this topic.
I was thinking with a no-mmu approach in my mind, that's why the
.bss approach. And also the exposure of the entire array to the other
subsystem is not a good idea.

Thank you for pointing me

Best regads
-- 
Giulio Benetti
CEO/CTO@Benetti Engineering sas
