Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01455EB757
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiI0CEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiI0CEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:04:25 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C37BA8339;
        Mon, 26 Sep 2022 19:04:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e68so8438730pfe.1;
        Mon, 26 Sep 2022 19:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SnO8aVtavYR6NyHfDDKowaxtha4eDB/hQjOAOFJayeQ=;
        b=KDYrV4B33D0SRsBg8Jm1HIymG1tY5VT0P8OfWSzisMqjKRot3grFKGXzRk2P61w3mt
         lgUWL6ISYXJlNOGy2GnHiVWLEVpA12AQJx8Tn8DY/gf/mo9mul08aGqvELWcU5h/j7cb
         tJnd01ylv8iLi0hpHp58pxw0wdpLf55Tnf2EiN9jpABTWXAECgNSJZdhtR5vNd+hZ/Or
         cHAa8oM299cEPS7JvbC68HvIWYgUSx+J1HBvzLKzUSfZxGWswSyNfXajHRE2rCfLCgqF
         EN7XjPos3T3TCsvw4j5vxk2VpmEVboBtd/3Iy3AxWE3KKdhoCWK1gH/knagEpi9PEtGt
         RWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SnO8aVtavYR6NyHfDDKowaxtha4eDB/hQjOAOFJayeQ=;
        b=VeG3cZ6C5egNj05ZSaBTi7yW2ehGDwU64ulg7bSvC1+kuWH71IgwtVKabkeOhvgXrl
         kHwAb+qvFaXIrKWgVjK2qjYz4rLUozTOe9zK2Hw0YwMgDxVktdkWbuhZBGjcanxo6rHF
         86WGT803FfmeTLSanvOiSsameYjkcPIW3WAIsQuc22Xngd2WIaP7WtuJwK/oOYIa2/4b
         RE8crFnqbf2ER5fsowpDwZhlEr1JcaCyblSdDtGyZmnsCTiHkBnC+KpdOHAy6l7tm4Kt
         l7hudxeuygaRu2uLDkUqtLnQUWCy0lzwxQe3+XTFXUbXIwWJYkROgVxxzhb1NfPN3jHu
         um+w==
X-Gm-Message-State: ACrzQf3xYQfPJclZ2pUwL6c8EpTRODbFPL+OlDPqx6Na2gHRbF17lveO
        lDYbISOov8zxKRjrfKvZanw=
X-Google-Smtp-Source: AMsMyM6O6JvCHN+Du7f/0+Gbm01LHsBKNiTCjGRGOnuMCtM5ighdJp+lDhGPXShoGYJg88HpOl6nqQ==
X-Received: by 2002:a65:5184:0:b0:439:14cb:fbe4 with SMTP id h4-20020a655184000000b0043914cbfbe4mr21845211pgq.166.1664244264085;
        Mon, 26 Sep 2022 19:04:24 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-66.three.co.id. [180.214.232.66])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b001641b2d61d4sm145692plg.30.2022.09.26.19.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:04:23 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 389511037F7; Tue, 27 Sep 2022 09:04:18 +0700 (WIB)
Date:   Tue, 27 Sep 2022 09:04:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: device: fix repeated words in comments
Message-ID: <YzJaIolrTarQ4Qdn@debian.me>
References: <20220918094915.19567-1-yuanjilin@cdjrlc.com>
 <20220926185852.GA2581083-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z7VFNrjjSH/G3qIC"
Content-Disposition: inline
In-Reply-To: <20220926185852.GA2581083-robh@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z7VFNrjjSH/G3qIC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 01:58:52PM -0500, Rob Herring wrote:
> On Sun, Sep 18, 2022 at 05:49:15PM +0800, Jilin Yuan wrote:
> > Delete the redundant word 'of'.
>=20
> Again? Sigh.
>=20
> Please read:
>=20
> https://lore.kernel.org/all/CAL_JsqL4GvgFYzGUfhW5pvm4wYGrFaj6gHOYZjnOMuk2=
zCz67w@mail.gmail.com/
>=20
> >=20
> > Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
>=20
> Are you sure you are the author?
>=20

Hi Rob,

Some reviewers sent comments for similar patches from @cdjrlc.com
people (including myself at [1]), with some of them requesting changes.
However, there are never any responses to these reviews from @cdjrlc.com
people, just like ZTE developers sending through cgel.zte ignored
review comments [2] (try searching `f:"cdjrlc.com" AND s:"Re:"`, it returns
nothing for now).

Thanks.

[1]: https://lore.kernel.org/lkml/YyclQlws9d7vheDk@debian.me/
[2]: https://lore.kernel.org/lkml/878rn1dd8l.fsf@intel.com/

--=20
An old man doll... just what I always wanted! - Clara

--z7VFNrjjSH/G3qIC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYzJaHQAKCRD2uYlJVVFO
owdzAP4silDAtVrFUialTJDTN4QOtYT3Ezv6SHadYD4SDLgS6AD/QHIxT6wf1SQv
k7QDBtRPT90lwKxVHKjKW6OWzs0rTQU=
=3v9Z
-----END PGP SIGNATURE-----

--z7VFNrjjSH/G3qIC--
