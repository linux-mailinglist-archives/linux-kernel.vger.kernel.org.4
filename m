Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB36DF8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjDLOg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDLOg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:36:56 -0400
X-Greylist: delayed 3583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Apr 2023 07:36:27 PDT
Received: from linderud.pw (linderud.dev [163.172.10.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20269126;
        Wed, 12 Apr 2023 07:36:27 -0700 (PDT)
Received: from linderud.pw (localhost [127.0.0.1])
        by linderud.pw (Postfix) with ESMTP id 25C0FC0293;
        Wed, 12 Apr 2023 14:38:27 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linderud.pw;
        s=linderud; t=1681303107;
        bh=O8aSdXpTVrDXIG6KsH5yZYXrkaTdUzwYMD1SqhEYBaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dM88oRf1u+qblbhjh1UNixkaXpk2+2DmnsIoD65HqxxNZ3rNWS61Xoi8Y+aizFgRk
         xzJcyCacbnDKV7l+SFXyTQ+V8m7GeNay5buHPp7Vtohvazqpq3319vmS7QG9PrhwkX
         rpoGZ4LtL57TzLg0Et5Z/+Hbr7S8I6y5QBtnpNIM4RIJuU90ik0C4Q1vitu+M8dr8i
         0YhC5po9jcm5RDyxzzENj+KYTWVi1H08u5ulK0XGISUPfLxqn8UsYWS2S/ZeTV1t5w
         rWvajDfILar9vprpgkP8sDd590e4p/oQNcmmE3CcW5HoHDhyO0ZMPFFfv/GpId8JZV
         WilHMdDKOhRvodUXMa2x3mrQk+54DPbfeVkKGWn9Yn29uohLOO4ps1nw3DoXnkNTuu
         ZscqaAUNi+TrcbFVF9vJRxZ+9tZ+lUuFNAhix4GISjacggjSNCzP/vv/jRrny81Y4c
         MrmNS8AOebCgjVjXfO7ChmvWkX3t2OOHDa6EjVMu93lQNlm956GoPaVySQX/iRJgSH
         XdY/vlo8i5E3fm+cOmTlv9vXNlYCP8296+SvRhKhX6mhS+zyU5fsOe1bwFHMzrkKaW
         PxIFUiBKyFBlapzPojkHWkPHncLnllqCzuDb+1oXWyeRfb1d5M4Nk6wA1snx6thvNY
         eEzVFpzTfm5muJySAFnXYLLE=
Received: from localhost (unknown [85.252.93.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: morten)
        by linderud.pw (Postfix) with ESMTPSA id DD86AC018B;
        Wed, 12 Apr 2023 14:38:26 +0200 (CEST)
Date:   Wed, 12 Apr 2023 14:38:25 +0200
From:   Morten Linderud <morten@linderud.pw>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Deborah Brouwer <deborah.brouwer@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Message-ID: <ipjch2egqg43r6h3drwmmm5s3lbidknke42gz7d6w2digskp2e@o4hzg6zrtli3>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <ZDSRSWhWsN34MghQ@xps>
 <CANiq72=n1b=fJ2XZZx_MLKkbKMTmnmTBMgA3GJ_hqyARPtwEiQ@mail.gmail.com>
 <20230412025834.GA301301@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p6d65wvmwi2vphxp"
Content-Disposition: inline
In-Reply-To: <20230412025834.GA301301@mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p6d65wvmwi2vphxp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2023 at 10:58:34PM -0400, Theodore Ts'o wrote:
> On Tue, Apr 11, 2023 at 04:22:56PM +0200, Miguel Ojeda wrote:
> >=20
> > Thanks, it is great to hear that the guide helped! :)
> >=20
> > On resources: nowadays we have a webpage, too. Still to be completed,
> > but you may find it useful already: https://rust-for-linux.com
>=20
> Something that would perhaps be useful is to document (a) what
> versions of Rust is available for various distributions, or pointers
> to how to get that information for various distributions.  For
> example, you can get that information from Debian using [1].  It
> appears that Fedora isn't distributing rustc at *all*, at least
> according to [2], so apparently for Fedora people will need to install
> it from source.

You can get a list here:
https://repology.org/project/rust/versions

Another alternative is this webpage:
https://pkgs.org/download/rust

--=20
Morten Linderud
PGP: 9C02FF419FECBE16

--p6d65wvmwi2vphxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEwQA0ZnZjToDJQPuenAL/QZ/svhYFAmQ2pkAACgkQnAL/QZ/s
vha0pw//fecghEK5I9RyfAQ2BiwDSVkPaOhflT7Fcfzdt01nYS++SsyxxnOVRYfc
1txshNmNbUzTIRpbJ5AlDAGfBMpL882FTtfpJ9bZxAqSMa/OziYdVKAzcEFDWLja
OWXk0YJpuAwD7mRlMVuXTnn5CkujhcbCsuOLDOfopP1MCkjW20tGW4sLlJuyG94b
NowjEMiVSBhERIAqXNG6wq33GNALClt1NgFtLerbUShikMwSTnkzB0z8T+quJKc2
3NRn8DCfPHtleuuu1V+oRjeoaYcxpxodIArX8yT0inshvC+HSrvTLEbrhr1DJUhJ
x4lN3SEyL60qtPjw1WSN2iTTWoLH0iWm/i8NDJpRXH86nL7StgNgOZGnN0YxN2Ku
OFr+nRIpRt+kmdOvqDBkY3VR0pM13GXPX0crGOJpTgwmUAWVEznpdylaDK3eXRI3
BghkDNi4xdiRDV92wRnyq96/wxfT+yjWlIQZnl9C9/m0JXrmSJmQJZw4vRs6gcdA
Zn5davlN+0Q0KQqpXDTRMn7af7iQVOOrLqJDiqd7QkEI1qXzfKwyD99epsbIpxvH
S+N52+frr7Jpk6BuSwn1JNpAWL1tOHGG2cwPn3jdOR26T6v2RNFnD29QObHLGsxc
PfOh7CkLDC+LD8klTenmwu0+KrrvVHcUQKtGn4f5ht82OEmIS0E=
=p1yX
-----END PGP SIGNATURE-----

--p6d65wvmwi2vphxp--
