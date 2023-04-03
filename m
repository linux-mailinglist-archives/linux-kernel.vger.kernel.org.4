Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24536D3B35
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 02:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjDCAzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 20:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjDCAzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 20:55:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E614AD27;
        Sun,  2 Apr 2023 17:55:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d17so27604173wrb.11;
        Sun, 02 Apr 2023 17:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680483302; x=1683075302;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HSGBXzMogo2CcbWE7eakS4vEGfL4+gqcdYd/Ldm/rAg=;
        b=eafBRC4arnUdu4CZZRpPbUTje0YomlHF4z1mIL47WOVELsvypxxXwLtB94krP4Bi+q
         CY0pQ5O6s7YlXumc9zC25N+N9Z5Lv23jvBAStP/hAevWAZaYQJ3XuQW/rWN/hHX7lR/P
         H7796IZZ6FTtyO7pM25CwBIdZWmcFSIXu7CYn9+8fyzshBkI/SAatRJ0ajyjqt11LUTM
         DS1MAHhWx5cq1XX4KTuUoFrNzGHxdXAMSDdJaC+OhTvCEZ2jcPJpiC0Hjzdg8Q0WVTS+
         DN1EnURsPWnldrEDh1zyJntlYOybSDKhYYrPj7rsfbWqZDiuCNeslolXLKe3LGK+WULZ
         zJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680483302; x=1683075302;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSGBXzMogo2CcbWE7eakS4vEGfL4+gqcdYd/Ldm/rAg=;
        b=qpk53jsN7nD9lnOl60QQh3966vc2A1lPt+4svU48iCzqtk5JwJE9mbKj49LNCk49kz
         i3CSFlLjSgbWH6Q1L7O2IqghLnBY4mbS3V9a9Bq6uM3kHqELOtC+DNIvvPMn4jzxzK3X
         6NL0sWEpmaHZ0A3Guv5zC4nGH0zddN/7IRPrLOHpOf1hTn5w4ISMgAD7wtF0NikDhP+G
         3JY5KBkPsKKc6R7nsdT8SoCpkUOCs5E/q3JEXb4nH31lPVG7YglNxIamQeWaoD97h+hR
         OK/rnttYmmVa/rRjYaq1mEAiaMR1mBPFluqRXTL9B/LpGtPTbPH9bwKrCRDDAOttpaY+
         Edzw==
X-Gm-Message-State: AAQBX9cDhMoOn4+3zlREh/y+wLdGiRbNTQH4dEwiA4opHdsuynJB+J44
        L7me6EYD0ijJDfHIedclEGYdA8II5P0=
X-Google-Smtp-Source: AKy350ap7yVTYufKRM+ljze9linea41lbhLGLpXpROnqhvgIMzLiVDVUDdlOeO6VBMppdO163sVewg==
X-Received: by 2002:a5d:5104:0:b0:2cf:ea5d:f607 with SMTP id s4-20020a5d5104000000b002cfea5df607mr24680737wrt.17.1680483301769;
        Sun, 02 Apr 2023 17:55:01 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b003edc11c2ecbsm10468767wmd.4.2023.04.02.17.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 17:55:01 -0700 (PDT)
Message-ID: <3f33c6d4-fdbe-e3b4-675a-64f61c35fdb1@gmail.com>
Date:   Mon, 3 Apr 2023 02:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     linux-man <linux-man@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Marcos Fouces <marcos@debian.org>, Sam James <sam@gentoo.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
Subject: man-pages-6.04 released
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vJajRKsgVicqx7GTA0wHdJ0Q"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------vJajRKsgVicqx7GTA0wHdJ0Q
Content-Type: multipart/mixed; boundary="------------zUKni7UaHA0NJSF6KUSv0r1p";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: linux-man <linux-man@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 GNU C Library <libc-alpha@sourceware.org>, Marcos Fouces
 <marcos@debian.org>, Sam James <sam@gentoo.org>,
 Jonathan Corbet <corbet@lwn.net>, Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <3f33c6d4-fdbe-e3b4-675a-64f61c35fdb1@gmail.com>
Subject: man-pages-6.04 released

--------------zUKni7UaHA0NJSF6KUSv0r1p
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gidday!

I'm proud to announce:

	man-pages-6.04 - manual pages for GNU/Linux

The release tarball is already available at <kernel.org>.

Tarball download:
	<https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/>
Git repository:
	<https://git.kernel.org/cgit/docs/man-pages/man-pages.git/>

The most notable changes in the release are:

-  New APIs have been documented in proc(5) (KPF_PGTABLE), landlock(7)
   (LANDLOCK_ACCESS_FS_REFER, LANDLOCK_ACCESS_FS_TRUNCATE), and udp(7)
   (UDP_GRO, UDP_SEGMENT).

-  C89 information has been restored.  Information about old standards
   and systems has been moved to a new HISTORY section.  VERSIONS has
   been repurposed, and STANDARDS has been simplified.  Some functions
   have been marked as deprecated, according to their standards.

-  The build system has been improved to allow several operations that
   distributions usually perform, such as installing compressed pages,
   installing link pages as symlinks, or moving mandirs.

Thanks you all for contributing!

Cheers,

Alex

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Changes in m=
an-pages-6.04 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=


Released: 2023-04-03, Aldaya


Contributors
------------

The following people contributed patches/fixes, reports, notes,
ideas, and discussions that have been incorporated in changes in
this release:

Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
Alejandro Colomar <alx@kernel.org>
Andrew Clayton <andrew@digital-domain.net>
Brian Inglis <Brian.Inglis@Shaw.ca>
"Carlos O'Donell" <carlos@redhat.com>
Christian Brauner <brauner@kernel.org>
Christoph Lameter <cl@linux.com>
Dmitry Goncharov <dgoncharov@users.sf.net>
"Dmitry V. Levin" <ldv@strace.io>
Elliott Hughes <enh@google.com>
Elvira Khabirova <lineprinter0@gmail.com>
Fotios Valasiadis <fvalasiad@gmail.com>
"G. Branden Robinson" <g.branden.robinson@gmail.com>
Guy Shefy <guyshefyb@gmail.com>
G=C3=BCnther Noack <gnoack3000@gmail.com>
Helge Kreutzmann <debian@helgefjell.de>
Iker Pedrosa <ipedrosa@redhat.com>
Jack Pearson <jack@pearson.onl>
Jakub Wilk <jwilk@jwilk.net>
Marco Bonelli <marco@mebeim.net>
Matt Jolly <Matt.Jolly@footclan.ninja>
Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Nate Eldredge <nate@thatsmathematics.com>
Oskari Pirhonen <xxc3ncoredxx@gmail.com>
Patrick Reader <_@pxeger.com>
Paul Eggert <eggert@cs.ucla.edu>
Paul Smith <psmith@gnu.org>
Ralph Corderoy <ralph@inputplus.co.uk>
Rodrigo Campos <rodrigo@sdfg.com.ar>
Samanta Navarro <ferivoz@riseup.net>
Serge Hallyn <serge@hallyn.com>
Simon Horman <simon.horman@corigine.com>
Timo Stark <t.stark@nginx.com>
Tom Schwindl <schwindl@posteo.de>
"Valentin V. Bartenev" <vbartenev@gmail.com>
Vincent Lefevre <vincent@vinc17.net>
Vladislav Ivanishin <vlad@ispras.ru>
Willem de Bruijn <willemb@google.com>
Wu Zhenyu <wuzhenyu@ustc.edu>
Yedidyah Bar David <didi@redhat.com>
Younes Manton <younes.m@gmail.com>
<imachug@yandex.ru>
<pabeni@redhat.com>


Apologies if I missed anyone!


Newly documented interfaces in existing pages
---------------------------------------------

proc.5
	KPF_PGTABLE			(Linux 4.18)

landlock.7
	LANDLOCK_ACCESS_FS_REFER	(Linux 5.19)
	LANDLOCK_ACCESS_FS_TRUNCATE	(Linux 6.02)

udp.7
	UDP_GRO				(Linux 5.0)
	UDP_SEGMENT			(Linux 4.18)


Global changes
--------------

-  Sections:
   -  Add HISTORY.
   -  HISTORY: Restore C89 references.
   -  Repurpose VERSIONS.
   -  Simplify STANDARDS.
   -  SYNOPSIS: Mark several functions as deprecated.

-  Build system:
   -  Support installing in different mandirs
      (e.g., man3typedir=3D'/usr/share/man/man3').
   -  Support installing compressed pages (Z=3D'.gz').
   -  Support installing link pages as symlinks (LINK_PAGES=3D'symlink').=



Changes to individual pages
---------------------------

The manual pages (and other files in the repository) have been improved
beyond what this changelog covers.  To learn more about changes applied
to individual pages, use git(1).


--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------zUKni7UaHA0NJSF6KUSv0r1p--

--------------vJajRKsgVicqx7GTA0wHdJ0Q
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmQqI90ACgkQnowa+77/
2zICIg/+Oh10/MKK6FjIo7sCXDxE9gPSOVf5rLjogjSQIk4pApoyTtNOupegedMa
1JlStM3FgabIx43UQRAsS+EHKlzPCeCcp+upn0YfhK+ceTcNCmIxn0CWG9vk3Cij
hYvvQpAdkmOIiQdhQpsk6kUHQahdKR87Tkry8dO/GZDrwf3aBp26osfWVhjR9Ts4
kq/OaKHBTS7mMVeftV0hSDqBgoGGbhZd/BaMvrqY+L0fXcvp5rc4FXe9IvrW/0yb
7JrSvLBgufm2hx09hN9BC0rLVJCHeYVLoYL0uvY1UH5XekejucSgrViAzR8KdJw8
3JdyMV4GjTDymG2aHingKvQoKwEd8I6YP7o6RpHoDtpjXm/J+ylcSDumRoPcyi2k
7wUIkaKSekwcn9HLoQxNCD333GrxArzSS3fmtqDavgfXqltOaLkaf2+pElg2ISsx
c4wvVj0jpWmf/YHzqT/kuvOEvKMt9RTORqPBJ10oyZn5EJsZYwidVcMFREvCKnl3
R42EOg+gNK26nOO+lYbi9KEDJ1H02QEbaFbzlYNS0VG8+987S2OI770XM6f2A9Qs
8kRb5F00ra0edUWrYIrxfPxl1UBf72IH2SuQatNTzcLGvlcfZ7Actktcb4QaGPXT
LK7LFUg2Ujy5Mcs8V6GTAMqHi7ojbucGiAViWYPAoTn/JXRSfbQ=
=TtnO
-----END PGP SIGNATURE-----

--------------vJajRKsgVicqx7GTA0wHdJ0Q--
