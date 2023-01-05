Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B077C65EE28
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjAEOCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjAEOBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:01:45 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158A658318;
        Thu,  5 Jan 2023 06:01:19 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso2080716pjp.4;
        Thu, 05 Jan 2023 06:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZPqnw94bwf3KSF4c58t6GNXHQRK1QCZZyLGdvhFtgU=;
        b=nR5jklJYM4uAOdxK56Sl/iBxjrBg/EXYEgg/TVrvz9o/GwSFnH83knikqnmK55yfZw
         /RKWWCURQhFO+RX8l0goFhwPBMHT7akg9F0qOBM1BYljrpbNqx4OEHrxpWe96QfmA8Bs
         f2IDQ5ieIH/HnNpGmQCzTQTW1N7DhQ1gKvdrU0Pfo1vcEgEV72za4ReFpUUjWS5LvJOA
         fo/ZDX1reGdqiQNGxjQqyxJkCqr1iMYiKk9EEV1MEB/dG2u3aFZaD6+SQhndDEsPRcvD
         smr0PfxGtAZlvRvB0CKsLCY19wEHIt2GN488wKf1kXwNY2CDPplEf0Nb4oiu+XoWwwBy
         bpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZPqnw94bwf3KSF4c58t6GNXHQRK1QCZZyLGdvhFtgU=;
        b=8Chj8YNNYCcedJM8YDj+ALx6iylO0bAP1JGhX/kzM94KzrmzrHKnoqbVnHY9nuzzJK
         fKClDOadjlVG4fHwfIKnucMavoDSSCJGNUyBEnrXF0KImYkbXK2sZPUgtpBds7DbX+cr
         52XdkpCIppVwdzo9bxU2krEYrdbYGckOHVCxN5CD3UJTrlsN0JjCSNPMmtH+AZ4y1ClQ
         aSlNlthRmJ3hEvtLHLSIOOuX58NGnc8WIWPRERtYf4+OaDqPgzvJuv8ndxbDPhbPaxfT
         4BE0FB1IEq96KLmNbwrWpSi7TrBhsTj4WflwHymXPAbq4iMIRKVFSUt06rF/c6EhOY8S
         h0jQ==
X-Gm-Message-State: AFqh2kqplPDppnhR9Kf1cBrboPngKdYj0IghzVghRAHd71kztjauGZ/+
        QZH+q6g7gnFYdgc435Jsbc4=
X-Google-Smtp-Source: AMrXdXula8sfngBHs5QXT5nJ0jqXPgGyNszqj0iVq64x8mR+shYO8h4t8S6nIYcNDQpxfJ3WVDBFLA==
X-Received: by 2002:a17:90a:7849:b0:226:3a7c:f248 with SMTP id y9-20020a17090a784900b002263a7cf248mr27033707pjl.24.1672927278496;
        Thu, 05 Jan 2023 06:01:18 -0800 (PST)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id ei4-20020a17090ae54400b00225daca646csm1436852pjb.34.2023.01.05.06.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 06:01:17 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 0E21710381D; Thu,  5 Jan 2023 21:01:14 +0700 (WIB)
Date:   Thu, 5 Jan 2023 21:01:14 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Heiko Carstens <hca@linux.ibm.com>, yang.yang29@zte.com.cn
Cc:     freude@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next v2] s390/zcrypt: use strscpy() to instead of
 strncpy()
Message-ID: <Y7bYKgjYSG09OD0f@debian.me>
References: <202301031002076571212@zte.com.cn>
 <Y7P6mSuYkmP8g8Ot@osiris>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OpWV2mU/05KOlxs5"
Content-Disposition: inline
In-Reply-To: <Y7P6mSuYkmP8g8Ot@osiris>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OpWV2mU/05KOlxs5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2023 at 10:51:21AM +0100, Heiko Carstens wrote:
> On Tue, Jan 03, 2023 at 10:02:07AM +0800, yang.yang29@zte.com.cn wrote:
> > From: Yang Yang <yang.yang29@zte.com>
> >=20
> > The implementation of strscpy() is more robust and safer.
> > That's now the recommended way to copy NUL-terminated strings.
> >=20
> > Signed-off-by: Yang Yang <yang.yang29@zte.com>
> > Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> > ---
> > chang for v2
> >  - match the FROM with the Email
>=20
> You sent this from yang.yang29@zte.com.cn, but the sign-off is without the
> ".cn" suffix. Can you please make sure that your sign-off chain actually
> follows the rules as outlined in Documentation/process/submitting-patches=
=2Erst?
>=20
> If you read that then the sign-off line from Xu Panda shouldn't be there,
> since the patch was not authored or routed via Xu Panda.

Specifically, the second SoB from Xu should only be included if he was
in From: mail header (that is, he should have sent the patch instead of
Yang).

Ah! Thanks for reminding me of this trivial issue that I always missed
when reviewing ZTE patches.

Xu, are you really transporting Yang's patch?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--OpWV2mU/05KOlxs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY7bYJwAKCRD2uYlJVVFO
o5S4AP95j5Jj6Yu5/m76VPdoMVaMFkwkB6k44b5xhsPWdopqBwEAglth7VekCRz5
oOf+gf5FpLY6cLn7z2CRuX/MNzLNnwQ=
=01JV
-----END PGP SIGNATURE-----

--OpWV2mU/05KOlxs5--
