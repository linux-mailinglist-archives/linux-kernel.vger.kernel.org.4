Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9875374634A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjGCTZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGCTZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:25:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E74CE4F;
        Mon,  3 Jul 2023 12:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688412297; x=1689017097; i=deller@gmx.de;
 bh=CKYjyaMobzSQljg/AG7qOjaOlzIYyW9vXC5zfAK9+2s=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=B57pNcGQLuexcb79eaCGpeNKbVoVPNEkN1J4/cDHA1cLiiQ0AXwxB2vosGzL5hoQEDtt63p
 rBoPFgEao+WDyTEH18NXpNAR+jFT7C/Ol1ospOuwz7pdVRVnsKWQ0xi9ynYmsDC1wmmJD76xZ
 wt/Fy1QmoJUcnz5l7jGbIMp4JZw+ti1iZbAqS3woQlqlaLynMfvJbsj8kKvNkuIhO8nL32lNk
 4rss2/AYAHRM2D8nlUMON1aUtKsjU4L9QepOl3Z0cWX/qNyrlUBykPfWBEFR5lxTJDj4rHzTI
 0dP8BL1+xGJnPv4HpXIBElUTzq4ES2qlh6BfFO32X+6/GmtndN4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.165]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY68d-1qWh8u1puf-00YRKI; Mon, 03
 Jul 2023 21:24:57 +0200
Message-ID: <11fef47a-4805-df0e-016e-d2a777087129@gmx.de>
Date:   Mon, 3 Jul 2023 21:24:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
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
 <7146f74d-8638-46c7-8e8c-15abc97a379f@gmx.de>
 <CAHk-=wjqp09i1053vqFc41Ftegkrh0pD+MKY-3ptdYu3FUh6Bw@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAHk-=wjqp09i1053vqFc41Ftegkrh0pD+MKY-3ptdYu3FUh6Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1XnXryH7ols1skoi/J2OxLwgkZsnSWiUn/LzY7n87R6dOWX6yft
 ST1zz2gya7Uz9H7urem3pL/OWdvquTd46jNGCTCisOnEji2PYJBjZaxnkOmJTmyr+bJIDjy
 yvL6kugzCNhY2T09W0gZIwlPpKpS+LNY9Z59JgH0oozxcs28f26UGDRVR4IJGGfVzkE4Y06
 peDUIQS2drMl0I2qgM8Zw==
UI-OutboundReport: notjunk:1;M01:P0:Si2hy5OLHQA=;tyyzNfOheCDoGkMZO6Rs0SaRDTq
 V+jEcHXRV5RqZiS+dWgnmnehcPh/snRb8THh08TPbvwPkcO/EhQd3mGTIu2xz0l2WWf/mXtMn
 tVQxIuw/gEjWFHzb1wHeiVav3j4TK5FS3FZ5zE+7FyeIWV1LC3l/TFdngw3fM97wSNUIoOF/j
 yv9f7YQHxqnyekMQ6wR+ypAF2buo2Xp9GwPNVuJ5/zpyOMOjTBJP9RXAQMEmGPmN+6dh0p4lM
 36z81noCcKcZ4tmwc4Pn8PTgoLVoNbzl4HZkwSrtznWZSRz2cp1CaivL9NSmGW6Z12biaPRln
 q3vRktHW1JT75XvMPar4qs4pPvsMugNfMTA4AEUkJOPhV7eJIQBTBucRET2/MX9VOfJXLXmPt
 FiBv/bk9smg5wCKz+bz4NOxN6DRffjy0IbVqPv2i7H0Zs+/TauQTkTURrdcNqDMTohTbdUC1P
 A2qEyFOmEw08d1T5WJfCEAtaMrmxvH88UCw1FuLnPYTVGkrAG6QzOeeUjsAj04XoRifU19lF+
 gTIIlhtJzr0OqiGhEmRx185vLbkylDN1u8xicyjoNSG1QB50R4Vm0xwi0leki8TF6G1DTv+L1
 g01i4OWb1WJmEGN+vk5laaP41QBmb9zrYRYgsrOL/+ganUVHIoodiKknKN2Z9RwowZd8ufEi7
 EJqB9JeQohJ0CrrWuuXMhIexqAkeBnqBFc0M9nBgptV32Go/OUObLy3odgLB9ITWEHud2Cqe/
 +JJU115uZc0gmo+0zV6L4VAo/Qx6O6R856Ivb2cZ1BCgXot11H3ahMd8+f2b9dyv9EFz9qpNy
 GQC0X3xWM0+dtkfBTwjbdS4iRno5eKL8aR6l3ZLg0Is14FtEWn8RCE+79OdwiroLfNDCLZo7I
 q3n3jyly25T1aSmLHSVG1NlyYg2wLzXyUeTtBJgqIK4g6Fy9D7ZD/rXqOmdjL0C6+uSgiGwTp
 v5POM0RT2LiJG3imhdByv9KdQiI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 18:49, Linus Torvalds wrote:
> On Mon, 3 Jul 2023 at 00:08, Helge Deller <deller@gmx.de> wrote:
>>
>> Great, that patch fixes it!
>
> Yeah, I was pretty sure this was it, but it's good to have it
> confirmed. Committed.

Thank you!

Nice to see that Greg picked up the patch for stable that fast as well!

>> I wonder if you want to
>> #define VM_STACK_EARLY VM_GROWSDOWN
>> even for the case where the stack grows down too (instead of 0),
>> just to make clear that in both cases the stack goes downwards initiall=
y.
>
> No, that wouldn't work for the simple reason that the special bits in
> VM_STACK_INCOMPLETE_SETUP are always cleared after the stack setup is
> done.
>
> So if we added VM_GROWSDOWN to those early bits in general, the bit
> would then be cleared even when that wasn't the intent.
>
> Yes, yes, we could change the VM_STACK_INCOMPLETE_SETUP logic to only
> clear some of the bits in the end, but the end result would be
> practically the same: we'd still have to do different things for
> grows-up vs grows-down cases, so the difference might as well be here
> in the VM_STACK_EARLY bit.

Ok, thanks for explainig!

Helge
