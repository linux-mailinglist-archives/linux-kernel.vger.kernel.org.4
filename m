Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E697467C65E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjAZIz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjAZIzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:55:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 234D442BE9;
        Thu, 26 Jan 2023 00:54:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37D19C14;
        Thu, 26 Jan 2023 00:55:27 -0800 (PST)
Received: from [10.34.100.128] (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F7463F71E;
        Thu, 26 Jan 2023 00:54:42 -0800 (PST)
Message-ID: <26a57d7f-5917-c54b-2f96-492346a599a1@arm.com>
Date:   Thu, 26 Jan 2023 09:54:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 6/6] arch_topology: Build cacheinfo from primary CPU
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20230104183033.755668-1-pierre.gondois@arm.com>
 <20230104183033.755668-7-pierre.gondois@arm.com>
 <CAMuHMdUjgxgOXf5He1x=PLn7MQTjZgFQUHj8JrwbyweT4uOALQ@mail.gmail.com>
 <20230124140420.4srnufcvamvff77v@bogus> <Y8/tl999NQwbPL/R@wendy>
 <20230124144839.2szjjv256j3pdaif@bogus>
 <20230124145541.2xwtr7ro2bjnsjd7@bogus>
 <20230125145423.pid3hsstswzuez73@bogus>
 <CAMuHMdWZ+_kdMp+0VfYAJZRHBWiyobQQJwEM_kHN6yeVVGxSvg@mail.gmail.com>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAMuHMdWZ+_kdMp+0VfYAJZRHBWiyobQQJwEM_kHN6yeVVGxSvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert, Sudeep,

On 1/25/23 16:28, Geert Uytterhoeven wrote:
> Hi Sudeep,
> 
> On Wed, Jan 25, 2023 at 3:54 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>> On Tue, Jan 24, 2023 at 02:55:41PM +0000, Sudeep Holla wrote:
>>> Geert, can you please try with the patch Conor pointed out and see if
>>> that helps to fix the allocation failures[1]
>>>
>>
>> Sorry for the nag, but did you get the chance to test -next with [1]
>> and see if it fixes the cacheinfo memory failure you were observing ?
> 
>> [1] https://lore.kernel.org/all/20230103035316.3841303-1-leyfoon.tan@starfivetech.com/
> 
> After applying that patch, the issue is gone.
> Thanks, sending my Tb!
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds

Happy to hear the issue disappears with the patch, thanks for solving the issue,
Regards,
Pierre
