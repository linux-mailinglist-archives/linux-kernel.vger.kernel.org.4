Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1532F6070BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJUHMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJUHMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:12:10 -0400
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAF36156
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:12:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id D9D86604F6;
        Fri, 21 Oct 2022 09:12:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666336326; bh=/3PWYcnWXVIz8kqWweN+aE56j9N52ods25cY6FPuoko=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dFINKL1jhxgnngpAfyAsU0P2J3x7chBayHK20zTAOnMbMJyvjP4R60KqYgMc29YrF
         x+LrtvE9nRHxLtPvo6+nJgBDN07s+uWoDBFo62vmOkNDhDFkAbZ9rVtBneHMzrlFng
         w1Ezfd4oa/SNKksTpVU8y1Za4ZiemYLiMbqfV08hdCGOiANt88DyzRKUKLBS7YJgFx
         XNAqJv32ynbafYlHbZg0nhZoyQcZsZyIqfa7yZFhi7mTsZ35nDDjvooK8wdn7ha+jI
         Nagz7msbjNYn6de5FGy490JRZxOwtOk4D+EJvsnThKxR8MpLTFyvMcVULW04r8KFXg
         M+ZUEd1Cm/K9Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nFOXzUTzzb2B; Fri, 21 Oct 2022 09:12:04 +0200 (CEST)
Received: from [10.0.2.105] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id AA4E6604EC;
        Fri, 21 Oct 2022 09:12:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666336324; bh=/3PWYcnWXVIz8kqWweN+aE56j9N52ods25cY6FPuoko=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BREGvZnrSouo9uMQ7jrwaTnDjjWzHlCSS7PTC70SmZm8LY6pzDQZ3MSgfuYo+rTIT
         ueiNtG8IkwoM7qcWqSS7Dopyxt8cFLjORcRcbUokwD/rZ8CzGViOww1MeBn2zWq+my
         P8po+xk7H4av+XY279KuT5UMdNtxJJfhDxI+JrEfwnfv/WKBxrSNNt+oG7GBCeN4pt
         1YHTutt66iK9HDmnboIrBDKDOSfuWgY26aMOotQGW9eKOZHCBwTtLJT6Kmr7HUjgR9
         HjEmEtQQKDEnxfVjET+EVu20qgvDkv61YLWz9+Eas4PMsCuybsO31Ro/4HGg/W2pHX
         6ATukTq2DHNAA==
Message-ID: <6b23f145-9bb3-281d-5d59-ccc73afd617d@alu.unizg.hr>
Date:   Fri, 21 Oct 2022 09:12:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Slade Watkins <srw@sladewatkins.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jintao Yin <nicememory@gmail.com>, hsinyi@chromium.org,
        linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        regressions@leemhuis.info, regressions@lists.linux.dev
References: <20221018174157.1897-1-phillip@squashfs.org.uk>
 <20221020135545.586-1-nicememory@gmail.com>
 <41ef4b22-eea8-2d67-99d8-6aaae7d25ac1@squashfs.org.uk>
 <02b72b86-7240-5530-477a-c8bdcfd35ef5@gmail.com>
 <CA+pv=HO36vMH6Uqu412MF+Hmu-+57QeapGt6k+QDDxr-AsbJkw@mail.gmail.com>
 <3a6c0d0c-68ad-ffbb-0e56-c0282ac84149@squashfs.org.uk>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <3a6c0d0c-68ad-ffbb-0e56-c0282ac84149@squashfs.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.2022. 3:48, Phillip Lougher wrote:

> On 21/10/2022 00:44, Slade Watkins wrote:
>> [Resend due to formatting issue, thanks gmail.]
>>
>> On Thu, Oct 20, 2022 at 7:23 PM Bagas Sanjaya <bagasdotme@gmail.com> 
>> wrote:
>>>
>>> Ah! I was about to test his third fixup patch. I prefer to go
>>> with your fix instead (as the formal patch).
>>
>> +1, agreed.
>>
>> -srw
>
> His patch is wrong, plus he's broken a number of rules of conduct, two 
> serious.  But, I will not reprimand him as kernel maintainer for what is
> probably extreme naivety, unless I have to.
>
> The link to the full set of patches is here
>
> https://lore.kernel.org/lkml/20221020223616.7571-1-phillip@squashfs.org.uk/ 
>
>
> The first patch fixes the regression reported here in the correct way.
>
> The second patch fixes another regression (which is separate to the
> regression causing the issue here).  This is where the code incorrectly
> extends readahead beyond the end of the file.  This is the reason for
> the unused trailing pages that Jintao Yin noticed.  But, this patch
> fixes the cause, rather than fixing the symptom.
>
> The third patch fixes the buffer release race condition that I
> posted a fix for earlier.
>
> Spitting this into three patches is one of the rules.  Each patch should
> do one thing, and one thing only.  Three separate regressions means
> three separate patches.  This is a requirement for "git bisect" to work
> effectively.

Dear Mr. Phillip,

My squashfs learning curve isn't yet at the stage to verify what your 
statements,
however, separating each of the regression causes into different patches 
seems
logical even to me.

I can confirm a successful build of mainline vanilla 6.1-rc1 + your 
patches-[012/3].

The snapped Firefox with the previously held windows and tabs that caused
the initial regression reproduce now work seemingly OK.

Have a nice day.

Best regards,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union
--
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

