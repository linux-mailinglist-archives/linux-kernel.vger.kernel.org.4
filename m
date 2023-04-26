Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E0C6EF69B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbjDZOl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241032AbjDZOl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:41:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998727280;
        Wed, 26 Apr 2023 07:41:25 -0700 (PDT)
Received: from [192.168.1.43] ([77.7.2.190]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mgvan-1qU1QJ17AT-00hOoH; Wed, 26 Apr 2023 16:41:18 +0200
Message-ID: <62fa90f7-e465-8cd7-3007-dd5104bcabe5@metux.net>
Date:   Wed, 26 Apr 2023 16:41:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Content-Language: tl
To:     Hans Petter Selasky <hps@selasky.org>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <441a96cb-7dd1-0885-df64-933ebdb55e9e@selasky.org>
 <0ec4becd05c49e8f0bf214fbd62208ea67c2b4c3.camel@collabora.com>
 <6fc0a0c6-a7c9-5350-9b9e-1ea9dab568d0@selasky.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
In-Reply-To: <6fc0a0c6-a7c9-5350-9b9e-1ea9dab568d0@selasky.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Sa3AMuNG8WdeBgqUAVs2KtHI4Dk2mZJi+AcM13wq1T4mCJFlomF
 Nl2J1o7G1HqDVOKgPbqJica18/CKR0OuBDRF+6eLtGcmORDgGiVrLYfLcgooFu/jbTWVcyQ
 XuXbF2R7VwHpRO03zdFBo8wy7uBXwl7AeA6Y0bwvcz+diY1jwigdPI80Sg3b1OdZVlP7FsI
 bdMm7mjNPGzjiE19k8uEg==
UI-OutboundReport: notjunk:1;M01:P0:/CDVuJ8S2Lk=;NbIQR9K0/rzirW61wQVQ18ijocO
 +dLHEb4xDdSZIS8LxMoivDw/r3EuIKPxjMmZNvSdMacL2D0W2HdFl0nyWFJgnhX7jETxETOCH
 G+3t8FbpgIj7xE/8QqLkNGRwhFkVOGVEKaJFYvqcXbA2CbEVPtrv3ICdG7E5bac1wbGsUe5t4
 XJTV8To8h0uid4CSsnf3RxT1tJLE7BQ+ClvmXoDr1yUggfL2MU+YTDL/FMLOMFJW6Zk2g5kGD
 lJbLkUXJZAubHkKqChyALrO0/xIR0HRBKFPjC27VhHMzRnNzWEo0LuMWhNcny17aBrIBeuJn2
 3ZfW5RbYcF8U+OcNkLb+EE1WSfxSvB6mL1je1+cBwCd30Ah4oO4q+RM4+d1zHybeLBI6MLZ8/
 bsRL3pYLU3/06OAVrmqqfaNM63TAdFBGGFepNcQONLZujuAyzT5cb+716ol85EdeDN+1a+Kgl
 95uFygGuhkyoyEmD4WauAyGOnKtwNPhptUlnfsHrvZbUekt1F7tHvAQ1IsqJK7odKEbhVANLE
 /NBxlvMi5fcpSMhimVRcx0shw581807oQhoHzpmaChgK1/HTijHb0L3arxXOl0/nN6/7uiiRr
 TiqKrXalWZXZHIocYfm6LbX8IjAjYRO4qoD7mSKvoxkpMOhraJLLMvrmJkHZfKRRCAwdzPQ1p
 7S+6Av1QkEjmmNmyXSaqfgxHSLeQrGERPDVb99hWOg==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.04.23 20:59, Hans Petter Selasky wrote:

> Adding a dependency to build the Rust compiler even to build one or two 
> V4L2 device drivers, would mean a lot to my small hselasky/webcamd 
> project. It already has to fetch a copy of the Linux kernel, and now has 
> to bootstrap Rust from stage0 to stageN.

Did it ever cross your mind, being a bit thankful that you can use our
Linux code for your BSD project ?

Linux kernel code was never meant to be used anywhere outside the Linux
kernel. It's cool to see that such things are possible, but that's
really out of scope here.

> I personally say no. It's like 
> XCode unfortunately. I download 100's of GBytes of upgrades to XCode, 
> and barely upload one millionth worth of code back to Apple. It's not 
> good. Software developers shouldn't have to download more stuff than 
> they upload?

Where does the connection to Xcode come from ?

> Why not move Linux-V4L2 drivers to user-space? 

Feel free to send patches.

>> The reality is that it isn't up to anyone to say who should or
>> shouldn't become
>> a kernel developer. The resources are out there for anyone to try, and
>> if
>> maintainers take in their patches, then that's the end of the story.
> The GPLv2 license should not be the only reason behind Linux developers 
> putting drivers in the kernel-space. I think moving more stuff to 
> user-space would benefit a greater purpose.

I don't recall any specific case for the license being the primary
reason for putting someting into the kernel instead of userland.

If you want userland v4l drivers: feel free to send patches. Those
should also be capable of directly passing around HW buffers between
separate devices (eg. fg -> codec -> display), which often is
performance critical in embedded devices.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
