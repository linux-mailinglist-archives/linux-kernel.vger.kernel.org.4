Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60255FC8F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJLQMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJLQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:12:10 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E748BBE30;
        Wed, 12 Oct 2022 09:12:07 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oieKx-00007h-6g; Wed, 12 Oct 2022 18:12:03 +0200
Message-ID: <8a743f72-1b81-20c3-a2fa-8196b5278fef@leemhuis.info>
Date:   Wed, 12 Oct 2022 18:12:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, de-DE
To:     Hans de Goede <hdegoede@redhat.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>,
        ksummit <ksummit@lists.linux.dev>, workflows@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <20221004175354.bfvg3vhfqch35ib5@meerkat.local>
 <c74d9d75-4428-e22d-1adb-334b1173d871@leemhuis.info>
 <20221004202540.etokkm3jk6sk7z7y@meerkat.local>
 <89926f21-e172-9f3d-d08f-8d5eef812ee1@leemhuis.info>
 <477635db-c89b-cfd3-cd26-fea51bb094a5@redhat.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
In-Reply-To: <477635db-c89b-cfd3-cd26-fea51bb094a5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1665591127;6ad03025;
X-HE-SMSGID: 1oieKx-00007h-6g
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.10.22 11:57, Hans de Goede wrote:
> On 10/5/22 11:00, Thorsten Leemhuis wrote:
>> On 04.10.22 22:25, Konstantin Ryabitsev wrote:
>>> On Tue, Oct 04, 2022 at 10:06:28PM +0200, Thorsten Leemhuis wrote:
>>>> Your plan would afaics mean that we invest further into a software
>>>> abandoned by its upstream and already becoming more and more of a
>>>> maintenance burden. That investment would also further increase our
>>>> dependency on that software by establishing workflows that rely on it.
>>>> Is that really wise at this point? Wouldn't it be better to spend that
>>>> time and effort to build something better that is more future proof?
>>>
>>> Unfortunately, there's no such thing. ;) And maybe we'll even help tip the
>>> course of history into the other direction -- Red Hat uses bugzilla, and so
>>> does OpenSuse, so there's a pretty good core of well-funded companies that
>>> would be in a position to help keep bugzilla going if it's looking like the
>>> platform is still alive. Or that could all be wishful thinking and they'll all
>>> migrate to Jira or something equally horrible, who knows.
>>
>> Well, Red Hat apparently is already in the process of migrating to Jira
>> in the long run:
>> https://lists.fedoraproject.org/archives/list/epel-devel@lists.fedoraproject.org/thread/U7TZRWXVUGBCHS6EBJIBSFAVPFUHHV7J/
>>
>> To quote that mail from March:
>>
>> ```
>> As some of you may know, Red Hat has been using both Bugzilla and Jira
>> via issues.redhat.com for RHEL development for several years.  Our
>> intention is to move to using issues.redhat.com only for the major
>> RHEL releases after RHEL 9.
>> ```
> 
> That is for RHEL only though I'm not sure what the plans for Fedora are.

FWIW & for completeness: at least Fedora's project leader Matthew Miller
thinks that Fedora ```should plan to migrate [from bugzilla] to
something else in the next three years. There are two reasons for this,
and only one of them is that Red Hat is moving away. The second is that
Bugzilla isn’t a great tool for what we need anyway.

On the first part: yes, there’s a long, slow sunset, but I think
realistically we’re going to see business-side attention drop
significantly, and we’ll have correspondingly worse and worse service.
Right now, there are basically only two people keeping it all going,
which is heroic. I don’t think it’s too much
pulling-back-the-corporate-curtain to guess that if one or both get
tired of that and decide to go start a yak farm, Red Hat won’t
prioritize hiring backfill dedicated in the same way. We could ask CPE
to keep it going, but… there’s so much more I’d like to ask CPE. (And
non-CPE volunteers? There’s so much that’s more interesting!)

So to the second part: Bugzilla isn’t what we really need anyway.[...]```

See his post from March here for links and the rest of his msg:
https://discussion.fedoraproject.org/t/the-future-of-bugzilla-in-fedora/37735
I quoted the msg fully at the end of this mail for completeness.

Only learned about this msg now through a comment from Matthew
(https://lwn.net/Articles/910966/ ) in an article about this thread
(https://lwn.net/Articles/910740/ ). To quote from his lwn.net comment:

```
Tl;dr: many similar issues as in the above conversation. Triage is a big
deal. "Bugs" aren't really the best place to start -- it's better to
send people to a help forum first, file bugs second. [...]
```

Ciao, Thorsten

P.S.: Here is the promised full quote of:
https://discussion.fedoraproject.org/t/the-future-of-bugzilla-in-fedora/37735

```
> The Future of Bugzilla in Fedora
> Project Discussion
> council
> engineering
> quality-assurance
> Matthew Miller
> mattdm Fedora Council Member
> Mar 22
> 
> I posted this on the Fedora Development mailing list 3, in the thread
> RHEL moving to issues.redhat.com only long term 2, and am re-posting
> here for broader discussion.
> 
> Here’s what I’m thinking: we should plan to migrate to something else
> in the next three years. There are two reasons for this, and only one
> of them is that Red Hat is moving away. The second is that Bugzilla
> isn’t a great tool for what we need anyway.
> 
> On the first part: yes, there’s a long, slow sunset, but I think
> realistically we’re going to see business-side attention drop
> significantly, and we’ll have correspondingly worse and worse
> service. Right now, there are basically only two people keeping it
> all going, which is heroic. I don’t think it’s too much
> pulling-back-the-corporate-curtain to guess that if one or both get
> tired of that and decide to go start a yak farm, Red Hat won’t
> prioritize hiring backfill dedicated in the same way. We could ask
> CPE to keep it going, but… there’s so much more I’d like to ask CPE.
> (And non-CPE volunteers? There’s so much that’s more interesting!)
> 
> So to the second part: Bugzilla isn’t what we really need anyway.
> 
> I’m not saying Bugzilla has been terrible — it’s served us well, in
> fact. And I have personal fondness for it that, which I do not for,
> say, the wiki. :classic_smiley: Buzilla is it’s deeply integrated in
> a lot of our processes, and we’ve got a lot of automations and so on.
> It’s important. But… there’s a lot that could be better. I think
> specifically:
> 
> It doesn’t serve as a single place to track everything. We’ve got
> stuff scattered around Bugzilla; issue trackers in Pagure GitLab, and
> GitHub; pull requests in all of those places; and more. Not to
> mention upstreams (and inconsistent approaches to tracking upstream
> issues). I’m not arguing that we need ALL things in one place, but
> it’s important that Bugzilla isn’t that now anyway.
> 
> Bugzilla a terrible experience for end users. Usually it’s the Wrong
> Place. When a user has a problem, that may or may not be caused by a
> software defect. This is a whole topic of its own, but in short, it’s
> really better for most users to report problems at Ask Fedora, and
> then possibly after triage a bug should be filed and tracked
> somewhere.
> 
> Many of our users are advanced and recognize real defects and file
> good reports, but this leads to even more frustration, because our
> response is inconsistent. Maybe that report should actually be
> upstream. Maybe it’s in a dependency package that’s really only
> loosely maintained. For whatever reason, a lot of perfectly good
> reports end up closed EOL, which is never a good outcome.
> 
> We’re inconsistent with PRs vs issues, which is confusing and makes
> more duplication. I have seen cases where a packager complained that
> someone filed a PR that they never noticed, saying “this should be a
> bug so I’ll see it”, while others close bugs with “please send a PR”.
> We could make stronger statements about policies, but as long as
> these two things exist in separate places, that tension will keep
> coming back.
> 
> Plus plenty of minor things: Our workflow still is shoehorned around
> a bunch of RH-centric stuff (lots of fields, flags, and statuses that
> we don’t really use or want). It’s not great for the review workflow,
> or for some of the other things we’ve twisted it to. A
> component-centric approach makes it hard to track larger issues. The
> SCM workflow is … not good.
> 
> And I’m sure there’s more. But I’m not really here to complain about
> Bugzilla. It’s just actually not filling our needs. I therefore think
> that Jira / issues.redhat.com 5 wouldn’t either — although it’s got a
> ton of features on top, it’s fundamentally the same kind of thing.
> 
> We need define exactly what we do need, and figure out how to get
> that, in a sustainable way going forward. And fortunately, we DO have
> a few years, so for once we could do this before it’s a crisis.
> 
> I think we should create a project to figure this out. In fact, I
> think it should be a Fedora Objective. But, it also shouldn’t be a
> completely blue-sky initiative — we should avoid trying to develop a
> new gigantic piece of software that we own. (See past results on
> that, sigh.)
> 
> We do have some pieces already in place that should be part of the
> foundation (or at least other metaphorical bricks in the
> construction):
> 
> Ask Fedora is the place for users to report and discuss problems.
> This is our first-line of support, and it’s where we can do triage.
> Then, software defects may or may not be tracked relating to those
> conversations.
> 
> Package-specific issues should be next to the PRs. Let’s enable issue
> tracking on src.fedoraproject.org (with whatever gitforge we end up
> with that on). I think this makes sense for initial package review
> too, although that would need some workflow changes.
> 
> Bodhi and the CI results system and all of that. This is
> update-centric, but does also have a lot of issue-tracker-like
> characteristcs in the “karma” system, and it is inherently close to
> our release process. Maybe some of the process that currently goes
> through Bugzilla could move here.
> 
> The Fedora account system and Fedora message bus, plus the packager
> dashboard, the (under significant update!) Fedora notifications
> system, and so on. We have a nice underlying infrastructure for tying
> things together, and we can do more integrations. (Look at how Copr
> uses Discourse, for example. Or the Blocker Bugs app and its
> connections with Pagure and, um, Bugzilla.)
> 
> Obviously that’s not nearly sufficient. But we should look at all of
> our needs around tracking issues, plans, projects, blockers, and
> defects; consider different packaging cases with various
> relationships with upstreams; and imagine ideal workflows for users,
> packagers, project managers, spin and edition teams, QA, and all the
> other stakeholders. The last time we did this was in 2013, so… it’s a
> good 10-years-later exercise! (Infrastructure Fedora bug tracker -
> Fedora Project Wiki 2)
> 
> Then, once we have a good shared understanding of what we want, start
> fitting pieces like the above into that picture, define the gaps, and
> then find exactly what we need to fill them.
```
