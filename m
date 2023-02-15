Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558006981BC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjBORRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjBORRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:17:16 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A31E1A677;
        Wed, 15 Feb 2023 09:17:14 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n33so7840675wms.0;
        Wed, 15 Feb 2023 09:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2twJ0+LPvhbq/29pOQVPpX7bKDhvTAMPyvCAfa+NIDE=;
        b=bV4cP5huycCfDkMa2DH7xYxBj9fhHX0sdlBOC3lyoXda/OQE6z6m/x6sy4XZzjPTdx
         yeZuok72fV9ARva+cXDY1wJswQZkQnJUpAeAC3YltWLdENc/C9MY2PzNHkc8EJ9KdbA3
         EiEhNe2GDPr+e+j8es7eHz+IVOIbIve9nn/gq21OCHI/SQECCJQNbzPUYYuyONKCK0Zo
         ElY9sFyeQ38iZbrmbamT1z0efVKzLeSAfGtIwB94VZxMT0UnGbRN3E1X1y2+KWoUG/TA
         gt9d3UaHnxufv+9Bx8cvhuuWSBBI9ahFwXnW7gcbp/fF+oSwRtMXuVmqjXVSMFYso0EL
         2zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2twJ0+LPvhbq/29pOQVPpX7bKDhvTAMPyvCAfa+NIDE=;
        b=vcyt5kDhVIx/yMR4ZyT7Uj8uuMIN9nP32oFKgSCZI9xm7MzBgkLTY1qt/dNIZ48j4r
         99RGFFeMAMBF1ShDrc4YsMR6/H0ndp5GB/UcLNCS5PKK9QHpdjwE4aOe7/n9qqhTTaJQ
         t8FxDRymIJC9NFmDa+Sy1+10KzwGQOf052F2IpIbupr5ABbKwJy7S8QwIBSLGI/apJOV
         fZaQsZN2PoPHfZ/h+OF3N3KM6ehIA301JoMccfyEuoAQ7tDie1vlLe35lrMw7Sodl9aQ
         aGxGS9DhHPOrzbZXpFrqBWEEmLCBwK2WvfRlVGOIU2hawQeQzwAp4LMN9Ag3bazEwkYX
         bDDQ==
X-Gm-Message-State: AO0yUKW+sSS+Og3kvX3RXAJQe/pjw9qa61GCPuCU2/6mXVGxqbCrP4KS
        CpgwTzBAmI7f56LcBz9NpU7zd+gcQW4=
X-Google-Smtp-Source: AK7set/ptOHwkCYwY12s+LyyyNopEO6wfTHshvWyooeOYgpTjpGX888fNh/ztt+BFRyJ5qGAXpcYjA==
X-Received: by 2002:a05:600c:3290:b0:3df:e54a:4ac5 with SMTP id t16-20020a05600c329000b003dfe54a4ac5mr2518068wmp.27.1676481432965;
        Wed, 15 Feb 2023 09:17:12 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b003e00c9888besm2982939wmo.30.2023.02.15.09.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 09:17:12 -0800 (PST)
Message-ID: <63b28ab6-1a5b-0031-8860-51bc66d80ee5@gmail.com>
Date:   Wed, 15 Feb 2023 18:16:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] rseq.2: New man page for the rseq(2) API
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        "G. Branden Robinson" <g.branden.robinson@gmail.com>
References: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
 <669eb324-aef6-0583-c8a4-f54a93ee4d6d@gmail.com>
 <20230215012054.twzw4k5et6hxvi2j@illithid>
 <849b233c-b094-849d-a8fe-9b53cde33c80@efficios.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <849b233c-b094-849d-a8fe-9b53cde33c80@efficios.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------J3uNRF7p3fumC2nptJ28d0bD"
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
--------------J3uNRF7p3fumC2nptJ28d0bD
Content-Type: multipart/mixed; boundary="------------0sytF3fFfBl7QiOXr1hHYXb4";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-man <linux-man@vger.kernel.org>,
 "G. Branden Robinson" <g.branden.robinson@gmail.com>
Message-ID: <63b28ab6-1a5b-0031-8860-51bc66d80ee5@gmail.com>
Subject: Re: [PATCH 1/1] rseq.2: New man page for the rseq(2) API
References: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
 <669eb324-aef6-0583-c8a4-f54a93ee4d6d@gmail.com>
 <20230215012054.twzw4k5et6hxvi2j@illithid>
 <849b233c-b094-849d-a8fe-9b53cde33c80@efficios.com>
In-Reply-To: <849b233c-b094-849d-a8fe-9b53cde33c80@efficios.com>

--------------0sytF3fFfBl7QiOXr1hHYXb4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

On 2/15/23 18:09, Mathieu Desnoyers wrote:
> On 2023-02-14 20:20, G. Branden Robinson wrote:
>> [CC list violently trimmed; for those who remain, this is mostly man
>> page style issues]
>=20
> [ Gently added linux-man to CC list. ;-) ]

:-)

>=20
>>
>> At 2023-02-14T23:29:37+0100, Alejandro Colomar wrote:
>>> On 2/14/23 20:54, Mathieu Desnoyers wrote:
>>>> +per-thread data structure shared between kernel and user-space.
>>>
>>> This last 'user-space' is not adjectivated, so it should go without
>>> a hyphen, according to common English rules.
>>
>> +1
>=20
> done
>=20
>=20
>>
>> Also I like your coinage.  "Adjectivated yeast" is reflexive and
>> tautological!
>>
>>>> +.RB ( "struct rseq" )
>>>
>>> We format types in italics, so this should be '.RI'.
>>
>> +1
>=20
> OK, so it's italics for both types and arguments.
>=20
> I will replace all the bold markers for "struct rseq" and "struct=20
> rseq_cs" to italic in the description (but not in the synopsis section =

> and not in the code snippets).
>=20
>>
>>>> +Only one
>>>> +.BR rseq ()
>>>> +ABI can be registered per thread, so user-space libraries and
>>>> +applications must follow a user-space ABI defining how to share thi=
s
>>>> +resource.
>>>
>>> Please use semantic newlines.  See man-pages(7):
>>>
>>>     Use semantic newlines
>>>         In  the source of a manual page, new sentences should be star=
ted on new
>>>         lines, long sentences should be split into lines at clause br=
eaks (com=E2=80=90
>>>         mas, semicolons, colons, and so on), and long clauses should =
 be  split
>>>         at  phrase  boundaries.   This convention, sometimes known as=
 "semantic
>>>         newlines", makes it easier to see the effect of  patches,  wh=
ich  often
>>>         operate at the level of individual sentences, clauses, or phr=
ases.
>>
>> I think I've said this before, but, strictly, commas in particular can=

>> separate things that are not clauses.  Clauses have subjects and
>> predicates.
>>
>> Might it be better to say simply:
>>
>>    Start each sentence on a new line.  Split long sentences where
>>    punctuated by commas, semicolons, and colons.
>>
>> With this there is not even any need to discuss "phrase boundaries".
>>
>=20
> I've modified to:
>=20
> Only one
> .BR rseq ()
> ABI can be registered per thread,
> so user-space libraries and applications must follow a user-space ABI
> defining how to share this resource.
>=20
> Hopefully that's correct.

Yes, that's good.

>=20
>=20
>>> In the above lines, that would mean breaking after the comma,
>>> and not leaving resource in a line of its own.
>>
>> The latter is inevitably going to happen from time to time simply due =
to
>> sentence length and structure and the line length used by one's text
>> editor.  I don't think an "orphan word" (what typographers call this) =
is
>> symptomatic of anything in *roff source when filling is enabled.
>>
>>>> +The ABI defining how to share this resource between applications an=
d
>>>> +libraries is defined by the C library.
>>>> +Allocation of the per-thread
>>>> +.BR rseq ()
>>>> +ABI and its registration to the kernel is handled by glibc since ve=
rsion
>>>> +2.35.
>>>> +.PP
>>>> +The
>>>> +.BR rseq ()
>>>> +ABI per-thread data structure contains a
>>>> +.I rseq_cs
>>>> +field which points to the currently executing critical section.
>>>
>>> currently-executing should probably use a hyphen
>>> (if I understood the line correctly).
>>
>> This is not the case, according to some style authorities.  Dave Kempe=
r
>> convinced me of this on the groff list.
>>
>> Here is one resource.
>>
>> https://www.editorgroup.com/blog/to-hyphenate-or-not-to-hyphenate/
>>
>>> See an interesting discussion in the groff@ mailing list:
>>> <https://lists.gnu.org/archive/html/groff/2022-10/msg00015.html>
>>
>> That's not _squarely_ on point, as none of "block", "device", or "base=
d"
>> is an adverb.  "Currently" is.
>=20
> Leaving unchanged based on this discussion.
>=20
>>
>>>> +For each thread, a single rseq critical section can run at any give=
n
>>>> +point.
>>>> +Each critical section need to be implemented in assembly.
>>>
>>> needs?
>>
>> +1
>=20
> done.
>=20
>>
>>>> +.TP
>>>> +.B Structure alignment
>>>
>>> Let's remove the bold here.  It's not necessary for marking a constan=
t
>>> or something that needs bold.  And the indentation is already making
>>> it stand out, so bold is a bit too much aggressive to the reader.
>>
>> I agree; if it wouldn't be styled in running text, it doesn't need
>> styling as a paragraph tag; it already stands out by dint of its
>> placement as a tag.
>>
>>>> +Its value should always be confirmed by reading the cpu_id field be=
fore
>>>
>>> cpu_id should be formatted (.I).
>>
>> +1
>=20
> done
>=20
>>
>>>> +user-space performs any side-effect
>>>> +(e.g. storing to memory).
>>>> +.IP
>>>> +This field is always guaranteed to hold a valid CPU number in the r=
ange
>>>> +[ 0 ..  nr_possible_cpus - 1 ].
>>>
>>> Please use interval notation:
>>> 	[0, nr_possible_cpus)
>>> or
>>> 	[0, nr_possible_cpus - 1]
>>> whichever looks better to you.
>>>
>>> We did some consistency fix recently:
>>> <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?=
id=3D147a60d792a5db8f3cb93ea16eefb73e16c1fb91>
>>>
>>> Also, do we have a more standard way of saying nr_possible_cpus?
>>> Should we say nproc?
>=20
> nproc(1) means:
>=20
>         Print  the number of processing units available to the current
>         process, which may be less than the number of online processors=

>=20
> Which is the number of cpus currently available (AFAIU the result of th=
e
> cpuset and sched affinity).
>=20
> What I really mean here is the maximum value for possible cpus which ca=
n=20
> be hotplugged into the system. So it's not the maximum number of=20
> possible CPUs per se, but rather the maximum enabled bit in the possibl=
e=20
> CPUs mask.
>=20
> Note that we could express this differently as well: rather than saying=
=20
> that it guarantees a value in the range [0, nr_possible_cpus - 1], we=20
> could say that the values are guaranteed to be part of the possible cpu=
s=20
> mask, which would actually more accurate in case the possible cpus mask=
=20
> has a hole (it tends to happen with things like lxc containers nowadays=
).
>=20
> Do you agree that we should favor expressing this in terms of belonging=
=20
> to the possible cpumask set rather than a range starting from 0 ?

On 2/15/23 18:12, Mathieu Desnoyers wrote:
> Actually, the field may contain the value 0 even if 0 is not part of th=
e=20
> possible cpumask. So forget what I just said about being guaranteed to =

> be part of the possible cpus mask.
>=20
> Thoughts ?
>=20
> Thanks,
>=20
> Mathieu

I don't have a full understanding, so I will trust you for deciding what =
is
best.  I'll try to understand it, but my kernel knowledge is rather limit=
ed :)

I suggest writing a detailed description, instead of (or complementary to=
 it)
just using a range, since readers might wonder as I did, what nr_possible=
_cpus
is (it's not really described anywhere so far).  With a worded descriptio=
n,
we can later improve it if we find it not clear enough, but should be eno=
ugh
for an initial page.

Thanks!

Alex

>=20
> Thanks,
>=20
> Mathieu
>=20

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------0sytF3fFfBl7QiOXr1hHYXb4--

--------------J3uNRF7p3fumC2nptJ28d0bD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmPtE4EACgkQnowa+77/
2zLP3A//Zte5uBerrP0sjfMfJpGU3RXRGZ+aVgYGOo2/a30lMn0MgWRRtfz11CNT
5luU7bBygmwE0vfnjdIpdhVhKQufYxyGd8SKM/dVrZPOZKlDJX1uepwLlfme4QNx
g8y62CNXFXfKJ0fuys8FlXId3ko9miGEHhnHe0zR/WfuOkjAMqlJg2pJyuCtmmzw
gbXT55GUVrat7M9opQN86UApSldBOxcgS2GId6r23WBWw15AgeIOy7jnmCM+ol/0
y03cmGN2hlRL7u4B7KJ3yOCmevKkBs6T4k06/cncfDiqDXB2ImQf/CY2DVovu63z
0RxN/6S9I8dECCsy1KVoO6dt668417J5VXEiWizOv/lgWgNtUbJP2H1kX/i61GNj
q4EkeYqo/e9h0i0pEwHV/xSCQo3I2DPxWCLfD/E/rgET3YD2UtnAA6iLC208GQbK
OuCoAFpgATRSYqXWiFPlNDV0Sm8YWtVzlMdKzAvhX+QYjihyS+H/jUTP0mfmNe4b
3bxZ82WnuPzCs9z0OhSTsI5qxfYFxSfEN7+dzFsYJCux17KQmqrFmH3Hcg7ElqcP
psJD9wuTuGBif2ky87TF+3J3a0Blwx8R3pmVwVagOuyAYJHcgp5Vme1a+8EkTddK
CQnj4opfteOuAIqBF6K9jGJBchywKms18jiuQl7OCPFDRIbqGsU=
=p/7U
-----END PGP SIGNATURE-----

--------------J3uNRF7p3fumC2nptJ28d0bD--
