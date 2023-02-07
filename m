Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024FE68DDD8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjBGQYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjBGQYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:24:39 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CE1618A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:24:38 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id AC2C63200995;
        Tue,  7 Feb 2023 11:24:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 Feb 2023 11:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1675787077; x=
        1675873477; bh=7R/XpmUSA4PMsRDNnIxTLaD71IjwOgO4tuP4PJAPXfE=; b=e
        hS1EsTjdIbS10P2nGog4LDrzwrs60Gy+ynxxfRH9QLMw4Gv8zh76sPfiv0WO1Ym2
        itOUmvmFxZ/UHtWqYVNIwbf4y1WJxH8O1OIVJcOq5D8BUEDxC9b1HxCOi7Fakj5a
        kO4w67pYUEFp4wqnrWDudEgXs0pBUX0ePPK+vYhxBEUxZKvGgPuaI2CUBk01Q48k
        PANmFZiTs4a250SjxrdJnoEFEo4qpaTvIl5xU5OGveYsqoUDfupW4MWNF69nX9zI
        A5f9sIlPY7zABTYqdNlwyayTKcR1SIFsfimZjIAsvxAmFbWQdhAYEsE/ipWywBXU
        E3kxIxHEkFmBy4DlCGH0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675787077; x=1675873477; bh=7R/XpmUSA4PMsRDNnIxTLaD71Ijw
        OgO4tuP4PJAPXfE=; b=TiNHFOBRHipDJhJ2gujiI790VTtFpy7/qED7pvyB5uqK
        o/QT8KEBd6ppeyo4tJAdhAuvtBJiMGlzCh//N+2dIwt/GJqb8H+U7m0haeNbl0gh
        b4bsUwRRUImxpT/V43O6w2dPvgoGpfWHe3N1uyTwFDkf0hb1Rcm7qbZEgegDAdNH
        G1TP0TiIKsvWsilqy5a7BTntG/4rhfGBR1l/lT9pkofZsbCr/ObqfarbnXgC2Fkv
        dECPPJ16UnMYIf6o1p1RQqD359NzXwQyoCRghsah+C+LPa6yhrBMsY3Y9PnyNdQh
        /KGH/sGV999qO0/66fsOrq76ZW2h6XprPw/pzkIVLQ==
X-ME-Sender: <xms:RXviYwff7vGgpVpg44S6Y6cLBDyQIGjHoAFpJCteY6OniUFHbEF7YQ>
    <xme:RXviYyNcf5OAWFWG0eFK9qjMe3cnITx6IKlKnV5IRs9vsm87IT_9Qm00ya2023-r2
    44ZH1L262YIqyo>
X-ME-Received: <xmr:RXviYxgFpnu1FGtgZRB3kk1Ov8mTCY-iMPay46o8bqpQkA4ek0z78Z_Uqxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegkedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepudeileefueetvdelheeuteffjeeg
    jeegffekleevueelueekjeejudffteejkeetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:RXviY18nR5WwQZNZ2B4R-OvY3WMqqumsP3pXw212_wUM6MxeCCAaig>
    <xmx:RXviY8vhgmZ27T05dA911uh4Fk5w8q1z2xScM6kkMUxfST1Dooisbw>
    <xmx:RXviY8Ehoe4Nbs5992bQHDriYNJJ87P-SxY9Y0_XiXo0ATRw3ayBsQ>
    <xmx:RXviY4KeSXyT0o6IhYWhy-qGC8W-HHUimyF2zUj9mf35sxfRL9qOUw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Feb 2023 11:24:36 -0500 (EST)
Date:   Tue, 7 Feb 2023 11:24:26 -0500
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Joe Thornber <thornber@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH 2/2] dm-thin: Allow specifying an offset
Message-ID: <Y+J7QrS7JqeNqbot@itl-email>
References: <20230207011849.1343-1-demi@invisiblethingslab.com>
 <20230207011849.1343-2-demi@invisiblethingslab.com>
 <CAJ0trDZ88Tcaf9Y75S-vB1vWXPN9UEsqPV1bTrkAtSYFfUngAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ScLOiD2qe/Xm+M6i"
Content-Disposition: inline
In-Reply-To: <CAJ0trDZ88Tcaf9Y75S-vB1vWXPN9UEsqPV1bTrkAtSYFfUngAQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ScLOiD2qe/Xm+M6i
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 7 Feb 2023 11:24:26 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH 2/2] dm-thin: Allow specifying an offset

On Tue, Feb 07, 2023 at 03:03:57PM +0000, Joe Thornber wrote:
> Nack.  I'm not building a linear target into every other target.  Layering
> targets is simple.

It also introduces a performance penalty, which is measurable on some
workloads.  Even dm-linear is not free.  The crypt target also has this
feature, so there is precedent.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--ScLOiD2qe/Xm+M6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmPie0IACgkQsoi1X/+c
IsFczhAA1UG7afUNotup5av9jXAA3Zc9u75TsHUT5BOxVMTIuej/hxQMqEWB5WY+
MZBbAjjsaZlnxlUWq3Kmi2ch1RNSWLndSGWszL6itoSZu4IV7aFRoQ/+SDHB0dGj
r4P5K27NDv069VDvjy8wktfV80zbmoDJEnpv7F/1O5A/4X3eH5szB2quko/3YpTS
jraiEvrzOO1qowXzgJILGbbwQDE+NGZKDquKCHrKg6w7JXArzC+FW/F3o0r9+CHL
+7ZyLc6Gpe/LDNmKlPyhjMEE4tSOL7gyMzQ6we+A9mw26lhjfuav4BwJSaue62JA
1qDOB6NtYRLNehKIfO2qzlrdcthUicy+/6CJrC5I+lNKFt8me83TqyNUCaxwuX5w
BeeSWi76NuNLfDVAOTPWe7AhkNAa8BpE69oWQFAS1NC+jYWTzIO053IXPUMgK/ol
v96ZU22tSTi149D+sY3kUo/Nx44dx0lNgiqBIJSwhSkNONuSAl/ajTslJGUOAm5Z
H0/LRZEKAE7y8kDV/U5nEaH6Vn5ijhwUO0ebaPW3Lq8nbN6Ddo3DykkN5uHw5w4f
R6r6P1MGiwp92BqXfBGBsEUR5Ulsh/hVFPOGknHK7HwfuaQXCdwuqljcrCiCL/p8
XTUO5qu0bJ9i2x5NqZSOjlqJfMI3CNu2StJ8PVJSxCBhn2I89QE=
=hLCQ
-----END PGP SIGNATURE-----

--ScLOiD2qe/Xm+M6i--
