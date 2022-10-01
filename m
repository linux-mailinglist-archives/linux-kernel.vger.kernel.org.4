Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDBA5F1AB7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJAH5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJAH5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:57:39 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC1318C005;
        Sat,  1 Oct 2022 00:57:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f23so5766267plr.6;
        Sat, 01 Oct 2022 00:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=KrBJ3OnNzeftZkiKUXUK07emKURterDHFpsjXpd7SC8=;
        b=eDMWjlPOpE1dsLjQecDaGZnmw9fLcm/u4u0Ao85kTGzHERPlJLxvCQ7RzDsXW1LSMK
         hY/t+keV+6kw5/EqY8rwlvGMzYHZWNg9KK4aGog4+k4/jNT5JwRgbJ0xG6jTDgpBiofc
         qLFcZ4nqAYmxJm6xK0NpHQaazgkMJpdqoV8n3tXAZEnfDkYmS6Q0KS6vVZs5jAGiIAEi
         KKnaa7om9DBKUoIk+59AETGB7bG6UXO+9WF4EORMh8/vrBfJ4656ezat5mFu2d/OJljr
         F5YF6Y+ZDUit8nT1lzz/qPMaZTN7Tj3p67a2GyHqKQ0yNfV3jm6X9opYiPQuKeqm/XHO
         SD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KrBJ3OnNzeftZkiKUXUK07emKURterDHFpsjXpd7SC8=;
        b=EGEWRiZjiHZ8GMRyONzvq+wPD2M10TOrYD1hp50I52PonmxuNcL8wNzDIVygLWcGYW
         64uwP8FkmHgzmPRY9knysQwuXQ4oqoyRVsQ3QH2gjMAYDiDataW3xzW6Z+XSzeeGIm9Q
         r0kbE2AIaBpGJmH56JKALke6p66Cel7K2c5fq1OCZjYFx8a3NyQL8l2+sTyVwEFwdv1n
         VrFkS57MShtTVdYzAr2H4xkh/F7SMHLWkDv+gU+4qgdeO8+I2/Gxp+bLbOSx1APF82oq
         rJpmEKF2SBccmdyamcXQcWmDzhe3FFsZZAC4alNxuLNze4cr07fOgNfl5lmnceZfPqnB
         i5Tg==
X-Gm-Message-State: ACrzQf2GGEBobhTpNASIUOswFijKbi5mKGbqmY8Ku7X+wh6CEOasjjFp
        3IIxYAysjo1MNRNHkGvmBvmdPO7UuGTfng==
X-Google-Smtp-Source: AMsMyM6oK8+n9+z1Ng+fYKbMFK1uepblQ0jl38KIuxoxFLX0uGDr50qDVb2Lgj3zlMjPRtt3emJU5g==
X-Received: by 2002:a17:90a:9c7:b0:205:ebc5:f592 with SMTP id 65-20020a17090a09c700b00205ebc5f592mr2237177pjo.153.1664611053158;
        Sat, 01 Oct 2022 00:57:33 -0700 (PDT)
Received: from debian.me (subs09a-223-255-225-74.three.co.id. [223.255.225.74])
        by smtp.gmail.com with ESMTPSA id iw12-20020a170903044c00b0017cb3207855sm2478885plb.99.2022.10.01.00.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 00:57:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 43A4C103744; Sat,  1 Oct 2022 14:57:27 +0700 (WIB)
Date:   Sat, 1 Oct 2022 14:57:27 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Slade Watkins <srw@sladewatkins.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <Yzfy5wXuU0uxdIqr@debian.me>
References: <20220929135325.4riz4ijva2vc7q5p@meerkat.local>
 <95c3384b-53d0-fd6c-6ec5-a7e03fdeddfc@gmx.com>
 <F300ED64-5E8E-4060-89DC-C98BC5FF08E6@sladewatkins.net>
 <YzXK6Px+BrNuuMZH@pendragon.ideasonboard.com>
 <a86adc6d-05db-ec2e-c5de-d280aad9fb8a@leemhuis.info>
 <Yzbtuz6L1jlDCf9/@pendragon.ideasonboard.com>
 <BYAPR13MB250377AAFCC43AC34E244795FD569@BYAPR13MB2503.namprd13.prod.outlook.com>
 <3cfaef48-744f-000f-1be5-6f96d64dea24@gmx.com>
 <YzcdnnjJA4M09dNH@pendragon.ideasonboard.com>
 <YzeVVV+nPaxsqS0V@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RFCm67F2aeOXrvQp"
Content-Disposition: inline
In-Reply-To: <YzeVVV+nPaxsqS0V@mit.edu>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RFCm67F2aeOXrvQp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2022 at 09:18:13PM -0400, Theodore Ts'o wrote:
> On Fri, Sep 30, 2022 at 07:47:26PM +0300, Laurent Pinchart wrote:
> > > Debian uses an email based bug tracker and you know what? Most people
> > > avoid it like a plague. It's a hell on earth to use. Ubunutu's Launch=
pad
> > > which looks and feels like Bugzilla is a hundred times more popular.
> >=20
> > It would be pretty sad if the only options we could come up with for bug
> > tracking would be either popular with reporters and ignored by
> > maintainers, or the other way around. Ideally we wouldn't have to decide
> > which of those two classes of users to prioritize, but I fear that,
> > given resource starvation, we'll have to make a decision there that will
> > be unpopular with one of the two sides.
>=20
> Funny thing.  I've largely given up on getting any kind of useful bug
> report from Launchpad, so I've largely ignored it.  In contast, the
> bug reports I get for e2fsprogs from Debian are generally far more
> actionable, with bug reports that have all of the data so I can
> actually root cause the problem, and help the user.
>=20

So no matter how the bug tracker interface is, the etiquette is:
Whenever something buggy happens, try to gather all information related
to that event (reproduction steps and reproducer, logs, crash dumps,
etc), then file the polished report. From your experience, it seems like
Debian people knows it.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--RFCm67F2aeOXrvQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYzfy3gAKCRD2uYlJVVFO
owpKAQDqs3NaPzyJxecuSDu3seERfmPSXU7yhojYUK+ijxRcOQD+KOQZIAVxQI1m
MdIgbD/Z+MU5jKPdPMY6FRc/vYLWWw8=
=UwbF
-----END PGP SIGNATURE-----

--RFCm67F2aeOXrvQp--
