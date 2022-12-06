Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E5E643C3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 05:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiLFE0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 23:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLFE0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 23:26:35 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59371A22E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 20:26:34 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q1so12314930pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 20:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JFzSwj2UsOfE/ApheojhszW7qAncTn0zPiyeo2+89Kk=;
        b=XICQdXQkpUQT1aoGftgoROTd8PONW3R4QpgVai+2MlM4c9XQJ/upAeyi5101p5dgdZ
         S3jo1DDu2qVWJK2zglerOVEqdt5xkZqh8zWsXM9TTab2ohNMyXB1weI9UjRdQIMAWNyN
         78ExsxMF4fro2PuD3o0168ZRjOzJDzhACZfkHvFB294AqYwliFtm9hxV/mrUQvTe6jlx
         jjpabSy3+DBlklbPX7E/ODzego8ng7fpNA2BaOBPpPFotiQ31nDMVsTAvAp+fx2ZDnQJ
         KPS4x3lCvjv2UbD2sG9fX7UqaZVff0ew5Zu+va0mNkGjccRoVtk/8Ilw1YZRdidnw2EV
         /3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFzSwj2UsOfE/ApheojhszW7qAncTn0zPiyeo2+89Kk=;
        b=SVbWm4IYEDYnWgWvnJfIi1ecVFDBHNmVDsyOscsw2B32R1cZAdJ9DBsFh7HA6gBXuk
         hnjdOF77pv60FSqBFZxmAS8Af9AjRhP3MN2QRHYoaPnpPliKrUjuIxHfVhgqT3i1uiX4
         BHFfb4O6JELtvxSASYAjhOjnUe4VsbVX5LyKka4x+udIpxj55gCSpmE5Adwb5M0rx7B6
         OF/iZhmhmv/4botW0PIvoWYzfzE6KhHlrD4La2hrPdfDVog1isLRcjGg1GL9bXkffl6y
         7LK+Ay2S1SC/hxWPUMmfohEHAb79FvWohDfguLLG1KvLNL9/g32uBhi/OtaLwtIH4uFm
         Rz9g==
X-Gm-Message-State: ANoB5pm5j67pqj2a/5ovKU/FXT9K5Ss66mt7rn8mHUPZ7iOgqFSAxkBV
        sqBzrG65yqdgfExfrYGOIF4=
X-Google-Smtp-Source: AA0mqf7reR0SU5yUtiMz2X1QKMVhlZRiIcEgIP368SeRykiQ3SYIx0fzWgW/LhkTGahui+owekhlEA==
X-Received: by 2002:a63:4910:0:b0:478:27a1:8602 with SMTP id w16-20020a634910000000b0047827a18602mr35307639pga.9.1670300794206;
        Mon, 05 Dec 2022 20:26:34 -0800 (PST)
Received: from debian.me (subs02-180-214-232-2.three.co.id. [180.214.232.2])
        by smtp.gmail.com with ESMTPSA id q5-20020aa79825000000b0057458d1f939sm10626301pfl.152.2022.12.05.20.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 20:26:33 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 9D29A100AD9; Tue,  6 Dec 2022 11:26:30 +0700 (WIB)
Date:   Tue, 6 Dec 2022 11:26:30 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     ye.xingchen@zte.com.cn, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: use sysfs_emit() to instead of scnprintf()
Message-ID: <Y47Edh3g+Ld9gFnt@debian.me>
References: <202212011053265568903@zte.com.cn>
 <878rjm2kfm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GjOSs0npbigzXBmw"
Content-Disposition: inline
In-Reply-To: <878rjm2kfm.fsf@intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GjOSs0npbigzXBmw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2022 at 12:50:53PM +0200, Jani Nikula wrote:
> On Thu, 01 Dec 2022, <ye.xingchen@zte.com.cn> wrote:
> > From: ye xingchen <ye.xingchen@zte.com.cn>
> >
> > Replace the open-code with sysfs_emit() to simplify the code.
>=20
> I was going to push this, but noticed the function has a third
> scnprintf(), and the last two play together with count. It would be
> confusing to have a mix of sysfs_emit() and scnprintf(). The third one
> can't be blindly converted to sysfs_emit() because it writes at an
> offset not aligned by PAGE_SIZE.
>=20
> So I'm not taking this.
>=20

Hi Jani,

Fortunately you'd NAKed this patch from ZTE people, which are known for
ignoring your (and others) patch review. Remember that they were used to
send from cgel.zte gmail account [1], which after the address was banned
=66rom LKML, they tried to send from their own corporate account but Greg
suspected that emails sent from them are spoofed [2].

Thanks.

[1]: https://lore.kernel.org/lkml/878rn1dd8l.fsf@intel.com/
[2]: https://lore.kernel.org/lkml/Y3NqyDDGz%2FUKPgxM@kroah.com/

--=20
An old man doll... just what I always wanted! - Clara

--GjOSs0npbigzXBmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY47EcQAKCRD2uYlJVVFO
oxNvAQDaz4sHLhHTfDnNNN7CRci/KWUK4z2C2t7Vn5cKoqxhmgEA+C9pOLMOG6ta
PuwUxC+yGaNiCvAepAumTZ4XSesIDw0=
=i0Fp
-----END PGP SIGNATURE-----

--GjOSs0npbigzXBmw--
