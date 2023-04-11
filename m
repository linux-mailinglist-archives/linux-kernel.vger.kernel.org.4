Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53526DD64C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjDKJKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDKJKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:10:19 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FFE3C3B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 02:09:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 39F2160501;
        Tue, 11 Apr 2023 11:09:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1681204174; bh=abti+C7bpRHAGHiKGI6drE+s3kKqqLnu5wTasiccstE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iS3FgabE+2TcYAybzLhbkgFJnO8Z+Wm13b2ftekUfm6K4bwIOE/Wv5OurBV8tWfq3
         Jf0/7OmMZ59GbLLVESkJRqro3It+Qb3XJHw1Fd5n45i3xXMjgG9hSZnxx4XKpPYWFI
         GEUZ1fGv9+stlU3Kf1oahlMWpnEMbIhiCtTpyYiZgi4v9moeRQrFQD60YXcxw3xyrr
         UCGiVsoVRwxR3dRBL8RUuyALgqFuxVbVu/FH8w+IkOZtSACzVR0a+1Xcgay8AGGSnq
         8zi3O4bYVD5tfIv2UBmcxw14BFzc0ngSHy0E27N/58E+JnfePbSGQ5nI+Fo4LipYhz
         ey/OV2Ts87sJA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id idlnefPEN3ll; Tue, 11 Apr 2023 11:09:31 +0200 (CEST)
Received: from [10.0.1.96] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id ADD1B604F7;
        Tue, 11 Apr 2023 11:09:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1681204171; bh=abti+C7bpRHAGHiKGI6drE+s3kKqqLnu5wTasiccstE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ew1T5WD6rTFB8Epjs6uBhId8M8esycbLBIb03uyS2JBL5pqjMvF6/gUsgg9wJg05F
         VriuKOOkspcdLvDCdUPcrd7/eEvsBtdUQ4PNQacMVzPlC0SyJmh+oVeK63pVhvmk33
         UeBwN/Xsi/ST7qB/Aq0hqxVlex7DHJAC5aNY1YgLYE+WN5LIRFgW4SQUpxbvL5VNnO
         mjou6mdh5eIsWzekby6Uh3ljC92IXQP6zvurWbh2OEFJwd7D779t46LXeTZtz5zjEu
         Mh2EfFL6+pXKBi1+NaNCsk9Cz9tkJYd3lHj6awRpH4Yq2YFcXzyvkqvDq4xhgalNAP
         /9vajW6ZbtYyQ==
Message-ID: <d702766d-01e2-a5b2-08ac-3a16befa7ab5@alu.unizg.hr>
Date:   Tue, 11 Apr 2023 11:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 1/2] Add release hook to LSM
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230310194159.GB528@domac.alu.hr>
 <ZAuJY1MM3hEiT0ri@smile.fi.intel.com>
 <147c1a43-b5a1-a802-3d14-5f2de8306cc3@alu.unizg.hr>
 <ZAuPjCT/GGy860hW@smile.fi.intel.com>
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZAuPjCT/GGy860hW@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.3.2023. 21:14, Andy Shevchenko wrote:
> On Fri, Mar 10, 2023 at 09:02:18PM +0100, Mirsad Goran Todorovac wrote:
>> On 10. 03. 2023. 20:47, Andy Shevchenko wrote:
>>> On Fri, Mar 10, 2023 at 08:42:00PM +0100, Mirsad Goran Todorovac wrote:
>>>>
>>>> Add release() hook to the definition of the LSM modules, to enable calling
>>>> destructors and deallocating allocated resources cleanly.
>>>>
>>>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>>>
>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>
>>> I haven't given you this tag. Sorry, you must not add something
>>> which was not explicitly given.
> 
>> This change could have long lasting consequences if approved, and I am not
>> continuing the patch submission without your mentoring and approval.
>>
>> It is true that I assumed that you have reviewed the patch, but you did not
>> explicitly give the Reviewed-by tag.
>>
>> But I am rather new to this patch submission process, and please would you
>> please mentor me to do this the right way.
> 
> We have a nice documentation for that [1]. Please, read it in full.
> If some questions left, do not hesitate to ask.
> 
> [1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Hi,

I am catching up on this, and now I see that my Reviewed-by: tag to the patch
proposal you just suggested was way off.

I apologise once again.

I was in clear violation of the Code of Conduct, though I thought I was doing
just what it was demanded.

There is beginner's luck, but there are also newbie errors.

Reviewed-by: as per patch submission instructions implies much more than I have
assumed when writing it.

But they say that a fault that makes one humble is better than the success that
makes him arrogant.

Thank you for taking the time from your busy schedule to instruct me to read
that fine manual, which I ought to have done by myself in the first place.

Thanks again for all the mentoring on the patch submission process.

I haven't Cc:-ed the developers and maintainers not to fill their mailboxes needlessly,
but it goes to the list so this is a public formal apology.

Best regards,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

