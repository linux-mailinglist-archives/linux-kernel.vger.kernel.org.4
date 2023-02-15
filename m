Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D126973EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjBOBwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBOBwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:52:16 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404002A157;
        Tue, 14 Feb 2023 17:52:14 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n33so6282979wms.0;
        Tue, 14 Feb 2023 17:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Dh7W8B7GdfNW9yPvCjvXCuyXKP9Wu7p2Nt1nW6SFtM=;
        b=phrqXdzRmKmaU13ShVFndAAUftLPIuXjw5K3mLIl02WLP6mgyjilKVr0GbwTS4DR0e
         Z5r5XS1j0dAQ8Ad2m8bCjsXIWP3p7lFiX3ha8aEqdjdr5xJlhZGoY2JTzsIPwyNTuBiS
         FkSZFGt5yVsK4hgZNQJMF5VNPoI0JlSpkF0rj33eS5YO9WC1BuFPBSnXc9fFqD+LUrif
         /f+R6RaHepdFAn+WvhQln2+c89vgFhVQ7fhiYEe1mhVeIjZmVMK0Ow5s1oD8BoT+na3O
         NEKNjJjocatuZB+VpF7jWDofvS6EQBpmkwpuUqQ76ec3HlVbX2mcW2ZbSaSkPm+1vOu8
         YWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Dh7W8B7GdfNW9yPvCjvXCuyXKP9Wu7p2Nt1nW6SFtM=;
        b=MGmfjkTPfuT9IE9HAZx0ZDyA7lWatPytX0mFY8eUixzsstmJWmCG5GgwS027UlPSLw
         XzPt8Dr5O7bjo/wD5yMOSlU9tXFZWLtySmo8JfhfqWASMDLWr8RnmJUoCJs2TRYclcBr
         lVdJLoTbBcmOhSt+WjtHEMkuLwHNLB4PIik+YhTvJ9J6Ij2tuxYEFQ/umhRwLknpnb5M
         ON4hIE0CK0wh/fkdk1pm8qUpWng0aFSGN55WGYxmLpyX1gaTuKXAPh1rARDCpm+H3xU0
         lk+DD4YTg2MzDhknlqNBYCNmvso07duqFj5MBg4MAp9c33CrzOyKgLtBE+7yJFhYpUpj
         c4AA==
X-Gm-Message-State: AO0yUKWsEDsUy8A6n0T8zCYZYL7ZnkLACLiRItveOso8dobpSuXLhtlE
        7yTKnzEqP9jXoNsIW+Sw9lA=
X-Google-Smtp-Source: AK7set9RpbtmJnOFc0EN+4fgOgfEdwNGUfnLsA4RWOCn+1MjXx1AJ+DNRglvZ6JyJTJmemNm6AOD0Q==
X-Received: by 2002:a05:600c:a293:b0:3d2:3be4:2d9a with SMTP id hu19-20020a05600ca29300b003d23be42d9amr633180wmb.20.1676425932520;
        Tue, 14 Feb 2023 17:52:12 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c4d0600b003de664d4c14sm437341wmp.36.2023.02.14.17.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 17:52:11 -0800 (PST)
Message-ID: <82ced680-8c2c-75b7-4368-16e602353f32@gmail.com>
Date:   Wed, 15 Feb 2023 02:52:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] rseq.2: New man page for the rseq(2) API
Content-Language: en-US
To:     "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>
References: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
 <669eb324-aef6-0583-c8a4-f54a93ee4d6d@gmail.com>
 <20230215012054.twzw4k5et6hxvi2j@illithid>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20230215012054.twzw4k5et6hxvi2j@illithid>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Xj05Fg30Ypwl9s1c12Cq5qbF"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Xj05Fg30Ypwl9s1c12Cq5qbF
Content-Type: multipart/mixed; boundary="------------wK9md0z3a2LwFwAtiC8g3CEm";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-man <linux-man@vger.kernel.org>
Message-ID: <82ced680-8c2c-75b7-4368-16e602353f32@gmail.com>
Subject: Re: [PATCH 1/1] rseq.2: New man page for the rseq(2) API
References: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
 <669eb324-aef6-0583-c8a4-f54a93ee4d6d@gmail.com>
 <20230215012054.twzw4k5et6hxvi2j@illithid>
In-Reply-To: <20230215012054.twzw4k5et6hxvi2j@illithid>

--------------wK9md0z3a2LwFwAtiC8g3CEm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Branden,

On 2/15/23 02:20, G. Branden Robinson wrote:
> [CC list violently trimmed; for those who remain, this is mostly man
> page style issues]

Ironically, you trimmed linux-man@  :D

>=20
> At 2023-02-14T23:29:37+0100, Alejandro Colomar wrote:
>> On 2/14/23 20:54, Mathieu Desnoyers wrote:
>>> +per-thread data structure shared between kernel and user-space.
>>
>> This last 'user-space' is not adjectivated, so it should go without
>> a hyphen, according to common English rules.
>=20
> +1
>=20
> Also I like your coinage.  "Adjectivated yeast" is reflexive and
> tautological!

:D

I didn't even think about it.  "adjetivado" is an actual word in Spanish,=

so I just guessed that it would exist in English.  But yes, it's a nice
word for this case :)

>=20
>>> +.RB ( "struct rseq" )
>>
>> We format types in italics, so this should be '.RI'.
>=20
> +1
>=20
>>> +Only one
>>> +.BR rseq ()
>>> +ABI can be registered per thread, so user-space libraries and
>>> +applications must follow a user-space ABI defining how to share this=

>>> +resource.
>>
>> Please use semantic newlines.  See man-pages(7):
>>
>>    Use semantic newlines
>>        In  the source of a manual page, new sentences should be starte=
d on new
>>        lines, long sentences should be split into lines at clause brea=
ks (com=E2=80=90
>>        mas, semicolons, colons, and so on), and long clauses should  b=
e  split
>>        at  phrase  boundaries.   This convention, sometimes known as "=
semantic
>>        newlines", makes it easier to see the effect of  patches,  whic=
h  often
>>        operate at the level of individual sentences, clauses, or phras=
es.
>=20
> I think I've said this before, but, strictly, commas in particular can
> separate things that are not clauses.  Clauses have subjects and
> predicates.
>=20
> Might it be better to say simply:
>=20
>   Start each sentence on a new line.  Split long sentences where
>   punctuated by commas, semicolons, and colons.
>=20
> With this there is not even any need to discuss "phrase boundaries".

I still disagree with that;
punctuation is not enough
(see below).

>=20
>> In the above lines, that would mean breaking after the comma,
>> and not leaving resource in a line of its own.
>=20
> The latter is inevitably going to happen from time to time simply due t=
o
> sentence length and structure and the line length used by one's text
> editor.

That's if you only break at sentence and clause boundaries,
and then adjust at 80 columns...

>  I don't think an "orphan word" (what typographers call this) is
> symptomatic of anything in *roff source when filling is enabled.

but if you also break at phrase boundaries
(when/where convenient)
you'll find that you get rid of those "orphan words",
because you'll never have to adjust at 80 columns
(or rather,
you'll try to find a way to break it
that also happens to be a phrase boundary
because breaking at phrase boundaries is _better_
than breaking at random points which may happen to be
in the middle of a compound noun).

>=20
>>> +The ABI defining how to share this resource between applications and=

>>> +libraries is defined by the C library.
>>> +Allocation of the per-thread
>>> +.BR rseq ()
>>> +ABI and its registration to the kernel is handled by glibc since ver=
sion
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
>=20
> This is not the case, according to some style authorities.  Dave Kemper=

> convinced me of this on the groff list.
>=20
> Here is one resource.
>=20
> https://www.editorgroup.com/blog/to-hyphenate-or-not-to-hyphenate/

Hmm, interesting.  I didn't think about it, but it makes sense
to not hyphenate here.

>=20
>> See an interesting discussion in the groff@ mailing list:
>> <https://lists.gnu.org/archive/html/groff/2022-10/msg00015.html>
>=20
> That's not _squarely_ on point, as none of "block", "device", or "based=
"
> is an adverb.  "Currently" is.

You're right.

>=20
>>> +For each thread, a single rseq critical section can run at any given=

>>> +point.
>>> +Each critical section need to be implemented in assembly.
>>
>> needs?
>=20
> +1
>=20
>>> +.TP
>>> +.B Structure alignment
>>
>> Let's remove the bold here.  It's not necessary for marking a constant=

>> or something that needs bold.  And the indentation is already making
>> it stand out, so bold is a bit too much aggressive to the reader.
>=20
> I agree; if it wouldn't be styled in running text, it doesn't need
> styling as a paragraph tag; it already stands out by dint of its
> placement as a tag.
>=20
>>> +Its value should always be confirmed by reading the cpu_id field bef=
ore
>>
>> cpu_id should be formatted (.I).
>=20
> +1
>=20
>>> +user-space performs any side-effect
>>> +(e.g. storing to memory).
>>> +.IP
>>> +This field is always guaranteed to hold a valid CPU number in the ra=
nge
>>> +[ 0 ..  nr_possible_cpus - 1 ].
>>
>> Please use interval notation:
>> 	[0, nr_possible_cpus)
>> or
>> 	[0, nr_possible_cpus - 1]
>> whichever looks better to you.
>>
>> We did some consistency fix recently:
>> <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?i=
d=3D147a60d792a5db8f3cb93ea16eefb73e16c1fb91>
>>
>> Also, do we have a more standard way of saying nr_possible_cpus?
>> Should we say nproc?
>=20
> Apropos of a separate discussion we had weeks ago, Alex, I remembered
> where I saw "nitems" as a variable name.
>=20
> _UNIX Programming_, second edition, by Kernighan and Ritchie!
>=20
> https://wolfram.schneider.org/bsd/7thEdManVol2/uprog/uprog.pdf
>=20
> Plop _that_ down on the desk of the person who claimed it was a stupid
> variable name that no good programmer would ever use.

ROFL.  I'm bookmarking this!

>=20
> (I think appeals to authority are just fine as long as one is being
> mean.  ;-P

Indeed ;-P

>  And as regards variable naming, Kernighan is a _legitimate_
> authority: a subject matter expert with multiple well-regarded books on=

> coding style to his credit.  Ritchie's strengths were more esoteric,
> enough that he put up specimens of his own youthful hubris as, I think,=

> an effort to discourage his many admirers from copying his mistakes as
> slavishly as his successes[1]--apart from their humor value.)
>=20
>> Branden, IIRC, this seems to be the reason why I didn't want .RS for
>> indenting code examples.  It doesn't fit nicely right after TP.
>>
>> Why is there a blank line?  I'm not even sure that's reasonable.  Is
>> it a (minor) bug in man(7)?  (FWIW, mandoc(1) is consistent with
>> groff(1).)
>=20
> Right, I'll take this up in the separate thread you started for it on
> the groff list.

Sure.

>=20
> Regards,
> Branden
>=20
> [1] https://www.bell-labs.com/usr/dmr/www/odd.html
>=20
>     See particularly "Comments I do feel guilty about".

Yep, that page is always funny :)

Cheers,

Alex


--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------wK9md0z3a2LwFwAtiC8g3CEm--

--------------Xj05Fg30Ypwl9s1c12Cq5qbF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmPsOsMACgkQnowa+77/
2zI7rQ//TVyLf4xAVvaho4V11PH7DtEniFhXUN2dC+VZfKTci4mdGiSHF0n34OfC
VDWK/6TMPe5tsWRbVggu6X7WSkwFSyxcTJKpYBUuArqJPEQ6uMwWVaX9xfiFSnrf
NcwGt3bwnep6Nz2bt2Bm9Eck/WunXx2WbefjUs+c1DnMvZAw9/gx8FKGxRG9BJDh
DvjHp74BnbLZiduCA22dUrYZUtHfFgJKVL3Jjnf4Y0zrMJ94khQhe9YCpOyG2y7Z
QFK+F6hIeULuvZYAxlGKcgMw44n9Iky6D/l7n6xyi57hGwTEzuTCmwb7fdbPC3HY
LFEZOz6jlJWZINyHNHQLJggEsQ3bF6hOQJeKiXTWVgbPlW74y5423tQsz14d6Eiq
LrO+cjy352fB/7Si/JWetFpnhl/PHazdvlYwXKqyaXUApJyvEYEVMLv4COFMaxwl
aa8YYdMfrloi2QslqmWte+4hVUd9xdYS3nz0rGdqUqDbwayNvmxOKZJlvmpaK09v
XtbjXoJ5TGe0Yc45vV7ipN447TVvwUAToclKWJSJ5WybwTVBijBp6oSyQSBp6zCM
rcUKlewdef4HD0iLgTsglrGeS8AoIQIzwJOiXarGMaai5YlY7Xt59qtQqSKykreP
Y7f8BcgL0mzBySlPNXM1CR8VqJQFSLOJhlIgQAzY8jADYUU9JBs=
=q32l
-----END PGP SIGNATURE-----

--------------Xj05Fg30Ypwl9s1c12Cq5qbF--
