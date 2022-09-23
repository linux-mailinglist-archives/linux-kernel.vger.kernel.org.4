Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FF35E7D75
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiIWOns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiIWOnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:43:42 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96D412FF00;
        Fri, 23 Sep 2022 07:43:40 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1objty-0000ZC-Ah; Fri, 23 Sep 2022 16:43:38 +0200
Message-ID: <aa35d204-3033-96f2-ed83-c5034067fe4b@leemhuis.info>
Date:   Fri, 23 Sep 2022 16:43:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US, de-DE
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <7f02143c-461f-268b-0f17-7fe20a7423d6@leemhuis.info>
 <875yhep5l1.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v2 0/4] Rewrite the top-level index.rst
In-Reply-To: <875yhep5l1.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1663944220;115e561c;
X-HE-SMSGID: 1objty-0000ZC-Ah
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.22 15:45, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> On 22.09.22 22:41, Jonathan Corbet wrote:
>>> The top-level index.rst file is the entry point for the kernel's
>>> documentation, especially for readers of the HTML output.  It is currently
>>> a mess containing everything we thought to throw in there.  Firefox says it
>>> would require 26 pages of paper to print it.  That is not a user-friendly
>>> introduction.
>>
>> That's true, but is it maybe good or even important for googleability?
>> When you talked about this in your LPC talk this went on in the matrix chat:
>>
>> ```
>> Nur Hussein
>> I feel like every existing page needs to be accessible (somehow)
>> from that starting page
>>
>> Zsuzsa Nagy
>>
>> access to all pages <- findability from a search engine (technical
>> author talking here)
>>
>> step #2 in-site search for those who already landed on your pages
>> ```
> 
> So every page remains accessible, just like they are now.  They just
> aren't linked directly from the front page - as many pages already are
> not.  I honestly don't understand what the problem is here.

I'm not sure myself if there is a problem, I just wanted to bring that
LPC chat up, as it seemed Zsuzsa had a lot of experience with this sort
of problems at was at least somewhat interested in Linux kernel docs --
so I thought it might be worth bringing Zsuzsa into this discussion (but
I couldn't quickly find a email address to simply CC).

> *No* site links everything directly on its front page.  Even if it had
> an effect on search engines, I think it would be wrong to prioritize SEO
> over basic usability.

Yeah, agreed. Something about SEO not being a priority was mentioned in
the chat, too.

>>> This series aims to improve our documentation entry point with a focus on
>>> rewriting index.rst.  The result is, IMO, simpler and more approachable.
>>> For anybody who wants to see the rendered results without building the
>>> docs, have a look at:
>>>
>>>   https://static.lwn.net/kerneldoc/
>>
>> I still think we're doing all this to build something for users and
>> hence docs for users should be at the top spot. I'd even think "those
>> people are selfish" if I'd look into the docs of a software and find
>> texts for developers at the top spot.
> 
> Again ... who are the users?

I meant people just using the kernel, not developing the kernel itself
or developing software that's running on top of it.

>  I maintain that the actual users of our
> docs are primarily kernel developers.

I guess you are right with that, but maybe that's just like that due to
the docs we have and not the docs we should have (or should aim for
having in the long run).

IOW: why is the kernel different from say LibreOffice, Firefox, or some
random command line app: if I look into the documentation (say because
I'm using that software for the very first time or because I have a
problem with it after using it for years) I don't expect to see lots of
docs at the most prominent place that are only relevant for people that
want to modify said software; I'd expect things like "what is this
software and how can I use it", "how can I install this software", "how
can I report a bug", and "what knobs are available to deal with corner
cases" there.

>>> Unless I get screams I plan to slip this into 6.1.  It is definitely not
>>> the final form of the front page, but I doubt we'll ever get there; we can
>>> change it in whatever ways make sense.
>>
>> My 2 cent: why the rush? I'd say: let's try to get some feedback from
>> Zsuzsa and experts on docs first. I'd be willing to approach them. If
>> that doesn't work out over the next few weeks, just merge what you have
>> for 6.2.
> 
> I want to do it because it's a clear step forward and has already been
> pending for a month.  It is surely not perfect, and there will
> undoubtedly be changes, perhaps big ones, to come, but I cannot imagine
> a scenario where we want to go back to the mess we have now.

I understand and yes, maybe it's the right thing to do; but OTOH that
page is a mess for quite a while already, so is it really a big problem
to just leave it like that for 9 or 10 more weeks while trying to bring
in a few more people that might be able to directly bring us on a good
long-term course?

Ciao, Thorsten
