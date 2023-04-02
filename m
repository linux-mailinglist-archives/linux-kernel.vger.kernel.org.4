Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284B46D3817
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 15:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjDBN1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 09:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBN1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 09:27:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088EE5FFA;
        Sun,  2 Apr 2023 06:27:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q102so24820350pjq.3;
        Sun, 02 Apr 2023 06:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680442024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbdL7KkvQ82fAe5djvivuibJu2664croIJIdJMGh+kQ=;
        b=TsPesgJvSErJnJtAg3/aTWlCULgIyZ4QgR/5Mf9tAHabQKbwqicezd2NimjN2E4y25
         +ZlAaakrfofmrdOsj5jelxuz0ISo1u8eCSD4V2AyzA3cSXVt2Ew4gmPeU+vmBiE4+FiD
         /08q6BOKZtoP+a/s6uJdi01SEk0r7rhVS+cL52+AO4OawFr5FVQO/9siewIQtYz3Et3u
         Qzuy+MIJ4HyPrTvXZo8iomR7xtF4E5UPP+9Y7D+ugkFMQrnWri8lY25hEiD/kSCE4uTV
         LTCzplrbJf3O/Vl1VNGoi9vvHEWOHjC5oSjJbjoBNGz9hvE+PfCepOgHL7Bp1UaGSC7O
         xe/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680442024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbdL7KkvQ82fAe5djvivuibJu2664croIJIdJMGh+kQ=;
        b=QeFAEUbllAKvXxIKP3gzkWXBXQP3k6oEmFPFG8lrn7gOUfkGvMkL1Gc7ocVkb089/e
         AXhU5fQs5bfJNU9YBUDFssEyQULU8CE3JdWgrzpxM4x4agMR6wajj852yOymVE0njYIu
         F/vCPTEFDsN20WTgsaNpRtV8yq9G/aDJ98KqP9mlpRI7q0Wu89njJzNhzsfMKy2BjVnK
         Uapc80xspfRuC2gUsIdSPFhBjIP78hzDnBQKxvKgukXfqUBNJfHw6oElkYoFTmJnjEX3
         C2YBVINBS9sAHCSDBqGf5ih2qC+iblL2doKvIN0uFCefoP1zqyp/5S0irbkHEt+LqQ5e
         rtZg==
X-Gm-Message-State: AO0yUKVuL/MvGeU+2ljK9sdpD6odNazNWqo2Nr3TAgQPEHbSmXseBg3J
        lhcqeZPCvKPP0yPnKW7DX8E=
X-Google-Smtp-Source: AK7set/paSWQhha7wLAUxN+IU7yHKYH1hHFbgAAWpVgJ0psQ98mgrhpwVFbPLyCg9/isep0L3IBM+w==
X-Received: by 2002:a05:6a20:4f88:b0:d3:78ab:77c3 with SMTP id gh8-20020a056a204f8800b000d378ab77c3mr29939874pzb.48.1680442024514;
        Sun, 02 Apr 2023 06:27:04 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-38.three.co.id. [116.206.12.38])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78699000000b00580e3917af7sm4622850pfo.117.2023.04.02.06.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 06:27:04 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CCA351066AF; Sun,  2 Apr 2023 20:27:00 +0700 (WIB)
Date:   Sun, 2 Apr 2023 20:27:00 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Ron Economos <re@w6rz.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: Bug in recent changes to builddeb
Message-ID: <ZCmCpCL7mfuf+71q@debian.me>
References: <54a519ec-bfe5-60f3-fc43-707a11d38d2a@w6rz.net>
 <642d6944-4488-4dc6-99e9-209849b9771c@infradead.org>
 <5946f189-c564-e196-a375-cb03edcacaa0@infradead.org>
 <CA+icZUXt2Q6k6b6tHVA_F6rjeUTPmMb9uCCz+rbDJ9UW2kq3=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9nm8mXwebsdpjF4p"
Content-Disposition: inline
In-Reply-To: <CA+icZUXt2Q6k6b6tHVA_F6rjeUTPmMb9uCCz+rbDJ9UW2kq3=A@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9nm8mXwebsdpjF4p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2023 at 06:49:00AM +0200, Sedat Dilek wrote:
>=20
> Hi Masahiro,
>=20
> when do you plan the next git-pull request to Linus?
>=20
> For people using Debian and builddeb this is really annoying.

He has sent the PR [1] and got merged.

Thanks.

[1]: https://lore.kernel.org/lkml/CAK7LNAQEKgqrJNeknymSTsiRBbjoJJjWQ8VJ7ViC=
2-9Z0Mgpyw@mail.gmail.com/

--=20
An old man doll... just what I always wanted! - Clara

--9nm8mXwebsdpjF4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZCmCoQAKCRD2uYlJVVFO
o5uCAQDXn5FKcuShOWk41xg09WbLLsHfnfbzMfKxrnAed2xW6AEA5Z702KdxOo7N
xifApWkFmTkWWRIoXj02PU66hjZxqgw=
=jycJ
-----END PGP SIGNATURE-----

--9nm8mXwebsdpjF4p--
