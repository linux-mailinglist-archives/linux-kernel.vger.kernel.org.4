Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2285FFA8E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 16:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJOOfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 10:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJOOfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 10:35:42 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Oct 2022 07:35:39 PDT
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB904D244;
        Sat, 15 Oct 2022 07:35:39 -0700 (PDT)
Received: from [10.2.11.223] (unknown [10.2.11.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id B73B5187C1D4;
        Sat, 15 Oct 2022 16:16:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1665843374; bh=v5byCCbzgoUsSwv2FnayNlVux3Dzc6HK0R9SVKx3mVY=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To;
        b=XbL9kSyPd0uc24BqTzDjcXX/NkK5nXJsW1EdZIc5QVRWstmlVbkwQ/JbeMinDyuNc
         nBGQFPJjzpB05I5s8zjNXHD/OwzDhIYMxlkP8DpkB3IV2w5tYKfGf8eqPywqucX+DB
         +lzd3GT+hjW5xF8KjGYKfeknkq6NySKgxlAdyzH8=
Content-Type: multipart/mixed; boundary="------------XhKck0qOnJW5WHXa9z0SMSgn"
Message-ID: <00604162-9157-3862-b463-de90cb17c69a@schinagl.nl>
Date:   Sat, 15 Oct 2022 16:16:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 00/13] [RFC] Rust support
Content-Language: nl
From:   Olliver Schinagl <oliver+list@schinagl.nl>
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
 <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com>
 <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
 <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com>
 <5c0bb1db-5589-32ca-ac22-4aafb3c15751@schinagl.nl>
 <20220728112114.0000003a@garyguo.net>
 <a4803f2e-2e46-1c7d-0e89-96f5cbb0ad11@schinagl.nl>
In-Reply-To: <a4803f2e-2e46-1c7d-0e89-96f5cbb0ad11@schinagl.nl>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------XhKck0qOnJW5WHXa9z0SMSgn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

As this thread kind of went silent and as the 'big merge' for this 
feature is getting closer, here a final plee, inspired by this slashdot 
post [0].

The post in itself speaks of a new team forming on working on the Rust 
styleguide, which in itself is still evolving. This makes sense, rust is 
new, it's not very commonly in use and as with all good things, they evolve.

One comment in that slashdot post [1] I want to bring forward and quote 
a piece of:
"i created a new repository, and thought i was being hip and modern, so
i started to evangelize spaces for the 'consistency across environments'

i get approached by not one, but TWO coworkers who unfortunately are 
highly visually impaired and each has a different visual impairment

at that moment, i instantaneously conceded — there's just no 
counter-argument that even comes close to outweighing the accessibility 
needs of valued coworkers"

Visual impairness is a thing, it does not make someone smarter or 
dumber. Helping those with visual impairments should be concidered, and 
not shunted off by saying 'but the rust guys came up with the perfect 
style, so we should use it'.

Find attached, a diff to the .rustfmt.toml, that should keep things more 
consistent with the current kernel style.

I'll leave it now to Linus and Greg to concsider this, and will keep my 
peace (though I hope they actually read it :p).


Olliver


[0]: 
https://developers.slashdot.org/story/22/10/07/2351222/rust-programming-language-announces-new-team-to-evolve-official-coding-style
[1]: https://developers.slashdot.org/comments.pl?sid=22182701&cid=62949323

On 28-07-2022 22:43, Olliver Schinagl wrote:
> Hey Gary,
> 
> On 28-07-2022 12:21, Gary Guo wrote:
>> Hi Olliver,
>>
>> On Wed, 27 Jul 2022 10:05:31 +0200
>> Olliver Schinagl <oliver+list@schinagl.nl> wrote:
>>
>>> Consitency is absolutly important! Zero argument there. My argument
>>> is, the consistency should be within the kernel tree, not 'but the
>>> rest of the world is using style X/Y/Z, lets be consistent with that.
>>> In an utopia, maybe, but the real world doesn't work that way, sadly.
>>> So in an attempt to standardize (rustfmt) they just "invented" a new
>>> standard. Which btw is common, we see this happening every so often,
>>> right?
>>
>> Difference languages have different characteristics and I don't think
>> it's necessarily good (and often isn't) to blindly apply coding style
>> of one language onto another. So I don't see rustfmt as "inventing yet
>> another standard" really, because there aren't many conflicting coding
>> style standards in Rust world; almost everyone just settled on using
>> rustfmt, mostly using the default, maybe with a few small
>> project-specific configuration tweaks.
> I was mostly arguing about a) lets look at this and b) having said
> configuration tweaks, rather then blindly (pun not really intended)
> going with rust's defaults :)
> 
>>
>> A small example for C and Rust differences:
>>
>> Rust requires braces around branches of if expression, and C doesn't.
>> So in kernel coding style you often have:
>>
>> 	if (condition) do_something();
>>
>> Or
>>
>> 	if (condition)
>> 		do_something();
>>
>> But in Rust it will be:
>>
>> 	if condition {
>> 	    do_something();
>> 	}
> So kernel style kind of says 'no braces around single statements'; but
> if your rust compiler doesn't allow this; well then there's nothing to
> do. You could even argue to update the kernel C style on this to make it
> consistent again. BUT, this inconsistency makes it cognative 'hard'. If
> this if a C or a rust function? for example during a review. During
> authoring, when writing both C and rust code (due to nececity, not
> constant context switching) you cognitivly constantly have to go
> back/foward. While I'm sure there's people here that can do this all day
> without problem, some of of find this harder then needs to be. Hence the
> request to _try_ to keep consistency within the kernel tree.
> 
>>
>> That's just an example of one control flow constructions. There are
>> differences between Rust match and C switch, etc. Rust's official
>> coding style takes properties of Rust into consideration, so in many
>> regards it's a more suitable coding style for Rust code in kernel, then
>> applying kernel's C coding standard directly on kernel's Rust code.
>>
>> Your earlier email in the thread also mentions about indentation, and I
>> have a few things to point out as well.
>>
>> First, Rust code typically requires more levels of indentation than C
>> code. For example, many functions might be methods and they are inside
>> an impl block, which creates one extra level of indentation.
>> Statements inside match arms' block are two levels more indented than
>> the match statement itself, as opposed to C's switch (as kernel coding
>> style doesn't indent the case labels). As a result, 8 spaces for 1 level
>> can be a bit excessive for Rust code, and thus the 4 space indentation
>> used in rustfmt default.
>>
>> Secondly, I don't think the argument about tabs being customisable
>> holds; in kernel coding style tabs are strictly 8 characters. For line
> Sure, this rule implies that for alignment, tabs should be set to 8 so
> things align nicely. However, nobody forces people to set their editor
> to 8 character width. Not doing so, doesn't break anything. At worst,
> you may commit something that is poorly aligned (but we _should_ be
> using tabs to indent, spaces to align anyway :p, tab == indent has meaning).
> 
> With non-tab indentation, this is no longer really possible, or at
> least, editors haven't solved that problem yet, as it tends to still
> break (due to the mixing of indentation and alignment using a single
> character). Maybe once we have AI and ML in our editors though :p
> 
>> continuation it's not uncommon to use a series of tabs followed by a
>> few spaces, e.g.
>>
>> 	int function_name(int first_argument,
>> 	< tab  >< tab  >..int second_argument)
>>
>> changing tab into 4 spaces will break the layout. (and I'll not go into
>> well-known reasons about non-4-space-tab messing up code in terminal
>> etc).
>>
>>> Copy/pasting is known to cause bugs. There's actually research from
>>> NASA on that. Code-reuse (libraries/functions) are not bad. But
>>> (worst kind of example) copy paste from stack-overflow, or
>>> copy/pasting stuff without actually looking at the content and
>>> forgetting to rename something, causes bugs. Why is this relevant?
>>> The whole 'lets be consistent with the rust codebase of the wrold'
>>> argument. E.g. if everybody uses the same style (which is idealistic
>>> and great) then copy/pasting becomes consistent. Where I say, try to
>>> be careful when copy/pasting code.
>>
>> When we vendor in code as a whole (e.g. like we currently do for
>> alloc crate), it is proper code reuse. With different coding style the
>> vendored code either diverges from upstream (which makes upstreaming
>> much more difficult) or diverge from rest of kernel's Rust code base.
> Very fair point of course. Though really, we should fix the upstream
> rust preferred format, but there it was already stated, that 'too bad,
> sorry' which from a developer point of view is fine, your project, your
> choice. From a disabilities point of view, sucks of course.
> 
>>
>>> But if that is the case, why not try to follow the kernels existing
>>> code-style as close as possible with the rust-fmt configuration? I
>>> know code-style has been discussed a few times over the decades; but
>>> not many changes have been done, surely, if there's some codestyle
>>> changes that are best for the kernel, they would have been 'advised'?
>>> '4 space indents are better then 8-size tabs, on new code, try to use
>>> them' for example :p
>>
>> You do realize that you are creating a new coding style by doing this,
>> right? It feels like creating problems rather than solving problems.
>>
>> My personal feeling is that it's easier for me to adapt to different
>> coding style when switching between languages, but it's rather awkward
>> for me when trying to use different coding styles with the same
>> language. I find myself no problem switching between 2 spaces when
>> coding JavaScript to 4 spaces when coding Rust to 8 spaces(tab) when
>> coding C, but it's rather painful to switch between C projects with
>> different coding styles. I certainly don't want to switch between Rust
>> projects with vastly different coding styles.
> And I'm happy for you that you can easily take in 2 and 4 spaces. For
> me, it is extremly hard to read. So it's not a 'personal preference'
> thing. But I suggest to read the earlier posted links, where others at
> length explain it as well, how it is like to feel excluded becaues its
> just hard to read.
> 
>>
>>> But why? Why should we not be consistent with the kernels' code-base
>>> (while yes, that is not rust, but C, but we can follow the same
>>> style?)
>>
>> Difference languages have different characteristics, and one size
>> doesn't fit them all :)
> I'm not even arguing this at all :)
> 
> I think the biggest issues i'm speaking of really are the braces and the
> spaces really, where the braces can be argued for/against, it's
> cognitive harder, but can be dealth with (and we can expect
> inconsitencies; but the sapces vs tabs thing, personal configuration vs
> forced with is the point I was trying to raise.
> 
> As said before, 'every building is different, some offer wheelchair
> ramps, others do' kind of point, not like 'this building is red, and
> that one is blue, and not every color fits all :p
> 
>>
>>> Sadly, I've seen so much vendor code (yeah, I know) which doesn't
>>> even have consistency in their own files ...
>>
>> That's very true. So when all other Rust code currently follow
>> (roughly) the same coding style and this situation doesn't currently
>> exist, let's not make it worse...
>>
>> Best,
>> Gary
> 

--------------XhKck0qOnJW5WHXa9z0SMSgn
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-rustfmt-Match-style-with-kernel-codestyle.patch"
Content-Disposition: attachment;
 filename="0001-rustfmt-Match-style-with-kernel-codestyle.patch"
Content-Transfer-Encoding: base64

RnJvbSAwYWMxZTU2NDM1ZTI3YWRkZGVmOTgwNmRiZjExMzRmOTA5ZTk5ZGQ0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBPbGxpdmVyIFNjaGluYWdsIDxvbGl2ZXJAc2NoaW5h
Z2wubmw+CkRhdGU6IFNhdCwgMTUgT2N0IDIwMjIgMTY6MDk6MDYgKzAyMDAKU3ViamVjdDog
W1BBVENIXSBydXN0Zm10OiBNYXRjaCBzdHlsZSB3aXRoIGtlcm5lbCBjb2Rlc3R5bGUKClNp
Z25lZC1vZmYtYnk6IE9sbGl2ZXIgU2NoaW5hZ2wgPG9saXZlckBzY2hpbmFnbC5ubD4KLS0t
CiAucnVzdGZtdC50b21sIHwgOCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhLy5ydXN0Zm10LnRvbWwgYi8ucnVzdGZtdC50b21sCmlu
ZGV4IDNkZTVjYzQ5NzQ2NS4uMjkwYjg4YzAwMjY1IDEwMDY0NAotLS0gYS8ucnVzdGZtdC50
b21sCisrKyBiLy5ydXN0Zm10LnRvbWwKQEAgLTEsNSArMSwxMyBAQAorYmlub3Bfc2VwYXJh
dG9yID0gIkJhY2siCiticmFjZV9zdHlsZSA9ICJBbHdheXNOZXh0TGluZSIKK2NvbnRyb2xf
YnJhY2Vfc3R5bGUgPSAiQWx3YXlzU2FtZUxpbmUiCiBlZGl0aW9uID0gIjIwMjEiCitoYXJk
X3RhYnMgPSAidHJ1ZSIKK2luZGVudF9zdHlsZSA9ICJWaXN1YWwiCittYXRjaF9ibG9ja190
cmFpbGluZ19jb21tYSA9ICJ0cnVlIgogbmV3bGluZV9zdHlsZSA9ICJVbml4Igorc3RydWN0
X2xpdF9zaW5nbGVfbGluZSA9ICJmYWxzZSIKK3RhYl9zcGFjZXMgPSAiOCIKIAogIyBVbnN0
YWJsZSBvcHRpb25zIHRoYXQgaGVscCBjYXRjaGluZyBzb21lIG1pc3Rha2VzIGluIGZvcm1h
dHRpbmcgYW5kIHRoYXQgd2UgbWF5IHdhbnQgdG8gZW5hYmxlCiAjIHdoZW4gdGhleSBiZWNv
bWUgc3RhYmxlLgotLSAKMi4zOC4wCgo=

--------------XhKck0qOnJW5WHXa9z0SMSgn--
