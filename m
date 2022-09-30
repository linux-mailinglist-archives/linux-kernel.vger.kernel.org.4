Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857B65F07BA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiI3Jfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiI3JfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:35:21 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7511EEDE8E;
        Fri, 30 Sep 2022 02:35:19 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oeCQO-0004tH-VO; Fri, 30 Sep 2022 11:35:17 +0200
Message-ID: <a86adc6d-05db-ec2e-c5de-d280aad9fb8a@leemhuis.info>
Date:   Fri, 30 Sep 2022 11:35:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US, de-DE
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Slade Watkins <srw@sladewatkins.net>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
 <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
 <7b427b41-9446-063d-3161-e43eb2e353f9@gmx.com>
 <20220929135325.4riz4ijva2vc7q5p@meerkat.local>
 <95c3384b-53d0-fd6c-6ec5-a7e03fdeddfc@gmx.com>
 <F300ED64-5E8E-4060-89DC-C98BC5FF08E6@sladewatkins.net>
 <YzXK6Px+BrNuuMZH@pendragon.ideasonboard.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
In-Reply-To: <YzXK6Px+BrNuuMZH@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1664530519;5e66e74c;
X-HE-SMSGID: 1oeCQO-0004tH-VO
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.22 18:42, Laurent Pinchart wrote:
> On Thu, Sep 29, 2022 at 10:54:17AM -0400, Slade Watkins wrote:
>>> On Sep 29, 2022, at 10:22 AM, Artem S. Tashkinov <aros@gmx.com> wrote:
>>>
>>> I've mentioned several times already that mailing lists are _even worse_
>>> in terms of reporting issues. Developers get emails and simply ignore
>>> them (for a multitude of reasons).
>>
>> It’s 100% true that emails get _buried_ as waves of them come in (LKML
>> itself gets hundreds upon hundreds a day, as I’m sure all of you know)
>> and it just isn’t something I personally see as viable, especially for
>> issues that may or may not be high priority.
> 
> E-mails are not that bad to report issues, but they can't provide the
> core feature that any bug tracker oughts to have: tracking. There's no
> way, with the tools we have at the moment (including public-inbox, b4
> and lei), to track the status of bug reports and fixes.

Well, I'd disagree partially with that, as my regression tracking bot
"regzbot"
(https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
; https://linux-regtracking.leemhuis.info/regzbot/mainline/) does
exactly does that: tracking, by connect the dots (e.g. monitoring
replies to a report as well recording when patches are posted or
committed that link to the report using Link: tags), while making sure
nothing important is forgotten. But sure, it's still very rough and
definitely not a full bug-tracker (my goal is/was to not create yet
another one) and needs quite a bit of hand holding from my side. And I
only use it for regressions and not for bugs (on purpose).

Ciao, Thorsten
