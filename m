Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE596A1E56
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjBXPRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBXPRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:17:32 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2886CF10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:17:11 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id op8so14227457qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2rrFLVjSCO8hdOxBP+XaxX9i89B+HKjmbRtlYbNzsk=;
        b=FnaXL4lJ8w3wYmoqsvaWAMDIO5xg2RqQV5VQ3cmFjSrHHTL25nCHCIJlJ7PlYKDKgb
         gxqCLJ7+Dya/bkpjkCs3HLQfYybjyrfsXvCYXr9x/VBXx+eQEkMKjEBja8nOmWGrFOhB
         88/XkFo0DxPGAmna7h+aUROYVuqOEatBuNUBCCFAe913t35z5a+dEw0fquqDYt6cT9ot
         lbVNlc6WYGwac+OhnzpENVwLk4jGdCubutkJPIwzJVF5j9vMLpWZo26uFv24ZCGMiS64
         bd/J1KB0vYnxsTOtlsp8LP6p64cs9yZUrLJYUx3w4J37f2mXpqQft4sEIpXhh3yLWg5o
         yAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2rrFLVjSCO8hdOxBP+XaxX9i89B+HKjmbRtlYbNzsk=;
        b=ABvNk1gVutJ97luhqperZMjHtyBzYpSdv5J/gBRTjXxT6Q3/AVcVKlAQHwjo1+3j5F
         RsuqdFH/LPSFRsMVAcugpLCW6IJHR5IawVuslV/EnY1PliDhW+NBWFCNjUYJTF49ot/p
         BuDAaID2hLSZecL0ZEz2nwzTnDmdi2EATFzeE2ZKqdVHNidrTLnUFYcVcXbw/2P2dV06
         cO7Ta42WNvOn8f3m5iXHSOmnB817evr7qjbCSWK4FRfQif4C6Q69ZptKFhqYgcyvF84r
         hJ+QZeJKbq0eKMkBpumP8+W1oDMz1ZX6q0WAgT01cTIvqIkSuNgIi0h+aH4UR3YZzH8x
         07Ug==
X-Gm-Message-State: AO0yUKU2irQsCwHs2YAwQd2YR5+fb3SbQcabSuLgpec0KU+l6M0p1iOp
        MmhcFKjql1uZ0lYTsehuV3jSESJ9jOkeyRLT
X-Google-Smtp-Source: AK7set9NzOpqC4mXuimletGMfilB1q0da9pI1/htPz7axtyoHADi4WmpClp3gFbCzYJYngcHwraC4g==
X-Received: by 2002:a05:6214:2603:b0:56e:a9d4:428a with SMTP id gu3-20020a056214260300b0056ea9d4428amr33591484qvb.1.1677251829903;
        Fri, 24 Feb 2023 07:17:09 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id c8-20020ac80548000000b003ba19e53e43sm6752359qth.25.2023.02.24.07.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 07:17:09 -0800 (PST)
Date:   Wed, 22 Feb 2023 14:24:55 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] regmap-irq: Place kernel doc of struct
 regmap_irq_chip in order
Message-ID: <Y/ZsB8GXdEAvgCtH@fedora>
References: <20230220153334.87049-1-andriy.shevchenko@linux.intel.com>
 <Y/ZGMDI9wcOwMUWI@fedora>
 <Y/e19Oqf1XwDo/aw@smile.fi.intel.com>
 <Y/ZU3YWmC+/sN2iq@fedora>
 <Y/jRNW0QXA6rznDj@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JzPOL+6xO4K4HczV"
Content-Disposition: inline
In-Reply-To: <Y/jRNW0QXA6rznDj@smile.fi.intel.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JzPOL+6xO4K4HczV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2023 at 05:01:09PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 22, 2023 at 12:46:05PM -0500, William Breathitt Gray wrote:
> > On Thu, Feb 23, 2023 at 08:52:36PM +0200, Andy Shevchenko wrote:
> > > On Wed, Feb 22, 2023 at 11:43:28AM -0500, William Breathitt Gray wrot=
e:
> > > > On Mon, Feb 20, 2023 at 05:33:34PM +0200, Andy Shevchenko wrote:
> > > > >  	unsigned int use_ack:1;
> > > > >  	unsigned int ack_invert:1;
> > > > >  	unsigned int clear_ack:1;
> > > > > +	unsigned int status_invert:1;
> > > > >  	unsigned int wake_invert:1;
> > > > > -	unsigned int runtime_pm:1;
> > > > >  	unsigned int type_in_mask:1;
> > > > >  	unsigned int clear_on_unmask:1;
> > > > > +	unsigned int runtime_pm:1;
> > > > >  	unsigned int not_fixed_stride:1;
> > > > > -	unsigned int status_invert:1;
> > > >=20
> > > > These don't look alphabetical, so what is the order for these?
> > >=20
> > > Nope, the order is to follow:
> > > a) kernel doc
> > > b) semantics of each of the groups
> > >=20
> > > Do you think the order can be improved? Can you point out how?
> >=20
> > No, I don't have any particular improvement suggestions, I'm just want
> > to understand the current order for when I introduce something new here
> > (e.g. no_status). If I understand correctly, status_invert was moved up
> > to be with the other "*_invert" flags,
>=20
> As far as I read these there are IRQ related flags, and some others.

Okay, that makes sense to me too.

> > but why was runtime_pm moved
> > to above not_fixed_stride rather than below it?
>=20
> Do you think that not_fixed_stride belongs to "*mask" group?

However, I don't think runtime_pm belongs to a "*mask" group either
because it's a lock for power management if I'm not mistaken. So if we
can move runtime_pm below not_fixed_stride then we can avoid the
respective runtime_pm kernel doc line move which makes the diff for this
patch slightly simpler.

William Breathitt Gray

--JzPOL+6xO4K4HczV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY/ZsBwAKCRC1SFbKvhIj
K6GOAP9jMgIAbX0AOn51ybOoQBf4ADOt6Gsn8u/Egv8snmOMswD7Baq6TzyZGHd+
tUzHPof0rSsaoJYffklLPSdzCPV12wg=
=st3G
-----END PGP SIGNATURE-----

--JzPOL+6xO4K4HczV--
