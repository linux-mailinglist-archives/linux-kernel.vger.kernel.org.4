Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F66C6BD626
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCPQpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjCPQpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:45:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E6B158AD;
        Thu, 16 Mar 2023 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=vut4o6ubLCwL+GJBabXhghmfOyZkTutqKPnYYZdR2xs=; b=xqr4Myq3dKw9Np8YQgXZ2T7AB0
        N1liK+fE8payFGlno5CqiJJm6OrFXLZ7GP0ilh2N2D4XLUzcxA9sU3vYB89YhaS6Vf0U7VvsUfk4i
        6WTw/h1UUyn6D8lCLEebepFjLYxfFdznG/Ixpii5uDKplXpYo9sRD7weTDRWG+FHN8E+Ch25vC62Z
        /PIEclK1vvpsxG4NvEUIfsncl9aMFdv2RXtErjWkWMRLcJ7v2kx3iWd3AT9Ks3CiLqASF/iRWI95R
        msPnnNSOHYy6j9tA3tRPoquYGBfOIrpVj7JYsgBfXbZam5kMHLX3zYtK1le9BDrNqHU6+BZvITZi2
        xyqtclXQ==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pcqiV-00H2dB-0t;
        Thu, 16 Mar 2023 16:44:39 +0000
Message-ID: <ef8fbda8-cace-1db3-9161-abd2e75dcf13@infradead.org>
Date:   Thu, 16 Mar 2023 09:44:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/7 v4] sh: remove sh5/sh64 last fragments
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
References: <20230306040037.20350-1-rdunlap@infradead.org>
 <20230306040037.20350-6-rdunlap@infradead.org>
 <c16434108aaf639782f905ae45e94ea9d58621f1.camel@physik.fu-berlin.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c16434108aaf639782f905ae45e94ea9d58621f1.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/16/23 06:23, John Paul Adrian Glaubitz wrote:
> Hi Randy!
> 
> On Sun, 2023-03-05 at 20:00 -0800, Randy Dunlap wrote:
>> A previous patch removed most of the sh5 (sh64) support from the
>> kernel tree. Now remove the last stragglers.
>>
>> Fixes: 37744feebc08 ("sh: remove sh5 support")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Cc: linux-sh@vger.kernel.org
>> Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> ---
>> v2: update after adding the parisc64 alias to kbuild.rst
>> v3: skipped
>> v4: refresh & resend
>>
>>  Documentation/kbuild/kbuild.rst                           |    1 -
>>  Documentation/scheduler/sched-arch.rst                    |    2 --
>>  Documentation/translations/zh_CN/scheduler/sched-arch.rst |    2 --
>>  scripts/checkstack.pl                                     |    7 -------
>>  tools/perf/arch/common.c                                  |    2 --
>>  tools/scripts/Makefile.arch                               |    5 -----
>>  tools/testing/selftests/mm/Makefile                       |    2 +-
>>  tools/testing/selftests/mm/run_vmtests.sh                 |    2 +-
>>  8 files changed, 2 insertions(+), 21 deletions(-)
>>
>> diff -- a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
>> --- a/Documentation/kbuild/kbuild.rst
>> +++ b/Documentation/kbuild/kbuild.rst
>> @@ -161,7 +161,6 @@ But some architectures such as x86 and s
>>  
>>  - x86: i386 for 32 bit, x86_64 for 64 bit
>>  - parisc: parisc64 for 64 bit
>> -- sh: sh for 32 bit, sh64 for 64 bit
>>  - sparc: sparc32 for 32 bit, sparc64 for 64 bit
>>  
>>  CROSS_COMPILE
> 
> This hunk doesn't apply anymore since the parisc part has been dropped although I can't
> find the commit for that. Could you rebase your patch, please?

The parisc part has not been dropped. It's in linux-next but not yet in mainline.
(commit 49deed336ef9a)

Do you want this patch to apply to mainline? (I created it in linux-next.)
I can do that in a few hours. I'm busy ATM.

I suppose there will be a merge conflict between parisc and SH.


> Apologies that I didn't have the time earlier to start looking at this series!

No problem. We'll get there.  Thanks.

-- 
~Randy
