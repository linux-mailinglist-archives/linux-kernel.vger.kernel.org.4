Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9536BB3F1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjCONJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCONJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:09:32 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A964114E92;
        Wed, 15 Mar 2023 06:09:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 442C8E2304;
        Wed, 15 Mar 2023 06:09:30 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b4q4DcU4QBRv; Wed, 15 Mar 2023 06:09:29 -0700 (PDT)
Date:   Wed, 15 Mar 2023 14:09:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1678885769; bh=0YolK6eZj9BJntGS6UUbtpnOXw9MSd2uaRG11myp+R8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FrjEcZgzsbKPKMuJEcdvtYzJUDFUFMnItYi9FOYCC3TAG4Cx2wemQvDm3q1z8FMHi
         vH4RckUZ8eSUXxIIIijTZyWFchE3t8IhIHDktuW8LDeMmCpqQcojEBV2GGnXsDjdnn
         B2pvhvkGt84kXI+fhX9odVz3p1dipbsS53kPwC78eS+bk2hX6RGs5fyVQdQsEuQxJY
         I03Eoj3elEDjK3eO2R3+TUlK3BUKjhh1pUphCZH7C6m4XmVIeUPSESNwNngpkjinJp
         50F8ke4gjbXEOC7xzkffOx89agpDD5a0x1MT3sGr2R8ETbdjk1KcXHdRkOmYs0mCY4
         zpHAo9H+85hvw==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCHv3 1/2 RESEND] doc/media api: Try to make enum usage
 clearer
Message-ID: <20230315140914.707e0cc9.dorota.czaplejewicz@puri.sm>
In-Reply-To: <ZBGahMbA1fBrKLYP@valkosipuli.retiisi.eu>
References: <20230219120034.5819b4ac.dorota.czaplejewicz@puri.sm>
        <ZBGahMbA1fBrKLYP@valkosipuli.retiisi.eu>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BV6mp6Z.cVyZ5F8YY9YWRAT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BV6mp6Z.cVyZ5F8YY9YWRAT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 15 Mar 2023 12:14:28 +0200
Sakari Ailus <sakari.ailus@iki.fi> wrote:

> Hi Dorota,
>=20
> On Sun, Feb 19, 2023 at 12:00:34PM +0100, Dorota Czaplejewicz wrote:
> > This clarifies which side of the calls is responsible for doing what to=
 which parts of the struct.
> > This also explicitly states that repeating values are disallowed.
> > It also expands the terse description of the access algorithm into more=
 prose-like, active voice description, which trades conciseness for ease of=
 comprehension. =20
>=20
> The commit message lines should be wrapped at 74 characters. Please do use
> checkpatch.pl in the future. There is also no apparent reason to add a
> newline after a period.
>=20
> The same applies to the other patch as well.
>=20
> I've addressed the issues this time.

Thanks for taking a look. What is the next step?

--Dorota
>=20
> >=20
> > Added: mbus codes must not repeat
> > Added: no holes in the enumeration
> > Added: enumerations per what?
> > Added: who fills in what in calls
> > Changed: "zero" -> "0"
> > Changed: "given" -> "specified"
> >=20
> > Still unclear how it works so didn't describe: "which". What is a "try =
format" vs "active format"?
> >=20
> > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > ---
> > Hi,
> >=20
> > I took those patches out of the freezer. I made sure they still apply (=
they do), and corrected some errors pointed out by Jacopo in the previous r=
ound of reviews. =20
>=20
> Ditto.
>=20
> >=20
> > Thanks,
> > Dorota
> >=20
> >  .../v4l/vidioc-subdev-enum-mbus-code.rst      | 38 +++++++++++++------
> >  1 file changed, 26 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-m=
bus-code.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbu=
s-code.rst
> > index 417f1a19bcc4..63bff24d0520 100644
> > --- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-cod=
e.rst
> > +++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-cod=
e.rst
> > @@ -31,15 +31,28 @@ Arguments
> >  Description
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> > -To enumerate media bus formats available at a given sub-device pad
> > -applications initialize the ``pad``, ``which`` and ``index`` fields of
> > -struct
> > -:c:type:`v4l2_subdev_mbus_code_enum` and
> > -call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl with a pointer to t=
his
> > -structure. Drivers fill the rest of the structure or return an ``EINVA=
L``
> > -error code if either the ``pad`` or ``index`` are invalid. All media b=
us
> > -formats are enumerable by beginning at index zero and incrementing by
> > -one until ``EINVAL`` is returned.
> > +This call is used by the application to access the enumeration
> > +of media bus formats for the selected pad.
> > +
> > +The enumerations are defined by the driver, and indexed using the ``in=
dex`` field
> > +of struct :c:type:`v4l2_subdev_mbus_code_enum`.
> > +Each enumeration starts with the ``index`` of 0, and
> > +the lowest invalid index marks the end of enumeration.
> > +
> > +Therefore, to enumerate media bus formats available at a given sub-dev=
ice pad,
> > +initialize the ``pad``, and ``which`` fields to desired values,
> > +and set ``index`` to 0.
> > +Then call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl
> > +with a pointer to this structure.
> > +
> > +A successful call will return with the ``code`` field filled in
> > +with a mbus code value.
> > +Repeat with increasing ``index`` until ``EINVAL`` is received.
> > +``EINVAL`` means that either ``pad`` is invalid,
> > +or that there are no more codes available at this pad.
> > +
> > +The driver must not return the same value of ``code`` for different in=
dices
> > +at the same pad.
> > =20
> >  Available media bus formats may depend on the current 'try' formats at
> >  other pads of the sub-device, as well as on the current active links.
> > @@ -57,14 +70,15 @@ information about the try formats.
> > =20
> >      * - __u32
> >        - ``pad``
> > -      - Pad number as reported by the media controller API.
> > +      - Pad number as reported by the media controller API. Filled in =
by the application. =20
>=20
> Here, too...
>=20
> >      * - __u32
> >        - ``index``
> > -      - Number of the format in the enumeration, set by the applicatio=
n.
> > +      - Index of the mbus code in the enumeration belonging to the giv=
en pad.
> > +    Filled in by the application. =20
>=20
> Wrong indentation.
>=20
> >      * - __u32
> >        - ``code``
> >        - The media bus format code, as defined in
> > -	:ref:`v4l2-mbus-format`.
> > +	:ref:`v4l2-mbus-format`. Filled in by the driver.
> >      * - __u32
> >        - ``which``
> >        - Media bus format codes to be enumerated, from enum =20
>=20


--Sig_/BV6mp6Z.cVyZ5F8YY9YWRAT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmQRw3oACgkQADBpX4S8
Znd/bA/7Bxc/fWZNp6/h9Wkj2rd04kRRIZtR1+sYBks6GqZuSLRikbtMbX7jZnDK
649yPzfqnnNVum/TF6qTWWix2zueOePBxg+oepCIOTmu6Vl+J05c9O9RtJmpft0U
WyadXHACP1Hf+RmCZDH8Nefi3g6LojG029mxz2EBWapWrOQYsR+qAPEa4fBKrzcr
d2soLNfJa1BpkbRqeFNx+eAuvogGbYmxPCDcAddv82KtM3SjtUrWCD9GtvTfGCT0
YTAIcfXAfd1wgsNSme5nbZudpHodAUDwvDsQ/p3cYyCJNpZt7BcuUhCqcklNJ8pl
Co2OAlH4LzAvy+qEzKq72Z5bG/un/l5tH3dfWeYYL1bh939RX4fyVmV+wQdhAFQ1
8DlTYKfa35ENL0KOVyEbNq6LMKB4mFWIuqfIIcyra/zJSQSqfAO2867Xxsibnn45
pRMua0PeSujHVcf7QA6WLVwxifUJIvgDVvcCzMWqVDY2lLPczLvUFIHk7JQOxkVr
fXsWmvCdyOEvyTgi1BSb9xGLoKiIlZ60yQy7DLqgMXXC6ZykCr1moOE81KUGIGBR
zH8hfSDVmXm4nJzo9Op9aCiLGJlT514ltvIma/Soaxvv7cg5SoB5TgntAKqEKshI
mHMXyrlBqTBkCYD3aqUnvi3cFpg1xCnC0RyAv6ZJArFIkHsbVJA=
=QeDg
-----END PGP SIGNATURE-----

--Sig_/BV6mp6Z.cVyZ5F8YY9YWRAT--
