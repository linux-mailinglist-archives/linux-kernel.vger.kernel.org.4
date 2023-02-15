Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CA66981A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjBORJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBORJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:09:25 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BEF7A9E;
        Wed, 15 Feb 2023 09:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1676480963;
        bh=eiSYp3CWa9f5+5UCPUS1CMqGZs9fj9OtcbZW+higofY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D+11Ayfy6w51aezry8N6+/JDX6p+k2xSEAToS+GTO49Ix2LfFLT0Yx/mgw3EJ5VPq
         XOpCDh1dgxxSOwKe89Zk8nd8HFWN0kdDDIOWwzwnPk25gOsM2nRlJGCQLhjHtRRa4C
         sKP3AGsF6D01ybPFaYPsNKwXZzOkxnYf/2bO48F5gnw09nRIkQX+bhMZdURsvGUI/P
         D/y9VnkAOVCI8L9i4LI5f3lcqeH4npJ2uAcLQ+nn3Syx1pGr765CAvcEWjZUVaTfub
         bJxZ2WEWJ4KklliH8Dln6SBeXa8xhRDQ5VhSTWZA2ZLfTJ/OhlxB9REdMDTc1TVFVh
         tWSSA1ZUHjE8Q==
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PH4LW2d36zlZV;
        Wed, 15 Feb 2023 12:09:23 -0500 (EST)
Message-ID: <849b233c-b094-849d-a8fe-9b53cde33c80@efficios.com>
Date:   Wed, 15 Feb 2023 12:09:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/1] rseq.2: New man page for the rseq(2) API
Content-Language: en-US
To:     "G. Branden Robinson" <g.branden.robinson@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>
References: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
 <669eb324-aef6-0583-c8a4-f54a93ee4d6d@gmail.com>
 <20230215012054.twzw4k5et6hxvi2j@illithid>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230215012054.twzw4k5et6hxvi2j@illithid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-14 20:20, G. Branden Robinson wrote:
> [CC list violently trimmed; for those who remain, this is mostly man
> page style issues]

[ Gently added linux-man to CC list. ;-) ]

> 
> At 2023-02-14T23:29:37+0100, Alejandro Colomar wrote:
>> On 2/14/23 20:54, Mathieu Desnoyers wrote:
>>> +per-thread data structure shared between kernel and user-space.
>>
>> This last 'user-space' is not adjectivated, so it should go without
>> a hyphen, according to common English rules.
> 
> +1

done


> 
> Also I like your coinage.  "Adjectivated yeast" is reflexive and
> tautological!
> 
>>> +.RB ( "struct rseq" )
>>
>> We format types in italics, so this should be '.RI'.
> 
> +1

OK, so it's italics for both types and arguments.

I will replace all the bold markers for "struct rseq" and "struct 
rseq_cs" to italic in the description (but not in the synopsis section 
and not in the code snippets).

> 
>>> +Only one
>>> +.BR rseq ()
>>> +ABI can be registered per thread, so user-space libraries and
>>> +applications must follow a user-space ABI defining how to share this
>>> +resource.
>>
>> Please use semantic newlines.  See man-pages(7):
>>
>>     Use semantic newlines
>>         In  the source of a manual page, new sentences should be started on new
>>         lines, long sentences should be split into lines at clause breaks (com‐
>>         mas, semicolons, colons, and so on), and long clauses should  be  split
>>         at  phrase  boundaries.   This convention, sometimes known as "semantic
>>         newlines", makes it easier to see the effect of  patches,  which  often
>>         operate at the level of individual sentences, clauses, or phrases.
> 
> I think I've said this before, but, strictly, commas in particular can
> separate things that are not clauses.  Clauses have subjects and
> predicates.
> 
> Might it be better to say simply:
> 
>    Start each sentence on a new line.  Split long sentences where
>    punctuated by commas, semicolons, and colons.
> 
> With this there is not even any need to discuss "phrase boundaries".
> 

I've modified to:

Only one
.BR rseq ()
ABI can be registered per thread,
so user-space libraries and applications must follow a user-space ABI
defining how to share this resource.

Hopefully that's correct.


>> In the above lines, that would mean breaking after the comma,
>> and not leaving resource in a line of its own.
> 
> The latter is inevitably going to happen from time to time simply due to
> sentence length and structure and the line length used by one's text
> editor.  I don't think an "orphan word" (what typographers call this) is
> symptomatic of anything in *roff source when filling is enabled.
> 
>>> +The ABI defining how to share this resource between applications and
>>> +libraries is defined by the C library.
>>> +Allocation of the per-thread
>>> +.BR rseq ()
>>> +ABI and its registration to the kernel is handled by glibc since version
>>> +2.35.
>>> +.PP
>>> +The
>>> +.BR rseq ()
>>> +ABI per-thread data structure contains a
>>> +.I rseq_cs
>>> +field which points to the currently executing critical section.
>>
>> currently-executing should probably use a hyphen
>> (if I understood the line correctly).
> 
> This is not the case, according to some style authorities.  Dave Kemper
> convinced me of this on the groff list.
> 
> Here is one resource.
> 
> https://www.editorgroup.com/blog/to-hyphenate-or-not-to-hyphenate/
> 
>> See an interesting discussion in the groff@ mailing list:
>> <https://lists.gnu.org/archive/html/groff/2022-10/msg00015.html>
> 
> That's not _squarely_ on point, as none of "block", "device", or "based"
> is an adverb.  "Currently" is.

Leaving unchanged based on this discussion.

> 
>>> +For each thread, a single rseq critical section can run at any given
>>> +point.
>>> +Each critical section need to be implemented in assembly.
>>
>> needs?
> 
> +1

done.

> 
>>> +.TP
>>> +.B Structure alignment
>>
>> Let's remove the bold here.  It's not necessary for marking a constant
>> or something that needs bold.  And the indentation is already making
>> it stand out, so bold is a bit too much aggressive to the reader.
> 
> I agree; if it wouldn't be styled in running text, it doesn't need
> styling as a paragraph tag; it already stands out by dint of its
> placement as a tag.
> 
>>> +Its value should always be confirmed by reading the cpu_id field before
>>
>> cpu_id should be formatted (.I).
> 
> +1

done

> 
>>> +user-space performs any side-effect
>>> +(e.g. storing to memory).
>>> +.IP
>>> +This field is always guaranteed to hold a valid CPU number in the range
>>> +[ 0 ..  nr_possible_cpus - 1 ].
>>
>> Please use interval notation:
>> 	[0, nr_possible_cpus)
>> or
>> 	[0, nr_possible_cpus - 1]
>> whichever looks better to you.
>>
>> We did some consistency fix recently:
>> <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=147a60d792a5db8f3cb93ea16eefb73e16c1fb91>
>>
>> Also, do we have a more standard way of saying nr_possible_cpus?
>> Should we say nproc?

nproc(1) means:

        Print  the number of processing units available to the current
        process, which may be less than the number of online processors

Which is the number of cpus currently available (AFAIU the result of the
cpuset and sched affinity).

What I really mean here is the maximum value for possible cpus which can 
be hotplugged into the system. So it's not the maximum number of 
possible CPUs per se, but rather the maximum enabled bit in the possible 
CPUs mask.

Note that we could express this differently as well: rather than saying 
that it guarantees a value in the range [0, nr_possible_cpus - 1], we 
could say that the values are guaranteed to be part of the possible cpus 
mask, which would actually more accurate in case the possible cpus mask 
has a hole (it tends to happen with things like lxc containers nowadays).

Do you agree that we should favor expressing this in terms of belonging 
to the possible cpumask set rather than a range starting from 0 ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

