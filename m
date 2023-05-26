Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE79712FB5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 00:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244292AbjEZWGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 18:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjEZWGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 18:06:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F1410A;
        Fri, 26 May 2023 15:05:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD9F565427;
        Fri, 26 May 2023 22:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D596C4339E;
        Fri, 26 May 2023 22:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685138613;
        bh=BwvcSxw09qrYnzwTnJsHPC1O/6lwzjzErbn1rRv/HJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJKBuRUX+S1sdM3L1pd36dzdDiHXNAzoMvzsBuK39o3AcqQTyiP8b7NEfSNjURcm4
         pvWaoFjeY6HWCxQDuLHe0O5AX+7xK6TlAiJuHu9eOdgAHKy+wJ1sdvGTnP0ucbmjlQ
         9el20HJpymz4bdudaV+r1GsRwa5dOBScqIRJCJEuYcLn6YKOQSaw5lVa3rE2LYMKHY
         2+8sM/rYKo0KvAqdYph19zB685b8JBnR/6ho7n3Xzy20AdYNAXETEQwVcqnwnDw0Ry
         D7AsO6Dee9i7L4pXCv3XFSSOrZr6Ar+JBxUz9WhAachu99IW0ge8ItfDfyYnfP7S7u
         XcpRDrb9mMNwg==
Date:   Fri, 26 May 2023 23:03:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Fred Treven <Fred.Treven@cirrus.com>
Cc:     Ben Bright <Ben.Bright@cirrus.com>,
        James Ogletree <James.Ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: input: cirrus,cs40l26: Support for
 CS40L26
Message-ID: <20230526-vowel-precise-12f644b57d85@spud>
References: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
 <20230526-swapping-clay-d114144380a4@spud>
 <BBCD72CC-8312-4D57-9814-0E3A7F260F00@cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2jKjhS3G2UCFZYTf"
Content-Disposition: inline
In-Reply-To: <BBCD72CC-8312-4D57-9814-0E3A7F260F00@cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2jKjhS3G2UCFZYTf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 09:32:36PM +0000, Fred Treven wrote:
> > On May 26, 2023, at 2:27 PM, Conor Dooley <conor@kernel.org> wrote:
> > Tooling does not like your series very much, prob the missing v2's on
> > some patches:
> > Grabbing thread from lore.kernel.org/all/1685059471-9598-1-git-send-ema=
il-fred.treven%40cirrus.com/t.mbox.gz
> > Checking for newer revisions
> > Grabbing search results from lore.kernel.org
> > Analyzing 6 messages in the thread
> > Will use the latest revision: v2
> > You can pick other revisions using the -vN flag
> > Checking attestation on all messages, may take a moment...
> > ---
> >   =E2=9C=93 [PATCH v2 1/5] dt-bindings: input: cirrus,cs40l26: Support =
for CS40L26
> >     =E2=9C=93 Signed: DKIM/cirrus.com
> >     + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >   =E2=9C=93 [PATCH v2 2/5] Input: cs40l26 - Support for CS40L26 Haptic =
Device
> >     =E2=9C=93 Signed: DKIM/cirrus.com
> >     + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >   ERROR: missing [3/5]!
> >   ERROR: missing [4/5]!
> >   ERROR: missing [5/5]!
>=20
> Understood. I was uncertain if this was just needed for patches that had
> been edited or for all new patches. I will resubmit with some other code
> changes to address other comments I=E2=80=99ve received and will mark the=
 patches
> with the same version number.=20

I just whack an N into git format-patch's --reroll-count/-v option, and
use the same across the whole series. Makes people's and tool's lives
easier :)

> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - cirrus,cs40l26a
> >> +      - cirrus,cs40l26b
> >> +      - cirrus,cs40l27a
> >> +      - cirrus,cs40l27b
> >=20
> > I had a _brief_ look at the driver - you don't seem to have any match
> > data, so are all of these devices actually compatible with eachother?
> >=20
> > IOW, should this be:
> > properties:
> >  compatible:
> >    oneOf:
> >      - items:
> >          - enum:
> >              - cirrus,cs40l26b
> >              - cirrus,cs40l27a
> >              - cirrus,cs40l27b
> >          - const: cirrus,cs40l26a
> >=20
> >      - const: cirrus,cs40l26a
> >=20
> > And then drop all but the cs40l26a in the driver? Apologies if I missed
> > some difference in there.
>=20
> They are all compatible, yes. There is match data in cs40l26-i2c.c and
> cs40l26-spi.c if you are referring to the of_device_id struct.
> Please let me know if I=E2=80=99m misunderstanding your meaning here.

What I saw looking in the driver was:
+static const struct of_device_id cs40l26_of_match[CS40L26_NUM_DEVS + 1] =
=3D {
+	{ .compatible =3D "cirrus,cs40l26a" },
+	{ .compatible =3D "cirrus,cs40l26b" },
+	{ .compatible =3D "cirrus,cs40l27a" },
+	{ .compatible =3D "cirrus,cs40l27b" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cs40l26_of_match);

So you have a bunch of compatibles, but didn't immediately appear to be
doing anything different depending on which one of them you get.
What I meant was populating the data field of of_device_id with something
different depending on the compatible.
If the programming model is the same, you can document that they are all
compatible with "cirrus,cs40l26a", rather than having to add new entries
to the match table. Also has the advantage that if you bring out a
cirrus,cs40l27c that is compatible with the existing devices, then no
changes are needed to software to support it ;)

Or perhaps you are doing something different based on the compatible
that I just did not notice.

Cheers,
Conor.

(The [CS40L26_NUM_DEVS + 1] is also usually just [] btw)

--2jKjhS3G2UCFZYTf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHEsrwAKCRB4tDGHoIJi
0m7vAQDPzkfu91KtDUkEA7ub+4y9eLte9nVAnGrARvlVVXgIKwEAkpltvYoRM5aU
qpe0T2WtOMV0O1ZhF3C3JeZw97aPswU=
=MSmA
-----END PGP SIGNATURE-----

--2jKjhS3G2UCFZYTf--
