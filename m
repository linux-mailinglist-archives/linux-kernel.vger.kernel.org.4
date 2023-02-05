Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97C868AF5D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 11:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBEKkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 05:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBEKki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 05:40:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7582196B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 02:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1675593629; bh=cGS81BKeuKvdvwYWLolNR1dKdCP569puCV//0ST94MI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YpWuwxE54K7Qx9nAcGS5avoCh98BV1lrtqAPbrykZxbZ88jDlmeYGqXqJpN1JVMAC
         GrWy98Rip8LQosHn7ex2SYjPxL7H2KjJkEdtpERaOcHndNp+pB/1Fj1miTAeHJpA2k
         oRTAIQIkFsDdQoLzAjLVzvq4uPZI+Ll3MHc00CQm0KZh2aLTNzuM3mcztrMyBLknlW
         oGVMGERzhDfu9R14Lf5VXtdjxKbb+hqLw/63nj7FXtTnpZBZGYskLTbeu8pLZu7J7x
         zd888TC99zX6LmYW4LpDAk54PKwzCYGT8uB5gbJWNBeLetkXPySWyWiCCdkW4TZpmK
         hzUfZn0xchUew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([185.175.219.1]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXdC-1p29dv2CDC-00Mboo; Sun, 05
 Feb 2023 11:40:29 +0100
Date:   Sun, 5 Feb 2023 11:40:28 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] checkpatch.pl: Relax commit ID check to allow more than
 12 chars
Message-ID: <Y9+HnJ9ldBZP16zp@probook>
References: <20230129123431.1282427-1-j.neuschaefer@gmx.net>
 <78d224a63f6c27bf700d59007b6f3c89746d728c.camel@perches.com>
 <3afee0493d3718f2e38b6c54dab23d38360cd5d0.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QVNdtCdvpDJ4Wr7k"
Content-Disposition: inline
In-Reply-To: <3afee0493d3718f2e38b6c54dab23d38360cd5d0.camel@perches.com>
X-Provags-ID: V03:K1:KszUNIOjhYtrHV/QOE/sLgzc3+Iowa2H+x3ts6Y5Vywvjl66rPY
 lHexevzQZ+kFOQKw8Q3GNNdWWsIQeHPuNT1geCw6lacR4hDQVbt16QS1Af2xFiV7sjkgvwH
 MZjUPPCdlyeawgY79QIvHkFfdLu4L29vg43TIz1DhS5H7aybJD1zetlMUM5l/a1fo6F6TNP
 9OjLyV5ZYbvqwXLyvzYSg==
UI-OutboundReport: notjunk:1;M01:P0:l1K+KWXUChM=;GmZ97Vx/fQTA7furRq5sImbCTTE
 GiQMJWe64aIeerJ4bkFgWa00a7q5FYSzlWrjVp1TalGgDEx2BXPOGLV2mnKKIh6f1fu1i8B9G
 Y7qHswpCE3QFAnzOT8rA1mp5/mfjQJDH8TUYVpM7/XbOIkiGy74BhXPcsIlhdPEPpq2TYn+F1
 +Oc4MuY2vCdlwjEExJ5vO7rLO4rNFh+Tw8UqV5Eh4j4Ih9ImiETEoINvSsOBjWvarDziUGsbc
 OQxFLkQ2niZIijUXeAZdNfs1wYTxBSnPoie8n9izjRxmIlXA6jf83eMUyJlKi0tLySV9faN4Y
 hLgQHOpN+k9LSu/5BwhvAOQGRtRufDm8cNNKo8aw2XKVwECm1VsvuY41ckPQrbbgjIVdZ325n
 7U4dzKNJ/jLXx8N7HeXm39ewJZZXQnKw3G5apTs7Art24J3PsEt2OQ4CiQFZ5h8bb2iFenrWQ
 Tj46sUh++0xNERpcp6jCl5lF0oo3jBBNIeS79oXXG7M9ykiEm1NrYvUh+iPnIyLjNulkpfmyP
 5YP6zdlhPhb4DMUMKGijpHfDtZBM3jZRPrHORiEcRECBCkGyJr4uXsb35o7zgOYaxPe41Bfew
 p+QtoEC4SJATKU/QGmEKHtdeA+4K4CnPiv4AKu0XEI+GiD+goGQ8QH+g1s0indMy14Nk7+XIm
 7m0GOwjfThMhxEXnAvCQ5zuVTo6qwkoSG/Xq+JyYKpMwV+wGHogxwm9D3MxzoknOqXVgIJLcl
 r6476rueblQUq46JJBvTINOu9EF0oRbyj1rVVASqZO3s4JIXqw1ig/lotpzorZHioEHyy+lh0
 9zSoGLIW78tR4iAgZgwvrr9E5MThniUX/lnWyTnkL6UGXtWU33xCHxFVi44vxgJtt19TY1h+R
 0X316a+9t7q6RBf932eIh5WkgihxoUkMoCcal/fwa867SwsYqENGNHNAbonLyyaDs0iFiD6qr
 QcOkyhtfp3gYnZziyQbyIsC8jko=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QVNdtCdvpDJ4Wr7k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 04, 2023 at 08:57:59AM -0800, Joe Perches wrote:
> On Sun, 2023-01-29 at 09:52 -0800, Joe Perches wrote:
> > On Sun, 2023-01-29 at 13:34 +0100, Jonathan Neusch=C3=A4fer wrote:
> > > By now, `git log --pretty=3D%h` (on my copy of linux.git) prints comm=
it
> > > hashes with 13 digits, because of the number of objects.
> > >=20
> > > Relax the rule in checkpatch.pl to allow a few more digits (up to 16).
> >=20
> > NAK without updating the process docs first.
>=20
> btw: it looks like 12 will still be sufficient for awhile yet
>=20
> $ git count
> total 1154908
> $ git -c core.abbrev=3D5 log --pretty=3Dformat:%h | \
>   perl -nE 'chomp;say length' | sort | uniq -c | sort -n -k2
>     198 5
>  664613 6
>  450955 7
>   36667 8
>    2312 9
>     155 10
>       8 11

Ok, I get similar stats on my tree (which includes linux-next and a few
other remotes).

However, git's default heuristic for %h length uses 13 digits here, so I
think other people might get 13 digits as well. I could force git to use
less digits than it naturally would, by setting core.abbrev=3D12 (and
document this idea in the documentation), but that doesn't seem nice.
Therefore, I still think allowing a few more digits is a good idea.


Thanks,
Jonathan

--QVNdtCdvpDJ4Wr7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmPfh3EACgkQCDBEmo7z
X9sDXQ//fL1lOs4DhlfBMUWqcl7Ng5vp3aJcAaUgJlX/ZmWIzy6SerT82BOBG1jy
2Hk5PRDllJxT3ODWtlvSyV1ywib1aYt8QPU+791YthvfNBlC+dUygxyMdrrRccDv
NURBNl2M/0KFYHgqRUHupQF+fSZuUp/c/FGQ32eGdfuKFCc8qLa0CZROF1WL9p4x
kvDXuEL1urjHU3aDGzi54Tr4u2YlWxCLIU6oos40lXsEGbBDav1Aall1F72YlDTX
3tJY7MvIPWuXZ+Y/exBbb+TAsJdDVhgqp6UCT1K7/MaPExugclakaZKPhn2J5M7b
pQOVXVYSxjtCUQKm1h42cfAfOmAEt7SG4q43VkeIi4F9KeYK9zV367xX7EHjG3+4
FZFBWIKEq89INno/snUE0JhcGwbLCU/2jCplrl8iAwk0zKYt4mro8nC1cdzcxq2K
LSMNtVKXKn7dq5sjGfIc2fHreBeaxqS509GVcGTtpmuYEEKlf1VTjBG5Mv9Ro8oL
wur4fxUa/RKX+niPjUrHPy7/Xt0FRwsdjz49YDyzULuN6WDEbMMMtmyNDB/t1xgJ
rTASOhVGTVRzONIYlMy7r2COPc85qjc4Ye/P3BOLnv15jLAymgHN3Nh5MI3wplMk
AkmKGqG6ClD9jSjHZ5r2G6ucRsgoympBDfrmyMpU/vck1/xA8QU=
=31hc
-----END PGP SIGNATURE-----

--QVNdtCdvpDJ4Wr7k--
