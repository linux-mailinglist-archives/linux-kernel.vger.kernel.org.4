Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2230C5EF6AB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbiI2Ncl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbiI2NcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:32:20 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C5A1B0521;
        Thu, 29 Sep 2022 06:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664458311;
        bh=JkHxh9W92WJM230LVDMdsu3OS9WtKyDpwbq54yzCMK4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EX8OkvO/ytMaykh5OU6WcCjOKjKb0QmyjwVlXzTo6NyPe/pIN/Z0+UQivq9AeatRH
         X6ALboTALxtuZUY9EEl6zHGzqd9k8ImtLvISG0RJyCy+i6RUxB4L7ooRwyqx+2pYWo
         gTea+FCZg69ymotLHtQHSPrPzVRxAeD4ERusmEgk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.7.110.20] ([143.244.37.136]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9kC-1oRnlj0SBY-00GVES; Thu, 29
 Sep 2022 15:31:51 +0200
Message-ID: <7b427b41-9446-063d-3161-e43eb2e353f9@gmx.com>
Date:   Thu, 29 Sep 2022 13:31:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, workflows@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
 <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UMFkQq+V7WKXBCQj1sXZb4YI9u1kT3xTYqTeQq2YP4hDWVl9/IL
 SQOZbe4vrN9aCDKiD4RQ69kFHoQzxD9AhU1mE98E2nbz/CUH0zz+M2wuGTISZvVigCW8vQ1
 G+Ir1PSt2A1/gqiq8xXW8m464qXDx5URtZMtem0ScXdB+ezAJaQm/mEXdlfAUCQLWzb2McM
 eWCmfHkISScKV6FJ2LaLw==
X-UI-Out-Filterresults: junk:10;V03:K0:spjduJ8pNV8=:sKctWCrZREGqkKnBY/2dAch+
 quS1TFJqUyHRwE6d2NqEViblqBGDJelBKjheHB42dmC4uDYwVKIqSP/bevl9ey8NcNnmm+I7z
 LkJhnzlIkN9vob3uq/fmT9TeZGeq+8Hkz9ybI0WvbOyM3l2yzAmxY5RFnhjh8O7lHkD/fdZkT
 gapSTN5QXhSUhMSswq6BCz8k4eXEfQtKOjMV4UlevTCMtnL9xWORuJtSDDzWaZFoxyK7zuNu+
 z6lX22zrrt/OogfHBEURt9tu05FZyOblbi4ZHsKbFUk3vVDJIwGpY58dsw+JLhWSKXi5RCpwy
 ZcUzIj3WGGSwZFlxEqiBCeCwP+WiC4vB3zPnb4fES7kojQXRFKhLjPmft927knGHexVeH12fn
 NWMhNRY/CzW2U3NECkQSmi6jn6Ff14JIx7rhZhlNuCiyT3oMxKZDQ+7ir7zoR2EjRXwBwlZWU
 1yQZxnbpsO04pCg1MUSxu+CgIfqrmNERKRCmv7/86dT3icjwscW+MYsSqqdcGBuDUNsLRIeVW
 g8kXKHoWyAoleR/ZNo7bFtiMkxGdAwGzgnLQ6vtsQ1SylI+z/ONPlTpYGwIhlamHfHwkPPj6c
 dqppqmEzXYRhRDbC04s5IIKPlkWcAdZBicueeHJqFAlCPfwDvBR+1cQ9F9lSj5lN0L2N9pki1
 fOGrVoPZZzVWlxgbCVSJleeMQx6tYfu3b/D9xeJdonkj6Qz7+zVLVHPsn1n2rErXYd5ClRmyj
 dbBG3ri63++Ome1/dE14crSDGJhktI2QWruYi73cHV5i3SS7qjfFDV63hF9p5Ffnkbm5/moBE
 FceiIMKvwoDKrVTaVr805GG/i+4apiKbkymgAiihFqCrFXJ9vDr1EgGJ62UFX1m3a1QVYvO2x
 iJBzritAUahSF/Y5+n/IvaZIjdX2u/+dDratx+46gmObSujwghiIEQYJ2Np3hEDxTmJrobrwd
 /zTiEQBXqfySkcfw2SM4p9ozKSI8GAI4lcXFnngrx45joJ4x/0mAtLf9MApTrJ4n0Q9G/dGTX
 iEe0XqlVdkes1ngww/PC0UCsudkoZXCzXkSkvkFzLtODzHpnNiuaN6DaJ0Zt3HxqiTSKmHeo4
 wj/GLK5kuJrPS6jvVMk7k5hcp/rINwSOferwBjJbkv2UZMagaHKO//AbpvZ4v3lYLBEdbxlVg
 baRSf/vdcwMHrqtZdpPqgQL3ZP7hETXYGknEmgqXqrZtzQ==
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/22 13:04, Konstantin Ryabitsev wrote:
> On Thu, Sep 29, 2022 at 12:22:35PM +0000, Artem S. Tashkinov wrote:
>> AFAIK, the kernel bugzilla is a Linux Foundation project and the
>> organization receives funding from its very rich members including
>> Google, Meta, Intel, and even Microsoft. The fact that no one is
>> seriously working on it looks shameful and sad. We are not talking abou=
t
>> a minor odd library with a dozen users we are talking about the kernel.
>
> The bugzilla as a software platform is a Mozilla product, not Linux
> Foundation. Unfortunately, it's pretty much dead:
>
> 1. all development has stopped years ago
> 2. it doesn't even work with recent MySQL servers
> 3. it is written in perl5 and can only pretty much run with mod_perl
>
> We're committed to running it as far as we can, but we all must also adm=
it
> that the platform is near-death and probably will become an ever-increas=
ing
> burden to keep it operating. Heck, one of our IT staff is currently tryi=
ng to
> convert bugzilla.kernel.org to use Postgres just so we can keep operatin=
g it
> past the end of 2022.
>
> The Linux Foundation IT is in charge of running infrastructure -- we're =
not a
> development shop. All of our software projects are pretty much "skunkwor=
ks"
> efforts (and yes, this includes b4).
>
> We do have ability to fund development efforts -- LF has been the primar=
y
> sponsor behind public-inbox.org over the past 3 years. However, there mu=
st be
> a clear, strong, and well-articulated mandate from the community. From w=
hat I
> heard, the vast majority of maintainers simply want a web form that woul=
d
> allow someone to:
>
> 1. clearly state what kernel version they are using
> 2. clearly describe what they were trying to do
> 3. explain what they expected vs. what they got
> 4. attach any files
> 5. give this bug report a unique identifier
>
> Then a designated person would look through the bug report and either:
>
> a. quick-close it (with the usual "talk to your distro" or "don't use a
>     tainted kernel" etc)
> b. identify the responsible maintainers and notify them
>
> The hard part is not technical -- the hard part is that "designated pers=
on."
> Being a bugmaster is a thankless job that leads to burnout, regardless o=
f how
> well you are paid. Everyone is constantly irate at you from both ends --=
 the
> users are annoyed because their stuff doesn't work, and the maintainers =
are
> annoyed because you keep yanking them to work on dull problems that requ=
ire a
> ton of back-and-forth with people who aren't capable of applying patches=
 and
> booting custom kernels.
>
> Before we try to fix/replace bugzilla, we really need to figure out the =
entire
> process and pinpoint who is going to be the one in charge of bug reports=
. If
> you think that LF should establish a fund for a position like that, then=
 you
> should probably approach LF fellows (Greg KH, Shuah Khan), who can then =
talk
> to LF management. The IT team will be happy to support you with the tool=
ing,
> but tooling should come second to that -- otherwise we'll just be replac=
ing an
> old and rusty dumpster on fire with a new and shiny dumpster on fire.
>
> -K

To me it sounds like the best way to keep moving forward is simply
convert git.kernel.org + patchwork.kernel.org + bugzilla to
gitlab.kernel.org and that will solve all the issues immediately. That
will require of course a ton of work but:

1) All the commiters will be automatically present and you can easily CC
them

2) All the kernel directories could be split into components with the
respective developers being subscribed to them automatically. There's an
issue though: sometimes directories/components are rearranged. Gitlab
however is quite powerful, so issues can be easily moved between component=
s.

3) It's gonna be a ton easier to keep track of commits and
discuss/review them. AFAIK it's now done using LKML +
patchwork.kernel.org and then commits are merged by maintainers. So many
places to keep track of.

4) Gitlab probably can be integrated with other gitlabs (at least AMD,
Intel and Nouveau drivers are developed on gitlab.freedesktop.org).

Gitlab simplifies all of that tremendously. Github will work as well but
I know many people don't like it.

Linus, as a commander, may continue having his local git repo or using
its own git website and get merge requests from gitlab.kernel.org. For
him barely anything will change (aside from URLs to fetch from).

Gitlab works as a docker container and requires only a Postgres backend
which simplifies updates and backups.

Best regards,
Artem
