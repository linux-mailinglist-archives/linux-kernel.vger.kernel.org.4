Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D38746358
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjGCTcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGCTcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:32:47 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094AFE6B;
        Mon,  3 Jul 2023 12:32:46 -0700 (PDT)
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
 <11fef47a-4805-df0e-016e-d2a777087129@gmx.de>
User-agent: mu4e 1.10.4; emacs 29.0.92
From:   Sam James <sam@gentoo.org>
To:     Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        John David Anglin <dave.anglin@bell.net>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
Date:   Mon, 03 Jul 2023 20:31:21 +0100
In-reply-to: <11fef47a-4805-df0e-016e-d2a777087129@gmx.de>
Message-ID: <87v8f04wpy.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Helge Deller <deller@gmx.de> writes:

> On 7/3/23 18:49, Linus Torvalds wrote:
>> On Mon, 3 Jul 2023 at 00:08, Helge Deller <deller@gmx.de> wrote:
>>>
>>> Great, that patch fixes it!
>>
>> Yeah, I was pretty sure this was it, but it's good to have it
>> confirmed. Committed.
>
> Thank you!
>
> Nice to see that Greg picked up the patch for stable that fast as well!

Sorry, where? I was just about to check if it was marked for backporting
but I can't see it in Greg's trees yet.

We need it fo 6.1, 6.3, 6.4.

(Apologies if I'm missing it somewhere obvious.)
