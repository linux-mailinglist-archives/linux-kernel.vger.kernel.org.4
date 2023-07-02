Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857EF74527D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 23:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGBVdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 17:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGBVdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 17:33:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75941E42;
        Sun,  2 Jul 2023 14:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688333582; x=1688938382; i=deller@gmx.de;
 bh=zoNTrcu17OXpgIuGcZIvxt9ubX9C4LB/Hqt+z3ZP4h4=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=qgg3fznCpQ4W/OcwDrNJayMCh8Ol98cpiE5MyjMFIHFjjnhCiBW9L81hlhyeqEv8xataUdQ
 9aQqoQLu4K1mOBy8LCmPpmUcEAPBMLxq/joVhflPGQIPybJodl1qq4KKmdF2IsQuVL1swV80v
 DO8RYs7tpqiP6O6p00Q9CRF1sHeMUZmeR/wX8PBi0jmC1VFb6cLHYeBf5T+LdyNEUCki1g0ND
 +mbIyoWOfrWe+QO5kx6cdZNc9EBu88vlCxsPIRvEd0tg0wDG27nPtJPP3uj0BMOWCed04kWcL
 8aiFa4UrxfGlDL1ZZNnOW9RaydFpR0IMl8k+GAF+gyLGOfjWEyAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.131]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Udt-1qMPHb348n-006zoJ; Sun, 02
 Jul 2023 23:33:02 +0200
Message-ID: <5fd98a09-4792-1433-752d-029ae3545168@gmx.de>
Date:   Sun, 2 Jul 2023 23:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John David Anglin <dave.anglin@bell.net>
References: <20230629184151.888604958@linuxfoundation.org>
 <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <2023063001-overlying-browse-de1a@gregkh>
 <0b2aefa4-7407-4936-6604-dedfb1614483@gmx.de>
In-Reply-To: <0b2aefa4-7407-4936-6604-dedfb1614483@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Yhl0DRuuLPKEMiY143f2N6rriAfbId77ULH2KXnQFOoo9YEc5p
 Rz5/9HFqMpYPYjBVkGk/n+l7DxusKZ02OVttxqO9kGoN9frimC9B+8vF2w7xGxO76aPhbDn
 DPl3LuBRAWIS5FGRyjQcHNq7e6SNXi6kiSZjeDYT673dH1UN9nLhgH8LiLpgf/DXiSduPEB
 oRkBMg2OIB7RMHjP0DCYA==
UI-OutboundReport: notjunk:1;M01:P0:rlpGPtRtE0g=;fcye9KtAlNqbjwGrLOMOoEcB/Xz
 /V9Q95CRG/a7Nqt63mKJQOEJgcFkTX+BOdS5MsNeSLGoeTQJBPjTFd1+UL9uoZCW68uYtezg1
 owTp56q/sLiY7yE071UeyCAC1O7hB3unjU+uTaI0+iMsin+/3iWqxK4qltVF/kxBDHSu0C4YH
 Dfa0GVTsLv56I4DWbO4VwFDXvkw21vuzjooCodPvS7GGNQ1faN4UwKtv+DTNdJd29lzym2dDh
 iLwFFSF0j/Wd1TD6Cs16/pwtJLAIsyrcOSV+MBjUWCQI81Xuu31Pt3cYIa+7PqZPJgmjT5HOG
 znFbIlcX+/of13qiEG+V3KyvMzRGRSTnOXG20BnRaXNUOMv+WHdMZs/nutmCcKoMJcc4Kb22r
 YTPXn1r5XtlQRumCOqi0tr7YhSp5Aq7GUjs4iRwZt6hPeXO6dFAmb16u9q3Hw3sUUIZ/0xr6P
 OO1YjQNq3cmWxZAVQiSGqzqersipjdfF6b+BmiP0KF50GhrYnpu5z6VEJmHJidacPR20NXu/f
 TejHkDlzM4ppHXRuIiAepuD5ZZJFp6IiyWPYoqJTlp5gr0tNp4rNsdhpfdgG3U7GMZkkStqVd
 QV6NSAfglPl0DFmbX1NC1jx+tpbK27JPVrQNUDMCEY8cHumAaZcil+y4GmKxB9tEZvKOybt9z
 VAAd4fpJvl/Vk+pPGJZPO66eAtvDL7OIa2wpWkysOIGvhBWp3oIRNB6PyN6jdmW94lbAhPhFL
 B5CBOkv6fiXFA9Qurhc55SI9Yw/alfS4JFOMbsQK+M6QE3Yl5l0J8LxUTHJ7RfVansIZJFSdr
 uD8XrwE969R5iJ9N5rMc5GiJKMKZJyQTHX/Fdl0W/jkQ8dXuGVRUiRmkHmGmxHKtWle5Qbkc5
 1tOWV4A2+oGKmh2XB31m+QEolqdJppXIuBa2fTMYScTXgHH6v2bfjLUN3c3RAZtCFy4dVuN/P
 yyLZplnytkfcg0pyygcbp9hODLQ=
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

On 6/30/23 08:56, Helge Deller wrote:
> On 6/30/23 08:29, Greg Kroah-Hartman wrote:
>> On Thu, Jun 29, 2023 at 11:16:21PM -0700, Linus Torvalds wrote:
>>> On Thu, 29 Jun 2023 at 22:31, Naresh Kamboju <naresh.kamboju@linaro.or=
g> wrote:
>>>>
>>>> arch/parisc/mm/fault.c: In function 'do_page_fault':
>>>> arch/parisc/mm/fault.c:292:22: error: 'prev' undeclared (first use in=
 this function)
>>>> =C2=A0=C2=A0 292 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!prev || !(prev->vm_flag=
s & VM_GROWSUP))
>>>
>>> Bah. "prev" should be "prev_vma" here.
>>>
>>> I've pushed out the fix. Greg, apologies. It's
>>>
>>> =C2=A0=C2=A0=C2=A0 ea3f8272876f parisc: fix expand_stack() conversion
>>>
>>> and Naresh already pointed to the similarly silly sparc32 fix.
>>
>> Ah, I saw it hit your repo before your email here, sorry about that.
>> Now picked up.
>
> I've just cherry-picked ea3f8272876f on top of -rc2, built and run-teste=
d it,
> and everything is OK on parisc.

Actually, your changes seems to trigger...:

root@debian:~# /usr/bin/ls /usr/bin/*
-bash: /usr/bin/ls: Argument list too long

or with a long gcc argument list:
gcc: fatal error: cannot execute '/usr/lib/gcc/hppa-linux-gnu/12/cc1': exe=
cv: Argument list too long

I'm trying to understand what's missing, but maybe you have some idea?

Helge
