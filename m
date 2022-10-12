Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E45FC069
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJLGFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJLGFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:05:30 -0400
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D0B6D9FC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 23:05:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 09027604ED;
        Wed, 12 Oct 2022 08:05:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665554723; bh=xuoJSukhYj9ZILJWRFf+VGISYqH3FXP6oaibbbYodUo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=YhYWF3O5OotSlrKXEsah9GCbDWvcSvycMgT52U+ho1gHqMA1PkLcjwiFWptdseQ78
         OswWRAXLVdgHeQCEMj5IBkMp/lftpBP/gIMOj5u2CrMbNgG1FzXAQkbznqRcwUlj3/
         XypW2i9omn8thwDoXWUE/XQ3+gLUWnjNWS9VOHjLEksmXTcMP9UY+GY9LMOM8MTjgt
         3pbfN7f0nMuyDcoet6RyvVE9CZaiTKGjizRhJWMB2Dz2wofasBaQw1vkiLktM3vQqs
         4eAqjq9Cxs/nhnRDsSeQqFmBg7LzMZUN2mU1+ACLxK3ny+MAjpxntOIyHstBxIbD05
         03IGkQNFgZLQA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TOEZg7Z8QhJ5; Wed, 12 Oct 2022 08:05:19 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 423F9604EC;
        Wed, 12 Oct 2022 08:05:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665554719; bh=xuoJSukhYj9ZILJWRFf+VGISYqH3FXP6oaibbbYodUo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=HNwUUce73fMm3g49fRXg/biKE+SkncvH7fXQp2QLVHnt4xDxwBvVIPCrsMch6url5
         ygTwdbLQV2H5vBshmQ7G1Xbv51F6m6h5meC7jiLj57e7v5YjBF6RNn3bx6hYOJX3bI
         4iguI991pjeLany8S3rS2NdR5p3ghq4wgMUS92d62psR/OmXgANW/lUvWtvNWRdWeT
         ghlIdFc74mJvdjD+FCNxEQZTvOZlSB5N2bzp2OcjDvGyGtzY5YIMYFL0tebgeGfqnq
         8lH3WFDuWKMXmhUfEb43edmnItRpBNHNCbxH7cBIiY60Y+cJu7ja9uu/gVJRZLxQJy
         RRH5WeVzJTkiw==
Message-ID: <e335e7cd-366f-7ced-2707-b6ef49cfe9eb@alu.unizg.hr>
Date:   Wed, 12 Oct 2022 08:05:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: BUG reproduced: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org
Cc:     Marc Miltenberger <marcmiltenberger@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Slade Watkins <srw@sladewatkins.net>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <5bb75cbc-a0db-537b-12d0-889230c865d8@leemhuis.info>
 <0fb2a9ff-df76-8af9-e54a-c2dc6bfd9478@leemhuis.info>
 <bdab45d3-c893-42ff-dbb9-5fa93d0dff55@alu.unizg.hr>
 <dd62210d-d095-f971-2b7b-0ec54fd189a9@leemhuis.info>
 <c05134cc-92fa-dac2-e738-cf6fae194521@alu.unizg.hr>
 <6ba15505-1c04-df2b-237f-b3060f26d2e6@leemhuis.info>
 <25cd0e21-ed8e-1836-b0ec-c052c2276cd8@alu.unizg.hr>
 <c40786ab-8b3b-9b64-683f-dac589c024df@alu.unizg.hr>
In-Reply-To: <c40786ab-8b3b-9b64-683f-dac589c024df@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/22 18:43, Mirsad Goran Todorovac wrote:

> On 10/6/22 14:25, Thorsten Leemhuis wrote:
>>>>>>
>>>>>>> One more question:
>>>>>>>
>>>>>>> On 06.10.22 14:00, Thorsten Leemhuis wrote:
>>>>>>> Were those two vanilla kernels? I asked in #snappy on IRC and 
>>>>>>> was told
>>>>>>> that "snapd simply expects some ubuntu bit in patched into the 
>>>>>>> kernel if
>>>>>>> it detects that it runs on an official ubuntu install...". This 
>>>>>>> was also
>>>>>>> suggested "it probably makes sense to file a but in LP to make the
>>>>>>> kernel team aware".
>>>>>> Yes, last time I tried it with git clone from linux_stable on 
>>>>>> kernel.org
>>>>>> and
>>>>>> config-6.0.0-060000-generic from the official Ubuntu mainline build
>>>>> You don't want to do that. Better take the config used to build a
>>>>> working kernel (say 5.19.y) and then build 6.0 with it (after running
>>>>> "make olddefconfig"), because it might be a new kernel option (say 
>>>>> for a
>>>>> new security technique) that might cause the problem, as explained 
>>>>> here:
>>>>> https://docs.kernel.org/admin-guide/reporting-regressions.html
>>>> If I understood well, that would mean building www.kernel.org git
>>>> linux_stable
>>>> source with Ubuntu's config-5.9.13-051903?
>>> I meant "please download Linux 6.0 (ideally through git, that you have
>>> everything to perform a bisection), add the config from a working 
>>> kernel
>>> (if config-5.9.13-051903 is one, yeah, then take that) as .config and
>>> then run "make olddefconfig" before compiling and installing the kernel
>>> to see if 6.0 fails with that config that was working.
>>
>> Hi, Thorsten,
>>
>> Having done this build with mentioned config-5.19.13-051903-config from
>> Ubuntu's mainline build and your recommended make option
>> had produced a kernel that so far did not exhibit the Firefox snap
>> "tab crash/wrong Verneed record version" bug.
>>
>> However, the uptime is 1d 18h50min, so it might be too early to draw
>> a definite general conclusion.
>>
>> Now, the brave conlusion seems to be that the culprit is one of the 
>> modules
>> added in config-6.0.0-060000-generic.
>>
>> I am new to this, but is seems that we should look at some compiled-in
>> modules (147 loadable and 41 compiled-in):

Hi, guys,

I can also confirm the bug with the official RPM build from elrepo stock 
mainline kernel:

[marvin@pc-mtodorov linux_torvalds]$ uname -rms
Linux 6.0.0-1.el8.elrepo.x86_64 x86_64
[marvin@pc-mtodorov linux_torvalds]$ /snap/bin/firefox &
/snap/firefox/1883/usr/lib/firefox/firefox: 
/snap/firefox/1883/usr/lib/firefox/firefox: no version information 
available (required by /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
/snap/firefox/1883/usr/lib/firefox/firefox: 
/snap/firefox/1883/usr/lib/firefox/firefox: no version information 
available (required by /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
/snap/firefox/1883/usr/lib/firefox/firefox: 
/snap/firefox/1883/usr/lib/firefox/firefox: no version information 
available (required by /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libpthread.so.0: version `' not found (required by 
/snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libpthread.so.0: version `' not found (required by 
/snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/librt.so.1: version `' not found (required by 
/snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/librt.so.1: version `' not found (required by 
/snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: error while loading shared 
libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verneed record
/snap/firefox/1883/usr/lib/firefox/firefox: error while loading shared 
libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verneed record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: error while loading shared 
libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verneed record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: error while loading shared 
libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verneed record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: error while loading shared 
libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verneed record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: error while loading shared 
libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verneed record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: error while loading shared 
libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verneed record
Missing chrome or resource URL: 
resource://gre/modules/UpdateListener.sys.mjs
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/firefox: error while loading shared 
libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verneed record
/snap/firefox/1883/usr/lib/firefox/pingsender: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/pingsender: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
/snap/firefox/1883/usr/lib/firefox/pingsender: error while loading 
shared libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 
0 of Verneed record
/snap/firefox/1883/usr/lib/firefox/firefox: symbol lookup error: 
/snap/firefox/1883/usr/lib/firefox/libxul.so: undefined symbol: PL_strcmp

[1]+  Done                    /snap/bin/firefox  (wd: ~/Downloads)
(wd now: ~/linux/kernel/linux_torvalds)
[marvin@pc-mtodorov linux_torvalds]$

However, I haven't yet done informing the Ubuntu developers.

I will try to do that later today.

-Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia

