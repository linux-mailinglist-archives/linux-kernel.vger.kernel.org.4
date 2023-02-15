Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A1269736E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjBOBVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjBOBVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:21:09 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90F783D6;
        Tue, 14 Feb 2023 17:20:56 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-16aa71c1600so21250091fac.11;
        Tue, 14 Feb 2023 17:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dsQzSddCpDZDyvCChAZWNx355V3MxdovBZTOPDFqaU0=;
        b=SUsgoYbZq2h6ROB0/GzgaSpxon8hFr/c6paJ0mtzRPF8olRAPl4lIzmv8LS5NjU++C
         kHBwK9p4+AWLVd8nQ8bdKm/MOlkIyIGvxWJFkO7UT0cPlbqNq9n3hlyBa7sqngHdjQUP
         9f7QJIy6FCtZNSrBWbUoa8ocucuKtOvA3tRjo2WWUfxvP0hpG5923rY42nBu5p22h6b+
         sEE5sCdd0ZFTOjj0o6pGKrCR1A0h6IEZwdyVB0k7Qt5LDVgtjHe9sr9BUQu/WDQkQQcu
         4z4z/+5AvTS1lcM3DahPsFsQDkXjXzybZyKNyeMFqyQeVaL5PUFVJXpgHv1gn/n/ARpi
         3Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsQzSddCpDZDyvCChAZWNx355V3MxdovBZTOPDFqaU0=;
        b=OD4OGtJSCEVV4fCkUvfS7OnIrrePHIgBbk0DlAfncAWmt50sY4SZ/d9peFL7QQzcBs
         Cd388SiBDIZt+QV6xGG92mu5ZiF6DrFuZHYH3iw8VTmjm/Fwdlz86OyrZMz0zhKoxnEf
         j0WRKy5WxhWK+SyR0L2ggxWKTOeIyfebHq6UnRUdNevMbtw+2x54xFWaRW73WA3TVT1R
         Y3EP8mMK0md/qkGYAGhcbdCcb4Z4wNcBzptUGUEpByPHbZg3wLA+VLUe9EHP3Jwd/CpJ
         2ML3vgHLSRztnXpInoLsrUKA3cPLeFF6agxxP7qeRbDDzobSrAYKmDwlpLy3pUCqv1Kb
         PbDQ==
X-Gm-Message-State: AO0yUKXdaxjkhvCgD60VH8AySjUeKomwvah9w+JhGrwOKXKuZ7vTtMk7
        fE9pM1ZZLbvBIl9K1V8ohrkr2aRE433QHA==
X-Google-Smtp-Source: AK7set+JRSkAhAEvkEIBw3UA7KioLbcm6cMtZD0cOS4ryhL0bs5MWrhatQo307vydTk9gbwjcK9nAg==
X-Received: by 2002:a05:6870:b292:b0:16a:1d0a:714f with SMTP id c18-20020a056870b29200b0016a1d0a714fmr199095oao.36.1676424056036;
        Tue, 14 Feb 2023 17:20:56 -0800 (PST)
Received: from illithid (ip68-12-97-90.ok.ok.cox.net. [68.12.97.90])
        by smtp.gmail.com with ESMTPSA id u1-20020a4aa341000000b004a0ad937ccdsm6578540ool.1.2023.02.14.17.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 17:20:55 -0800 (PST)
Date:   Tue, 14 Feb 2023 19:20:54 -0600
From:   "G. Branden Robinson" <g.branden.robinson@gmail.com>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/1] rseq.2: New man page for the rseq(2) API
Message-ID: <20230215012054.twzw4k5et6hxvi2j@illithid>
References: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
 <669eb324-aef6-0583-c8a4-f54a93ee4d6d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jbpzsvthlazbp3z2"
Content-Disposition: inline
In-Reply-To: <669eb324-aef6-0583-c8a4-f54a93ee4d6d@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jbpzsvthlazbp3z2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[CC list violently trimmed; for those who remain, this is mostly man
page style issues]

At 2023-02-14T23:29:37+0100, Alejandro Colomar wrote:
> On 2/14/23 20:54, Mathieu Desnoyers wrote:
> > +per-thread data structure shared between kernel and user-space.
>=20
> This last 'user-space' is not adjectivated, so it should go without
> a hyphen, according to common English rules.

+1

Also I like your coinage.  "Adjectivated yeast" is reflexive and
tautological!

> > +.RB ( "struct rseq" )
>=20
> We format types in italics, so this should be '.RI'.

+1

> > +Only one
> > +.BR rseq ()
> > +ABI can be registered per thread, so user-space libraries and
> > +applications must follow a user-space ABI defining how to share this
> > +resource.
>=20
> Please use semantic newlines.  See man-pages(7):
>=20
>    Use semantic newlines
>        In  the source of a manual page, new sentences should be started o=
n new
>        lines, long sentences should be split into lines at clause breaks =
(com=E2=80=90
>        mas, semicolons, colons, and so on), and long clauses should  be  =
split
>        at  phrase  boundaries.   This convention, sometimes known as "sem=
antic
>        newlines", makes it easier to see the effect of  patches,  which  =
often
>        operate at the level of individual sentences, clauses, or phrases.

I think I've said this before, but, strictly, commas in particular can
separate things that are not clauses.  Clauses have subjects and
predicates.

Might it be better to say simply:

  Start each sentence on a new line.  Split long sentences where
  punctuated by commas, semicolons, and colons.

With this there is not even any need to discuss "phrase boundaries".

> In the above lines, that would mean breaking after the comma,
> and not leaving resource in a line of its own.

The latter is inevitably going to happen from time to time simply due to
sentence length and structure and the line length used by one's text
editor.  I don't think an "orphan word" (what typographers call this) is
symptomatic of anything in *roff source when filling is enabled.

> > +The ABI defining how to share this resource between applications and
> > +libraries is defined by the C library.
> > +Allocation of the per-thread
> > +.BR rseq ()
> > +ABI and its registration to the kernel is handled by glibc since versi=
on
> > +2.35.
> > +.PP
> > +The
> > +.BR rseq ()
> > +ABI per-thread data structure contains a
> > +.I rseq_cs
> > +field which points to the currently executing critical section.
>=20
> currently-executing should probably use a hyphen
> (if I understood the line correctly).

This is not the case, according to some style authorities.  Dave Kemper
convinced me of this on the groff list.

Here is one resource.

https://www.editorgroup.com/blog/to-hyphenate-or-not-to-hyphenate/

> See an interesting discussion in the groff@ mailing list:
> <https://lists.gnu.org/archive/html/groff/2022-10/msg00015.html>

That's not _squarely_ on point, as none of "block", "device", or "based"
is an adverb.  "Currently" is.

> > +For each thread, a single rseq critical section can run at any given
> > +point.
> > +Each critical section need to be implemented in assembly.
>=20
> needs?

+1

> > +.TP
> > +.B Structure alignment
>=20
> Let's remove the bold here.  It's not necessary for marking a constant
> or something that needs bold.  And the indentation is already making
> it stand out, so bold is a bit too much aggressive to the reader.

I agree; if it wouldn't be styled in running text, it doesn't need
styling as a paragraph tag; it already stands out by dint of its
placement as a tag.

> > +Its value should always be confirmed by reading the cpu_id field before
>=20
> cpu_id should be formatted (.I).

+1

> > +user-space performs any side-effect
> > +(e.g. storing to memory).
> > +.IP
> > +This field is always guaranteed to hold a valid CPU number in the range
> > +[ 0 ..  nr_possible_cpus - 1 ].
>=20
> Please use interval notation:
> 	[0, nr_possible_cpus)
> or
> 	[0, nr_possible_cpus - 1]
> whichever looks better to you.
>=20
> We did some consistency fix recently:
> <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=
=3D147a60d792a5db8f3cb93ea16eefb73e16c1fb91>
>=20
> Also, do we have a more standard way of saying nr_possible_cpus?
> Should we say nproc?

Apropos of a separate discussion we had weeks ago, Alex, I remembered
where I saw "nitems" as a variable name.

_UNIX Programming_, second edition, by Kernighan and Ritchie!

https://wolfram.schneider.org/bsd/7thEdManVol2/uprog/uprog.pdf

Plop _that_ down on the desk of the person who claimed it was a stupid
variable name that no good programmer would ever use.

(I think appeals to authority are just fine as long as one is being
mean.  ;-P  And as regards variable naming, Kernighan is a _legitimate_
authority: a subject matter expert with multiple well-regarded books on
coding style to his credit.  Ritchie's strengths were more esoteric,
enough that he put up specimens of his own youthful hubris as, I think,
an effort to discourage his many admirers from copying his mistakes as
slavishly as his successes[1]--apart from their humor value.)

> Branden, IIRC, this seems to be the reason why I didn't want .RS for
> indenting code examples.  It doesn't fit nicely right after TP.
>=20
> Why is there a blank line?  I'm not even sure that's reasonable.  Is
> it a (minor) bug in man(7)?  (FWIW, mandoc(1) is consistent with
> groff(1).)

Right, I'll take this up in the separate thread you started for it on
the groff list.

Regards,
Branden

[1] https://www.bell-labs.com/usr/dmr/www/odd.html

    See particularly "Comments I do feel guilty about".

--jbpzsvthlazbp3z2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh3PWHWjjDgcrENwa0Z6cfXEmbc4FAmPsM20ACgkQ0Z6cfXEm
bc4FwxAAjs/q4uw20RmaDqECzesiAvjFNgjlzbfn2g6sOxiK4rcYE+kxSJOhYRzz
IL4RYcnBcfKViELwMEfXxgrIyWbFrTxJoMBX1pPszpvdFdlEyMNu1ZVDYKNunbMy
xhYLKYjwUpmpzdDHR3dqjr7Si4Va4QdlCLzLem9eZoWMVkqokUYkJav4yqY06uq4
gFq+7kYqbmIEDsnvIXG1V5Cnanp0h5WrHlE48fTsC5Kr9730u+reBNhfpjtq90yO
m5Yrqwi9KejuBG3KX54kjT4YeUlJEPaKuKyo+KVsxjmoz96S1/dv2P4awzh6G9s4
xpgM23iNJz6LP49tOXRR+94c/Ek+e5aBxQnn1i11b6x1CnxuwE7QnKYpHWsw4XmG
PfzfdPLTO6i/SV8txe7B1NGhqdPjXyQ+IFf4/LaX8CruOzSzMMUjT7/ekz7i2AHu
mBbFzX+ix16DHVoKmwhYJUgwJLlFzj986zpBUp6+om9iX4j6xNPaH+YtnbgRaTU3
ckBy59QZ7CH0bmt8+/2OHNwD5FUZd4pIoL8Wbzz7o/Q4glYaivX8ohBOXMaLgctk
4Zrn56PSD273OpdgiRe16TeI7aK1b6w4SibGFwKBovzVp4EY8nfP935TRVQdFs+N
ug+PXvNLgIM9hT6nrYB1DX8F8zUvQ//LS8pDuEadbQ1TfpTLrec=
=Ddc1
-----END PGP SIGNATURE-----

--jbpzsvthlazbp3z2--
