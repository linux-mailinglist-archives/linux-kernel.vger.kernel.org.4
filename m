Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1068B6219E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiKHQ5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiKHQ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:56:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF55D59856;
        Tue,  8 Nov 2022 08:56:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D30E1FB;
        Tue,  8 Nov 2022 08:57:00 -0800 (PST)
Received: from [10.57.5.11] (unknown [10.57.5.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1FCB3F703;
        Tue,  8 Nov 2022 08:56:50 -0800 (PST)
Message-ID: <1b2f25e5-cd60-a533-14be-a608f4c801bd@arm.com>
Date:   Tue, 8 Nov 2022 17:56:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/5] ACPI: PPTT: Remove acpi_find_cache_levels()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gavin Shan <gshan@redhat.com>,
        Peter Chen <peter.chen@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221108110424.166896-1-pierre.gondois@arm.com>
 <20221108110424.166896-4-pierre.gondois@arm.com>
 <20221108161315.lmm3sakza5quyzlv@bogus>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20221108161315.lmm3sakza5quyzlv@bogus>
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



On 11/8/22 17:13, Sudeep Holla wrote:
> On Tue, Nov 08, 2022 at 12:04:19PM +0100, Pierre Gondois wrote:
>> acpi_find_cache_levels() is used at a single place and is short
>> enough to be merged into the calling function. The removal allows
>> an easier renaming of the calling function in the next patch.
>>
>> Also reorder the parameters in the 'reversed Christmas tree' order.
> 
> Not sure if the above is worth mentioning explicitly. Even if you do,
> 'parameters' sounds very confusing to at-least me. I was searching for
> the changes is some function parameters to understand what it was and
> finally realised you meant the stack variable declaration order here.
> Right ?

Yes right, I will use another word.

> 
> 
> Other than that, it looks good.
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 

Regards,
Pierre
