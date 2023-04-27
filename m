Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095336F0DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 23:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344240AbjD0VbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 17:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjD0VbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 17:31:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6748A1FFF;
        Thu, 27 Apr 2023 14:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1682631014; i=ps.report@gmx.net;
        bh=gG9ay1JgOrFpa75yqkO8/mg6sCJdAOlXhrWdSjos4Rc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=MlVU8TYUp2EpIPuIX9gQziILxwmdTFs1pEqs8qzhuGBFDonMtXDeuZDH6W7CucaOU
         Ae780tAnMkXDGwGa4ok18+J7hOmJbq16g/K3wNE5DZQ+NXXHnWges+PaAH1jpf+xAI
         AuwZxJR0+t4UAweUcyVuUu38ZECMHpGD15yZx4sNipYS9I2oIQx+OE+S39t65NUIY3
         CJ6AZCg9ud2601ASsXTiZuqjnOqOPh676k8z1d4TbjnLgWwx31MFSTLAaVxG6Pe0Lm
         Xg48nM86Wb/cVBepNaHaCbB2zc4uAOLjbaxzRyVcvhLcxN/n3yADtzfJtBMFIOseB2
         e4khuyqpgT8SA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([62.216.209.88]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9kM-1q4E0Y1qMW-00Ga6y; Thu, 27
 Apr 2023 23:30:14 +0200
Date:   Thu, 27 Apr 2023 23:30:10 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Konrad =?UTF-8?B?R3LDpGZl?= <k.graefe@gateware.de>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Felipe Balbi <balbi@ti.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] vsprintf: Add %p[mM]U for uppercase MAC address
Message-ID: <20230427233010.15f7677d@gmx.net>
In-Reply-To: <d1a14976-5f53-3373-0695-e10e6a9371de@rasmusvillemoes.dk>
References: <2023042625-rendition-distort-fe06@gregkh>
        <20230427115120.241954-1-k.graefe@gateware.de>
        <d1a14976-5f53-3373-0695-e10e6a9371de@rasmusvillemoes.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C5ubCS4kTqwQG0zMkeM9Cx269CvGy7tm1IRw5EQmFC0sLeq5tQ2
 W/38OEF2KyLzn3ZHt9agTt+W3x/9J/HZEvDVxlLn5W+JN+gdwIUts1Hr8UzwtOsVyOvUVuM
 1VlTXob5BUMfzi/LK1exvZbqsvAywdyCqkxbbXVduO4OkMrdkRKiLi+XaSlK8KlPEkTMKXe
 2Cpt3pZnQ1S6Rp81XCPqQ==
UI-OutboundReport: notjunk:1;M01:P0:KkGXVEgS7Jo=;VcS/xSULeBpNuNKhc5QmPmSP7sl
 4LknYtRg4l4a2VD9+yYYuQAMLjkle+aOGS+mQD+CiueIbG5TitW1ok48WRKw5lARXLxkCsYYg
 mxJyW4b50FnyxderVFNW0tECC7269XeTpG/p/Ccap2kusTDrbB/fI1Kh2Wmn0OfRPZJCQSgu4
 XpWttUlBTDjmKrUmPgTZsE2Cwrj8AwnsYmlWefu08lpJ7FOWCjJzCKFHUje8tJVyCBYENQzMj
 oegWn1fYEa8GCB6P6RsJk2CzXR8EfbOwK/2uPO/5Vq9CxSFUgsHzIsLna2USFBBGGTfGdUufh
 II+344944Bxfdtz7cZ9yjtsYUEfZh9bld0QfFDw0qmrGEtPowy09g9xpxoeJKtey4/wdSrxF5
 7FEsQ1RPJEhJWqJAMkzweAbCwyER2VZkG7s5UdVjLQyMq4Qjv5pwx/Tll8RONGLqQi912oSPM
 LRqrUMkM62QdEMp4BxcwQStbrIVvMUkyp+DCkh7S9A3l7i7CUrlHVeWVuzi1ys09ISFORxHVW
 Kou68tm/Pja6CJV3AFv/zZOE11NXqU/mF49tDsObcgFWo3BLxpI//W83TPCwcZpye99KAa/ly
 9+hY3Ry41s37meKJT2z3wnB8rhd4oR5D0gFNMXEtb898HXEhY303Y4XR8cIoL6jckf03A6n7A
 A+boePCoH3788cIouzOwOOCl49zgWAG7GigJQowUckEfi0ILKWf2ngeN4XJ6z0Sm61yIMVjgu
 QWtqL8nvvxO6Ubh+QA5kq6MyiQmOl1BNiLBmTfaWQtnJxsV9GRxL4jV5Yi7kdInCVu/k52tiH
 PAkrnwKqyOfXVWA297GdghVKJbLNEHpk1OuMcmbqQJcX16AnEWC8cQiYQVQfRGUSqEGmV/jXw
 1eNZCUZRpMjcCIznQ9kCDcJx5UAiLNSt7mhl6lGLxH1EPoYZcvl/yCcReRlwJHt7kxwUcWQuJ
 n9FkBVTv8f4jFndshaciuMOX+O8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rasmus, Konrad, *,

On Thu, 27 Apr 2023 14:35:19 +0200, Rasmus Villemoes <linux@rasmusvillemoes=
.dk> wrote:

> On 27/04/2023 13.51, Konrad Gr=C3=A4fe wrote:
> > The CDC-ECM specification requires an USB gadget to send the host MAC
> > address as uppercase hex string. This change adds the appropriate
> > modifier.
> >=20
> > Cc: stable@vger.kernel.org =20
>=20
> Why cc stable?
>=20
> > Signed-off-by: Konrad Gr=C3=A4fe <k.graefe@gateware.de>
> > ---
> > Added in v3
> >=20
> >  lib/vsprintf.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-) =20
>=20
> The diffstat here, or for some other patch in the same series,
> definitely ought to mention lib/test_printf.c.
>=20
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index be71a03c936a..8aee1caabd9e 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1269,9 +1269,10 @@ char *mac_address_string(char *buf, char *end, u=
8 *addr,
> >  {
> >  	char mac_addr[sizeof("xx:xx:xx:xx:xx:xx")];
> >  	char *p =3D mac_addr;
> > -	int i;
> > +	int i, pos;
> >  	char separator;
> >  	bool reversed =3D false;
> > +	bool uppercase =3D false;
> > =20
> >  	if (check_pointer(&buf, end, addr, spec))
> >  		return buf;
> > @@ -1281,6 +1282,10 @@ char *mac_address_string(char *buf, char *end, u=
8 *addr,
> >  		separator =3D '-';
> >  		break;
> > =20
> > +	case 'U':
> > +		uppercase =3D true;
> > +		break;
> > +
> >  	case 'R':
> >  		reversed =3D true;
> >  		fallthrough; =20
>=20
> This seems broken, and I'm surprised the compiler doesn't warn about
> separator possibly being uninitialized further down. I'm also surprised
> your testing hasn't caught this. For reference, the full switch
> statement is currently

Compiler (gcc) does not warn because of Makefile:

  1038 # Enabled with W=3D2, disabled by default as noisy
  1039 ifdef CONFIG_CC_IS_GCC
  1040 KBUILD_CFLAGS +=3D -Wno-maybe-uninitialized
  1041 endif

With this commented:

  lib/vsprintf.c: In function =E2=80=98mac_address_string=E2=80=99:
  lib/vsprintf.c:1310:30: warning: =E2=80=98separator=E2=80=99 may be used =
uninitialized [-Wmaybe-uninitialized]
   1310 |                         *p++ =3D separator;
        |                         ~~~~~^~~~~~~~~~~
  lib/vsprintf.c:1273:14: note: =E2=80=98separator=E2=80=99 was declared he=
re
   1273 |         char separator;
        |              ^~~~~~~~~

Regards,
Peter

>=20
>         switch (fmt[1]) {
>         case 'F':
>                 separator =3D '-';
>                 break;
>=20
>         case 'R':
>                 reversed =3D true;
>                 fallthrough;
>=20
>         default:
>                 separator =3D ':';
>                 break;
>         }
>=20
> > @@ -1292,9 +1297,14 @@ char *mac_address_string(char *buf, char *end, u=
8 *addr,
> > =20
> >  	for (i =3D 0; i < 6; i++) {
> >  		if (reversed)
> > -			p =3D hex_byte_pack(p, addr[5 - i]);
> > +			pos =3D 5 - i;
> > +		else
> > +			pos =3D i;
> > +
> > +		if (uppercase)
> > +			p =3D hex_byte_pack_upper(p, addr[pos]);
> >  		else
> > -			p =3D hex_byte_pack(p, addr[i]);
> > +			p =3D hex_byte_pack(p, addr[pos]); =20
>=20
> I think this becomes quite hard to follow. We have string_upper() in
> linux/string_helpers.h, so I'd rather just leave this loop alone and do
>=20
>   if (uppercase)
>     string_upper(mac_addr, mac_addr);
>=20
> after the nul-termination.
>=20
> Rasmus
>=20

