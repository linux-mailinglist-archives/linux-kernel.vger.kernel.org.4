Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE93170BE8E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjEVMjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjEVMja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:39:30 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950A4FE;
        Mon, 22 May 2023 05:39:11 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q14oH-0006AD-S6; Mon, 22 May 2023 14:38:45 +0200
Message-ID: <55dda0bb-fe42-6dee-28ea-00121554d092@leemhuis.info>
Date:   Mon, 22 May 2023 14:38:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [regression] Since kernel 6.3.1 logitech unify receiver not
 working properly
Content-Language: en-US, de-DE
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, guy.b@bluewin.ch
References: <9b987585-0834-bb8c-3414-283c29f3f2ab@leemhuis.info>
 <bec024d5-4088-00ae-f7b5-7188868b1707@leemhuis.info>
 <b7717c43-74bf-b91d-d3ce-874493df602c@gmail.com>
 <CAO-hwJ+At1J_yUpX2q_dJekzZ-PoTDAvxmkTk_e4Yu0Z338bEA@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAO-hwJ+At1J_yUpX2q_dJekzZ-PoTDAvxmkTk_e4Yu0Z338bEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684759151;9c913b9b;
X-HE-SMSGID: 1q14oH-0006AD-S6
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.23 15:34, Benjamin Tissoires wrote:
> On Tue, May 16, 2023 at 3:25 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> On 5/11/23 18:58, Thorsten Leemhuis wrote:
>>> On 08.05.23 11:55, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>>>> kernel developers don't keep an eye on it, I decided to forward it by mail.
>>>>
>>>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217412 :
>>>
>>> TWIMC: a few other users (three or four iirc) showed up in that ticket
>>> and reported problems with the receiver, albeit the symptoms are not
>>> exactly the same for all of them, so there might be more than one problem.
>>>
>>> I'll try to motivate the affected users to perform a bisection. But
>>> would be great if those with more knowledge about this code could
>>> briefly look into the ticket, maybe the details the users shared allows
>>> one of you to guess what causes this.
>>
>> Hmm,
>>
>> You noted in the similar report [1] that developers involved here
>> ignore this regressions. I wonder if Linus has to be hired in
>> this case, and if it is the case, let's take a look and hear closely what
>> he will say.
> 
> Sigh... Not answering an email is bad, but maybe you can also
> understand that developers can take days off?

Yup, also a totally valid reason I forgot to mention in my reply last week.

> And it turns out that I was waiting for Bastien to chime in, but I can
> access his calendar too and just found out that he was AFK for the
> entire month, except for the first week, which I wasn't aware. May is
> a time where people in France have a lot of public holidays and is
> also the cut to use those time off or they expire.

Thx for that, knowing that Bastien is unavailable is really helpful.

> For me, I'll also be taking time off the rest of this week, so I won't
> be able to have a look at this until next week at the earliest.

Hope your enjoyed your days off!

FWIW, in case anybody is interested in a status update: one reporter
bisected the problem down to 586e8fede79 ("HID: logitech-hidpp: Retry
commands when device is busy"); reverting that commit on-top of 6.3
fixes the problem for that reporter. For that reporter things also work
on 6.4-rc; but for someone else that is affected that's not the case.

Makes me wonder if we deal with two different issues here. Just asked
where 6.4 does not work if reverting 586e8fede79 fixes things for them
as well.

For more details, see https://bugzilla.kernel.org/show_bug.cgi?id=217412

Ciao, Thorsten
