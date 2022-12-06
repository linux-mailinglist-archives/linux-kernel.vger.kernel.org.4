Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0353C643C83
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 05:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiLFEz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 23:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiLFEzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 23:55:54 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F9413F79
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 20:55:53 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p2Pzj-0002HW-2j; Tue, 06 Dec 2022 05:55:51 +0100
Message-ID: <25f4838b-208a-cf8c-914c-b2092665d56f@leemhuis.info>
Date:   Tue, 6 Dec 2022 05:55:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US, de-DE
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>
References: <20221205131424.36909375d90d5a40cd028bc0@linux-foundation.org>
 <11a9fe60f5333a931b8d75f67808b6d923c16dfa.camel@perches.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Fw: [PATCH 0/2] feat: checkpatch: prohibit Buglink: and warn
 about missing Link:
In-Reply-To: <11a9fe60f5333a931b8d75f67808b6d923c16dfa.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1670302553;dfa6cb4d;
X-HE-SMSGID: 1p2Pzj-0002HW-2j
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe! Many thx for looking into this.

On 06.12.22 02:02, Joe Perches wrote:
> On Mon, 2022-12-05 at 13:14 -0800, Andrew Morton wrote:
>> Begin forwarded message:
>>
>> Date: Sun,  4 Dec 2022 12:33:37 +0100
>> From: Kai Wasserbäch <kai@dev.carbon-project.org>
>> To: linux-kernel@vger.kernel.org
>> Cc: Andrew Morton <akpm@linux-foundation.org>, Thorsten Leemhuis <linux@leemhuis.info>
>> Subject: [PATCH 0/2] feat: checkpatch: prohibit Buglink: and warn about missing Link:
>>
>> Thorsten Leemhuis suggested the following two changes to checkpatch, which
>> I hereby humbly submit for review. Please let me know if any changes
>> would be required for acceptance.
> [...]
>> Suggested-by: Thorsten Leemhuis <linux@leemhuis.info>
>> Signed-off-by: Kai Wasserbäch <kai@dev.carbon-project.org>
>>
>> Kai Wasserbäch (2):
>>   feat: checkpatch: error on usage of a Buglink tag in the commit log
> 
> Why, what's wrong with a buglink reference?

Long story short: Linus doesn't like it:

```
>> BugLink: https://lore.kernel.org/r/20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1
>> BugLink: https://lore.kernel.org/r/CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com
> [...]
> please stop making up random tags that make no sense.
> 
> Just use "Link:"
> [...]
> 
> It's extra context to the commit, in case somebody wants to know the
> history. The "bug" part is (and always should be) already explained in
> the commit message, there's absolutely no point in adding soem extra
> noise to the "Link:" tag.>
```
That's a quote from
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/

In that message he also links to another mail from him, where he wrote:
```
> I think "BugLink:" is silly, because that's just a regular link.
> What's the upside of saying "Bug" in there? If you're fixing a bug,
> and are linking to reports and discussions by people, what does that
> "bug" buy you apart from another ugly CamelCase thing?
> 
> In other words, in "BugLink:", neither "Bug" nor "Link" is actually meaningful.
> 
> The current "Link:" tag exists AS A GENERIC WAY TO SAY "look, here's
> more information". That's the point. The word "Link" has no other
> meaning, and trying to then combine it with other things is worthless.
```
https://lore.kernel.org/all/CAHk-=wgzRUT1fBpuz3xcN+YdsX0SxqOzHWRtj0ReHpUBb5TKbA@mail.gmail.com/

Our docs say to use Link in this case, too; see
Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)

And using various tags for the same thing makes it also harder for
external scripts that look at commits to take further action -- like the
regression tracking bot I write and use for my work.

All of that obviously should have been in patch description. Let me
resubmit that patch with all of that in there, or are you dead against
this idea now?

>>   feat: checkpatch: Warn about Reported-by: not being followed by a
>>     Link:
> 
> I think this is unnecessary.

I expect this to cause more discussion, which is why this should be in a
separate submission. But in the end the reasons are similar as above:
(1) Linus really want to see those links to make things easier for
future code archeologists. (2) My regression tracking efforts heavily
rely on those Links, as they allow to automatically connect reports with
patches and commits to fix the reported regression; without those the
tracking is a PITA and doesn't scale.

Together that IMHO is strong enough reason to warn in this case.

Two quotes from Linus to show that he really wants those links:

```
> The current "Link:" tag exists AS A GENERIC WAY TO SAY "look, here's
> more information". That's the point. The word "Link" has no other
> meaning, and trying to then combine it with other things is worthless.
> 
> And a bug report is exactly that kind of "look, here's more
> information".
>
> [...]>
> The commit message should have enough of an explanation on its own
> ("Reported-by:" and the regular "Link:" to the report) that there's
> *no* excuse to try to make a bug report link special.
```
https://lore.kernel.org/all/CAHk-=wgzRUT1fBpuz3xcN+YdsX0SxqOzHWRtj0ReHpUBb5TKbA@mail.gmail.com/

```
>> The flag was dropped because it was causing drivers that requested their
>> memory resource with pci_request_region() to fail with -EBUSY (e.g: the
>> vmwgfx driver):
>>
>> https://www.spinics.net/lists/dri-devel/msg329672.html
> 
> See, *that* link would have been useful in the commit.
> 
> Again, the commit has a link to the patch *submission*, which is
> almost entirely useless. There's no link to the actual problem the
> patch fixes.
>> [...]>
> I _really_ wish the -tip tree had more links to the actual problem
> reports and explanations, rather than links to the patch submission.
>
> [...]>
> Put another way: I can see that
> 
>     Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
> 
> in the commit, but I don't have a clue what the actual report was, and
> there really isn't enough information in the commit itself, except for
> a fairly handwavy "Device drivers might, for instance, still need to
> flush operations.."
```
https://lore.kernel.org/amd-gfx/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

This also obviously would need to be in the patch description in some
form. I can take care of that.

Ciao, Thorsten
