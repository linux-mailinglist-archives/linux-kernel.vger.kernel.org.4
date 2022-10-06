Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB7F5F6984
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiJFOWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJFOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:22:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C311902B;
        Thu,  6 Oct 2022 07:22:46 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w2so2246034pfb.0;
        Thu, 06 Oct 2022 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=sRZSFwWJNhbEpFN+oXFfGXrnIdIcpCTTM+wG7N94QsI=;
        b=JRQuch3kUXVGtr5W9/EyWPjULMYe/bFi0Q8dovUbPZEwmlGHC7o2YgsOujBWPlTTB/
         Q/kn4LdHe4tvPCRKMb9WJ66cIthuKEQEOVNDTiVcPpshxQMQ1OcTJN/6ATitOhZ9DO/c
         YOfAwpcnCCEIIYxBXlRXk5hkCt5ODpwzC3kDdT9xqooMM8tQ7i0MfPmOgyQiqselXiFU
         3/rFC45MFc9gWZFxLcGWZDoQ/dZGduFweeRJndmCCs7v0pgt8eagh6oxSjq0wjrb2l/V
         i3CuHXgfv9xMJhpCE0GYeRd8EAz9TBGDl1+91DpcnL8maRtnp8VyxIvb14f8QDwvbVLJ
         6DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sRZSFwWJNhbEpFN+oXFfGXrnIdIcpCTTM+wG7N94QsI=;
        b=iTx8JwBr0IciVmh/2LAju3tgM9Lek6t5IjgxKgAapEAfPzahfeLPBctCh2U4txU9PE
         pnonLRd56Q5nvIkBzAPEKb1vhliwKEDBGv2QP2F142CNIcjZ1EXh3jYifAnX3bMHyI27
         httmX0MRmAnO3C3JMddifbxu6XH7sKE4dmzXwxXJ3hCODrDCO55AfBW08JOT8tQ2LaLl
         zDXLGCjJDgs7CCdvkIVQ1ymQIpEYHyWR92pDhWGR+X0IyC5rzmi3alkSO7UxQyCCVZYd
         p8+2XyDbmQXniuWBM8+uF6XqvyyZhvn2aPdTX7e2NZAebYi2BkMaERcYpVWa2ie5oj4M
         sYRg==
X-Gm-Message-State: ACrzQf38b7MHVqkMOL8ePewFdN+Vk3bYNV1+fPZuq0ziFShzcf4dJQzj
        5iygOhyhd4IRbx57h8Nh2vM=
X-Google-Smtp-Source: AMsMyM46Xdt/3q5bCq/DPIqf4SAmVBng++4iAU9zfGH+Eb2KLuKPINgSKRdZtbyaYxc8tHRO4dar+Q==
X-Received: by 2002:aa7:8e8c:0:b0:562:a549:efc5 with SMTP id a12-20020aa78e8c000000b00562a549efc5mr394615pfr.20.1665066165360;
        Thu, 06 Oct 2022 07:22:45 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x9-20020a63cc09000000b0043a0de69c94sm1938529pgf.14.2022.10.06.07.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 07:22:44 -0700 (PDT)
Message-ID: <e5cafa5a-ec09-2e37-a7d1-8bedadfe7bd7@gmail.com>
Date:   Thu, 6 Oct 2022 23:22:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v5 1/1] Documentation/process: Be more explicit about who
 to mail on patch submission
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org, joe@perches.com
References: <20221004124858.640349-1-bryan.odonoghue@linaro.org>
 <20221004124858.640349-2-bryan.odonoghue@linaro.org>
 <0a154bd0-f380-19ae-00df-5d73c1dc7c8b@gmail.com>
 <42f15689-d1ad-2be8-5fed-8f72d82402dc@linaro.org>
Content-Language: en-US
In-Reply-To: <42f15689-d1ad-2be8-5fed-8f72d82402dc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2022 17:27:06 +0100, Bryan O'Donoghue wrote:
> On 04/10/2022 16:17, Akira Yokosawa wrote:
>> Hi Bryan,
>>
>> I'll be silent on the word choice of "supporter" for the time being. :=
-)
>>
>> On Tue,=C2=A0 4 Oct 2022 13:48:58 +0100, Bryan O'Donoghue wrote:
>>> Recently when submitting a yaml change I found that I had omitted the=

>>> maintainer whose tree the change needed to go through.
>>>
>>> The reason for that is the path in MAINTAINERS is marked as Supported=
 not
>>> Maintained. Reading MAINTAINERS we see quote:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Su=
pported:=C2=A0=C2=A0 Someone is actually paid to look after this.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ma=
intained:=C2=A0 Someone actually looks after it.
>>>
>>> The current submitting-patches.rst only says to mail maintainers thou=
gh not
>>> supporters. Discussing further on the list the suggestion was made to=
 state
>>> that the following are the right addresses to mail:
>>>
>>> - Maintainers
>>> - Supporters
>>> - Reviewers
>>> - Dedicated lists
>>> - LKML as a fallback when there is no dedicated list
>>>
>>> Add in a two sentences to capture that statement.
>>>
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> ---
>>> =C2=A0 Documentation/process/submitting-patches.rst | 7 +++++--
>>> =C2=A0 1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/process/submitting-patches.rst b/Documenta=
tion/process/submitting-patches.rst
>>> index be49d8f2601b4..90fda3367a405 100644
>>> --- a/Documentation/process/submitting-patches.rst
>>> +++ b/Documentation/process/submitting-patches.rst
>>> @@ -227,8 +227,11 @@ You should always copy the appropriate subsystem=
 maintainer(s) on any patch
>>> =C2=A0 to code that they maintain; look through the MAINTAINERS file =
and the
>>> =C2=A0 source code revision history to see who those maintainers are.=
=C2=A0 The
>>> =C2=A0 script scripts/get_maintainer.pl can be very useful at this st=
ep (pass paths to
>>> -your patches as arguments to scripts/get_maintainer.pl).=C2=A0 If yo=
u cannot find a
>>> -maintainer for the subsystem you are working on, Andrew Morton
>>> +your patches as arguments to scripts/get_maintainer.pl).=C2=A0 In th=
e output of
>>> +get_maintainer.pl the recommendation is to mail every maintainer, su=
pporter,
>>> +reviewer and dedicated mailing list. If get_maintainer doesn't indic=
ate a
>>> +dedicated mailing list linux-kernel@vger.kernel.org should be includ=
ed. If you
>>> +cannot find a maintainer for the subsystem you are working on, Andre=
w Morton
>>> =C2=A0 (akpm@linux-foundation.org) serves as a maintainer of last res=
ort.
>>> =C2=A0 =C2=A0 You should also normally choose at least one mailing li=
st to receive a copy
>>
>> Quoting subsequent paragraph:
>>
>> =C2=A0=C2=A0 You should also normally choose at least one mailing list=
 to receive a copy
>> =C2=A0=C2=A0 of your patch set.=C2=A0 linux-kernel@vger.kernel.org sho=
uld be used by default
>> =C2=A0=C2=A0 for all patches, but the volume on that list has caused a=
 number of
>> =C2=A0=C2=A0 developers to tune it out.=C2=A0 Look in the MAINTAINERS =
file for a
>> =C2=A0=C2=A0 subsystem-specific list; your patch will probably get mor=
e attention there.
>> =C2=A0=C2=A0 Please do not spam unrelated lists, though.
>>
>> The paragraph you updated mentions the maintainers (as persons) to
>> send patches.
>>
>> The subsequent paragraph talks about mailing lists.
>>
>> After this patch is applied, they look mostly redundant except for
>> an important difference. In your patch, Cc: LKML is recommended only
>> when a subsystem-specific list can not be found. In the subsequent
>> paragraph, LKML is recommended to be Cc'd by default, in addition
>> to subsystem-specific lists. Does my interpretation wrong?
>=20
> Yes I take your point.
>=20
> It is probably wiser to drop "dedicated" from the sentence.
>=20
>> Doesn't the subsequent paragraph (quoted above) work for you?
>=20
> Not especially. I think it is a super-semantic distinction but,
> the word "normally" implies there is also an abnormal case.
>=20
> "Always" would be a better world than "normally"
Then I think "normally" is the suitable choice because the choice
of recipients is highly dependent of the nature of patches as well
as the subsystem in question.

For example, when submitting an "obviously correct" patch, my list
of CCs could be just:

   Cc: Main maintainer of the subsystem in question
   Cc: subsystem-specific list
   Cc: LKML

, because I can expect the main maintainer would apply it without
any need of someone else's review, and I don't want to spam other
maintainers/reviewers.

On the other hand, when submitting a fix of a regression, my list
of CCs would be:

   Cc: Author of the offending commit
   Cc: Reviewer A who gave a Reported-by: tag to the offending commit
   ...
   Cc: Maintainer B who is in the Signed-off-by chain of the offending co=
mmit
   Cc: Maintainer C who is also in the Signed-off-by chain
   ...
   Cc: Main Maintainer of the subsystem in question
   Cc: subsystem-specific list
   Cc: LKML

When submitting a new version of a patch, in addition to the above,

   Cc: Developer D who commented in earlier version(s) of the patch
   Cc: Developer E who commented in earlier version(s) of the patch
   ...

To be clear, I don't use get_maintainer.pl so much for patches to
subsystems I have experience with.
I sometimes try it for unfamiliar area of kernel source tree to know
which subsystem it belongs to.

I'm not sure if this scheme works if I need to submit a patch
to devicetree/media/... where organization of subsystems is complex.

As for submitting-patches.rst, although the expected audience is
inexperienced in submitting patches, it would be safe assume

>=20
>> If it does, you don't need to mention mail lists in your change.
>> Otherwise, you also need to tweak/remove the subsequent paragraph.
>>
>> Thoughts?
>=20
> The sentence I'm posting here pertains to the output of "get_maintainer=
".
> I think there is value in having a concise statement to say "take
> the output of get_maintainer and do X"
>=20
> I also think having a paragraph that says "you must always send
> to at least one mailing list" is both direct and true.
You might like to be told so, I'd like to know possible options
I can choose.

>=20
> You are not _required_ to run get_maintainer to submit a patch,
> it is simply _suggested_ so in my view the output of get_maintainer
> doesn't negate the statement that you must mail at least one public
> mailing list.
You lost me already.
Running get_maintainer is optional, but I must always obey its
suggestion? Huh?

I'm beginning to agree what Jon commented when he applied Krzysztof's pat=
ch [1]:

    I worry about trying to cram every detail into these documents; it's =
not
    as if their length isn't intimidating already.  But I've gone ahead a=
nd
    applied this, thanks.

[1]: https://lore.kernel.org/all/87ee12cq2j.fsf@meer.lwn.net/

Bryan, what you are trying here is going to worry Jon further.
I believe this introductory document needs to be kept as concise as
possible.

Documentation on get_maintainer.pl can go elsewhere, and can be as
lengthy as you'd like.

I think I'm not going to do any more review of this kind of change.

Bye.

Akira
>=20
> ---
> bod
