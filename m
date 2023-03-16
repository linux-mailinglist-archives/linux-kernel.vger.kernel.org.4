Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFFC6BDA57
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCPUnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCPUnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:43:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6505517141;
        Thu, 16 Mar 2023 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=TiQpKzxmbylVNd1yP8f+Wf08T0BPYKwuQVVHeaODFRc=; b=d7dqqTbmXtjehn6662h+1ThQtK
        t9PbgKUabVB4t/7OZ5qqK31DLvqmnl6FTyn5bQpwgaGtfhdwjaQOio/zoQT6MHBbM3BF5uJhGxszB
        iHBeOhGZF+AInKlWux459KYvzp10u2bmPQeyADv/9+YnuAOJhn8v/c/3Dzr9SJkJlFycJl630l9jT
        EKBKIqTUmbf8CVEz2s7FllMazoodAAhm0dHiPGC3Ym0YFg+cMAvZiTqST6siZNtqUEBI+aOOfCeRc
        TLp2W+dcfaedUXZFPzLDHA4cbyeE95x6umuaz4dmedk7n85c6PUCorzqqWloo1znK7Tqg/6QnM1Uj
        rTQFTM8w==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pcuRJ-00HXe9-1w;
        Thu, 16 Mar 2023 20:43:09 +0000
Message-ID: <ca94954e-88ea-6707-d2a5-722e589d0c87@infradead.org>
Date:   Thu, 16 Mar 2023 13:43:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/7 v4] sh: remove sh5/sh64 last fragments
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
References: <ef8fbda8-cace-1db3-9161-abd2e75dcf13@infradead.org>
 <A8D501D3-68ED-4112-BDA7-EE67357A2E28@physik.fu-berlin.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <A8D501D3-68ED-4112-BDA7-EE67357A2E28@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/23 09:52, John Paul Adrian Glaubitz wrote:
> 
> 
>> On Mar 16, 2023, at 5:45 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> ﻿Hi--
>>
>>> On 3/16/23 06:23, John Paul Adrian Glaubitz wrote:
>>> Hi Randy!
>>>
>>>> On Sun, 2023-03-05 at 20:00 -0800, Randy Dunlap wrote:
>>>> A previous patch removed most of the sh5 (sh64) support from the
>>>> kernel tree. Now remove the last stragglers.
>>>>
>>>> Fixes: 37744feebc08 ("sh: remove sh5 support")
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>> Cc: Rich Felker <dalias@libc.org>
>>>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>>>> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>>>> Cc: linux-sh@vger.kernel.org
>>>> Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>>>> ---
>>>> v2: update after adding the parisc64 alias to kbuild.rst
>>>> v3: skipped
>>>> v4: refresh & resend
>>>>
>>>> Documentation/kbuild/kbuild.rst                           |    1 -
>>>> Documentation/scheduler/sched-arch.rst                    |    2 --
>>>> Documentation/translations/zh_CN/scheduler/sched-arch.rst |    2 --
>>>> scripts/checkstack.pl                                     |    7 -------
>>>> tools/perf/arch/common.c                                  |    2 --
>>>> tools/scripts/Makefile.arch                               |    5 -----
>>>> tools/testing/selftests/mm/Makefile                       |    2 +-
>>>> tools/testing/selftests/mm/run_vmtests.sh                 |    2 +-
>>>> 8 files changed, 2 insertions(+), 21 deletions(-)
>>>>
>>>> diff -- a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
>>>> --- a/Documentation/kbuild/kbuild.rst
>>>> +++ b/Documentation/kbuild/kbuild.rst
>>>> @@ -161,7 +161,6 @@ But some architectures such as x86 and s
>>>>
>>>> - x86: i386 for 32 bit, x86_64 for 64 bit
>>>> - parisc: parisc64 for 64 bit
>>>> -- sh: sh for 32 bit, sh64 for 64 bit
>>>> - sparc: sparc32 for 32 bit, sparc64 for 64 bit
>>>>
>>>> CROSS_COMPILE
>>>
>>> This hunk doesn't apply anymore since the parisc part has been dropped although I can't
>>> find the commit for that. Could you rebase your patch, please?
>>
>> The parisc part has not been dropped. It's in linux-next but not yet in mainline.
>> (commit 49deed336ef9a)
>>
>> Do you want this patch to apply to mainline? (I created it in linux-next.)
>> I can do that in a few hours. I'm busy ATM.
>>
>> I suppose there will be a merge conflict between parisc and SH.
> 
> Oops, sorry. My bad. I will use the proper tree.

Just let me know if you want me to resend it.
Thanks.

-- 
~Randy
