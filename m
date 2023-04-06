Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765636D9876
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbjDFNnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDFNnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:43:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F33E44;
        Thu,  6 Apr 2023 06:43:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27EF564561;
        Thu,  6 Apr 2023 13:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA4EC433D2;
        Thu,  6 Apr 2023 13:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680788589;
        bh=URoLRDtsy7mbEea/C3F3239LWhjbKmy4/+amr79krwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkGd837mvUOyhT4HBhNRI6A48jM4CuDNbSplt1pzQ9D337ociT1dHBn03gg0xxzql
         GlNQG8f1XNCdT2va6GT0rmS48IRPzxbSvyMLvcMunESGxKdVnBFdPynd+iqg9oGoHh
         996AlyVdD92z3hHSeJJ8saxeh3aib5hcxZnXR6QRNeVXf/BLaoXmBPhP2k7ZlsV0jN
         85RSL0SRG8Kg4A/SDR9QeeaAwnpw23U2M6LJzZaue9c/Mc1iLCCtbGhRnVYyMj4u0J
         Qu+ja2npSuKDhs8QVqR+QkWininUr2/VviYrG/uvEd5IGUlTK7bq/mDwweXxO+qiii
         PlqwuS7W5VAIw==
Date:   Thu, 6 Apr 2023 14:43:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, Sascha Hauer <sha@pengutronix.de>,
        jerome Neanne <jneanne@baylibre.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v2 2/3] hwmon: (pmbus/core): Add regulator event support
Message-ID: <d6a3ca82-7245-45e1-b8ff-a9970671b04f@sirena.org.uk>
References: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
 <20230328150335.90238-2-Naresh.Solanki@9elements.com>
 <c88d3cdd-fb2f-c3ac-a9e8-e49f8e98b811@gmail.com>
 <17934bff-f728-d57a-c3c8-956634bd48c8@roeck-us.net>
 <3be67394-6082-1aeb-8a8d-90149217bdc7@gmail.com>
 <aea044ab-3a83-2369-aff7-5ef153618619@roeck-us.net>
 <0672fe4d-7293-4374-9186-29b008e5f8a2@sirena.org.uk>
 <CANhJrGO3X7pSsMBg6Gtf-q3=_JiCX4Qs=pGudL=etooM2F676g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5rVUboXIZqzB+ntf"
Content-Disposition: inline
In-Reply-To: <CANhJrGO3X7pSsMBg6Gtf-q3=_JiCX4Qs=pGudL=etooM2F676g@mail.gmail.com>
X-Cookie: Man and wife make one fool.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5rVUboXIZqzB+ntf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 06, 2023 at 11:00:02AM +0300, Matti Vaittinen wrote:
> ke 5. huhtik. 2023 klo 18.19 Mark Brown (broonie@kernel.org) kirjoitti:
> > On Wed, Apr 05, 2023 at 07:18:32AM -0700, Guenter Roeck wrote:

> > > Same situation. I though a regulator driver would notify the regulator subsystem

> I think this notification is not processed by the regulator subsystem.
> It is just delivered to the consumer driver(s) who have subscribed the
> notifications.

Right.  The hardware might autonomously do something but there's nothing
in the framework which will take any action.

> > The theory is that if a consumer detects that the device it's
> > controlling has bad power then it can take corrective action if there's
> > some specification mandated error handling (for something like a
> > standard bus) or risk of hardware damage.

> The problem I see here is that, if the error information itself
> (severity + notification type) does not 'classify' the error handling
> - then I don't see how any consumers can do handling unless they are
> targeted to one specific system only. My original thinking has been
> that ERROR level notifications are sent only when HW is no longer
> operable - and consumers are expected to do what-ever protective
> actions they can, including turning off the faulty regulator. That is
> why I originally asked about handling the PMBUS errors.

TBH I think if you're at the point where you've got regulator hardware
flagging problems in most system designs there's serious problems, I'm
not sure how likely it is that it's worth trying to classify the errors.
Perhaps there's some systems that frequently flag low level errors
though.

> > It can also try to avoid
> > interacting with hardware if that might not work.

> It'd be great to have documentation / specification for sending and/or
> handling the regulator events. I don't think we currently have such.
> As far as I understand, the notifications can be picked up by all
> consumers of a regulator. I am a bit worried about:
> a) Situations where notification handlers 'collide' by doing 'actions'
> which are unexpected by other handlers

I'm not sure what you're expecting there?  A device working with itself
shouldn't disrupt any other users.

> b) Situations where different notification senders send similar
> severity-level notifications for faults expecting different types of
> handling.

Like I say I'm not sure how much practical difference it makes to think
too hard about differentiating the errors.

> Or, is it so that no "generic handling" of these errors is to be
> expected? Eg, consumers who implement any handling must always be
> targeted to a very specific system? My thinking has been that the
> device sending the notification knows the severity of the problem and
> - for example the REGULATOR_EVENT_REGULATION_OUT is only sent with
> such severe problems that consumers can try disabling the regulator,
> whereas the _WARN level notifications may not warrant such action. But
> again, I don't think we have a specification for this - so this is
> just my thinking - which may be off.

Do we actually have practical examples of systems sending warnings that
aren't followed in very short order by more severe errors, notified or
otherwise?

--5rVUboXIZqzB+ntf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQuzGcACgkQJNaLcl1U
h9DBAwf/Y7v278IUTTFKtM8zh82+//bnj7JS7CBQUKv8QIdngzKfcbQxj5e99OmG
O7gl9jLpOUaDIV+6aoyhoW/IL0QQL005SAbO6CcKa9aZIjCxFmXN4OZGA+6QvZam
E7xFCccQ4+xtTM99xVM8QgpazCreNXj3Gnz4gCvXfW8t7bcAQJhlY/9gV5HYXNLY
LlcXrsD/mRvHotYutbHQZM0pTUMy54jdxMm2JrrLDweVKomBveRAdaEj4DQRzpEN
mSVgYm4v0eqbAgC4hKHaHGoPuqFGxb0d7cUY2l5E6O6QlvI3AHUtP9sCyddbH8Iu
fB7Zl3zI7BNZY0Cf0Ifqh8CaOalJvg==
=wRrb
-----END PGP SIGNATURE-----

--5rVUboXIZqzB+ntf--
