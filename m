Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6DC7308F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjFNUJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjFNUJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:09:03 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5A210EC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:09:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4D9953200901;
        Wed, 14 Jun 2023 16:08:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 14 Jun 2023 16:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686773337; x=1686859737; bh=6KX7wzeURcOEeMnaB3niY56Ida2X9r8UnB7
        8KPsJBtY=; b=NNRkC56GXPugsyOeD2actKwYDw6IEwRktEJ9wiqf5cYbhZk1C+0
        awLYJXyExoiAOQzBrmh6aX0rQgQ9gWxLysiP+xmA7W6vbLZBq6f9FmELkOQ72/TZ
        ouvlV3RKqCXyiBZ8lMwj+kjpJnXKCCnQF6iiWgnlWd5vKCswmWCOdH/CgkiJ+ZO3
        bVghTLG1zpYQb0TB8qn42zuAw4fgjK/3/3/L54vik7CXtjw/fVOcTWq6p7y43T+r
        00MfeUoqRAIlYbJ6Vm/S4b2q8H6eYTLnWe8471Mv1OqhdTqnlzqf1U9YeOJeqVKg
        X7tRaEdJ+5XJH5yOdh3bqkpZ7StO7EfqkYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686773337; x=1686859737; bh=6KX7wzeURcOEe
        MnaB3niY56Ida2X9r8UnB78KPsJBtY=; b=BNwr7u3na+kb3UuLnL5M40G7SzxDg
        vbFcBY0OJi75vF5UF6UvaAS7ie9wJ8Ys47rVWos5MFUVwvgvOt0W5aJGw7k1IwJb
        P7avsk2agcFNR3wDDeVnWsQHu7xLJRa6Qbu/HPjL0DrHr4pxkrwj2ICN/AmmE6yN
        SYlEXMUkfIp3yyieUIqqCMdxlvYLxggT/crhjh82BlLzeF7MelED2JuBOCqf8otE
        BBHwM7La10YVAa17WeffUwr/2ISAP5K7nfhIuRK0kLnz1WUcJI45mvMq+OOsZGyW
        iZnCEq8fXD02r/KR07PqjU2iUi3DxyH0YGEykTzzXqDf3d1OLeqfA7TRw==
X-ME-Sender: <xms:WB6KZLZNDDDqQEqBmxbe4_k48lMsbw76LPnBLvGSi17vvB1sY1cTNw>
    <xme:WB6KZKa2zEK0KHXrNiMceXvTDW26kiNcCh5uc-4L9Eo74pknZ2SbQ-AWTOTTC9dE7
    3GNC8se3U31io0>
X-ME-Received: <xmr:WB6KZN9Aq6niWfDzHjjEHTvslYx-J1ktqz7fw66SZ4QzlaxmOLFoo3Pr4Io>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvtddgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:WB6KZBplqo7Q0ZZLa2sBfIbj4FhcsnQINmeVjDtW2ox2RxciCHs8rA>
    <xmx:WB6KZGosntE1ZTC7iV2TvTzb5nJ4PpNl2t8lo8nm5L0aNg3yYWIwCA>
    <xmx:WB6KZHTB3rrjrjMoZiUP8MPP6J2uhJvTpkdhARFKdnLeB0e1b7aMDw>
    <xmx:WR6KZEanXhVkdSYnhVB2iG0WO-0k0rg1jkfK7VKl2ahd-HWGtkqWCg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jun 2023 16:08:55 -0400 (EDT)
Date:   Wed, 14 Jun 2023 16:08:51 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     David Laight <David.Laight@aculab.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 0/4] Make sscanf() stricter
Message-ID: <ZIoeVjC6offUywop@itl-email>
References: <6ab6adce-2318-4ae6-bde6-4317485639fd@p183>
 <ZId/IA41c2sJyvE0@itl-email>
 <ZIeHfBf3aB3vUgRM@smile.fi.intel.com>
 <ZIeMyQXU49OcoxY2@itl-email>
 <ec3d7ebe62654e949329785bb32c3822@AcuMS.aculab.com>
 <ZIiMrDxI5Ts0s8fK@itl-email>
 <23df90dd35874fd89c64906e6a6de164@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ndMq6uyPyBGNAYg2"
Content-Disposition: inline
In-Reply-To: <23df90dd35874fd89c64906e6a6de164@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ndMq6uyPyBGNAYg2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Jun 2023 16:08:51 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: David Laight <David.Laight@aculab.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 0/4] Make sscanf() stricter

On Wed, Jun 14, 2023 at 08:23:56AM +0000, David Laight wrote:
> From: Demi Marie Obenour
> > Sent: 13 June 2023 16:35
> >=20
> > On Tue, Jun 13, 2023 at 01:02:59PM +0000, David Laight wrote:
> > > From: Demi Marie Obenour
> > > > Sent: 12 June 2023 22:23
> > > ....
> > > > sscanf(), except to the extent that -Werror=3Dformat can keep worki=
ng.
> > > > Userspace sscanf() is almost useless: it has undefined behavior on
> > > > integer overflow and swallows spaces that should usually be rejecte=
d.
> > >
> > > scanf() is designed for parsing space separated data.
> > > Eating spaces it part of its job description.
> > >
> > > 	David
> >=20
> > In this case I would prefer to have two versions: one that eats spaces
> > and one that does not.  For instance, I don=E2=80=99t think any user of
> > xenbus_scanf() wants the space-swallowing behavior.  This can be worked
> > around in xenbus_scanf(), of course, by having it reject strings with
> > spaces (as determened by isspace()) before calling vsscanf().
>=20
> What sort of formats and data are being used?

Base-10 or base-16 integers, with whitespace never being valid.

> The "%s" format terminates on whitespace.
> Even stroul() (and friends) will skip leading whitespace.

Yes, which is a reason that strto*l() are just broken IMO.  I=E2=80=99m try=
ing
to replace their uses in Xen with custom parsing code.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--ndMq6uyPyBGNAYg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSKHlUACgkQsoi1X/+c
IsH3hw/5AehDaQcd7rD6jShESUA3CUBLSvI0dX8Wy+PtdBvL2K7YiJmByokguiXU
+4Shj1aNGvptBv5wHSpEC1ZVm8nyYAh70tnZlftkUJ0fUqJqMYug1by6zQVkXJ+P
dKjOpfVPnXYTrS/TuNyBL/COeeVYLGpfG2iLWce5JBAlXP7aERINUjEqpfuiuQ/l
tj1mBx8vxaiPa2cVtH8GzdE6aoOm9NKM2UKzIIEq5J+TfFw4efxWm4hAVAGMV3lA
xEJ5h97p6RNQ3UufZ1GyaCVN+2L9U/Q1cGxLvzYSX11K5wPfg3VmZU3UTmBat7Co
KmMra4aWTTjVliCxcIdTOO/xFPA1SWDgLTKg7ExmUbbbmFqjsXg52EevmoWHPR8b
YHxeFiX0TN7t9u4FvEq4Ic5Rzv69o0N7001THIYUfge46lQ76h1GdCR6LBpBBVoq
i3l+Max8LLMcw1HqyyxxLWeEiDy/aFIAsfktnWXVZkTBEoZgfO9+ncmq0ZE0/rwJ
4HKCgmasGM+ofuFsOdG3/v8Ra18nTYfSJRCvBtch5/V3SSbklhdsMBYBOgaZPzuM
N8ibN/bdvlxE4ia/qlu090z3+4AGuw0ZdHe2FDSFuqFB2YupWD7iaBrOvK4tYajs
FaDnqyw6ApMBYN+6lJj+mb8dBnD+k00paoIi8BG+KRbywL/X40w=
=zzor
-----END PGP SIGNATURE-----

--ndMq6uyPyBGNAYg2--
