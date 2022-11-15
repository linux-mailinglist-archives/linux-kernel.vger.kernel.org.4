Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071F162ADD4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKOWKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKOWK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:10:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFE8E2FC37;
        Tue, 15 Nov 2022 14:10:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE50F13D5;
        Tue, 15 Nov 2022 14:10:32 -0800 (PST)
Received: from [10.57.6.31] (unknown [10.57.6.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C90D53F73B;
        Tue, 15 Nov 2022 14:10:24 -0800 (PST)
Message-ID: <20ab3aba-0f19-a5a5-1fe6-16f579879c28@arm.com>
Date:   Tue, 15 Nov 2022 23:10:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] cacheinfo: Decrement refcount in cache_setup_of_node()
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Rob.Herring@arm.com,
        sudeep.holla@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20221026185954.991547-1-pierre.gondois@arm.com>
 <CAMuHMdV_rQcKVn73ywh_KcJS2uZ0xTdzGAYcTiQov4UzRouRvQ@mail.gmail.com>
 <CGME20221115193015eucas1p18c4b8ba131b72bc9017a14568a6a54bc@eucas1p1.samsung.com>
 <254cba04-0151-f7f1-1986-a8b763e940d1@samsung.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <254cba04-0151-f7f1-1986-a8b763e940d1@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/22 20:30, Marek Szyprowski wrote:
> Hi Geert,
> 
> On 15.11.2022 14:06, Geert Uytterhoeven wrote:
>> On Wed, Oct 26, 2022 at 9:03 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
>>> Refcounts to DT nodes are only incremented in the function
>>> and never decremented. Decrease the refcounts when necessary.
>>>
>>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> Thanks for your patch, which is now commit 3da72e18371c41a6
>> ("cacheinfo: Decrement refcount in cache_setup_of_node()") in
>> driver-core-next.
>>
>> I have bisected a refcount underflow during s2ram to this commit:
> 
> Similar issue can be reproduced with qemu/arm64 'virt' machine during boot:
> 

Hello Geert, Marek,

Thanks for reporting the issue. The patch at:
https://lore.kernel.org/all/20221115220520.2076189-1-pierre.gondois@arm.com/
should fix it,

Regards,
Pierre
