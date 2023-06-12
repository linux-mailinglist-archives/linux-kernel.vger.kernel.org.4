Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E624172D05B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjFLUUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbjFLUT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:19:58 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25E9DB;
        Mon, 12 Jun 2023 13:19:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B2085C013E;
        Mon, 12 Jun 2023 16:19:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 12 Jun 2023 16:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686601197; x=1686687597; bh=tA23MkpYIRU6TEDaHFbw3sUgPSUR1HWvRL3
        42c0i0R0=; b=qIzfUO/VPI7ncyy18zo9Hvb13RZ/OYo/y0KdUKiEiC+ZsXQXtDL
        AsPVxshAdWikjSyrhUCV4wOSWKfGS1akCngInfgtu2xMiEmYT5gdexwumtjq4Gk/
        aMdBUxp2Ul1OZTvarNkbiGfWvf3RW/oUftfxuyMPN4x+BN3H+aFj3e9W08cMdRQG
        Q977qNr0qzvzB8kdb5V8LzNW4F/a2Sg9QiBQaNdCDl7+6h2wPCBqZ3rXwmBkESEC
        br7X0oTWux3DBoYptHybdGzePx7vH/aWpSsznMHDd8i58R7rsFAfbgqWHEyg/ajK
        yp73FRSPJ/SJZbGm5PFswn7U7XZhM7bKTvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686601197; x=1686687597; bh=tA23MkpYIRU6T
        EDaHFbw3sUgPSUR1HWvRL342c0i0R0=; b=D9O27/co5sySAI0faxBxH84dGib7r
        HxlAqgjNmkJ8ceWWQsDwthEmF47in22xXsBoyOm18RlyelUHBvjGsTh0MNQVxJPu
        M5jR4/tOBPDjMyrsjhmXjaOh8S4zGjhz5zu0iqzWc81YMtbIM8tQXXJam9Ukt5YX
        cWP2TKRsmx1nrcr28rHNvEiAqh66SSBN5k+UtUvf53Z7JPC44X0dW9H9YRR9161S
        oxMEHMzYhglgK4vVX1Vu6ULAlQx0J0NBKJiuGlqP9DlEs8Ftm2jXrpBkIUhwsuV1
        J8E4o2VzoGsj0NpdkmQ/IqWJjSRJVlIuGqLmeK4zmW6dKETl8Uu6aeubQ==
X-ME-Sender: <xms:7H2HZOqfpUmjUjxw8viNot6xcTiBr355OZkn328BaSefFEQl-DC3qA>
    <xme:7H2HZMpu38g4g2sYOEkQOE0JaLR-xvoAgzyBOYfeVk-WLyH9OIJ0XLBOa3yg4Skq7
    fg6CnKYTXoBJcs>
X-ME-Received: <xmr:7H2HZDMARIpc1yXvBwrYLf8Fef5kaR-552EzBOx154WzvL9CWSWKt-tvfe4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduhedgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffej
    geejgeffkeelveeuleeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:7H2HZN5TCaXTtmllS-AAzdWghN6KSGarhe0jXrsdwbzdKhTpLxPy6g>
    <xmx:7H2HZN7tPbf8CATzImRboMMxWtX9V_28p0j0QGKEm2nm9l9e6s8fPA>
    <xmx:7H2HZNhXovagMFV6o0JjGip2LCLDLO85LQceFExD9qMom2ZwHhD-pw>
    <xmx:7X2HZOMG3Pvhk5f7SOkQHvJGwV5yWyVhRzp3nXpkVq7xBHg1sWs-Bw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jun 2023 16:19:55 -0400 (EDT)
Date:   Mon, 12 Jun 2023 16:19:52 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 1/4] limits.h: add UCHAR_MAX, SCHAR_MAX, and SCHAR_MIN
Message-ID: <ZId96g6rrlist/OA@itl-email>
References: <20230610204044.3653-1-demi@invisiblethingslab.com>
 <20230610204044.3653-2-demi@invisiblethingslab.com>
 <4c01e43a-0275-04a0-ad9d-ee2f2bf24e1c@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NGoQOQpHk48pW9+A"
Content-Disposition: inline
In-Reply-To: <4c01e43a-0275-04a0-ad9d-ee2f2bf24e1c@arm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NGoQOQpHk48pW9+A
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Jun 2023 16:19:52 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 1/4] limits.h: add UCHAR_MAX, SCHAR_MAX, and SCHAR_MIN

On Mon, Jun 12, 2023 at 05:31:51PM +0100, Vincenzo Frascino wrote:
> Hi Demi,
>=20
> On 6/10/23 21:40, Demi Marie Obenour wrote:
> > Some drivers already defined these, and they will be used by sscanf()
> > for overflow checks later.  Also add SSIZE_MIN to limits.h, which will
> > also be needed later.
> >=20
> > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > ---
> >  .../media/atomisp/pci/hive_isp_css_include/platform_support.h  | 1 -
> >  include/linux/limits.h                                         | 1 +
> >  include/linux/mfd/wl1273-core.h                                | 3 ---
> >  include/vdso/limits.h                                          | 3 +++
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> >=20
> ...
>=20
> > diff --git a/include/vdso/limits.h b/include/vdso/limits.h
> > index 0197888ad0e00b2f853d3f25ffa764f61cca7385..0cad0a2490e5efc194d8740=
25eb3e3b846a5c7b4 100644
> > --- a/include/vdso/limits.h
> > +++ b/include/vdso/limits.h
> > @@ -2,6 +2,9 @@
> >  #ifndef __VDSO_LIMITS_H
> >  #define __VDSO_LIMITS_H
> > =20
> > +#define UCHAR_MAX	((unsigned char)~0U)
> > +#define SCHAR_MAX	((signed char)(UCHAR_MAX >> 1))
> > +#define SCHAR_MIN	((signed char)(-SCHAR_MAX - 1))
>=20
> Are you planning to use those definitions in the vDSO library?

Nope.  They were added here for consistency with the other *_{MIN,MAX}
defines.

> If not can you please define them in linux/limits.h, the vdso headers con=
tain
> only what is necessary for the vDSO library.

Will fix in the next version.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--NGoQOQpHk48pW9+A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSHfesACgkQsoi1X/+c
IsEbjw/+LDz/ZrZ6HofU5Sjo8ZA8THCeJbaQEcjq0K1aUNrb9oa7qnZMECW3U/hh
RM/bfptOB77BTB1Lr5IAlutr5P+O4SnNNTXG49nuBAQhBNo3tZVlf3te8L+aS1Ia
kxBxACKwxxawCgVqOuXelC1PWkBZxOHSG+C4JLOAkqhoET4TZ8zcy2Tu+WFEoP6p
IM04KKvF8j50qiG0UQ2gLl7gGDCevJ6CIPS9FlNcUD3g7cW1az9tYoXNbk/GFExq
lzfEn+UQHsnw8scjuM9KvSYJU0LW3Ljl+AUgYxf1rJsGLWPHZDZELIXbSj8s6wv1
xDBCNUNRMJ+mxOgISUkViS2SzztCOfLMvFq33ei5Wozjr+p7hl6a5+pu8hZcljxW
iLv5LXKLbITKzmPC+hqAacpnrlVIYLxzeceEHPc10/gbZoBRxZETIodIMQDBbUAr
BKMDX9RMcBt0SRWbgfLJrW6pukQ9HQCNFdvGUJoIkowettr7SGU2n6R1rpwXOUKH
pty750hJlL5Q7BTeQApd8xbNFm3dlT0p10fKbOssUstDkpLYu2jgqBKTf8GIfOPY
p6/QjXZYTRXeCYy0uyeJrgXkW/q5GP6qAPF95WgJ0paVAym+OVD6FTBZTmOV1/z2
XQ/DQ9L1x5naaIaRMTt5J+Db1gmHxuNcT4Dbo9ua/9/TR/TlCD8=
=dZlN
-----END PGP SIGNATURE-----

--NGoQOQpHk48pW9+A--
