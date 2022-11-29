Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD2963BF3F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiK2LlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbiK2Lkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:40:51 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265C64A07F;
        Tue, 29 Nov 2022 03:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669722046; x=1701258046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dj3yv782CgVSbDWsCFTsi9bDR5Zdl0MYjrJXe4M+W9k=;
  b=ArKZ2WE3ZkDZU2YO+8xDjSNlSb056VrKcgfE++g8Ge0iJWU0gWz4R7i4
   Aqcx3OXOsZD8pzR7xM3GzAcyKDtDNk+spwjpMj2tEdBhG2Uww0Wlx26YT
   NPctNqjVStpXPIETedHZzMY+s6X5YRBxMS7rMYZeErxsHo8yMZX+x8cHZ
   6vs/zEv26PlC4yNBN8JYD/hm+UGnUofUy0JZVG4vCeFO6cdhYARd0CH56
   NfhdhjgKP9fzhI8uC52OISNdKUfMOhPqV9JMvNz2xMHm5f/YH6fEnb2Tw
   gcitPigciqPG10BIkz6hqtBDFAbp+rRr7eDhgNslZjhwoenQGbkmD8Nt4
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="185661326"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2022 04:40:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 29 Nov 2022 04:40:33 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 29 Nov 2022 04:40:31 -0700
Date:   Tue, 29 Nov 2022 11:40:12 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>, <palmer@dabbelt.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>, <heiko@sntech.de>,
        <linux-riscv@lists.infradead.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <guoren@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: Re: [PATCH 2/2] dt-bindings: riscv: fix single letter canonical order
Message-ID: <Y4XvnHIPw8ZuBZEk@wendy>
References: <Y4UJQYgCpnZJji9o@spud>
 <mhng-8141aa74-17c6-4692-a658-b5e4faad0c14@palmer-ri-x1c9a>
 <20221129051911.5xetsgfukxiljuhf@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221129051911.5xetsgfukxiljuhf@kamzik>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yo Drew, Palmer,

(preserving the conversation in case any DT folks want to chime
in on the ABI comment)

On 29/11/2022 05:19, Andrew Jones wrote:
> On Mon, Nov 28, 2022 at 03:41:19PM -0800, Palmer Dabbelt wrote:
>> On Mon, 28 Nov 2022 11:17:21 PST (-0800), Conor Dooley wrote:
>>> On Mon, Nov 28, 2022 at 10:12:17AM -0800, Palmer Dabbelt wrote:
>>>> On Mon, 28 Nov 2022 10:08:05 PST (-0800), Conor Dooley wrote:
>>>>> On Mon, Nov 28, 2022 at 09:41:03AM -0800, Palmer Dabbelt wrote:
>>>>>> On Thu, 24 Nov 2022 05:42:20 PST (-0800), heiko@sntech.de wrote:
>>>>>>> Am Donnerstag, 24. November 2022, 14:04:41 CET schrieb Conor Dooley:
>>>>>>>> I used the wikipedia table for ordering extensions when updating the
>>>>>>>> pattern here in foo.
>>>>>>>
>>>>>>>          ^ foo? :-)
>>>>>>>
>>>>>>>> Unfortunately that table did not match canonical order, as defined by
>>>>>>>> the RISC-V ISA Manual, which defines extension ordering in (what is
>>>>>>>> currently) Table 41, "Standard ISA extension names". Fix things up by
>>>>>>>> re-sorting v (vector) and adding p (packed-simd) & j (dynamic
>>>>>>>> languages). The e (reduced integer) and g (general) extensions are still
>>>>>>>> intentionally left out.
>>>>>>>>
>>>>>>>> Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-from-asciidoc-15112022 # Chapter 29.5
>>>>>>>> Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings for emulators")
>>>>>>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>>>>>>
>>>>>>> So I have compared the new pattern to the isa manual,
>>>>>>> and it looks like the order checks out, so
>>>>>>
>>>>>> Which ISA manual?
>>>>>
>>>>> For me, isa manual is the above github repo.
>>>>
>>>> Which commit, though?
>>>
>>> mutt won't let me paste a clown face emoticon.
>>>
>>>>>> There have been many mutually incompatible ISA string
>>>>>> encoding rules, at least one of them was a change to the extension ordering.
>>>>>> It's not entirely clear what the right answer is here, as we can't really
>>>>>> parse ISA strings without also knowing the version of the ISA manual we're
>>>>>> meant to parse them against.  Maybe we just accept everything?
>>>>>
>>>>> I don't think accepting everything is the right thing to do. A minimal
>>>>> amount of validation is still needed here, but I think we can deprecate
>>>>> the DT property entirely & make it optional if a new-and-improved way of
>>>>> encoding the in DT is used.
>>>>
>>>> Sorry, by "everything" I meant "everything that's even been allowed by the
>>>> ISA manual".  Just accetping anything would be bad ;)

I agree. I can always relax the regex if something comes to light - but
it's already pretty forgiving about the ordering of stuff - especially
the multiletter extensions.

>>>>
>>>>>> IMO it's time to just stop using the ISA string.  It's not a stable
>>>>>> interface, trying to treat it as such just leads to headaches.  We should
>>>>>> just come up with some DT-specific way of encoding whatever HW features are
>>>>>> in question.  Sure it'll be a bit of work to write that all down in the DT
>>>>>> bindings, but it's going to be way less work than trying to keep around all
>>>>>> this ISA string parsing code.
>>>>>
>>>>> I'm a glutton for punishment, I'll try and come up with some sort of
>>>>> other way to encode this information in DT that requires less parsing
>>>>> and validation. As I said on IRC, something that more resembles:
>>>>> if (of_property_wahtever("riscv,isa-foo")) { do_enable_foo() }
>>>>
>>>> That seems way simpler to me, thanks!  We'll still need to support whatever
>>>> was here as a legacy format, but at least we won't need to add a bunch of
>>>> new stuff to it -- that's where the parsing starts to get really
>>>> complicated.
> 
> While it's easy for Linux to add new DT nodes when new extension support is
> added, it's not so easy to add new ACPI objects. The current plan for ACPI
> is to use the ISA string[1]. With that in mind, I think Linux should
> continue to parse the string for DT as well.

I was thinking about how to implement this at the gym this morning,
before even reading this mail, and I have gotten cold feet about doing
riscv,isa-foo stuff anyway.

I don't really want to create a confusing, two-location way of turning
features on. We would be either forcing all other operating systems to
switch away from using riscv,isa too or creating a difference between
how Linux handles things compared to, say, FreeBSD or U-Boot.
IOW, if the "v" in riscv,isa turned it on for FreeBSD and a boolean DT
property of riscv,isa-v did it for Linux. I really dislike the idea of
that...

If we are going to have to parse it *anyway* for ACPI, then I think
there's little merit unfortunately.

I think we would also end up ballooning the code with a bunch of checks
for the different extensions which I am not keen on either.
Completely relaxing any parsing rules, as discussed below, seems like
a less user-hostile & more "application" independent way of proceeding.

> [1] https://docs.google.com/document/d/1LlCefO_0GQ_7Tf3lzfMPETEfMlGo2FfLRJ09IMqJKEk/edit
> 
>>>
>>> Yah, and "deprecated" in dt-schema doesn't actually do anything at the
>>> moment other than let humans know not to use something. Just gonna have
>>> to do some sort of "feature-wise AND" between the existing things we

That should be s/AND/OR/

>>> parse from the isa string & whatever riscv,isa-foo stuff later on.
>>
>> I suppose this is more of a Rob question, but could we just make the DT
>> bindings match the current ISA manual's rules and then have the kernel's
>> "riscv,isa" string parser accept more orderings to remain compatible?
>>
>> Sort of a API vs ABI stability question, but for DTB and bindngs.

AFAIU, the kernel needs to keep supporting only what was ever in a
dt-binding to satisfy the DT ABI and our current regex is compatible
with that so that's fine.
Whether or not we have laxer rules within the kernel is fine, as long
as we support whatever we specified previously in the binding.

>>>> FWIW, there's a similar dicussion going on in GCC land right now.
>>>>
>>>>>> I know I've said the opposite before, but there's just been way too many
>>>>>> breakages here to assume they're going to stop.
>>>>>
>>>>> :upside_down_face:
>>>>>
>>>>> Either way, I think these two patches are worth taking in the mean time.
>>>>
>>>> Yep, just as long as it doesn't break any of the strings that were valid
>>>> according to previous versions of the ISA manual I'm fine with it.
>>>
>>> I don't think so. I had been looking around for a supposed order for
>>> where to actually put H, which had been dropped - and the only place I
>>> recall seeing that was Wikipedia - which now seems like an awful
>>> decision since the order there looks kinda off anything I see in dozen
>>> or so spec PDFs I have downloaded. But that's where I got the K & V
>>> ordering from that I now think is wrong (and doesn't match any PDF I
>>> have). The other changes relax rules and add letters so they should be
>>> okay too.
>>
>> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

I am assuming that w/ these tags I can take this with other DT stuff,
since they're kinda unrelated to the ongoing conversation.

>> as it sounds like there aren't even any fixed rules, so I guess none of this
>> even matters?
> 
> IMHO, we should try to get the spec changed to say that the only order
> which matters is that single letter extensions come first (in any order)

Good luck, I'll +1 your PR.

> and then multi-letter extensions come after (in any order). Parsing
> becomes simple and we can publish the string in proc in any order too,
> maybe preferring alphabetical order for neatness.

Devil's advocate, then we break someone's parser that relied expects
things to be how they were ordered by a prior version of the spec?

Either way, I am happy to vote for a world in which the stuff we put
into /proc follows the loosest possible wording that has ever been
using in the spec (and in fact, I think we *need* to do that).

Per the thread on the Zbb stuff, the table claims it "defines the
canonical order in which extension names must appear in the name
string, with top-to-bottom in table indicating first-to-last in the
name string, e.g., RV32IMACV is legal, whereas RV32IMAVC is not." 

It does not contain an entry for Zihintpause & I cannot see anywhere
in the current incarnation* of the naming.tex document that tells us
how to sort unmentioned Standard Additional Extensions - just that
"Standard supervisor-level extensions should be listed after standard
unprivileged extensions" & "Standard machine-level extensions should
be listed after standard lesser-privileged extensions"

(as an aside, I think that second quote is missing a comma after
standard)

The implication there, is that something like Zihintpause could, per
this version of the spec*, be placed anywhere in the string once the
"Base Integer ISA" constraint is satisfied (or not permitted in the
string at all?). Have I missed something? This particular situation
has been the cause of all of my confusion lately - the doc says it
defines the order by the table, which then has no generic entry for
"Additional Standard Extensions".

* 10eea63205f371ed649355f4cf7a80716335958f

Anyways, I feel hopelessly confused by all of this stuff & I wish
we could just write down exactly what *we* are doing w.r.t. internal
kernel representation (yeah yeah https://xkcd.com/927/) as absolutely
noone seems to be sure what to do. Maybe in the "patch acceptance"
document.

In terms of our own parsing of the isa string, assuming single-letter
followed by multiletter is about the only assumption that I think we
should be making.
I don't think that parsing in any order after that really becomes an
issue unless we have x depends on y sort of things where x is not
explicitly required.

The specs currently say:
"Some ISA extensions depend on the presence of other extensions, e.g.,
``D'' depends on ``F'' and ``F'' depends on ``Zicsr''.  These
dependences may be implicit in the ISA name: for example, RV32IF is
equivalent to RV32IFZicsr, and RV32ID is equivalent to RV32IFD and
RV32IFDZicsr."

That'd mean that out-of-canonical-order processing isn't too bad since
the more expansive extension would imply the others too.
Who knows if that will hold for future extensions, but maybe we can
deal with things down the road.

I'll take a look at the current parser to at least get things
straightened out in my own head and then maybe submit a patch for the
docs as mentioned above so we can at least point patch submitters
at something concrete?

I am really sorry for all of the "chaos" that I've sown over the last
few days on this sort of subject, but everyone is doing different things
and it triggers my OCD heh. Knowing where we stand would be nice :)

Thanks,
Conor.

