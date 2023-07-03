Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC92E7455BF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjGCHJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGCHI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:08:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72648DD;
        Mon,  3 Jul 2023 00:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688368119; x=1688972919; i=deller@gmx.de;
 bh=luZeGm1GXeAsE8r2D/0EeQwg0QXYvcH0kDHoE08Z2OQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=pM2ZSHbaaXLsfr+Td+QUPXbRJSAGjK0UcFVjw+kSUZQXr7BIXpy3ebqanBeadAEjqu9ahMz
 o2DvwIoefhGbzQp4J0GuGarLBTPu8rRJ66Mv/sITmCTqG4Xnk/ZcWlntm2o3hfn00FHNRwmAt
 b26d+JxCwm/bDQWw1yrHEf9ihgm5lgzzYGdOzQNxVTk1GdyGRHD4ygTurC8KwUjm8igRqocoj
 eh1TXDictbtorxNkSrl2KwTcaDYEliYXGrA26fUXJM/nwAJYuSKKsTnjLhVHXBhB5KG7wcryr
 ezICwIlec7w6vKtTMj3NsEmm5RrDKszb05chCdX8M0JkOgxLe16g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2aD-1pZ9Pc0tiZ-00kC05; Mon, 03
 Jul 2023 09:08:39 +0200
Message-ID: <7146f74d-8638-46c7-8e8c-15abc97a379f@gmx.de>
Date:   Mon, 3 Jul 2023 09:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John David Anglin <dave.anglin@bell.net>
References: <20230629184151.888604958@linuxfoundation.org>
 <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <2023063001-overlying-browse-de1a@gregkh>
 <0b2aefa4-7407-4936-6604-dedfb1614483@gmx.de>
 <5fd98a09-4792-1433-752d-029ae3545168@gmx.de>
 <CAHk-=wiHs1cL2Fb90NXVhtQsMuu+OLHB4rSDsPVe0ALmbvZXZQ@mail.gmail.com>
 <CAHk-=wj=0jkhj2=HkHVdezvuzV-djLsnyeE5zFfnXxgtS2MXFQ@mail.gmail.com>
 <9b35a19d-800c-f9f9-6b45-cf2038ef235f@roeck-us.net>
 <CAHk-=wgdC6RROG145_YB5yWoNtBQ0Xsrhdcu2TMAFTw52U2E0w@mail.gmail.com>
 <2a2387bf-f589-6856-3583-d3d848a17d34@roeck-us.net>
 <CAHk-=wgczy0dxK9vg-YWbq6YLP2gP8ix7Ys9K+Mr=S2NEj+hGw@mail.gmail.com>
 <c21e8e95-3353-fc57-87fd-271b2c9cc000@roeck-us.net>
 <CAHk-=wj+F8oGK_Hx6YSPJpwL-xyL+-q2SxtxYE0abtZa_jSkLw@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAHk-=wj+F8oGK_Hx6YSPJpwL-xyL+-q2SxtxYE0abtZa_jSkLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zhNIve0Qn9wedvW+caLKaSTKvmFAILjNj7cOhlw/NpMQSs0L19O
 INKh9GBEywpaOqTgxw0u4T8E72R4bmbtihWSChGiCp/oNsBrEkcdnYMaQNfMkYEsYC+bNkL
 LJPd1/WAu3bAZh0PA61+XUaXhOd1qqr13EDNu/hu4b21CuTO76v3RuRmN78vVZsbjZBej4O
 bhUh9JaxrRs+ZwzuSBjGw==
UI-OutboundReport: notjunk:1;M01:P0:hnRkHV78HyA=;TW/3kwgffETGuHe+FcWFOGGyGRa
 vDVXDyQl85KlqKWEBwwaF2xBM0lRabcQ0xKgTHOUPSpU5ky+PepqqWcFShVuUI2nTA/tPto3t
 jiKH4cDeFwCM618wB/G2ByisUOL8sJ8+LKeQrN9cBmRZp1Uj45cNseWppH17BprDguPKkjbvO
 UIZXcvp3T/zoFlQZPrsSoxK7INljy+ftTXTTSekO1cqbB21GRLkLxxhM55U6IbnZWthZZU0YI
 9JtbNkpFgEA1ARiIRzcxQeuVHa0julagiPmgV3ehp3Q0p6V33ullSfcCiJp73LJigYAq+JTk+
 JOzbC4m7bnfGBhYm31Ca6lxsZlDhmN+NrWc4Ny+RkUH2x88zUjSlOXfQgDWwI0ajia4lp0iIf
 9wEHhR0PksjclwmoI3ctejXmDjCtzJRZDh9ih3c8e0fTG/Cu6h/3XMY1SZ6V+7tyxRBOX1gtc
 rBppkZtpfWfZOTYeHFDd6eMGwOxQEuxRKDihlEYQkbMV6IbPA2RoQ+Bwt2P7uFFlSPA6aFqHa
 xXlzMYO91L2IOOpqN/4DkSynN0dqmPIy9rS+Qd5We0MLJnFABR8I+uTKQkklaM2ra3FIQi7x/
 Qmi52xk80itcBeGVYQPNQgI0rVI+5JnPoPq7h4D9C7nRa/SocaV2/cAg5HNOIjL3Fg+1VF4ya
 ZYqd72kS7Dhq+CLLCNCzbO1iG+wsSeyM4nt79ocXIYoXk9TCvCYv9kcaz2spLfdZ6QmsZAi2V
 sGlL0xKX1L241GSAKRCUiur4CtQOf2QOYbCWHYTUG8arUJuh3XvxHKUx76wKF4xkpN5cewzQf
 Qw5j/byG/1zfNB1I/wx2uaBAobNXZvIu0UpSFCBRDb5SKlYf/ICyqlCquNF7cJctfudcteWXO
 Xv7uOIogdd0CtKL8KMpre/J/eSn5VQiCHaak4DGElEYhQtuhZJP4FQ0hA5apK5c45ktqR/xwE
 rVwlPTuB4/rjMK7tX2M+FLnZfF0=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 7/3/23 08:20, Linus Torvalds wrote:
> On Sun, 2 Jul 2023 at 22:33, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Here you are:
>>
>> [   31.188688] stack expand failed: ffeff000-fff00000 (ffefeff2)
>
> Ahhah!
>
> I think the problem is actually ridiculously simple.
>
> The thing is, the parisc stack expands upwards. That's obvious. I've
> mentioned it several times in just this thread as being the thing that
> makes parisc special.
>
> But it's *so* obvious that I didn't even think about what it really impl=
ies.
>
> And part of all the changes was this part in expand_downwards():
>
>          if (!(vma->vm_flags & VM_GROWSDOWN))
>                  return -EFAULT;
>
> and that will *always* fail on parisc, because - as said multiple
> times - the parisc stack expands upwards. It doesn't have VM_GROWSDOWN
> set.
>
> What a dum-dum I am.
>
> And I did it that way because the *normal* stack expansion obviously
> wants it that way and putting the check there not only made sense, but
> simplified other code.
>
> But fs/execve.c is special - and only special for parisc - in that it
> really wants to  expand a normally upwards-growing stack downwards
> unconditionally.
>
> Anyway, I think that new check in expand_downwards() is the right
> thing to do, and the real fix here is to simply make vm_flags reflect
> reality.
>
> Because during execve, that stack that will _eventually_ grow upwards,
> does in fact grow downwards.  Let's make it reflect that.
>
> We already do magical extra setup for the stack flags during setup
> (VM_STACK_INCOMPLETE_SETUP), so extending that logic to contain
> VM_GROWSDOWN seems sane and the right thing to do.
>
> IOW, I think a patch like the attached will fix the problem for real.
>
> It needs a good commit log and maybe a code comment or two, but before
> I bother to do that, let's verify that yes, it does actually fix
> things.
>
> In the meantime, I will actually go to bed, but I'm pretty sure this is =
it.

Great, that patch fixes it!

I wonder if you want to
#define VM_STACK_EARLY VM_GROWSDOWN
even for the case where the stack grows down too (instead of 0),
just to make clear that in both cases the stack goes downwards initially.

Helge
