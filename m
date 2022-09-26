Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05125EAE44
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiIZRfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiIZRe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:34:56 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 127B9DEA2;
        Mon, 26 Sep 2022 09:54:37 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 2CED02040;
        Mon, 26 Sep 2022 17:15:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1664205355;
        bh=O6butbHEYXb4X2YTzbhHaO1UylgtvPZjvHMs4RWdSvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JxiznzBra2+BR0qTR5UGFsIS055L/CO0mxcmXg0liP/AVCsFSQKoKe14LpHaJbWZq
         FgCcdSEqNKm2Zvscjpvz+wXc2/WNHgqWmEt6gtzVkFbn2oXSOs4oFUTTV5OdNDPbik
         VmLNpwl42PU4fGkCmeCPH72iCPnx9s7Au5MWnfq/4SwU1fJ/5fy4ghQ59j/BhNs/gF
         O0NIjhWLPooszMQD9CESnym/nwt81rkLslMJT3q5MI47CLz0/eT0wG7Ph25DCPWQmg
         otmjxCCN4BdkhYarHKUGCthMm17n/rJL0IVxWzqO+7nUXKBL+k2xgJzL2lDutxhiH6
         A3lHbNvWfb9iAZuCuiLnOoX/DuPd3Ql64EK0O8pkOqRgqFZnO+x5/tNQtGD8ucZBmU
         NGLj80zd2+EX24UgFgblGYsxhE9z+VqY1nOWdHSA54utZWReTwioykSH3JpQZ9Z6lL
         SOajSAx/JkXbJKzXKyfACYFS5hTjqqPs01szTRAHmJMsBEZmsemjmQyD4y5yy0Cu9r
         fnK/vh8+NTajE8JE5O6rxw3GE9NYgv9hV47R7jKN3hmYI2VssBFbrvkR/JZp7j5TGm
         7046P4UREg7FSI835qcareeyEqAYUdhinIFp3jy+LoHeR4oiV4+byeK2iRoKS2gAaV
         iC9wAhSX2hd6n4+6TBNeIUYA=
Date:   Mon, 26 Sep 2022 17:15:54 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v4 02/18] a.out: remove define-only CMAGIC, previously
 magic number
Message-ID: <20220926151554.7gxd6unp5727vw3c@tarta.nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
 <9cbea062df7125ef43e2e0b2a67ede6ad1c5f27e.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAMuHMdWxf=+CnwXT61VvYhcHi093rz=0ftWQXKVviMunzE1HHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="owvvegzmxe7bs6ov"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWxf=+CnwXT61VvYhcHi093rz=0ftWQXKVviMunzE1HHw@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--owvvegzmxe7bs6ov
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Mon, Sep 26, 2022 at 10:16:02AM +0200, Geert Uytterhoeven wrote:
> Thanks for your patch, which is now commit 53c2bd679017277f
> ("a.out: remove define-only CMAGIC, previously magic number") in
> driver-core/driver-core-next.
>=20
> On Fri, Sep 16, 2022 at 12:40 AM =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabij=
aczleweli.xyz> wrote:
> > The last user was removed in 5.1 in
> > commit 08300f4402ab ("a.out: remove core dumping support")
> > but this is part of the UAPI headers, so this may want to either wait
> > until a.out is removed entirely, or be removed from the magic number doc
> > and silently remain in the header
>=20
> Indeed. This is part of uapi, and might break some unknown
> userspace, while the gain is limited.  Do we really want to reduce
> include/uapi/linux/a.out.h piecewise (e.g. N_BADMAG() seems to be
> unused, too), instead of keeping it until a.out support is removed
> completely?

Not really, but it looked like a magic number in the magic-number.rst
sense due to the field being "magic" and the unintuitive type naming:
I hadn't realised it's part of the on-disk format
re-examination shows that it very well may be (have been).

> Anyway, even at that point, it might be wise to keep the header file
> around, as people have expressed the desire to run a.out binaries
> through a userspace-compatibility wrapper.

Agreed. Scissor-patch that reverts the removal below.

> > A cursory glance on DCS didn't show any user code actually using this
> > value
>=20
> What is DCS?

Debian Code Search; in this case my query was:
  https://codesearch.debian.net/search?q=3D%5CbCMAGIC%5Cb&literal=3D0

There's a few false positives here but all results that are using CMAGIC
to mean this CMAGIC (and aren't hurd code copied from linux)
just re-define it.

> >  Documentation/process/magic-number.rst                    | 1 -
> >  Documentation/translations/it_IT/process/magic-number.rst | 1 -
> >  Documentation/translations/zh_CN/process/magic-number.rst | 1 -
> >  Documentation/translations/zh_TW/process/magic-number.rst | 1 -
> >  include/uapi/linux/a.out.h                                | 3 ---
> >  5 files changed, 7 deletions(-)
> >=20
> > diff --git a/include/uapi/linux/a.out.h b/include/uapi/linux/a.out.h
> > index 5fafde3798e5..bb15da96df2a 100644
> > --- a/include/uapi/linux/a.out.h
> > +++ b/include/uapi/linux/a.out.h
> > @@ -70,9 +70,6 @@ enum machine_type {
> >     The first page is unmapped to help trap NULL pointer references */
> >  #define QMAGIC 0314
> >
> > -/* Code indicating core file.  */
> > -#define CMAGIC 0421
> > -
> >  #if !defined (N_BADMAG)
> >  #define N_BADMAG(x)      (N_MAGIC(x) !=3D OMAGIC         \
> >                         && N_MAGIC(x) !=3D NMAGIC         \
>=20
> Gr{oetje,eeting}s,
>                         Geert

Best,
=D0=BD=D0=B0=D0=B1

-- >8 --
Subject: [PATCH] a.out: restore CMAGIC

Part of UAPI and the on-disk format:
this means that it's not a magic number per magic-number.rst,
and it's best to leave it untouched to avoid breaking userspace
and suffer the same fate as a.out in general

Fixes: commit 53c2bd679017 ("a.out: remove define-only CMAGIC,
 previously magic number")
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 include/uapi/linux/a.out.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/a.out.h b/include/uapi/linux/a.out.h
index bb15da96df2a..5fafde3798e5 100644
--- a/include/uapi/linux/a.out.h
+++ b/include/uapi/linux/a.out.h
@@ -70,6 +70,9 @@ enum machine_type {
    The first page is unmapped to help trap NULL pointer references */
 #define QMAGIC 0314
=20
+/* Code indicating core file.  */
+#define CMAGIC 0421
+
 #if !defined (N_BADMAG)
 #define N_BADMAG(x)	  (N_MAGIC(x) !=3D OMAGIC		\
 			&& N_MAGIC(x) !=3D NMAGIC		\
--=20
2.30.2


--owvvegzmxe7bs6ov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMxwikACgkQvP0LAY0m
WPFsOg/+LbOR74Qel4hfE8PDMr9APMECOWl5vTlxh+SZqgou2UJ8HIQ6kqweyyZi
ap9urcIzyiIb4lnGUWSLMyGG89H6paRIAr8pPX/wLWOkkXpukCg77CnwbqZrQCO3
etsnNxwThtjN23Y4ggMhHwZ85Nn6RnhmzFcHHZ2UsfbyYjnGT85eZHhUzh8uFjjF
J2UEdff3e4dx32vGw+SRbzxre1g/fCXB1Yp8dcvvQ9vLJjxHqayK2uNVjVF3Cbmk
c71dYu38EEcAymYByMwDqiV1gKpisguLzsRctH2ZK6H7k1UakLutLH9GnRAeNJ+Z
6p/rb02O6N5yFGyXzjix74ILOWhhv/+HJ8D2EFWM02ictMrttjawVCcGSkU048d0
h3hSMEXR8vAcVu9utZyW1lMotDJHvcdlPYE9hA+Mem82B/+w6qIszvkG2//JO7So
HkkPkWEeel+3vWSfdilM1DhlX5aFgzdB74DrJywFbOzjwL4kYiKi53AEF0VJgCOd
vEcX/vxN8oVUxaaHL7Tun0UkWYCS1hpt8A74rbrWhdflM+Oc4c7A+0d9ga8MFM4f
CDygsPBClz2WthgcNV+1RfVh257MDurYIqmaLcenaQOBF5Z/6wHAnE5ne0D5oN0d
uYDvV2jjjSHts0sLJssHo3QEJr78NIMxC7G1ETfF42lWzGLPRUs=
=qrkH
-----END PGP SIGNATURE-----

--owvvegzmxe7bs6ov--
