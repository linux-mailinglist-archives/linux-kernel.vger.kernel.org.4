Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C385F2D00
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJCJQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJCJQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:16:33 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611EF10540;
        Mon,  3 Oct 2022 02:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664788569;
        bh=Vg3IHWsNeNzLSBJ1zEVncWlLMmqv52fMbLCWngXq+fo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eJDthvWs+imNvaVvNINUv2LvMQNjVFrkYW71/ryQfnYXWhr8RLXMQAspTdp9RRQGM
         acI9GC9giacgDnNjmznYGI/S8X2kviZ5PWwSAihage8nR6buuXAd9MA8zjXz5xJv23
         TI3BRQBV4z97wpDThivv48uHwnm/VshCNQoD+vCI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.25.110.16] ([143.244.37.214]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDbx-1pVBLw27BN-00udcx; Mon, 03
 Oct 2022 11:16:09 +0200
Message-ID: <251201be-9552-3a51-749c-3daf4d181250@gmx.com>
Date:   Mon, 3 Oct 2022 09:16:06 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
References: <Yzg7pHspc72I7TAb@mit.edu>
 <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com> <YzmBjgXq9geMnL1B@mit.edu>
 <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home>
 <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home>
 <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com> <YzoY+dxLuCfOp0sL@ZenIV>
 <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com> <YzqjfU66alRlGk5y@kernel.org>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <YzqjfU66alRlGk5y@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IYgQQC5h+eVSuxN4c4f5YesIMgGPYFCjoaG17hzzj+LkpGx9SQo
 jAmdXdlf2H6XD3nqTwWz0JbbUpP9kQ5hncTKAXx6vgpmQCZzx6eMzCt3RuQExpzx0SgjbSG
 qAJzrTSEkPbY0tLA1Rvl/TVNlDBmRZaXihS90ZAlx9gQj5qbjpyZtFlmMXihCvjYAAPi6XV
 Mto56ouBFH7dG4aQ1LsoA==
X-UI-Out-Filterresults: junk:10;V03:K0:VA6pfwskn4Y=:wI3s6PAaYdDT/XmTINCdZiXC
 iIi5NhhZoVZgJgbk1vCcDVu4H9fm2/nbRFsQYMmyaHl9gulOXaIuoglQ1jD+Iqb0js/Qe4i0F
 lMdL26qLckzCy5OiqgxjYi0NWlnLv81SZ7QowdJy/KE0JOabGkshrbtL8oEB+GqeoCx0o+rlA
 Np5DpbGdYklGWZikPxJ3/W2flOWsKzcVyju9RWQdVCyHf6YJFXEb6qlgjyCicSTJ1o7hBB1Cm
 LUwsjH30anp1pPwQ5FVIzmYgzp0QlyKleYE467NvVTvntBdBDOBaj8VRhlIHXij1QBWe6mwmi
 pJVdohCtZLNPSo3/l+5cE6YhYNsUTEBoABqSFnBUxF7Dmtv4gxF7wfMG7ES9w5OfFvxfCT84u
 MJhjjeDk6tbWhviYTIzuqLQG2LlJle9PpAg+2C8zT0lh94avGMhXFyetYEl1slg7ICaJQ2WY7
 InU/NXI45G9n+exH5+fUopuT5eujuS+0pKhuQ66RxympEQPrA7h+ZVqUocGuIxqa/vc4t8amk
 PX/fdAeSWXuFte4BxMZE3tkTcUSMoDLHwXiT4TQQrtrzI58k56ar3LwYEdsIC7fM7mn/5Gefh
 eLwuVAAY2kYUaCXo7dJhdj/R8iH9UPVbKBXMzfSK+FSbzqWbJRtYz8sr4jCTqjfD4LmxxTMem
 vRFiP0CApG2ceQxVgADQ/bZ42jpAVBksW9ak+ywiHtW7r4FjaSHN+DWjutBh+Pq9pkaodRsxf
 PlR0QTN2ajW2+S3o8CzrEPNX+RwcW0rE8kQeVbbM/y8Bn1IU0ghhz7Yg+wOcExTmDIfWQ7RfR
 fr6ZqwIXugt/Wq0DFaXmh8dWV4SDRpvmVcu/V8xtZUyhvlLzpDBvuJyu3nupqb0eIP2eqw7Jv
 JRKqV32KvbjS5A6b6PxBDmUpPnPMcVU73LHaT3O6ioGsKsHugbj/li16xVkYjw+TEHNLihEt+
 At8UEOYWZTCQguBbSyzyz5V26AZv6s9BwCPhXtqyHYF4Y2t41lly0+lr2oTCfaBwDEo9+tNCG
 BS+9RLcXkmm6Z+D16A606ixnHLA1QdG99WbK9U41/X3mNBMKZRad5IMiX71yDdEiOX+9QBe5N
 6ZHiVyTLNoMadk1WV4W21QknwfLB/VOL+2VM7SHLGRvFcZURBFW2p/2g6B3yoHwXxuo9TtfIz
 +HuD5RBSpp/TaBkDrFPEdffGCVxlyNQJ3zcfz6OC2R8i4w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/22 08:55, Mike Rapoport wrote:
> On Mon, Oct 03, 2022 at 07:41:08AM +0000, Artem S. Tashkinov wrote:
>>
>>
>> On 10/2/22 23:04, Al Viro wrote:
>>> On Sun, Oct 02, 2022 at 10:20:40PM +0000, Artem S. Tashkinov wrote:
>>>
>>>> Bugzilla hasn't been updated in a very long time so it's missing both
>>>> mailing lists and individual kernel developers.
>>>>
>>>> AFAIK, some pieces of kernel have no appropriate mailing lists at all=
.
>>>> What about that? I've no clue.
>>>
>>> There's that file, right in the root of the source tree.  Called "MAIN=
TAINERS",
>>> in all-caps...  Could have something to do with locating maintainers, =
could it not?
>>>
>>>> Opt-in will work, except I've no idea how to make it work. Mass email
>>>> all the kernel developers and politely invite them to sign up? Most w=
ill
>>>> simply ignore it.
>>>
>>> Sigh...   You really don't seem to appreciate just how deep a septic
>>> tank you've jumped into with your combination of "it should be opt-out=
"
>>> and "but unsubscribing takes just a minute, what are you unhappy about=
?!?"
>>>
>>> Maybe you are not using email a lot, but for just about everyone who d=
oes...
>>> We have heard that.  Many, many times.  From many sources - spammers,
>>> "legitimate" companies' marketing departments, etc.
>>>
>>> And you keep moving along the same track - the usual reaction of some
>>> company after having pulled back a bloody stump and enjoyed the pile o=
f
>>> explanations of the reasons why opt-out is *NOT* *ACCEPTABLE*, *EVER*
>>> is along the lines of "OK, we'll just spam everyone in our database on=
ce
>>> and ask them to opt-in - that must be OK, right?"
>>
>> Being on bugzilla does _not_ mean you'll receive a single email unless
>> someone _specifically_ CC's you.
>
> If I'm not mistaken, bugzilla lets CC people explicitly. How the databas=
e
> of emails in bugzilla would help choosing the right people to CC better
> than MAINTAINERS?
>
> You repeated multiple times that bug reports sent to the mailing lists a=
re
> ignored, but what will make emails from bugzilla different from those bu=
g
> reports? Why do you think they will get more attention?

Maybe because they are specific? Maybe because they are not part of a
high volume mailing list such as LKML? Maybe because lots of developers
are _not_ on any mailing lists?

>
>> Anyways, Bugzilla is bad but it surely works. Let's have 100+ more
>> interchanges inventing something most users (for whom Bugzilla exists -
>> which people here keep forgetting all the time) will a have hard time
>> working with.
>
> You keep repeating that bugzilla is better then email, but the major poi=
nt
> here is not the tools, but the lack of resources to deal with initial
> triage of the bugs and holding users' hand to get a meaningful report.
> Until that changes, there is no point in trying to add more people CC'ed=
 on
> bugzilla reports. They won't be handled unless somebody would want to ta=
ke
> care of them and forcing people to receive these reports won't make anyb=
ody
> more willing to help.

The initial conversation started with the fact that Bugzilla is old,
semi-deprecated, requires MySQL [no idea what's bad about it, Bugzilla
can work with MariaDB and Percona as well] and its components along with
the respective emails are extremely outdated. If I remember correctly
triaging bugs was raised much later in the discussion and is orthogonal
to the topic.

Triaging bugs could be and should be done by the people who are willing
to help [for free]. There's no problem with bugs filed under "Other" if
the reporter has no idea where to file them as long as they are visible
and searchable.

Imagine instead you send your issue to a random mailing list. What is
the chance another person with a similar issue will even find it?
Vanishingly low. The net result? Work and time wasted and no one is aware.

Again the volume of bug reports is relatively low, fewer than two dozen
a week.

Everything about Bugzilla so far has been completely blown out of
proportions:

* The insane number of emails it ostensibly sends: "OMG so much SPAM,
save me from it!"
* The privacy "issue" despite git commits and respective email addresses
being public
* The amount of work required to keep its components and email addresses
up to date - could be done maybe every 12-24 months
* The triaging "issue" which is outside the scope of this conversation

At the same time:

* Multiple reporters can perfectly find the people who have made bad
commits or who are responsible for certain drivers - it's safer to CC
them _via_ Bugzilla than to email them _privately_ or via mailing lists
which entails multiple issues including trust, SPAM, formatting,
English, net etiquette, etc. etc. etc.

You don't like Bugzilla? Fine, never touch it, never visit the website.
Never get emails from it.

Regards,
Artem
